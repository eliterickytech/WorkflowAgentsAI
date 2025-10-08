param(
  [string]$InputDir = $null,
  [string]$OutputDir = $null,
  [string[]]$Formats = @('png','svg')
)

if (-not $InputDir) {
  $InputDir = [System.IO.Path]::Combine($PSScriptRoot, '..', '..', 'docs', 'diagram')
}
if (-not $OutputDir) {
  $OutputDir = [System.IO.Path]::Combine($PSScriptRoot, '..', '..', 'docs', 'diagram', 'images')
}

Write-Host "Rendering Mermaid diagrams from: $InputDir" -ForegroundColor Cyan
Write-Host "Output directory: $OutputDir" -ForegroundColor Cyan

# Ensure output dir
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

# Check mmdc availability
$mmdc = (Get-Command mmdc -ErrorAction SilentlyContinue)
if (-not $mmdc) {
  Write-Warning "The 'mmdc' (Mermaid CLI) command is not available."
  Write-Host "Install Node.js (LTS) and then run:" -ForegroundColor Yellow
  Write-Host "npm install -g @mermaid-js/mermaid-cli" -ForegroundColor Yellow
  Write-Host "After installation, re-run this script." -ForegroundColor Yellow
  return
}

function Get-SanitizedMermaidFile {
  param(
    [Parameter(Mandatory)] [string]$SourcePath
  )
  $raw = Get-Content -Raw -Path $SourcePath
  # Strip Markdown code fences like ```mermaid, ```mermaid.flowchart, etc., and generic ``` closers anywhere
  $sanitized = $raw -replace "(?s)^```mermaid[^\r\n]*\r?\n", "" -replace "(?m)^```[A-Za-z0-9_.-]*\s*$", "" -replace "(?m)^```\s*$", ""

  # Keep only the first graph/flowchart block to avoid duplicates
  $lines = $sanitized -split "\r?\n"
  $firstIdx = $null
  for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '^\s*(graph|flowchart)\b') { $firstIdx = $i; break }
  }
  if ($null -ne $firstIdx) {
    $out = New-Object System.Collections.Generic.List[string]
    for ($j = $firstIdx; $j -lt $lines.Length; $j++) {
      if ($j -gt $firstIdx -and ($lines[$j] -match '^\s*(graph|flowchart)\b')) { break }
      $out.Add($lines[$j]) | Out-Null
    }
    $sanitized = ($out -join "`r`n").Trim()
  } else {
    $sanitized = ($lines -join "`r`n").Trim()
  }

  # Write to a temp file
  $tmpDir = Join-Path $env:TEMP "mermaid-sanitized"
  New-Item -ItemType Directory -Path $tmpDir -Force | Out-Null
  $tmpFile = Join-Path $tmpDir ([System.IO.Path]::GetFileName($SourcePath))
  Set-Content -Path $tmpFile -Value $sanitized -Encoding UTF8
  return $tmpFile
}

# Ensure output per file
Get-ChildItem -Path $InputDir -Filter *.mmd | ForEach-Object {
  $file = $_.FullName
  $base = [System.IO.Path]::GetFileNameWithoutExtension($file)
  $sanitizedFile = Get-SanitizedMermaidFile -SourcePath $file
  foreach ($fmt in $Formats) {
    $outFile = Join-Path $OutputDir ("$base.$fmt")
    Write-Host "mmdc: $file -> $outFile" -ForegroundColor Green
    mmdc -i $sanitizedFile -o $outFile
  }
}

Write-Host "Done." -ForegroundColor Cyan
