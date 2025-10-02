param(
  [Parameter(Mandatory=$true)][string]$Sprint,
  [string]$Activity = "",
  [string]$Context = ""
)

$base = Join-Path (Join-Path $PSScriptRoot "..\out") ("sprint" + $Sprint)
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
$relPrompts = "$relRoot" + "prompts-manual\prompts"
$relDocsAdrs = "adrs"
$relDocsDiagrams = "diagrams"

$suffix = ""
if ($Activity -and $Activity.Trim().Length -gt 0) { $suffix = " / $Activity" }

# Verificar se existe análise de projeto existente
$projectContext = ""
$contextFile = Join-Path (Split-Path $base) "project-analysis.md"
if (Test-Path $contextFile) {
  $projectContext = @"

## 🏗️ CONTEXTO DO PROJETO EXISTENTE

**ANÁLISE AUTOMÁTICA DISPONÍVEL:** ``project-analysis.md``

### ⚠️ **INSTRUÇÃO CRÍTICA PARA TODOS OS AGENTES:**

1. **LEIA PRIMEIRO** o arquivo ``project-analysis.md`` antes de propor qualquer solução
2. **MANTENHA CONSISTÊNCIA** com a arquitetura e tecnologias existentes
3. **INTEGRE** suas propostas com a estrutura atual (não substitua)
4. **USE** as mesmas bibliotecas, padrões e convenções já estabelecidos

**Esta análise contém informações sobre:**
- Estrutura arquitetural atual
- Tecnologias e frameworks em uso
- Padrões de código estabelecidos  
- Configurações de banco de dados
- Frameworks de teste configurados

"@
}

$runbook = @"
# Manual Runbook — Sprint $Sprint$suffix
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
- **99-checklist-final.md** (Product Owner Final - ÚLTIMO)

Politica: Nao faca perguntas; se faltar informacao, adote ate 3 suposicoes razoaveis, liste-as no inicio e prossiga.

**FLUXO AUTOMATIZADO COM APROVAÇÕES (VS Code Copilot Chat):**

🎯 **INÍCIO:** @agents/manual/product-owner.agent.md
   - Análise de negócio → 00-business-context.md + 00-requirements-brief.md
   - **APROVAÇÃO:** [SIM] ou [NÃO] para prosseguir
   - **SE SIM:** Executa automaticamente Mesa Redonda

🎪 **MESA REDONDA:** @agents/manual/roundtable-facilitator.agent.md  
   - Discussão técnica → 01-ata-mesa-redonda.md
   - **APROVAÇÃO:** [SIM] ou [NÃO] para prosseguir
   - **SE SIM:** Executa automaticamente Requirements Analyst

📋 **REQUIREMENTS:** @agents/manual/requirements-analyst.agent.md
   - Análise BDD → 02-requisitos-bdd.md + features/
   - **APROVAÇÃO:** [SIM] ou [NÃO] para prosseguir  
   - **SE SIM:** Executa automaticamente Systems Architect

🏗️ **ARCHITECTURE:** @agents/manual/systems-architect.agent.md
   - Design técnico → 03-arquitetura.md + adrs/ + diagrams/
   - **APROVAÇÃO:** [SIM] ou [NÃO] para prosseguir
   - **SE SIM:** Executa automaticamente Expert Developer

💻 **DEVELOPMENT:** @agents/manual/expert-developer.agent.md  
   - Implementação → 04-desenvolvimento.md + engineering/src/ + tests/
   - **APROVAÇÃO:** [SIM] ou [NÃO] para prosseguir
   - **SE SIM:** Executa automaticamente Frontend Specialist

🎨 **FRONTEND:** @agents/manual/frontend-specialist.agent.md
   - Interface → 04-frontend-implementation.md + 04-components/ + 04-ui-guidelines.md
   - **APROVAÇÃO:** [SIM] ou [NÃO] para prosseguir
   - **SE SIM:** Executa automaticamente Testing Specialist

