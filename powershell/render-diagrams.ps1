param(
  [string]$InputDir = $null,
  [string]$OutputDir = $null,
  [string[]]$Formats = @('png','svg')
)

if (-not $InputDir) {
  $InputDir = [System.IO.Path]::Combine($PSScriptRoot, '..', 'docs', 'diagram')
}
if (-not $OutputDir) {
  $OutputDir = [System.IO.Path]::Combine($PSScriptRoot, '..', 'docs', 'images')
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

# Ensure output per file
Get-ChildItem -Path $InputDir -Filter *.mmd | ForEach-Object {
  $file = $_.FullName
  $base = [System.IO.Path]::GetFileNameWithoutExtension($file)
  foreach ($fmt in $Formats) {
    $outFile = Join-Path $OutputDir ("$base.$fmt")
    Write-Host "mmdc: $file -> $outFile" -ForegroundColor Green
    mmdc -i $file -o $outFile
  }
}

Write-Host "Done." -ForegroundColor Cyan
