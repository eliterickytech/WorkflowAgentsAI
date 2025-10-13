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

# Resolve CLI to use (mmdc | npx fallback)
$mmdcCommand = $null
$directMmdc = Get-Command mmdc -ErrorAction SilentlyContinue
if ($directMmdc) {
  $mmdcCommand = @{ Type = 'mmdc'; Path = $directMmdc.Source }
} else {
  $npx = Get-Command npx -ErrorAction SilentlyContinue
  if ($npx) {
    Write-Warning "Comando 'mmdc' não encontrado. Usando fallback com npx @mermaid-js/mermaid-cli."
    $mmdcCommand = @{
      Type = 'npx'
      Path = $npx.Source
      Args = @('--yes', '@mermaid-js/mermaid-cli')
    }
  } else {
    Write-Warning "Nenhum Mermaid CLI disponível (mmdc ou npx)."
    Write-Host "Instale Node.js (LTS) e execute:" -ForegroundColor Yellow
    Write-Host "npm install -g @mermaid-js/mermaid-cli" -ForegroundColor Yellow
    Write-Host "ou use npx @mermaid-js/mermaid-cli" -ForegroundColor Yellow
    return
  }
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

  if ([string]::IsNullOrWhiteSpace($sanitized)) {
    return $null
  }

  # Write to a temp file (UTF-8 sem BOM)
  $tmpDir = Join-Path $env:TEMP "mermaid-sanitized"
  New-Item -ItemType Directory -Path $tmpDir -Force | Out-Null
  $tmpFile = Join-Path $tmpDir ([System.IO.Path]::GetFileName($SourcePath))
  $encoding = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($tmpFile, $sanitized, $encoding)
  return $tmpFile
}

# Helper to invoke CLI
function Invoke-MermaidCli {
  param(
    [string]$Input,
    [string]$Output,
    [string]$Format
  )
  $args =
    if ($mmdcCommand.Type -eq 'mmdc') {
      @('-i', $Input, '-o', $Output, '-f', $Format)
    } else {
      $mmdcCommand.Args + @('-i', $Input, '-o', $Output, '-f', $Format)
    }
  & $mmdcCommand.Path @args
  return $LASTEXITCODE
}

# Ensure output per file
$files = Get-ChildItem -Path $InputDir -Filter *.mmd -ErrorAction Stop
if ($files.Count -eq 0) {
  Write-Warning "Nenhum arquivo .mmd encontrado em $InputDir."
  return
}

$failures = 0
$totalRenders = 0

$files | ForEach-Object {
  $file = $_.FullName
  $base = [System.IO.Path]::GetFileNameWithoutExtension($file)
  $sanitizedFile = Get-SanitizedMermaidFile -SourcePath $file
  if (-not $sanitizedFile) {
    Write-Warning "Arquivo sanitizado vazio, ignorando: $file"
    return
  }
  foreach ($fmt in $Formats) {
    $outFile = Join-Path $OutputDir ("$base.$fmt")
    Write-Host "Renderizando $fmt: $file -> $outFile" -ForegroundColor Green
    $exitCode = Invoke-MermaidCli -Input $sanitizedFile -Output $outFile -Format $fmt
    $totalRenders++
    if ($exitCode -ne 0) {
      Write-Warning "Falha ao renderizar $file ($fmt). Código: $exitCode"
      $failures++
    }
  }
}

if ($failures -gt 0) {
  Write-Warning "$failures de $totalRenders renderizações falharam."
  exit 1
}

Write-Host "Renderização concluída ($totalRenders artefatos)." -ForegroundColor Cyan
