<#
.SYNOPSIS
    Valida a politica de encoding (BOM) do repositorio.

.DESCRIPTION
    Confere se os arquivos seguem a regra de BOM por tipo:
     - UTF-8 sem BOM para: .md, .ps1, .psm1, .yaml/.yml, .json, .feature, .ts, .js, .html
     - UTF-8 COM BOM para: .cs

    Opcionalmente corrige arquivos com BOM indevido (remove BOM) e adiciona BOM em .cs quando ausente.

.PARAMETER Fix
    Quando presente, aplica correcoes automaticas.

.EXAMPLE
    .\validate-encoding.ps1

.EXAMPLE
    .\validate-encoding.ps1 -Fix
#>
param(
    [switch]$Fix,
    [switch]$RepairMojibake,
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..\\..')).Path
)

$ErrorActionPreference = 'Stop'

function Write-ColoredOutput {
    param(
        [Parameter(Mandatory=$true)][string]$Message,
        [ValidateSet('Info','Success','Warning','Error')][string]$Type = 'Info'
    )
    $colors = @{ Info='Cyan'; Success='Green'; Warning='Yellow'; Error='Red' }
    Write-Host $Message -ForegroundColor $colors[$Type]
}

function Get-FileBOMStatus {
    param([Parameter(Mandatory=$true)][string]$FilePath)
    $bytes = [System.IO.File]::ReadAllBytes($FilePath)
    $hasBOM = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
    return @{ HasBOM = $hasBOM }
}

function Set-FileEncodingUTF8 {
    param(
        [Parameter(Mandatory=$true)][string]$FilePath,
        [Parameter()][bool]$WithBOM = $false
    )
    $content = Get-Content -Path $FilePath -Raw -Encoding UTF8
    $utf8 = New-Object System.Text.UTF8Encoding($WithBOM)
    [System.IO.File]::WriteAllText($FilePath, $content, $utf8)
}

# Regras de BOM por extensão
$encodingRules = @{
    '.md'      = @{ ExpectBOM = $false; Name = 'Markdown' }
    '.ps1'     = @{ ExpectBOM = $false; Name = 'PowerShell' }
    '.psm1'    = @{ ExpectBOM = $false; Name = 'PowerShell Module' }
    '.yaml'    = @{ ExpectBOM = $false; Name = 'YAML' }
    '.yml'     = @{ ExpectBOM = $false; Name = 'YAML' }
    '.json'    = @{ ExpectBOM = $false; Name = 'JSON' }
    '.feature' = @{ ExpectBOM = $false; Name = 'Gherkin' }
    '.ts'      = @{ ExpectBOM = $false; Name = 'TypeScript' }
    '.js'      = @{ ExpectBOM = $false; Name = 'JavaScript' }
    '.html'    = @{ ExpectBOM = $false; Name = 'HTML' }
    '.cs'      = @{ ExpectBOM = $true;  Name = 'C#' }
}

Write-ColoredOutput "`nValidando encoding (BOM) de arquivos..." 'Info'

$files = Get-ChildItem -Path $Root -Recurse -File |
    Where-Object {
        $_.FullName -notmatch '\\node_modules\\|\\\.git\\|\\\.venv|\\obj\\|\\bin\\' -and
        $encodingRules.ContainsKey([IO.Path]::GetExtension($_.Name).ToLowerInvariant())
    }

$total = $files.Count
$ok = 0; $bad = 0; $fixed = 0
$issues = @()

Write-ColoredOutput "Analisando $total arquivos..." 'Info'

foreach ($f in $files) {
    $ext  = [IO.Path]::GetExtension($f.Name).ToLowerInvariant()
    $rule = $encodingRules[$ext]
    $bom  = Get-FileBOMStatus -FilePath $f.FullName
    $has  = [bool]$bom.HasBOM
    $exp  = [bool]$rule.ExpectBOM

    if ($has -eq $exp) {
        $ok++
        continue
    }

    $expectedText = if ($exp) { 'UTF-8 COM BOM' } else { 'UTF-8 SEM BOM' }
    $actualText   = if ($has) { 'UTF-8 COM BOM' } else { 'UTF-8 SEM BOM' }

    $issue = [pscustomobject]@{
        File     = $f.FullName
        Type     = $rule.Name
        Expected = $expectedText
        Actual   = $actualText
        Fixed    = $false
    }

    if ($Fix) {
        try {
            if (-not $exp -and $has) {
                # remover BOM
                Set-FileEncodingUTF8 -FilePath $f.FullName -WithBOM:$false
                $issue.Fixed = $true; $fixed++
                Write-ColoredOutput "  [FIX] Corrigido (removido BOM): $($f.FullName)" 'Warning'
            } elseif ($exp -and -not $has) {
                # adicionar BOM (ex.: .cs)
                Set-FileEncodingUTF8 -FilePath $f.FullName -WithBOM:$true
                $issue.Fixed = $true; $fixed++
                Write-ColoredOutput "  [FIX] Corrigido (adicionado BOM): $($f.FullName)" 'Warning'
            }
        } catch {
            Write-ColoredOutput "  ERRO: Falha ao corrigir: $($f.FullName) - $($_.Exception.Message)" 'Error'
        }
    } else {
    Write-ColoredOutput "  ERRO: $($f.FullName) - Esperado: $expectedText | Encontrado: $actualText" 'Error'
    }

    $issues += $issue
    $bad++
}