🧪 **TESTING:** @agents/manual/testing-specialist.agent.md
   - Plano QA → 05-qa-plano.md + engineering/reports/
   - **EXECUÇÃO AUTOMÁTICA:** Product Owner Final

✅ **FINAL:** @agents/manual/product-owner-final.agent.md
   - Checklist completo → 99-checklist-final.md
   - **DECISÃO FINAL:** APROVADO ou NECESSITA AJUSTES

**🚀 FLUXO COMPLETO EM UMA EXECUÇÃO COM CONTROLE TOTAL!**

Links rapidos:
- Indice de Prompts: $relPrompts\README.md
- Genericos:
  - Requirements Analyst: $relPrompts\requirements-analyst-prompt.md
  - Systems Architect: $relPrompts\systems-architect-prompt.md
  - Expert Developer: $relPrompts\expert-developer-prompt.md
  - Testing Specialist: $relPrompts\testing-specialist-prompt.md
- Por Modelo:
  - GPT-5 Mesa Redonda: $relPrompts\por-modelo\gpt5-mesa-redonda.md
  - GPT-5 Systems Architect: $relPrompts\por-modelo\gpt5-systems-architect.md
  - Gemini Requirements Analyst: $relPrompts\por-modelo\gemini-requirements-analyst.md
  - Claude 4 Expert Developer: $relPrompts\por-modelo\claude4-expert-developer.md
  - Claude 4 Testing Specialist: $relPrompts\por-modelo\claude4-testing-specialist.md

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
# 00 - Business Context — Sprint $Sprint$suffix

**Product Owner:** [Análise de Negócio]

## Contexto da Demanda
- **Fonte:** $Context
- **Stakeholders:** [A definir]
- **Valor de Negócio:** [A definir]

## Objetivos Estratégicos
- [ ] Objetivo 1
- [ ] Objetivo 2
- [ ] Objetivo 3

## Prioridades
1. **Alta:** [Definir]
2. **Média:** [Definir] 
3. **Baixa:** [Definir]

## Critérios de Sucesso
- **Métrica 1:** [A definir]
- **Métrica 2:** [A definir]

## Riscos Identificados
- **Risco 1:** [Impacto + Mitigação]
- **Risco 2:** [Impacto + Mitigação]

## Aprovação para Mesa Redonda
- [ ] Contexto definido
- [ ] Prioridades estabelecidas
- [ ] Stakeholders identificados
"@
New-FileIfMissing -Path $f00a -Content $c00a

# 00 - Requirements Brief (Product Owner)  
$f00b = Join-Path $base "00-requirements-brief.md"
$c00b = @"
# 00 - Requirements Brief — Sprint $Sprint$suffix

**Product Owner:** [Briefing para Equipe Técnica]

## Visão do Produto
[Descreva a visão geral]

## User Stories Priorizadas
### Epic: [Nome do Epic]

#### US001 - [Título]
- **Como:** [Persona]
- **Quero:** [Funcionalidade]  
- **Para:** [Benefício]
- **Prioridade:** [Alta/Média/Baixa]
- **Critérios de Aceitação:**
  - [ ] Critério 1
  - [ ] Critério 2

#### US002 - [Título]
- **Como:** [Persona]
- **Quero:** [Funcionalidade]
- **Para:** [Benefício]
- **Prioridade:** [Alta/Média/Baixa]

## Definição de Pronto
- [ ] Código implementado
- [ ] Testes unitários (90%+ cobertura)
- [ ] Documentação atualizada
- [ ] Aprovação do PO

## Próximos Passos
1. **Mesa Redonda:** Discussão técnica com toda equipe
2. **BDD:** Elaboração detalhada de cenários
3. **Arquitetura:** Design técnico da solução
"@
New-FileIfMissing -Path $f00b -Content $c00b

# 01 - Ata da Mesa Redonda
$f01 = Join-Path $base "01-ata-mesa-redonda.md"
$c01 = @"
# 01 - Ata da Mesa Redonda — Sprint $Sprint$suffix

