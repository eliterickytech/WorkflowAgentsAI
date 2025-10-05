# Script de validacao de encoding para WorkflowAgentsAI<#

# Verifica se todos os arquivos estao com UTF-8 correto.SYNOPSIS

    Valida encoding e formatação de arquivos do projeto

param(

    [switch]$Fix.DESCRIPTION

)    Script para validar se todos os arquivos do WorkflowAgentsAI

    estão com encoding correto (UTF-8 sem BOM para maioria dos arquivos)

$ErrorActionPreference = 'Stop'

.EXAMPLE

function Test-FileEncoding {    .\validate-encoding.ps1

    param([string]$FilePath)    .\validate-encoding.ps1 -Fix

    #>

    $bytes = [System.IO.File]::ReadAllBytes($FilePath)

    $hasBOM = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)param(

        [switch]$Fix

    return @{)

        HasBOM = $hasBOM

        Encoding = if($hasBOM) { "UTF-8 BOM" } else { "UTF-8" }$ErrorActionPreference = 'Stop'

    }

}# Cores para output

$colors = @{

function Repair-FileEncoding {    Success = 'Green'

    param([string]$FilePath)    Warning = 'Yellow'

        Error = 'Red'

    try {    Info = 'Cyan'

        $content = Get-Content $FilePath -Raw -Encoding UTF8}

        $utf8NoBOM = New-Object System.Text.UTF8Encoding $false

        [System.IO.File]::WriteAllText($FilePath, $content, $utf8NoBOM)function Write-ColoredOutput {

        return $true    param(

    } catch {        [string]$Message,

        Write-Host "Erro ao corrigir: $_" -ForegroundColor Red        [string]$Type = 'Info'

        return $false    )

    }    Write-Host $Message -ForegroundColor $colors[$Type]

}}



# Regras por tipo de arquivofunction Test-FileEncoding {

$encodingRules = @{    param(

    '.md' = @{ ExpectBOM = $false; Name = 'Markdown' }        [string]$FilePath

    '.ps1' = @{ ExpectBOM = $false; Name = 'PowerShell' }    )

    '.psm1' = @{ ExpectBOM = $false; Name = 'PowerShell Module' }

    '.yaml' = @{ ExpectBOM = $false; Name = 'YAML' }    $bytes = [System.IO.File]::ReadAllBytes($FilePath)

    '.yml' = @{ ExpectBOM = $false; Name = 'YAML' }    $hasBOM = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)

    '.json' = @{ ExpectBOM = $false; Name = 'JSON' }

    '.feature' = @{ ExpectBOM = $false; Name = 'Gherkin' }    return @{

    '.cs' = @{ ExpectBOM = $true; Name = 'C#' }        HasBOM = $hasBOM

    '.ts' = @{ ExpectBOM = $false; Name = 'TypeScript' }        Encoding = if($hasBOM) { "UTF-8 BOM" } else { "UTF-8" }

    '.js' = @{ ExpectBOM = $false; Name = 'JavaScript' }    }

}}



