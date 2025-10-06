param(
  [Parameter(Mandatory=$true)][string]$Sprint,
  [string]$Context = "",
  [string]$Activity = "",
  [bool]$Orchestrators = $true,
  [string]$ApiKey = "",
  [string]$Provider = "",
  [string]$Model = "",
  [string]$BaseUrl = "",
  [switch]$Local
)

# Cenários suportados:
# 1) Local (OpenAI-compatible) com Ollama/LM Studio: set LOCAL_MODE=1 e opcional OPENAI_BASE_URL
# 2) OpenAI: defina OPENAI_API_KEY
# 3) Azure OpenAI: defina LLM_PROVIDER=azure e AZURE_* vars

$env:SPRINT = $Sprint
$env:RUN_CONTEXT = $Context
$env:OUTPUT_ACTIVITY = $Activity
$env:ORCHESTRATORS = if ($Orchestrators) { "1" } else { "0" }

# Provider/model options
if ($Provider) { $env:LLM_PROVIDER = $Provider }
if ($Model) { $env:LLM_MODEL = $Model }

# Local mode vs API key
if ($Local) {
  $env:LOCAL_MODE = "1"
  if (-not $BaseUrl) { $BaseUrl = "http://localhost:11434/v1" }
  $env:OPENAI_BASE_URL = $BaseUrl
  if (-not $ApiKey) { $ApiKey = "ollama" }
}
if ($ApiKey) { $env:OPENAI_API_KEY = $ApiKey }
if ($BaseUrl) { $env:OPENAI_BASE_URL = $BaseUrl }

# Diretório base da sprint (padrão canônico: data/out)
$outBase = Join-Path (Join-Path $PSScriptRoot "..\data\out") ("sprint" + $Sprint)
if ($Activity) { $outBase = Join-Path $outBase $Activity }
if (-not (Test-Path $outBase)) { New-Item -ItemType Directory -Path $outBase | Out-Null }

# Verificar se existe análise de projeto existente
$contextFile = Join-Path (Split-Path $PSScriptRoot) "project-analysis.md"
if (Test-Path $contextFile) {
  Write-Host "Contexto do projeto existente: project-analysis.md (sera considerado pelos orquestradores)"
  $env:PROJECT_ANALYSIS_PATH = $contextFile
}

Write-Host "Sprint: $Sprint"
Write-Host "Context: $Context"
Write-Host "Activity: $Activity"
Write-Host "Orchestrators: " ($env:ORCHESTRATORS)
if ($env:LLM_PROVIDER) { Write-Host "Provider: $($env:LLM_PROVIDER)" }
if ($env:LLM_MODEL) { Write-Host "Model: $($env:LLM_MODEL)" }
if ($env:OPENAI_BASE_URL) { Write-Host "BaseUrl: $($env:OPENAI_BASE_URL)" }
if ($env:OPENAI_API_KEY) { Write-Host "ApiKey: (set)" }
Write-Host "Out dir: $outBase"

# Executa os runners em sequência segura
# Suporta dois layouts:
# 1) Repositório: Install/orchestrators/
# 2) Projeto cliente: orchestrators/
$orchCandidates = @(
  Join-Path (Join-Path $PSScriptRoot "..") "Install\orchestrators",
  Join-Path (Join-Path $PSScriptRoot "..") "orchestrators"
)
$orchRoot = $orchCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $orchRoot) {
  throw "Pasta de orchestrators não encontrada. Verifique se 'Install/orchestrators' (repo) ou 'orchestrators' (projeto cliente) existe."
}

python (Join-Path $orchRoot "crewai_runner.py") $Sprint
python (Join-Path $orchRoot "autogen_dev_team.py") $Sprint
