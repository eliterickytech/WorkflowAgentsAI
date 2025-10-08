# Requires: Windows PowerShell 5.1+
# Encoding: UTF-8 (no BOM) | Line endings: CRLF
param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..\\..')).Path,
    [string[]]$Extensions = @('.md','.markdown','.ps1','.psm1','.yml','.yaml','.json','.feature','.ts','.js','.html'),
    [switch]$ShowClean
)

Write-Host "Scanning for mojibake markers and line-ending issues..." -ForegroundColor Cyan

$patterns = @(
    'Ã',  # common mojibake starter for UTF-8 decoded as Latin-1
    'Â',  # BOM/spacing artifact from double-encoding
    ([string]([char]0xFFFD)) # Unicode replacement character
)

$textFiles = Get-ChildItem -Path $Root -Recurse -File |
    Where-Object { $Extensions -contains ([IO.Path]::GetExtension($_.FullName).ToLowerInvariant()) }

$totalMatches = 0
$filesWithIssues = @()
$lineEndingIssues = @()

foreach ($file in $textFiles) {
    try {
        $content = Get-Content -Path $file.FullName -Raw -ErrorAction Stop
    } catch {
        Write-Warning "Failed to read: $($file.FullName) - $($_.Exception.Message)"
        continue
    }

    # Mojibake scan (regex OR of patterns)
    $escaped = @()
    foreach ($p in $patterns) {
        $escaped += [System.Text.RegularExpressions.Regex]::Escape($p)
    }
    $regex = ''
    foreach ($e in $escaped) {
        if ($regex.Length -gt 0) { $regex += '|' }
        $regex += $e
    }
    $moji = Select-String -InputObject $content -Pattern $regex -AllMatches
    if ($moji) {
        $totalMatches += $moji.Matches.Count
        $filesWithIssues += [pscustomobject]@{
            Path = $file.FullName
            Hits = $moji.Matches.Count
        }
        Write-Host ("[MOJIBAKE] {0} (hits={1})" -f $file.FullName, $moji.Matches.Count) -ForegroundColor Yellow
    } elseif ($ShowClean) {
        Write-Host ("[OK] {0}" -f $file.FullName) -ForegroundColor DarkGray
    }

    # Line ending policy check by extension
    $requiresCRLF = @()
    $requiresCRLF += '.md'
    $requiresCRLF += '.ps1'
    $requiresCRLF += '.psm1'
    $requiresLF = @()
    $requiresLF += '.yml'
    $requiresLF += '.yaml'
    $requiresLF += '.json'
    $requiresLF += '.feature'
    $requiresLF += '.ts'
    $requiresLF += '.js'
    $requiresLF += '.html'
    $ext = [IO.Path]::GetExtension($file.FullName).ToLowerInvariant()
    $hasCRLF = $content -like "*`r`n*"
    $hasLFOnly = (($content -like "*`n*") -and -not ($content -like "*`r`n*"))

    if ($requiresCRLF -contains $ext) {
        if (-not $hasCRLF) {
            $lineEndingIssues += [pscustomobject]@{ Path = $file.FullName; Expected = 'CRLF'; Found = 'LF-only' }
            Write-Host ("[EOL] {0} uses LF but expected CRLF" -f $file.FullName) -ForegroundColor Red
        }
    } elseif ($requiresLF -contains $ext) {
        if (-not $hasLFOnly) {
            $lineEndingIssues += [pscustomobject]@{ Path = $file.FullName; Expected = 'LF'; Found = 'CRLF or mixed' }
            Write-Host ("[EOL] {0} uses CRLF/mixed but expected LF" -f $file.FullName) -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host ("Mojibake hits: {0}" -f $totalMatches) -ForegroundColor Cyan
Write-Host ("Files with EOL issues: {0}" -f $($lineEndingIssues.Count)) -ForegroundColor Cyan

if ($filesWithIssues.Count -eq 0 -and $lineEndingIssues.Count -eq 0) {
    Write-Host "No issues found. PASS" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Issues detected. Review the warnings above. FAIL" -ForegroundColor Red
    exit 1
}