Write-Host "`nValidando encoding de arquivos..." -ForegroundColor Cyanfunction Repair-FileEncoding {

Write-Host ("=" * 70)    param(

        [string]$FilePath

# Obter arquivos    )

$files = Get-ChildItem -Path (Split-Path $PSScriptRoot -Parent) -Recurse -File |

    Where-Object {     try {

        $_.FullName -notmatch '\\node_modules\\|\\\.git\\|\\\.venv|\\obj\\|\\bin\\' -and        $content = Get-Content $FilePath -Raw -Encoding UTF8

        $_.Extension -in $encodingRules.Keys        $utf8NoBOM = New-Object System.Text.UTF8Encoding $false

    }        [System.IO.File]::WriteAllText($FilePath, $content, $utf8NoBOM)

        return $true

$totalFiles = $files.Count    } catch {

$correctFiles = 0        Write-ColoredOutput "  Erro ao corrigir: $_" 'Error'

$incorrectFiles = 0        return $false

$fixedFiles = 0    }

$validationErrors = @()}



Write-Host "`nAnalisando $totalFiles arquivos...`n"# Regras de encoding por tipo de arquivo

$encodingRules = @{

foreach ($file in $files) {    '.md' = @{ ExpectBOM = $false; Name = 'Markdown' }

    $ext = $file.Extension    '.ps1' = @{ ExpectBOM = $false; Name = 'PowerShell' }

    $rule = $encodingRules[$ext]    '.psm1' = @{ ExpectBOM = $false; Name = 'PowerShell Module' }

    $encoding = Test-FileEncoding -FilePath $file.FullName    '.psd1' = @{ ExpectBOM = $false; Name = 'PowerShell Data' }

        '.yaml' = @{ ExpectBOM = $false; Name = 'YAML' }

    $expectBOM = $rule.ExpectBOM    '.yml' = @{ ExpectBOM = $false; Name = 'YAML' }

    $hasBOM = $encoding.HasBOM    '.json' = @{ ExpectBOM = $false; Name = 'JSON' }

        '.feature' = @{ ExpectBOM = $false; Name = 'Gherkin' }

    if ($expectBOM -eq $hasBOM) {    '.cs' = @{ ExpectBOM = $true; Name = 'C#' }

        $correctFiles++    '.ts' = @{ ExpectBOM = $false; Name = 'TypeScript' }

    } else {    '.js' = @{ ExpectBOM = $false; Name = 'JavaScript' }

        $incorrectFiles++    '.html' = @{ ExpectBOM = $false; Name = 'HTML' }

            '.py' = @{ ExpectBOM = $false; Name = 'Python' }

        $expected = if($expectBOM) { "UTF-8 COM BOM" } else { "UTF-8 SEM BOM" }}

        $actual = if($hasBOM) { "UTF-8 COM BOM" } else { "UTF-8 SEM BOM" }

        Write-ColoredOutput "`n🔍 Validando encoding de arquivos..." 'Info'

        $errorObj = [PSCustomObject]@{Write-ColoredOutput "=" * 70 'Info'

            File = $file.Name

            Type = $rule.Name# Obter todos os arquivos relevantes

            Expected = $expected$files = Get-ChildItem -Path $PSScriptRoot -Recurse -File |

            Actual = $actual    Where-Object {

            Fixed = $false        $_.FullName -notmatch '\\node_modules\\|\\\.git\\|\\\.venv|\\obj\\|\\bin\\' -and

        }        $_.Extension -in $encodingRules.Keys

            }

        if ($Fix -and -not $expectBOM -and $hasBOM) {

            Write-Host "  Corrigindo: $($file.Name)" -ForegroundColor Yellow$totalFiles = $files.Count

            if (Repair-FileEncoding -FilePath $file.FullName) {$correctFiles = 0

                $errorObj.Fixed = $true$incorrectFiles = 0

                $fixedFiles++$fixedFiles = 0

                Write-Host "    Corrigido!" -ForegroundColor Green$validationErrors = @()

            }

        } else {Write-ColoredOutput "`nAnalisando $totalFiles arquivos..." 'Info'

            Write-Host "  ERRO: $($file.Name)" -ForegroundColor RedWrite-ColoredOutput ""

            Write-Host "     Esperado: $expected | Encontrado: $actual" -ForegroundColor Red

        }foreach ($file in $files) {

            $ext = $file.Extension

        $validationErrors += $errorObj    $rule = $encodingRules[$ext]

    }    $encoding = Test-FileEncoding -FilePath $file.FullName

}

    $expectBOM = $rule.ExpectBOM

# Resumo    $hasBOM = $encoding.HasBOM

Write-Host "`n$("=" * 70)"

Write-Host "RESUMO DA VALIDACAO" -ForegroundColor Cyan    if ($expectBOM -eq $hasBOM) {

Write-Host ("=" * 70)        $correctFiles++

    } else {

Write-Host "`nTotal de arquivos: $totalFiles"        $incorrectFiles++

Write-Host "Corretos: $correctFiles" -ForegroundColor Green

        $expected = if($expectBOM) { "UTF-8 COM BOM" } else { "UTF-8 SEM BOM" }

if ($incorrectFiles -gt 0) {        $actual = if($hasBOM) { "UTF-8 COM BOM" } else { "UTF-8 SEM BOM" }

    Write-Host "Incorretos: $incorrectFiles" -ForegroundColor Red

            $errorObj = [PSCustomObject]@{

    if ($Fix) {            File = $file.FullName.Replace($PSScriptRoot, '.')

        Write-Host "Corrigidos: $fixedFiles" -ForegroundColor Green            Type = $rule.Name

        if ($fixedFiles -lt $incorrectFiles) {            Expected = $expected

            Write-Host "Nao corrigidos: $($incorrectFiles - $fixedFiles)" -ForegroundColor Yellow            Actual = $actual

        }            Fixed = $false

    }        }

} else {

    Write-Host "`nTodos os arquivos estao com encoding correto!" -ForegroundColor Green        if ($Fix -and -not $expectBOM -and $hasBOM) {

}            Write-ColoredOutput "  🔧 Corrigindo: $($errorObj.File)" 'Warning'

            if (Repair-FileEncoding -FilePath $file.FullName) {

# Detalhes                $errorObj.Fixed = $true

if ($validationErrors.Count -gt 0 -and -not $Fix) {                $fixedFiles++

    Write-Host "`nARQUIVOS COM PROBLEMAS:" -ForegroundColor Red                Write-ColoredOutput "    ✅ Corrigido!" 'Success'

    $validationErrors | Format-Table -AutoSize File, Type, Expected, Actual            }

            } else {

    Write-Host "`nPara corrigir automaticamente, execute:" -ForegroundColor Cyan            Write-ColoredOutput "  ❌ $($errorObj.File)" 'Error'

    Write-Host "   .\validate-encoding.ps1 -Fix" -ForegroundColor Yellow            Write-ColoredOutput "     Esperado: $expected | Encontrado: $actual" 'Error'

}        }



Write-Host ""        $validationErrors += $errorObj

    }

# Exit code}

if ($incorrectFiles -gt 0 -and -not $Fix) {

    exit 1# Resumo

} elseif ($incorrectFiles -gt 0 -and $Fix -and $fixedFiles -lt $incorrectFiles) {Write-ColoredOutput "`n" + ("=" * 70) 'Info'

    exit 1Write-ColoredOutput "📊 RESUMO DA VALIDAÇÃO" 'Info'

} else {Write-ColoredOutput ("=" * 70) 'Info'

    exit 0

}Write-ColoredOutput "`nTotal de arquivos: $totalFiles" 'Info'

Write-ColoredOutput "✅ Corretos: $correctFiles" 'Success'

if ($incorrectFiles -gt 0) {
    Write-ColoredOutput "❌ Incorretos: $incorrectFiles" 'Error'

    if ($Fix) {
        Write-ColoredOutput "🔧 Corrigidos: $fixedFiles" 'Success'
        if ($fixedFiles -lt $incorrectFiles) {
            Write-ColoredOutput "⚠️  Não corrigidos: $($incorrectFiles - $fixedFiles)" 'Warning'
        }
    }
} else {
    Write-ColoredOutput "`n🎉 Todos os arquivos estão com encoding correto!" 'Success'
}

# Detalhes dos erros (se houver)
if ($validationErrors.Count -gt 0 -and -not $Fix) {
    Write-ColoredOutput "`n📋 ARQUIVOS COM PROBLEMAS:" 'Error'
    $validationErrors | Format-Table -AutoSize File, Type, Expected, Actual

    Write-ColoredOutput "`n💡 Para corrigir automaticamente, execute:" 'Info'
    Write-ColoredOutput "   .\validate-encoding.ps1 -Fix" 'Warning'
}

Write-ColoredOutput ""

# Exit code
if ($incorrectFiles -gt 0 -and -not $Fix) {
    exit 1
} elseif ($incorrectFiles -gt 0 -and $Fix -and $fixedFiles -lt $incorrectFiles) {
    exit 1
} else {
    exit 0
}
