param(
  [switch]$Install
)

$venv = Join-Path $PSScriptRoot "..\..\.venv-1\Scripts\Activate.ps1"
if (-not (Test-Path $venv)) {
  Write-Host "Ambiente .venv-1 não encontrado em $venv" -ForegroundColor Red
  exit 1
}

Write-Host "Ativando .venv-1..." -ForegroundColor Cyan
& $venv

if ($Install) {
  Write-Host "Instalando dependências do requirements.txt..." -ForegroundColor Cyan
  python -m pip install -r (Join-Path $PSScriptRoot "..\requirements.txt")
}
