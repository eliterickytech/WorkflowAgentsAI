param(
  [Parameter(Mandatory=$true)][string]$Sprint,
  [Parameter(Mandatory=$true)][string]$Activity
)

# Função para escrever informações
function Write-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }

# Validar parâmetros
if ([string]::IsNullOrWhiteSpace($Sprint)) { 
  Write-Error "Sprint é obrigatório (ex: 01, 02, 03)"
  exit 1
}

if ([string]::IsNullOrWhiteSpace($Activity)) { 
  Write-Error "Activity é obrigatória (ex: rn0001, rn0025)"
  exit 1
}

Write-Info "Criando nova atividade: Sprint $Sprint / Activity $Activity"

# Criar estrutura de entrada
$inputBase = "in\sprint$Sprint\$Activity"
$businessRequestPath = Join-Path $inputBase "business_request"
$attachmentsPath = Join-Path $inputBase "attachments"

Write-Info "Criando estrutura de entrada..."
$null = New-Item -ItemType Directory -Force -Path $businessRequestPath
$null = New-Item -ItemType Directory -Force -Path $attachmentsPath

# Criar estrutura de saída
$outputBase = "data\out\sprint$Sprint\$Activity"
$null = New-Item -ItemType Directory -Force -Path $outputBase
$null = New-Item -ItemType Directory -Force -Path (Join-Path $outputBase "features")
$null = New-Item -ItemType Directory -Force -Path (Join-Path $outputBase "adrs")
$null = New-Item -ItemType Directory -Force -Path (Join-Path $outputBase "diagrams")

# Criar arquivo template de solicitação
$templateContent = @"
# Solicitação - $Activity

## 📋 Descrição
[Descreva aqui o que precisa ser implementado]

## 🎯 Objetivo
[Por que esta funcionalidade é necessária?]

## ✅ Critérios de Sucesso
- [ ] Critério 1
- [ ] Critério 2  
- [ ] Critério 3

## 📎 Informações Adicionais
[Qualquer contexto extra, stakeholders, prioridades, etc.]

---
**Sprint:** $Sprint  
**Activity:** $Activity  
**Data:** $(Get-Date -Format 'dd/MM/yyyy')
"@

$templateFile = Join-Path $businessRequestPath "solicitacao.md"
Set-Content -Path $templateFile -Value $templateContent -Encoding UTF8

Write-Info "✅ Estrutura criada com sucesso!"
Write-Host ""
Write-Host "📁 Estrutura criada:" -ForegroundColor Yellow
Write-Host "   📥 ENTRADA:" -ForegroundColor Cyan
Write-Host "   - $businessRequestPath" -ForegroundColor Gray
Write-Host "   - $attachmentsPath" -ForegroundColor Gray
Write-Host "   📤 SAÍDA:" -ForegroundColor Cyan  
Write-Host "   - $outputBase" -ForegroundColor Gray
Write-Host ""
Write-Host "📝 Próximos passos:" -ForegroundColor Yellow
Write-Host "   1. Edite: $templateFile" -ForegroundColor Gray
Write-Host "   2. Adicione documentos em: $attachmentsPath" -ForegroundColor Gray
Write-Host "   3. Execute: .\powershell\start-manual.ps1 -Sprint $Sprint -Activity $Activity" -ForegroundColor Gray
Write-Host ""
Write-Host "🚀 Ou use GitHub Copilot Chat:" -ForegroundColor Yellow
Write-Host "   @agents/manual/product-owner.agent.md" -ForegroundColor Gray
Write-Host "   Sprint: $Sprint, Activity: $Activity" -ForegroundColor Gray