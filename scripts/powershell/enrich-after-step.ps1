# Requires -Version 5.1
param(
    [Parameter(Mandatory=$true)][string]$AgentId,
    [Parameter(Mandatory=$true)][string]$Sprint,
    [Parameter(Mandatory=$true)][string]$Activity,
    [Parameter(Mandatory=$false)][string]$RagEndpoint = "http://127.0.0.1:8088",
    [Parameter(Mandatory=$false)][string[]]$Paths,
    [Parameter(Mandatory=$false)][string]$Collection,
    [Parameter(Mandatory=$false)][string]$Role,
    [Parameter(Mandatory=$false)][int]$TopK = 8,
    [Parameter(Mandatory=$false)][switch]$Rerank
)

$ErrorActionPreference = 'Stop'

function Write-Info($msg) { Write-Host "[enrich] $msg" -ForegroundColor Cyan }
function Write-Warn($msg) { Write-Warning "[enrich] $msg" }
function Write-Err ($msg) { Write-Error "[enrich] $msg" }

if (-not $Collection) { $Collection = "sprint$Sprint-activity$Activity" }
if (-not $Role) { $Role = $AgentId }

# Default paths: docs + current sprint/activity outputs
if (-not $Paths -or $Paths.Count -eq 0) {
    $Paths = @(
        "docs",
        "agents/manual",
        "data/out/sprint$Sprint/$Activity"
    )
}

Write-Info "AgentId=$AgentId Sprint=$Sprint Activity=$Activity Collection=$Collection Role=$Role"
Write-Info "Paths: $($Paths -join ', ')"

# Ensure enrichment output folder exists
$enrichOut = Join-Path -Path "data/out/sprint$Sprint/$Activity" -ChildPath "enrichment"
if (-not (Test-Path $enrichOut)) { New-Item -ItemType Directory -Force -Path $enrichOut | Out-Null }

# 1) Ingest updated content
$ingestBody = @{ paths = $Paths; recursive = $true; collection = $Collection; role = $Role } | ConvertTo-Json -Depth 5
try {
    Write-Info "POST /ingest"
    $ingestRes = Invoke-RestMethod -Method Post -Uri "$RagEndpoint/ingest" -ContentType 'application/json' -Body $ingestBody
} catch {
    Write-Warn "Falha ao chamar /ingest: $($_.Exception.Message)"
    $ingestRes = @{ error = $_.Exception.Message }
}

# 2) Optional: prewarm retrieval for next agent
$queryBody = @{ question = "Resumo das mudanças da etapa $AgentId"; topK = $TopK; rerank = [bool]$Rerank; filters = @{ role = @($Role); sprint = $Sprint; activity = $Activity } } | ConvertTo-Json -Depth 5
try {
    Write-Info "POST /query (prewarm)"
    $queryRes = Invoke-RestMethod -Method Post -Uri "$RagEndpoint/query" -ContentType 'application/json' -Body $queryBody
} catch {
    Write-Warn "Falha ao chamar /query: $($_.Exception.Message)"
    $queryRes = @{ error = $_.Exception.Message }
}

# 3) Persist bundle for audit/next step
$bundle = [ordered]@{
    timestamp = (Get-Date).ToString('s')
    agentId   = $AgentId
    sprint    = $Sprint
    activity  = $Activity
    collection = $Collection
    role = $Role
    ingestResponse = $ingestRes
    queryPreview   = $queryRes
}
$bundlePath = Join-Path $enrichOut "_last-$($AgentId).json"
$bundle | ConvertTo-Json -Depth 8 | Out-File -FilePath $bundlePath -Encoding utf8
Write-Info "Bundle salvo em: $bundlePath"

Write-Host "[enrich] Concluido." -ForegroundColor Green
