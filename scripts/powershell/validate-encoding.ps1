<#
.SYNOPSIS
    Valida padrões de encoding (BOM), finais de linha e possíveis ocorrências de mojibake.

.DESCRIPTION
    - Garante UTF-8 sem BOM para arquivos de texto, exceto .cs (que exigem BOM).
    - Verifica finais de linha (CRLF para scripts/markdown, LF para arquivos web/config).
    - Identifica sequências típicas de mojibake (ï¿½, ÃÂ, etc.) e pode repará-las automaticamente.

.PARAMETER Fix
    Aplica correções automáticas para BOM e finais de linha.

.PARAMETER RepairMojibake
    Quando usado com -Fix, tenta reparar conteúdo com caracteres corrompidos (mojibake).

.PARAMETER Root
    Diretório raiz a inspecionar. Por padrão, assume o repositório (dois níveis acima deste script).

.EXAMPLE
    .\validate-encoding.ps1

.EXAMPLE
    .\validate-encoding.ps1 -Fix -RepairMojibake
#>
[CmdletBinding()]
param(
    [switch]$Fix,
    [switch]$RepairMojibake,
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Status {
    param(
        [Parameter(Mandatory)][string]$Message,
        [ValidateSet('Info','Success','Warning','Error')][string]$Level = 'Info'
    )
    $colors = @{
        Info    = 'Cyan'
        Success = 'Green'
        Warning = 'Yellow'
        Error   = 'Red'
    }
    Write-Host $Message -ForegroundColor $colors[$Level]
}

function Get-BomStatus {
    param([Parameter(Mandatory)][string]$Path)
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
    return @{ HasBom = $hasBom }
}

function Set-FileUtf8 {
    param(
        [Parameter(Mandatory)][string]$Path,
        [bool]$WithBom = $false
    )
    $content = [System.IO.File]::ReadAllText($Path)
    $encoding = New-Object System.Text.UTF8Encoding($WithBom)
    [System.IO.File]::WriteAllText($Path, $content, $encoding)
}

function Get-TargetFiles {
    param([string]$RootPath, [hashtable]$Rules)
    Get-ChildItem -Path $RootPath -Recurse -File |
        Where-Object {
            $_.FullName -notmatch '\\node_modules\\|\\\.git\\|\\\.venv|\\obj\\|\\bin\\' -and
            $Rules.ContainsKey([IO.Path]::GetExtension($_.Name).ToLowerInvariant())
        }
}

function Normalize-LineEndings {
    param(
        [Parameter(Mandatory)][string]$Path,
        [ValidateSet('CRLF','LF')][string]$Mode
    )
    $raw = [System.IO.File]::ReadAllText($Path)
    if ($Mode -eq 'CRLF') {
        $normalized = $raw -replace "`r?`n", "`r`n"
    } else {
        $normalized = $raw -replace "`r?`n", "`n"
    }
    if ($normalized -ne $raw) {
        $encoding = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($Path, $normalized, $encoding)
        return $true
    }
    return $false
}

function Repair-MojibakeText {
    param([Parameter(Mandatory)][string]$Text)

    $customPairs = @(
        @{ From = 'ï¿½fÂ¡'; To = 'á' }, @{ From = 'ï¿½fÂ£'; To = 'ã' },
        @{ From = 'ï¿½fÂ§'; To = 'ç' }, @{ From = 'ï¿½fÂ¨'; To = 'è' },
        @{ From = 'ï¿½fÂ©'; To = 'é' }, @{ From = 'ï¿½fÂª'; To = 'ê' },
        @{ From = 'ï¿½fÂ«'; To = 'ë' }, @{ From = 'ï¿½fÂ­'; To = 'í' },
        @{ From = 'ï¿½fÂ¯'; To = 'ï' }, @{ From = 'ï¿½fÂ±'; To = 'ñ' },
        @{ From = 'ï¿½fÂ³'; To = 'ó' }, @{ From = 'ï¿½fÂ´'; To = 'ô' },
        @{ From = 'ï¿½fÂµ'; To = 'õ' }, @{ From = 'ï¿½fÂº'; To = 'ú' },
        @{ From = 'ï¿½fÂ¼'; To = 'ü' }, @{ From = 'ï¿½fÂ¢'; To = 'â' },
        @{ From = 'ï¿½fÂ¤'; To = 'ä' },
        @{ From = "f',Ã‚Â¡"; To = 'á' }, @{ From = "f',Ã‚Â£"; To = 'ã' },
        @{ From = "f',Ã‚Â§"; To = 'ç' }, @{ From = "f',Ã‚Â©"; To = 'é' },
        @{ From = "f',Ã‚Âª"; To = 'ê' }, @{ From = "f',Ã‚Â­"; To = 'í' },
        @{ From = "f',Ã‚Â³"; To = 'ó' }, @{ From = "f',Ã‚Âµ"; To = 'õ' },
        @{ From = "f',Ã‚Âº"; To = 'ú' }, @{ From = "f',Ã‚Â¢"; To = 'â' }
    )

    $doubleEncoded = @(
        @{ From = 'Ã¡'; To = 'á' }, @{ From = 'Ã¢'; To = 'â' },
        @{ From = 'Ã£'; To = 'ã' }, @{ From = 'Ãª'; To = 'ê' },
        @{ From = 'Ã©'; To = 'é' }, @{ From = 'Ã¨'; To = 'è' },
        @{ From = 'Ã«'; To = 'ë' }, @{ From = 'Ã­'; To = 'í' },
        @{ From = 'Ã³'; To = 'ó' }, @{ From = 'Ã´'; To = 'ô' },
        @{ From = 'Ãµ'; To = 'õ' }, @{ From = 'Ãº'; To = 'ú' },
        @{ From = 'Ã§'; To = 'ç' },
        @{ From = 'Ã�'; To = 'Á' }, @{ From = 'Ã‚'; To = 'Â' },
        @{ From = 'Ãƒ'; To = 'Ã' }, @{ From = 'Ã„'; To = 'Ä' },
        @{ From = 'Ã‰'; To = 'É' }, @{ From = 'ÃŠ'; To = 'Ê' },
        @{ From = 'ÃŒ'; To = 'Ì' }, @{ From = 'Ã�'; To = 'Í' },
        @{ From = 'ÃŽ'; To = 'Î' }, @{ From = 'Ã“'; To = 'Ó' },
        @{ From = 'Ã”'; To = 'Ô' }, @{ From = 'Ã•'; To = 'Õ' },
        @{ From = 'Ãš'; To = 'Ú' }, @{ From = 'Ãœ'; To = 'Ü' },
        @{ From = 'Ã‡'; To = 'Ç' }
    )

    foreach ($pair in $customPairs) {
        $Text = $Text -replace [regex]::Escape($pair.From), $pair.To
    }
    foreach ($pair in $doubleEncoded) {
        $Text = $Text -replace [regex]::Escape($pair.From), $pair.To
    }

    # Remover replacement char remanescente
    $Text = $Text -replace [char]0xFFFD, ''
    return $Text
}

function Repair-MojibakeFile {
    param([Parameter(Mandatory)][string]$Path)
    $original = [System.IO.File]::ReadAllText($Path)
    $repaired = Repair-MojibakeText -Text $original
    if ($repaired -ne $original) {
        $encoding = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($Path, $repaired, $encoding)
        return $true
    }
    return $false
}

# Regras por extensão
$encodingRules = @{
    '.md'      = @{ ExpectBom = $false; LineEndings = 'CRLF' }
    '.ps1'     = @{ ExpectBom = $false; LineEndings = 'CRLF' }
    '.psm1'    = @{ ExpectBom = $false; LineEndings = 'CRLF' }
    '.yaml'    = @{ ExpectBom = $false; LineEndings = 'LF'   }
    '.yml'     = @{ ExpectBom = $false; LineEndings = 'LF'   }
    '.json'    = @{ ExpectBom = $false; LineEndings = 'LF'   }
    '.feature' = @{ ExpectBom = $false; LineEndings = 'LF'   }
    '.ts'      = @{ ExpectBom = $false; LineEndings = 'LF'   }
    '.js'      = @{ ExpectBom = $false; LineEndings = 'LF'   }
    '.html'    = @{ ExpectBom = $false; LineEndings = 'LF'   }
    '.cs'      = @{ ExpectBom = $true;  LineEndings = 'CRLF' }
}

Write-Status "`nValidando arquivos a partir de $Root" 'Info'
$files = Get-TargetFiles -RootPath $Root -Rules $encodingRules
$total = $files.Count
Write-Status "Arquivos analisados: $total" 'Info'

$bomIssues    = @()
$bomFixed     = 0

foreach ($file in $files) {
    $rule = $encodingRules[[IO.Path]::GetExtension($file.Name).ToLowerInvariant()]
    $status = Get-BomStatus -Path $file.FullName
    $hasBom = [bool]$status.HasBom
    $expect = [bool]$rule.ExpectBom
    if ($hasBom -ne $expect) {
        $bomIssues += [pscustomobject]@{
            File     = $file.FullName
            Expected = if ($expect) { 'UTF-8 com BOM' } else { 'UTF-8 sem BOM' }
            Actual   = if ($hasBom) { 'UTF-8 com BOM' } else { 'UTF-8 sem BOM' }
        }
        if ($Fix) {
            Set-FileUtf8 -Path $file.FullName -WithBom:$expect
            $bomFixed++
            Write-Status "  [FIX] Ajustado BOM: $($file.FullName)" 'Warning'
        }
    }
}

if ($bomIssues.Count -eq 0) {
    Write-Status "BOM: nenhum problema encontrado." 'Success'
} else {
    Write-Status "BOM: $($bomIssues.Count) arquivo(s) incorreto(s)." 'Error'
    if (-not $Fix) {
        $bomIssues | Format-Table -AutoSize
    }
}

# Verificação de finais de linha
$eolIssues = @()
$eolFixed  = 0
foreach ($file in $files) {
    $rule = $encodingRules[[IO.Path]::GetExtension($file.Name).ToLowerInvariant()]
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $hasCRLF = $content -like "*`r`n*"
    $hasLF   = $content -like "*`n*"
    $hasLFOnly = ($hasLF -and -not $hasCRLF)

    if ($rule.LineEndings -eq 'CRLF' -and $hasLF -and -not $hasCRLF) {
        $eolIssues += [pscustomobject]@{ File = $file.FullName; Expected = 'CRLF'; Found = 'LF' }
        if ($Fix -and (Normalize-LineEndings -Path $file.FullName -Mode 'CRLF')) {
            $eolFixed++
            Write-Status "  [FIX] Normalizado CRLF: $($file.FullName)" 'Warning'
        }
    } elseif ($rule.LineEndings -eq 'LF' -and $hasCRLF) {
        $eolIssues += [pscustomobject]@{ File = $file.FullName; Expected = 'LF'; Found = 'CRLF/mixed' }
        if ($Fix -and (Normalize-LineEndings -Path $file.FullName -Mode 'LF')) {
            $eolFixed++
            Write-Status "  [FIX] Normalizado LF: $($file.FullName)" 'Warning'
        }
    }
}

if ($eolIssues.Count -eq 0) {
    Write-Status "Finais de linha: nenhum problema encontrado." 'Success'
} else {
    Write-Status "Finais de linha: $($eolIssues.Count) arquivo(s) com divergência." 'Error'
    if (-not $Fix) {
        $eolIssues | Format-Table -AutoSize
    }
}

# Detecção e reparo opcional de mojibake
$mojiRegex = '(ï¿½|Ã[A-Za-zÃ‚Â]|Â[A-Za-z]|�)'
$mojiIssues = @()
$mojiFixed  = 0

foreach ($file in $files) {
    $raw = [System.IO.File]::ReadAllText($file.FullName)
    if ([regex]::IsMatch($raw, $mojiRegex)) {
        $mojiIssues += $file.FullName
        if ($Fix -and $RepairMojibake) {
            if (Repair-MojibakeFile -Path $file.FullName) {
                $mojiFixed++
                Write-Status "  [FIX] Mojibake reparado: $($file.FullName)" 'Warning'
            }
        }
    }
}

if ($mojiIssues.Count -eq 0) {
    Write-Status "Mojibake: nenhum problema detectado." 'Success'
} else {
    $msg = "Mojibake: $($mojiIssues.Count) arquivo(s) suspeito(s)."
    Write-Status $msg ($Fix -and $RepairMojibake -and $mojiFixed -eq $mojiIssues.Count ? 'Success' : 'Warning')
    if (-not $Fix -or -not $RepairMojibake) {
        foreach ($path in $mojiIssues) {
            Write-Status ("  - " + $path) 'Warning'
        }
        if (-not $Fix) {
            Write-Status "Informe -Fix -RepairMojibake para tentar correção automática." 'Info'
        }
    }
}

# Finalização / código de saída
$hasBlockingIssues = ($bomIssues.Count -gt $bomFixed) -or ($eolIssues.Count -gt $eolFixed) -or ($mojiIssues.Count -gt $mojiFixed -and $RepairMojibake)
if ($hasBlockingIssues -and -not $Fix) { exit 1 }
if ($hasBlockingIssues -and $Fix)      { exit 1 }
exit 0
