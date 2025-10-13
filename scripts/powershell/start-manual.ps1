param(
  [Parameter(Mandatory=$true)][string]$Sprint,
  [string]$Activity = "",
  [string]$Context = ""
)

$base = Join-Path (Join-Path $PSScriptRoot "..\data\out") ("sprint" + $Sprint)
if ($Activity) { $base = Join-Path $base $Activity }

$null = New-Item -ItemType Directory -Force -Path $base
$null = New-Item -ItemType Directory -Force -Path (Join-Path $base "features")
$null = New-Item -ItemType Directory -Force -Path (Join-Path $base "engineering\src")
$null = New-Item -ItemType Directory -Force -Path (Join-Path $base "engineering\tests")
$null = New-Item -ItemType Directory -Force -Path (Join-Path $base "engineering\reports")
$null = New-Item -ItemType Directory -Force -Path (Join-Path $base "attachments")
# Sprint-local: ADRs, Diagramas e Componentes Frontend
$null = New-Item -ItemType Directory -Force -Path (Join-Path $base "adrs")
$null = New-Item -ItemType Directory -Force -Path (Join-Path $base "diagrams")
$null = New-Item -ItemType Directory -Force -Path (Join-Path $base "04-components")

# Caminhos relativos para links no runbook
$relRoot = "..\..\"
if ($Activity -and $Activity.Trim().Length -gt 0) { $relRoot = "..\..\..\" }
$relPrompts = "$relRoot" + "src\\workflow_agents\\assets\\references\\prompts"
$relDocsAdrs = "adrs"
$relDocsDiagrams = "diagrams"

$suffix = ""
if ($Activity -and $Activity.Trim().Length -gt 0) { $suffix = " / $Activity" }

# Verificar se existe anf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡lise de projeto existente
$projectContext = ""
$contextFile = Join-Path (Split-Path $base) "project-analysis.md"
if (Test-Path $contextFile) {
  $projectContext = @"

## f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢?sÃ‚Â¬,Ã‚Âf'??Tf?s,Ã‚Â¯f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¸f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â CONTEXTO DO PROJETO EXISTENTE

**ANf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂLISE AUTOMf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂTICA DISPONf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂVEL:** ``project-analysis.md``

### f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¡f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â f'??Tf?s,Ã‚Â¯f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¸f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â **INSTRUf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O CRf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂTICA PARA TODOS OS AGENTES:**

1. **LEIA PRIMEIRO** o arquivo ``project-analysis.md`` antes de propor qualquer soluf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o
2. **MANTENHA CONSISTf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â NCIA** com a arquitetura e tecnologias existentes
3. **INTEGRE** suas propostas com a estrutura atual (nf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o substitua)
4. **USE** as mesmas bibliotecas, padrf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes e convenf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes jf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡ estabelecidos

**Esta anf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡lise contf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©m informaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes sobre:**
- Estrutura arquitetural atual
- Tecnologias e frameworks em uso
- Padrf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes de cf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³digo estabelecidos
- Configuraf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes de banco de dados
- Frameworks de teste configurados

"@
}

$runbook = @"
# Manual Runbook f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix
$projectContext
Contexto: $Context

Arquivos-alvo nesta sprint/atividade:
- **00-business-context.md, 00-requirements-brief.md** (Product Owner - PRIMEIRO)
- 01-ata-mesa-redonda.md
- 02-requisitos-bdd.md + features/*.feature
- 03-arquitetura.md (ADRs em adrs/; diagramas em diagrams/)
- 04-desenvolvimento.md
- **04-frontend-implementation.md + 04-components/ + 04-ui-guidelines.md** (Frontend Specialist)
- 05-qa-plano.md
- **99-checklist-final.md** (Product Owner Final - f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¡LTIMO)

Politica: Nao faca perguntas; se faltar informacao, adote ate 3 suposicoes razoaveis, liste-as no inicio e prossiga.

**FLUXO AUTOMATIZADO COM APROVAf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¢ES (VS Code Copilot Chat):**

f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â½f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¯ **INf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂCIO:** @agents/manual/product-owner.agent.md
   - Anf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡lise de negf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³cio f'??Tf?s,Ã‚Â¢ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢ 00-business-context.md + 00-requirements-brief.md
   - **APROVAf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O:** [SIM] ou [Nf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Mesa Redonda

f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â½f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âª **MESA REDONDA:** @agents/manual/roundtable-facilitator.agent.md
   - Discussf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnica f'??Tf?s,Ã‚Â¢ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢ 01-ata-mesa-redonda.md
   - **APROVAf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O:** [SIM] ou [Nf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Requirements Analyst

f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¹ **REQUIREMENTS:** @agents/manual/requirements-analyst.agent.md
   - Anf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡lise BDD f'??Tf?s,Ã‚Â¢ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢ 02-requisitos-bdd.md + features/
   - **APROVAf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O:** [SIM] ou [Nf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Systems Architect

f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢?sÃ‚Â¬,Ã‚Âf'??Tf?s,Ã‚Â¯f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¸f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â **ARCHITECTURE:** @agents/manual/systems-architect.agent.md
   - Design tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnico f'??Tf?s,Ã‚Â¢ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢ 03-arquitetura.md + adrs/ + diagrams/
   - **APROVAf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O:** [SIM] ou [Nf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Expert Developer

f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â» **DEVELOPMENT:** @agents/manual/expert-developer.agent.md
   - Implementaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o f'??Tf?s,Ã‚Â¢ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢ 04-desenvolvimento.md + engineering/src/ + tests/
   - **APROVAf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O:** [SIM] ou [Nf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Frontend Specialist

f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â½f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¨ **FRONTEND:** @agents/manual/frontend-specialist.agent.md
   - Interface f'??Tf?s,Ã‚Â¢ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢ 04-frontend-implementation.md + 04-components/ + 04-ui-guidelines.md
   - **APROVAf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O:** [SIM] ou [Nf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Testing Specialist

f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âª **TESTING:** @agents/manual/testing-specialist.agent.md
   - Plano QA f'??Tf?s,Ã‚Â¢ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢ 05-qa-plano.md + engineering/reports/
   - **EXECUf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O AUTOMf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂTICA:** Product Owner Final

f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã‚Â¦âÃÂ¢?sÃ‚Â¬.?oââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¦ **FINAL:** @agents/manual/product-owner-final.agent.md
   - Checklist completo f'??Tf?s,Ã‚Â¢ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â ââÃÂ¢,Ã…Â¡,Ã‚Â¬âÃÂ¢,Ã…Â¾,Ã‚Â¢ 99-checklist-final.md
   - **DECISf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O FINAL:** APROVADO ou NECESSITA AJUSTES

**f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¡ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ FLUXO COMPLETO EM UMA EXECUf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¡f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã‚Â âÃÂ¢?sÃ‚Â¬ÃÂ¢?zÃ‚Â¢O COM CONTROLE TOTAL!**

Links rapidos:
- Indice de Prompts: $relPrompts\README.md

- Referencias principais:
  - Mesa Redonda: $relPrompts\reference\1-mesa-redonda-rn0002-gpt5.md
  - Requirements Analyst: $relPrompts\reference\2-requirements-rn0002-gemini.md
  - Systems Architect: $relPrompts\reference\3-architecture-rn0002-gpt5.md
  - Expert Developer: $relPrompts\reference\4-development-rn0002-claude4.md
  - Testing Specialist: $relPrompts\reference\5-testing-rn0002-claude4.md
  - Guia de execucao: $relPrompts\reference\README-execucao.md

Templates de documentacao:
- ADR (Nygard): $relDocsAdrs\template-adr.md
- Diagrama (Mermaid): $relDocsDiagrams\template-diagram.mmd
"@

$runbookPath = Join-Path $base "manual_runbook.md"
$runbook | Out-File -FilePath $runbookPath -Encoding utf8
Write-Host "Manual runbook criado em: $runbookPath"

# Helpers: cria arquivo se nao existir
function New-FileIfMissing {
  param(
    [Parameter(Mandatory=$true)][string]$Path,
    [Parameter(Mandatory=$true)][string]$Content
  )
  if (-not (Test-Path -Path $Path)) {
    $Content | Out-File -FilePath $Path -Encoding utf8
    Write-Host "Criado: $Path"
  }
  else {
    Write-Host "Ja existe, mantendo: $Path"
  }
}

# 00 - Business Context (Product Owner)
$f00a = Join-Path $base "00-business-context.md"
$c00a = @"
# 00 - Business Context f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

**Product Owner:** [Anf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡lise de Negf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³cio]

## Contexto da Demanda
- **Fonte:** $Context
- **Stakeholders:** [A definir]
- **Valor de Negf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³cio:** [A definir]

## Objetivos Estratf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©gicos
- [ ] Objetivo 1
- [ ] Objetivo 2
- [ ] Objetivo 3

## Prioridades
1. **Alta:** [Definir]
2. **Mf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©dia:** [Definir]
3. **Baixa:** [Definir]

## Critf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©rios de Sucesso
- **Mf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©trica 1:** [A definir]
- **Mf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©trica 2:** [A definir]

## Riscos Identificados
- **Risco 1:** [Impacto + Mitigaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o]
- **Risco 2:** [Impacto + Mitigaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o]

## Aprovaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o para Mesa Redonda
- [ ] Contexto definido
- [ ] Prioridades estabelecidas
- [ ] Stakeholders identificados
"@
New-FileIfMissing -Path $f00a -Content $c00a

# 00 - Requirements Brief (Product Owner)
$f00b = Join-Path $base "00-requirements-brief.md"
$c00b = @"
# 00 - Requirements Brief f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

**Product Owner:** [Briefing para Equipe Tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnica]

## Visf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o do Produto
[Descreva a visf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o geral]

## User Stories Priorizadas
### Epic: [Nome do Epic]

#### US001 - [Tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â­tulo]
- **Como:** [Persona]
- **Quero:** [Funcionalidade]
- **Para:** [Beneff'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â­cio]
- **Prioridade:** [Alta/Mf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©dia/Baixa]
- **Critf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©rios de Aceitaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o:**
  - [ ] Critf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©rio 1
  - [ ] Critf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©rio 2

#### US002 - [Tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â­tulo]
- **Como:** [Persona]
- **Quero:** [Funcionalidade]
- **Para:** [Beneff'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â­cio]
- **Prioridade:** [Alta/Mf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©dia/Baixa]

## Definif'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o de Pronto
- [ ] Cf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³digo implementado
- [ ] Testes unitf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡rios (90%+ cobertura)
- [ ] Documentaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o atualizada
- [ ] Aprovaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o do PO

## Prf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³ximos Passos
1. **Mesa Redonda:** Discussf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnica com toda equipe
2. **BDD:** Elaboraf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o detalhada de cenf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡rios
3. **Arquitetura:** Design tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnico da soluf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o
"@
New-FileIfMissing -Path $f00b -Content $c00b

# 01 - Ata da Mesa Redonda
$f01 = Join-Path $base "01-ata-mesa-redonda.md"
$c01 = @"
# 01 - Ata da Mesa Redonda f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

**Prf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©-requisito:** Leia primeiro 00-business-context.md e 00-requirements-brief.md

Contexto: $Context

Politica: Nao faca perguntas; se faltar informacao, adote ate 3 suposicoes razoaveis, liste-as abaixo e prossiga.

Suposicoes:
-
-
-

Participantes: Product Owner, Requirements Analyst, Systems Architect, Expert Developer, Testing Specialist

## Contexto do PO (Resumo)
- **Valor de Negf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³cio:** [Do 00-business-context.md]
- **Prioridades:** [Do 00-business-context.md]
- **User Stories:** [Do 00-requirements-brief.md]

## Decisf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes Tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnicas
- [ ] Decisf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o 1 f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Justificativa
- [ ] Decisf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o 2 f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Justificativa

## Alinhamentos
- **Arquitetura:** [Consenso sobre approach]
- **Tecnologias:** [Stack aprovada]
- **Integraf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes:** [APIs e dependf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âªncias]

Acoes e responsaveis:
- [ ] Item f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Responsavel f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Prazo
"@
New-FileIfMissing -Path $f01 -Content $c01

# 02 - Requisitos (BDD)
$f02 = Join-Path $base "02-requisitos-bdd.md"
$c02 = @"
# 02 - Requisitos (BDD) f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

Fonte: [especifique .docx/.xlsx]
Regra alvo: RN-00xx

Cenarios (Gherkin) adicionais devem ser salvos em: $base\features\

Criterios de aceitacao (resumo):
-

Casos de teste:
-
"@
New-FileIfMissing -Path $f02 -Content $c02

# 03 - Arquitetura
$f03 = Join-Path $base "03-arquitetura.md"
$c03 = @"
# 03 - Arquitetura f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

Escopo/regra: RN-00xx

Diretrizes:
- .NET Framework 4.8, DDD, SOLID, Clean Architecture

Decisoes:
-

ADRs: usar adrs\ (template Nygard)
Diagramas: usar diagrams\ (Mermaid)

Estrutura proposta:
-
"@
New-FileIfMissing -Path $f03 -Content $c03

# 04 - Desenvolvimento
$f04 = Join-Path $base "04-desenvolvimento.md"
$c04 = @"
# 04 - Desenvolvimento f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

Componentes:
-

Tarefas:
- [ ] Implementar ...
- [ ] Validar ...
- [ ] Logs/Erro ...

Codigo: $base\engineering\src
Testes: $base\engineering\tests
"@
New-FileIfMissing -Path $f04 -Content $c04

# 04 - Frontend Implementation
$f04Frontend = Join-Path $base "04-frontend-implementation.md"
$c04Frontend = @"
# 04 - Frontend Implementation f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

## Technology Stack
- **Framework:** [Angular/React]
- **UI Library:** [PO-UI/Material/Sean Themes]
- **State Management:** [NgRx/Redux/Context]
- **Styling:** [SCSS/Styled-Components/Tailwind]

## Component Architecture
### Atomic Components
- Button, Input, Card, Modal...

### Composite Components
- DataTable, Form, Navigation...

### Page Components
- Dashboard, Profile, Settings...

## Performance Strategy
- Bundle size targets: <250KB initial
- Lazy loading implementation
- Caching strategies

## Testing Coverage
- Unit: 90%+ coverage
- Integration: Key user flows
- E2E: Critical paths

## Accessibility Compliance
- WCAG 2.1 AA compliance
- Keyboard navigation
- Screen reader optimization

Componentes: $base\04-components\
UI Guidelines: $base\04-ui-guidelines.md
"@
New-FileIfMissing -Path $f04Frontend -Content $c04Frontend

# 04 - UI Guidelines
$f04UiGuidelines = Join-Path $base "04-ui-guidelines.md"
$c04UiGuidelines = @"
# 04 - UI Guidelines f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

## Design Tokens
```scss
// Colors
--primary-50: #f0f9ff;
--primary-500: #3b82f6;
--primary-900: #1e3a8a;

// Typography
--font-family-sans: 'Inter', system-ui, sans-serif;
--font-size-base: 1rem;

// Spacing
--space-xs: 0.25rem;
--space-sm: 0.5rem;
--space-md: 1rem;
```

## Component Patterns
### Button States
- Default, Hover, Active, Disabled
- Primary, Secondary, Tertiary variants

### Form Validation
- Real-time validation
- Error state styling
- Success feedback

## Responsive Breakpoints
- xs: 0px
- sm: 576px
- md: 768px
- lg: 992px
- xl: 1200px

## Accessibility Standards
- Color contrast ratio 4.5:1
- Keyboard navigation support
- Screen reader compatibility
- ARIA labels implementation

## Animation Guidelines
- Transition duration: 200-300ms
- Easing: ease-in-out
- Micro-interactions for feedback
"@
New-FileIfMissing -Path $f04UiGuidelines -Content $c04UiGuidelines

# 05 - Plano de QA
$f05 = Join-Path $base "05-qa-plano.md"
$c05 = @"
# 05 - Plano de QA f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

Alvo:
-

Estrategia:
- Testes unitarios xUnit + FluentAssertions
- Fixtures via Bogus
- Cobertura minima 90%

Casos criticos:
-

Evidencias e relatorios: $base\engineering\reports
"@
New-FileIfMissing -Path $f05 -Content $c05

# Templates de documentacao (criadas se faltarem)
$adrTemplate = Join-Path $base "adrs\template-adr.md"
$adrContent = @"
# ADR-XXXX f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Titulo da Decisao

- Status: Proposed
- Data: $(Get-Date -Format 'yyyy-MM-dd')
- Contexto:
  - [Descreva o problema e as forcas em jogo]
- Decisao:
  - [Decisao tomada e a justificativa]
- Consequencias:
  - [Impactos positivos e negativos]
- Alternativas consideradas:
  - [Opcoes descartadas e por que]
"@
New-FileIfMissing -Path $adrTemplate -Content $adrContent

$diagramTemplate = Join-Path $base "diagrams\template-diagram.mmd"
$diagramContent = @"
%% Mermaid Diagram Template
flowchart TD
  A[Start] --> B[Step]
  B --> C{Decision}
  C -- Yes --> D[Path 1]
  C -- No  --> E[Path 2]
"@
New-FileIfMissing -Path $diagramTemplate -Content $diagramContent

# 99 - Checklist Final (Product Owner Final)
$f99 = Join-Path $base "99-checklist-final.md"
$c99 = @"
# 99 - Checklist Final f'??Tf?s,Ã‚Â¢ââÃÂ¢?sÃ‚Â¬.Ã‚Â¡f?s,Ã‚Â¬ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â Sprint $Sprint$suffix

**Product Owner Final:** [Validaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o Completa da Entrega]

## Status dos Artefatos

### f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã‚Â¦âÃÂ¢?sÃ‚Â¬.?oââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¦ Anf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡lise de Negf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³cio
- [ ] 00-business-context.md - Contexto e valor de negf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³cio definidos
- [ ] 00-requirements-brief.md - Briefing tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnico completo

### f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã‚Â¦âÃÂ¢?sÃ‚Â¬.?oââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¦ Alinhamento Tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnico
- [ ] 01-ata-mesa-redonda.md - Decisf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnicas consensuais

### f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã‚Â¦âÃÂ¢?sÃ‚Â¬.?oââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¦ Especificaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o
- [ ] 02-requisitos-bdd.md - Anf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡lise BDD completa
- [ ] features/*.feature - Cenf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡rios Gherkin abrangentes

### f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã‚Â¦âÃÂ¢?sÃ‚Â¬.?oââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¦ Arquitetura
- [ ] 03-arquitetura.md - Design tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnico documentado
- [ ] adrs/*.md - Decisf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes arquiteturais justificadas
- [ ] diagrams/*.mmd - Diagramas tf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©cnicos claros

### f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã‚Â¦âÃÂ¢?sÃ‚Â¬.?oââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¦ Implementaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o
- [ ] 04-desenvolvimento.md - Notas de desenvolvimento backend
- [ ] 04-frontend-implementation.md - Implementaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o frontend
- [ ] 04-components/ - Estrutura de componentes
- [ ] 04-ui-guidelines.md - Guidelines de interface
- [ ] engineering/src/ - Cf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³digo implementado
- [ ] engineering/tests/ - Testes unitf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡rios

### f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã‚Â¦âÃÂ¢?sÃ‚Â¬.?oââÃÂ¢,Ã…Â¡,Ã‚Â¬f?s,Ã‚Â¦ Qualidade
- [ ] 05-qa-plano.md - Estratf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©gia de testes definida
- [ ] engineering/reports/ - Evidf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âªncias de qualidade

## Critf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©rios de Aceitaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o

### Funcionais
- [ ] Todas as User Stories implementadas
- [ ] Cenf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡rios BDD cobertos por testes
- [ ] Regras de negf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³cio validadas

### Nf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o-Funcionais
- [ ] Arquitetura alinhada com padrf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âµes corporativos
- [ ] Cf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³digo seguindo boas prf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡ticas
- [ ] Cobertura de testes adequada (>90%)
- [ ] Documentaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o completa e atualizada

## Decisf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o Final

f'??Tf?s,Ã‚Â¢f'ÃÂ¢,Ã…Â¡f?s,Ã‚Âf'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³ **STATUS:** [PENDENTE ANf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚ÂLISE]

f'??Tf?s,Ã‚Â°f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â¸f'ÃÂ¢,Ã‚Â¦f?s,Ã‚Â½f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¯ **PRf'??Tf?ÃÂ¢,"ââÃÂ¢,Ã…Â¡,Ã‚Â¬f?ÃÂ¢,"XIMOS PASSOS:**
1. Aguardando validaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o do Product Owner Final
2. Revisf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o de critf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â©rios de aceitaf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â§f'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o
3. Decisf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â£o: APROVADO ou NECESSITA AJUSTES

---
**Este checklist serf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡ preenchido automaticamente pelo Product Owner Final apf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â³s anf'??Tf?ÃÂ¢,"f'ÃÂ¢,Ã…Â¡f?s,Ã‚Â¡lise completa dos artefatos.**
"@
New-FileIfMissing -Path $f99 -Content $c99
