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

# Verificar se existe an�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡lise de projeto existente
$projectContext = ""
$contextFile = Join-Path (Split-Path $base) "project-analysis.md"
if (Test-Path $contextFile) {
  $projectContext = @"

## �f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'â�,�š�f�?s�,�f�'�,¢�f¢â�,�š�,¬�f¢â�?s¬�,�f�'�?�?T�f�?s�,¯�f�'â�,�š�f�?s�,¸�f�'â�,�š�f�?s�, CONTEXTO DO PROJETO EXISTENTE

**AN�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,LISE AUTOM�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,TICA DISPON�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,VEL:** ``project-analysis.md``

### �f�'�?�?T�f�?s�,¢�f�'â�,�¦�f�?s�,¡�f�'â�,�š�f�?s�, �f�'�?�?T�f�?s�,¯�f�'â�,�š�f�?s�,¸�f�'â�,�š�f�?s�, **INSTRU�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O CR�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,TICA PARA TODOS OS AGENTES:**

1. **LEIA PRIMEIRO** o arquivo ``project-analysis.md`` antes de propor qualquer solu�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o
2. **MANTENHA CONSIST�f�'�?�?T�f�?�â�,��"��f�'â�,�¦�f�?s�, NCIA** com a arquitetura e tecnologias existentes
3. **INTEGRE** suas propostas com a estrutura atual (n�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o substitua)
4. **USE** as mesmas bibliotecas, padr�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes e conven�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes j�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡ estabelecidos

**Esta an�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡lise cont�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©m informa�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes sobre:**
- Estrutura arquitetural atual
- Tecnologias e frameworks em uso
- Padr�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes de c�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³digo estabelecidos
- Configura�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes de banco de dados
- Frameworks de teste configurados

"@
}

$runbook = @"
# Manual Runbook �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix
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
- **99-checklist-final.md** (Product Owner Final - �f�'�?�?T�f�?�â�,��"��f�'â�,�¦�f�?s�,¡LTIMO)

Politica: Nao faca perguntas; se faltar informacao, adote ate 3 suposicoes razoaveis, liste-as no inicio e prossiga.

**FLUXO AUTOMATIZADO COM APROVA�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¢ES (VS Code Copilot Chat):**

�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'â�,�¦�f�?s�,½�f�'â�,�š�f�?s�,¯ **IN�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,CIO:** @agents/manual/product-owner.agent.md
   - An�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡lise de neg�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³cio �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�,�š�,¬�f�?s�, �f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢ 00-business-context.md + 00-requirements-brief.md
   - **APROVA�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O:** [SIM] ou [N�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Mesa Redonda

�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'â�,�¦�f�?s�,½�f�'â�,�š�f�?s�,ª **MESA REDONDA:** @agents/manual/roundtable-facilitator.agent.md
   - Discuss�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o t�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnica �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�,�š�,¬�f�?s�, �f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢ 01-ata-mesa-redonda.md
   - **APROVA�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O:** [SIM] ou [N�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Requirements Analyst

�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'�,¢�f¢â�,�š�,¬�f�?�â�,��"�f�'�,¢�f¢â�,�š�,¬�f�?s�,¹ **REQUIREMENTS:** @agents/manual/requirements-analyst.agent.md
   - An�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡lise BDD �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�,�š�,¬�f�?s�, �f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢ 02-requisitos-bdd.md + features/
   - **APROVA�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O:** [SIM] ou [N�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Systems Architect

�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'â�,�š�f�?s�,�f�'�,¢�f¢â�,�š�,¬�f¢â�?s¬�,�f�'�?�?T�f�?s�,¯�f�'â�,�š�f�?s�,¸�f�'â�,�š�f�?s�, **ARCHITECTURE:** @agents/manual/systems-architect.agent.md
   - Design t�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnico �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�,�š�,¬�f�?s�, �f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢ 03-arquitetura.md + adrs/ + diagrams/
   - **APROVA�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O:** [SIM] ou [N�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Expert Developer

�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢�f�'â�,�š�f�?s�,» **DEVELOPMENT:** @agents/manual/expert-developer.agent.md
   - Implementa�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�,�š�,¬�f�?s�, �f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢ 04-desenvolvimento.md + engineering/src/ + tests/
   - **APROVA�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O:** [SIM] ou [N�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Frontend Specialist

�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'â�,�¦�f�?s�,½�f�'â�,�š�f�?s�,¨ **FRONTEND:** @agents/manual/frontend-specialist.agent.md
   - Interface �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�,�š�,¬�f�?s�, �f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢ 04-frontend-implementation.md + 04-components/ + 04-ui-guidelines.md
   - **APROVA�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O:** [SIM] ou [N�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O] para prosseguir
   - **SE SIM:** Executa automaticamente Testing Specialist

�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'â�,�š�f�?s�,§�f�'â�,�š�f�?s�,ª **TESTING:** @agents/manual/testing-specialist.agent.md
   - Plano QA �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�,�š�,¬�f�?s�, �f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢ 05-qa-plano.md + engineering/reports/
   - **EXECU�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O AUTOM�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,TICA:** Product Owner Final

�f�'�?�?T�f�?s�,¢�f�'â�,�¦�f¢â�?s¬�.�?o�f�'�,¢�f¢â�,�š�,¬�f�?s�,¦ **FINAL:** @agents/manual/product-owner-final.agent.md
   - Checklist completo �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�,�š�,¬�f�?s�, �f�'�,¢�f¢â�,�š�,¬�f¢â�,�ž�,¢ 99-checklist-final.md
   - **DECIS�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O FINAL:** APROVADO ou NECESSITA AJUSTES

**�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'â�,�¦�f�?s�,¡�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬ FLUXO COMPLETO EM UMA EXECU�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?s�,¡�f�'�?�?T�f�?�â�,��"��f�'â�,� �f¢â�?s¬â�?z¢O COM CONTROLE TOTAL!**

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
# 00 - Business Context �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

**Product Owner:** [An�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡lise de Neg�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³cio]

## Contexto da Demanda
- **Fonte:** $Context
- **Stakeholders:** [A definir]
- **Valor de Neg�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³cio:** [A definir]

## Objetivos Estrat�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©gicos
- [ ] Objetivo 1
- [ ] Objetivo 2
- [ ] Objetivo 3

## Prioridades
1. **Alta:** [Definir]
2. **M�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©dia:** [Definir]
3. **Baixa:** [Definir]

## Crit�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©rios de Sucesso
- **M�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©trica 1:** [A definir]
- **M�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©trica 2:** [A definir]

## Riscos Identificados
- **Risco 1:** [Impacto + Mitiga�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o]
- **Risco 2:** [Impacto + Mitiga�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o]

## Aprova�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o para Mesa Redonda
- [ ] Contexto definido
- [ ] Prioridades estabelecidas
- [ ] Stakeholders identificados
"@
New-FileIfMissing -Path $f00a -Content $c00a

# 00 - Requirements Brief (Product Owner)
$f00b = Join-Path $base "00-requirements-brief.md"
$c00b = @"
# 00 - Requirements Brief �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

**Product Owner:** [Briefing para Equipe T�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnica]

## Vis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o do Produto
[Descreva a vis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o geral]

## User Stories Priorizadas
### Epic: [Nome do Epic]

#### US001 - [T�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,­tulo]
- **Como:** [Persona]
- **Quero:** [Funcionalidade]
- **Para:** [Benef�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,­cio]
- **Prioridade:** [Alta/M�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©dia/Baixa]
- **Crit�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©rios de Aceita�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o:**
  - [ ] Crit�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©rio 1
  - [ ] Crit�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©rio 2

#### US002 - [T�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,­tulo]
- **Como:** [Persona]
- **Quero:** [Funcionalidade]
- **Para:** [Benef�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,­cio]
- **Prioridade:** [Alta/M�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©dia/Baixa]

## Defini�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o de Pronto
- [ ] C�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³digo implementado
- [ ] Testes unit�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡rios (90%+ cobertura)
- [ ] Documenta�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o atualizada
- [ ] Aprova�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o do PO

## Pr�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³ximos Passos
1. **Mesa Redonda:** Discuss�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o t�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnica com toda equipe
2. **BDD:** Elabora�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o detalhada de cen�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡rios
3. **Arquitetura:** Design t�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnico da solu�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o
"@
New-FileIfMissing -Path $f00b -Content $c00b

# 01 - Ata da Mesa Redonda
$f01 = Join-Path $base "01-ata-mesa-redonda.md"
$c01 = @"
# 01 - Ata da Mesa Redonda �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

**Pr�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©-requisito:** Leia primeiro 00-business-context.md e 00-requirements-brief.md

Contexto: $Context

Politica: Nao faca perguntas; se faltar informacao, adote ate 3 suposicoes razoaveis, liste-as abaixo e prossiga.

Suposicoes:
-
-
-

Participantes: Product Owner, Requirements Analyst, Systems Architect, Expert Developer, Testing Specialist

## Contexto do PO (Resumo)
- **Valor de Neg�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³cio:** [Do 00-business-context.md]
- **Prioridades:** [Do 00-business-context.md]
- **User Stories:** [Do 00-requirements-brief.md]

## Decis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes T�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnicas
- [ ] Decis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o 1 �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Justificativa
- [ ] Decis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o 2 �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Justificativa

## Alinhamentos
- **Arquitetura:** [Consenso sobre approach]
- **Tecnologias:** [Stack aprovada]
- **Integra�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes:** [APIs e depend�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,ªncias]

Acoes e responsaveis:
- [ ] Item �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Responsavel �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Prazo
"@
New-FileIfMissing -Path $f01 -Content $c01

# 02 - Requisitos (BDD)
$f02 = Join-Path $base "02-requisitos-bdd.md"
$c02 = @"
# 02 - Requisitos (BDD) �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

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
# 03 - Arquitetura �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

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
# 04 - Desenvolvimento �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

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
# 04 - Frontend Implementation �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

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
# 04 - UI Guidelines �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

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
# 05 - Plano de QA �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

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
# ADR-XXXX �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Titulo da Decisao

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
# 99 - Checklist Final �f�'�?�?T�f�?s�,¢�f�'�,¢�f¢â�?s¬�.¡�f�?s�,¬�f�'�,¢�f¢â�,�š�,¬�f�?s�, Sprint $Sprint$suffix

**Product Owner Final:** [Valida�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o Completa da Entrega]

## Status dos Artefatos

### �f�'�?�?T�f�?s�,¢�f�'â�,�¦�f¢â�?s¬�.�?o�f�'�,¢�f¢â�,�š�,¬�f�?s�,¦ An�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡lise de Neg�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³cio
- [ ] 00-business-context.md - Contexto e valor de neg�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³cio definidos
- [ ] 00-requirements-brief.md - Briefing t�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnico completo

### �f�'�?�?T�f�?s�,¢�f�'â�,�¦�f¢â�?s¬�.�?o�f�'�,¢�f¢â�,�š�,¬�f�?s�,¦ Alinhamento T�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnico
- [ ] 01-ata-mesa-redonda.md - Decis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes t�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnicas consensuais

### �f�'�?�?T�f�?s�,¢�f�'â�,�¦�f¢â�?s¬�.�?o�f�'�,¢�f¢â�,�š�,¬�f�?s�,¦ Especifica�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o
- [ ] 02-requisitos-bdd.md - An�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡lise BDD completa
- [ ] features/*.feature - Cen�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡rios Gherkin abrangentes

### �f�'�?�?T�f�?s�,¢�f�'â�,�¦�f¢â�?s¬�.�?o�f�'�,¢�f¢â�,�š�,¬�f�?s�,¦ Arquitetura
- [ ] 03-arquitetura.md - Design t�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnico documentado
- [ ] adrs/*.md - Decis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes arquiteturais justificadas
- [ ] diagrams/*.mmd - Diagramas t�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©cnicos claros

### �f�'�?�?T�f�?s�,¢�f�'â�,�¦�f¢â�?s¬�.�?o�f�'�,¢�f¢â�,�š�,¬�f�?s�,¦ Implementa�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o
- [ ] 04-desenvolvimento.md - Notas de desenvolvimento backend
- [ ] 04-frontend-implementation.md - Implementa�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o frontend
- [ ] 04-components/ - Estrutura de componentes
- [ ] 04-ui-guidelines.md - Guidelines de interface
- [ ] engineering/src/ - C�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³digo implementado
- [ ] engineering/tests/ - Testes unit�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡rios

### �f�'�?�?T�f�?s�,¢�f�'â�,�¦�f¢â�?s¬�.�?o�f�'�,¢�f¢â�,�š�,¬�f�?s�,¦ Qualidade
- [ ] 05-qa-plano.md - Estrat�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©gia de testes definida
- [ ] engineering/reports/ - Evid�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,ªncias de qualidade

## Crit�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©rios de Aceita�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o

### Funcionais
- [ ] Todas as User Stories implementadas
- [ ] Cen�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡rios BDD cobertos por testes
- [ ] Regras de neg�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³cio validadas

### N�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o-Funcionais
- [ ] Arquitetura alinhada com padr�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,µes corporativos
- [ ] C�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³digo seguindo boas pr�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡ticas
- [ ] Cobertura de testes adequada (>90%)
- [ ] Documenta�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o completa e atualizada

## Decis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o Final

�f�'�?�?T�f�?s�,¢�f�'â�,�š�f�?s�,�f�'â�,�š�f�?s�,³ **STATUS:** [PENDENTE AN�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,LISE]

�f�'�?�?T�f�?s�,°�f�'â�,�¦�f�?s�,¸�f�'â�,�¦�f�?s�,½�f�'â�,�š�f�?s�,¯ **PR�f�'�?�?T�f�?�â�,��"��f�'�,¢�f¢â�,�š�,¬�f�?�â�,��"XIMOS PASSOS:**
1. Aguardando valida�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o do Product Owner Final
2. Revis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o de crit�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,©rios de aceita�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,§�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o
3. Decis�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,£o: APROVADO ou NECESSITA AJUSTES

---
**Este checklist ser�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡ preenchido automaticamente pelo Product Owner Final ap�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,³s an�f�'�?�?T�f�?�â�,��"��f�'â�,�š�f�?s�,¡lise completa dos artefatos.**
"@
New-FileIfMissing -Path $f99 -Content $c99