Write-ColoredOutput "`nRESUMO" 'Info'
Write-ColoredOutput ("Total: $total | Corretos: $ok | Incorretos: $bad" ) 'Info'
if ($Fix -and $bad -gt 0) {
    Write-ColoredOutput ("Corrigidos: $fixed | Nao corrigidos: " + [Math]::Max(0, $bad - $fixed)) 'Info'
}

if ($issues.Count -gt 0 -and -not $Fix) {
    Write-ColoredOutput "`nDetalhes dos problemas:" 'Error'
    $issues | Select-Object File, Type, Expected, Actual | Format-Table -AutoSize
    Write-ColoredOutput "`nPara corrigir automaticamente, execute: .\\validate-encoding.ps1 -Fix" 'Info'
}

if ($bad -gt 0 -and -not $Fix) { exit 1 }
elseif ($bad -gt 0 -and $Fix -and $fixed -lt $bad) { exit 1 }
else {
    # Continue to EOL and mojibake validation
}

# --- EOL and Mojibake validation ---
$requiresCRLF = @('.md','.ps1','.psm1')
$requiresLF   = @('.yml','.yaml','.json','.feature','.ts','.js','.html')

$badEOL = 0; $fixedEOL = 0
$badMoji = 0
$repChar = [char]0xFFFD
# Detect typical mojibake patterns: 'Ãx' or 'Âx' where x is Latin-1 supplement, plus replacement char
$mojiRegex = "Ã[\u00A0-\u00FF]|Â[\u00A0-\u00FF]"
$eolIssues = @()
$mojiIssues = @()

foreach ($f in $files) {
    $ext = [IO.Path]::GetExtension($f.Name).ToLowerInvariant()
    $content = ''
    try { $content = Get-Content -Path $f.FullName -Raw -ErrorAction Stop } catch { continue }

    $hasCRLF = ($content -like "*`r`n*")
    $hasAnyLF = ($content -like "*`n*")
    $hasLFOnly = ($hasAnyLF -and -not $hasCRLF)

    if ($requiresCRLF -contains $ext) {
        if (-not $hasCRLF -and $hasAnyLF) {
            $badEOL++
            $eolIssues += [pscustomobject]@{ File=$f.FullName; Expected='CRLF'; Found='LF-only' }
            if ($Fix) {
                $lines = Get-Content -Path $f.FullName
                $new = [string]::Join("`r`n", $lines)
                [IO.File]::WriteAllText($f.FullName, $new, (New-Object System.Text.UTF8Encoding($false)))
                $fixedEOL++
                Write-ColoredOutput "  [FIX] Normalizado CRLF: $($f.FullName)" 'Warning'
            }
        }
    } elseif ($requiresLF -contains $ext) {
        if (-not $hasLFOnly -and $hasCRLF) {
            $badEOL++
            $eolIssues += [pscustomobject]@{ File=$f.FullName; Expected='LF'; Found='CRLF or mixed' }
            if ($Fix) {
                $lines = Get-Content -Path $f.FullName
                $new = [string]::Join("`n", $lines)
                [IO.File]::WriteAllText($f.FullName, $new, (New-Object System.Text.UTF8Encoding($false)))
                $fixedEOL++
                Write-ColoredOutput "  [FIX] Normalizado LF: $($f.FullName)" 'Warning'
            }
        }
    }

    $hasMoji = $false
    if ($content.IndexOf($repChar) -ge 0) { $hasMoji = $true }
    elseif ([System.Text.RegularExpressions.Regex]::IsMatch($content, $mojiRegex)) { $hasMoji = $true }
    if ($hasMoji) {
        if ($Fix -and $RepairMojibake) {
            # Attempt to repair by re-decoding Latin-1 string to UTF-8
            $latin1 = [System.Text.Encoding]::GetEncoding(28591)
            $origMatches = ([System.Text.RegularExpressions.Regex]::Matches($content, $mojiRegex)).Count
            $bytes = $latin1.GetBytes($content)
            $fixedContent = [System.Text.Encoding]::UTF8.GetString($bytes)
            $fixedMatches = ([System.Text.RegularExpressions.Regex]::Matches($fixedContent, $mojiRegex)).Count
            if ($fixedMatches -lt $origMatches) {
                [IO.File]::WriteAllText($f.FullName, $fixedContent, (New-Object System.Text.UTF8Encoding($false)))
                Write-ColoredOutput "  [FIX] Mojibake reparado: $($f.FullName)" 'Warning'
                $content = $fixedContent
                $hasMoji = $false
            }
        }
        if ($hasMoji) {
            $badMoji++
            $mojiIssues += $f.FullName
        }
    }
}

Write-ColoredOutput "`nRESUMO EOL/MOJIBAKE" 'Info'
Write-ColoredOutput ("Arquivos com problema de EOL: $badEOL | Corrigidos: $fixedEOL") 'Info'
Write-ColoredOutput ("Arquivos com possivel mojibake: $badMoji") 'Info'

if ($badEOL -gt 0 -and -not $Fix) { $exitCode = 1 } elseif ($badEOL -gt 0 -and $Fix -and $fixedEOL -lt $badEOL) { $exitCode = 1 } else { $exitCode = 0 }

if ($badMoji -gt 0) {
    Write-ColoredOutput "`nArquivos possivelmente com mojibake (verifique manualmente):" 'Warning'
    foreach ($p in $mojiIssues) { Write-ColoredOutput ("  - " + $p) 'Warning' }
}

exit $exitCode