**Pré-requisito:** Leia primeiro 00-business-context.md e 00-requirements-brief.md

Contexto: $Context

Politica: Nao faca perguntas; se faltar informacao, adote ate 3 suposicoes razoaveis, liste-as abaixo e prossiga.

Suposicoes:
- 
- 
- 

Participantes: Product Owner, Requirements Analyst, Systems Architect, Expert Developer, Testing Specialist

## Contexto do PO (Resumo)
- **Valor de Negócio:** [Do 00-business-context.md]
- **Prioridades:** [Do 00-business-context.md]
- **User Stories:** [Do 00-requirements-brief.md]

## Decisões Técnicas
- [ ] Decisão 1 — Justificativa
- [ ] Decisão 2 — Justificativa

## Alinhamentos
- **Arquitetura:** [Consenso sobre approach]
- **Tecnologias:** [Stack aprovada]
- **Integrações:** [APIs e dependências]

Acoes e responsaveis:
- [ ] Item — Responsavel — Prazo
"@
New-FileIfMissing -Path $f01 -Content $c01

# 02 - Requisitos (BDD)
$f02 = Join-Path $base "02-requisitos-bdd.md"
$c02 = @"
# 02 - Requisitos (BDD) — Sprint $Sprint$suffix

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
# 03 - Arquitetura — Sprint $Sprint$suffix

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
# 04 - Desenvolvimento — Sprint $Sprint$suffix

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
# 04 - Frontend Implementation — Sprint $Sprint$suffix

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
# 04 - UI Guidelines — Sprint $Sprint$suffix

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
# 05 - Plano de QA — Sprint $Sprint$suffix

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
# ADR-XXXX — Titulo da Decisao

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
# 99 - Checklist Final — Sprint $Sprint$suffix

**Product Owner Final:** [Validação Completa da Entrega]

## Status dos Artefatos

### ✅ Análise de Negócio
- [ ] 00-business-context.md - Contexto e valor de negócio definidos
- [ ] 00-requirements-brief.md - Briefing técnico completo

### ✅ Alinhamento Técnico  
- [ ] 01-ata-mesa-redonda.md - Decisões técnicas consensuais

### ✅ Especificação
- [ ] 02-requisitos-bdd.md - Análise BDD completa
- [ ] features/*.feature - Cenários Gherkin abrangentes

### ✅ Arquitetura
- [ ] 03-arquitetura.md - Design técnico documentado
- [ ] adrs/*.md - Decisões arquiteturais justificadas
- [ ] diagrams/*.mmd - Diagramas técnicos claros

### ✅ Implementação
- [ ] 04-desenvolvimento.md - Notas de desenvolvimento backend
- [ ] 04-frontend-implementation.md - Implementação frontend
- [ ] 04-components/ - Estrutura de componentes
- [ ] 04-ui-guidelines.md - Guidelines de interface
- [ ] engineering/src/ - Código implementado
- [ ] engineering/tests/ - Testes unitários

### ✅ Qualidade
- [ ] 05-qa-plano.md - Estratégia de testes definida
- [ ] engineering/reports/ - Evidências de qualidade

## Critérios de Aceitação

### Funcionais
- [ ] Todas as User Stories implementadas
- [ ] Cenários BDD cobertos por testes
- [ ] Regras de negócio validadas

### Não-Funcionais  
- [ ] Arquitetura alinhada com padrões corporativos
- [ ] Código seguindo boas práticas
- [ ] Cobertura de testes adequada (>90%)
- [ ] Documentação completa e atualizada

## Decisão Final

⏳ **STATUS:** [PENDENTE ANÁLISE]

🎯 **PRÓXIMOS PASSOS:**
1. Aguardando validação do Product Owner Final
2. Revisão de critérios de aceitação
3. Decisão: APROVADO ou NECESSITA AJUSTES

---
**Este checklist será preenchido automaticamente pelo Product Owner Final após análise completa dos artefatos.**
"@
New-FileIfMissing -Path $f99 -Content $c99