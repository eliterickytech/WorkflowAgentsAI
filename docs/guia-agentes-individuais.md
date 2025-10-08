# ðŸŽ¯ Guia Completo: Executando Agentes Individuais

**VersÃ£o:** 2.2.0  
**Data:** 30 de Setembro de 2025

Este guia detalha como usar **cada um dos 11 agentes de forma independente**, com exemplos prÃ¡ticos, contextos especÃ­ficos e casos de uso reais.

> Atualizacao 2025-10: o portifolio de agentes agora possui 11 especialistas. Esta revisao reorganiza os indices e adiciona orientacoes dedicadas para o Frontend Specialist Agent.

---

## **Indice Atualizado dos Agentes**

1. [Product Owner Agent](#1-product-owner-agent) - Descoberta e alinhamento inicial
2. [Mesa Redonda Agent](#2-mesa-redonda-agent) - Facilitacao de debates tecnicos
3. [Requirements Analyst Agent](#3-requirements-analyst-agent) - Modelagem de requisitos
4. [Systems Architect Agent](#4-systems-architect-agent) - Definicao de arquitetura
5. [UX/UI Specialist Agent](#5-uxui-specialist-agent) - Experiencia e interface
6. [Frontend Specialist Agent](#6-frontend-specialist-agent) - Implementacao de interface
7. [Testing Specialist Agent](#7-testing-specialist-agent) - Plano de qualidade
8. [Expert Developer Agent](#8-expert-developer-agent) - Engenharia e implementacao
9. [Testing Validator Agent](#9-testing-validator-agent) - Validacao de testes
10. [Code Reviewer Agent](#10-code-reviewer-agent) - Revisao tecnica de codigo
11. [Product Owner Final Agent](#11-product-owner-final-agent) - Encerramento e aprovacao

---

## **1. Product Owner Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **Refinamento de backlog** - transformar ideias vagas em requirements
- âœ… **AnÃ¡lise de viabilidade** - entender impacto e prioridade
- âœ… **ComunicaÃ§Ã£o com stakeholders** - traduzir tÃ©cnico para negÃ³cio
- âœ… **ValidaÃ§Ã£o de escopo** - confirmar entendimento antes do desenvolvimento

### **ðŸ’» Como executar:**

#### **Exemplo 1: AnÃ¡lise de Nova Funcionalidade**
```
@agents/manual/product-owner.agent.md

Sprint: 03, Activity: sistema-backup  
Contexto: "Cliente solicita backup automÃ¡tico dos dados. Preciso entender: requisitos, prioridade, impacto nos usuÃ¡rios e viabilidade tÃ©cnica."
```

#### **Exemplo 2: Refinamento de User Story Vaga**
```  
@agents/manual/product-owner.agent.md

Sprint: 02, Activity: melhorias-performance
Contexto: "Stakeholder reclama que 'sistema estÃ¡ lento'. Preciso transformar isso em requirements especÃ­ficos com critÃ©rios mensurÃ¡veis."
```

#### **Exemplo 3: ValidaÃ§Ã£o de Escopo Complexo**
```
@agents/manual/product-owner.agent.md

Sprint: 04, Activity: integracao-erp
Contexto: "IntegraÃ§Ã£o com SAP ERP. MÃºltiplos stakeholders, requisitos conflitantes. Preciso alinhar visÃ£o e priorizar funcionalidades."

Anexos necessÃ¡rios:
- Documento de requisitos inicial (se houver)
- Lista de stakeholders e suas necessidades
- RestriÃ§Ãµes tÃ©cnicas conhecidas
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/sistema-backup/
â”œâ”€â”€ 00-business-context.md      â† AnÃ¡lise do contexto de negÃ³cio
â””â”€â”€ 00-requirements-brief.md    â† Requirements estruturados
```

### **ðŸŽ¯ Dicas de uso:**
- **Seja especÃ­fico no contexto** - quanto mais informaÃ§Ãµes, melhor a anÃ¡lise
- **Inclua anexos** se tiver documentos existentes
- **Mencione stakeholders** e suas necessidades especÃ­ficas
- **Defina prazo/urgÃªncia** se relevante

---

## **2. Mesa Redonda Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **DecisÃµes arquiteturais complexas** - precisa de mÃºltiplas perspectivas
- âœ… **ResoluÃ§Ã£o de conflitos tÃ©cnicos** - diferentes abordagens possÃ­veis  
- âœ… **Brainstorming de soluÃ§Ãµes** - explorar alternativas antes de decidir
- âœ… **ValidaÃ§Ã£o de estratÃ©gias** - confirmar direÃ§Ã£o tÃ©cnica
- âœ… **AnÃ¡lise de trade-offs** - avaliar prÃ³s/contras de decisÃµes

### **ðŸ’» Como executar:**

#### **Exemplo 1: DecisÃ£o Arquitetural**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "DecisÃ£o: MicroserviÃ§os vs Monolito Modular para novo mÃ³dulo de relatÃ³rios. Avaliar: escalabilidade, complexidade, time skills, prazo 6 meses."

Foco: arquitetura, escalabilidade, manutenibilidade
```

#### **Exemplo 2: ResoluÃ§Ã£o de Conflito TÃ©cnico**
```
@agents/manual/roundtable-facilitator.agent.md  

Contexto: "Conflito: Frontend quer GraphQL, Backend prefere REST para nova API. Considerar: performance, curva aprendizado, ecosistema .NET."

Foco: APIs, performance, produtividade  
```

#### **Exemplo 3: EstratÃ©gia de MigraÃ§Ã£o**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "MigraÃ§Ã£o .NET Framework 4.8 â†’ .NET 8. 200+ classes, 5 anos legacy. EstratÃ©gia: big-bang vs incremental vs strangler fig pattern."

Foco: migraÃ§Ã£o, riscos, estratÃ©gia
```

#### **Exemplo 4: Mesa Focada em Problema EspecÃ­fico**
```
@agents/manual/roundtable-facilitator.agent.md

"Redebater apenas performance e caching - sistema com 10k usuÃ¡rios simultÃ¢neos"

Foco: performance, caching, otimizaÃ§Ã£o
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/decisao-arquitetura/
â””â”€â”€ 01-ata-mesa-redonda.md     â† Debate registrado com consenso
```

### **ðŸŽ¯ Dicas de uso:**
- **Defina o foco** claramente (ex: "apenas performance", "sÃ³ frontend")
- **Inclua restriÃ§Ãµes** conhecidas (orÃ§amento, prazo, skills do time)
- **Mencione contexto** do projeto (tamanho, criticidade, usuÃ¡rios)
- **Use para decisÃµes importantes** - nÃ£o para implementaÃ§Ãµes simples

---

## **3. Requirements Analyst Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **AnÃ¡lise de documentos** .docx/.xlsx para extrair regras
- âœ… **CriaÃ§Ã£o de arquivos RN-00xx.md** padronizados
- âœ… **Mapeamento de dependÃªncias** entre regras de negÃ³cio
- âœ… **ValidaÃ§Ã£o de consistÃªncia** terminolÃ³gica
- âœ… **TransformaÃ§Ã£o BDD** de requisitos em cenÃ¡rios Gherkin

### **ðŸ’» Como executar:**

#### **Exemplo 1: ExtraÃ§Ã£o de Regras de Documento**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 02, Activity: calculo-impostos
Contexto: "Transformar documento 'Regras_Tributacao_2024.docx' em regras estruturadas RN-0045 a RN-0052. Focar em: alÃ­quotas, isenÃ§Ãµes, casos especiais."

Arquivos de entrada:
- references-data/datas/business-rules-files/Regras_Tributacao_2024.docx
- references-data/datas/tables/validation-business-rules-files/casos_teste_tributacao.xlsx
```

#### **Exemplo 2: CriaÃ§Ã£o de CenÃ¡rios BDD**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 03, Activity: workflow-aprovacao  
Contexto: "Criar cenÃ¡rios BDD para workflow de aprovaÃ§Ã£o em 3 nÃ­veis. Regras: Valor < 1000 (auto), 1000-10000 (gestor), >10000 (diretor)."

Entrada: EspecificaÃ§Ã£o textual do workflow
SaÃ­da: CenÃ¡rios Gherkin estruturados
```

#### **Exemplo 3: Mapeamento de DependÃªncias**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 04, Activity: auditoria-regras
Contexto: "Mapear dependÃªncias entre RN-0001 (cÃ¡lculo base) e RN-0015 a RN-0025 (regras derivadas). Identificar impactos de mudanÃ§as."

Foco: anÃ¡lise de impacto, dependÃªncias
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint02/calculo-impostos/
â”œâ”€â”€ 02-requisitos-bdd.md               â† AnÃ¡lise estruturada
â”œâ”€â”€ features/
â”‚   â”œâ”€â”€ calculo-aliquota.feature      â† CenÃ¡rios Gherkin
â”‚   â””â”€â”€ casos-especiais.feature       
â””â”€â”€ references-data/business-rules/
    â”œâ”€â”€ RN-0045.md                    â† Regras extraÃ­das
    â”œâ”€â”€ RN-0046.md
    â””â”€â”€ ...
```

### **ðŸŽ¯ Dicas de uso:**
- **Prepare os arquivos** nas pastas corretas antes de executar
- **Seja especÃ­fico** sobre quais regras extrair (nÃºmeros RN-00xx)
- **Inclua contexto de domÃ­nio** (financeiro, tributÃ¡rio, etc.)
- **Valide termologia** - use termos consistentes com o sistema

---

## **4. Systems Architect Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **Design de arquitetura** para novas funcionalidades
- âœ… **RefatoraÃ§Ã£o arquitetural** de mÃ³dulos existentes
- âœ… **DefiniÃ§Ã£o de bounded contexts** e agregados (DDD)
- âœ… **EstratÃ©gias de integraÃ§Ã£o** com sistemas externos
- âœ… **DecisÃµes tÃ©cnicas estruturais** (patterns, frameworks)

### **ðŸ’» Como executar:**

#### **Exemplo 1: Arquitetura Nova Funcionalidade**
```
@agents/manual/systems-architect.agent.md

Sprint: 03, Activity: modulo-relatorios
Contexto: "Projetar arquitetura para mÃ³dulo de relatÃ³rios customizÃ¡veis. Requisitos: 500+ usuÃ¡rios simultÃ¢neos, exportaÃ§Ã£o PDF/Excel, agendamento, cache inteligente."

RestriÃ§Ãµes:
- .NET Framework 4.8
- PostgreSQL existente
- Infraestrutura on-premise
- Time conhece Entity Framework
```

#### **Exemplo 2: RefatoraÃ§Ã£o de MÃ³dulo Legacy**
```
@agents/manual/systems-architect.agent.md  

Sprint: 04, Activity: refactoring-pagamentos
Contexto: "Refatorar mÃ³dulo de pagamentos de 3 anos. Problemas: God classes, dependÃªncias circulares, difÃ­cil testar. Meta: Clean Architecture + SOLID."

Contexto atual:
- 15 classes principais
- LÃ³gica espalhada nas Controllers  
- Sem testes unitÃ¡rios
- Performance degradada
```

#### **Exemplo 3: IntegraÃ§Ã£o Sistema Externo**
```
@agents/manual/systems-architect.agent.md

Sprint: 05, Activity: integracao-sap
Contexto: "IntegraÃ§Ã£o bi-direcional com SAP ERP. Sincronizar: produtos, clientes, pedidos. Requisitos: real-time crÃ­tico, fallback offline, auditoria completa."

ConsideraÃ§Ãµes:
- SAP RFC vs Web Services  
- EstratÃ©gia de retry/circuit breaker
- Mapeamento de entidades
- Tratamento de conflitos
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/modulo-relatorios/
â”œâ”€â”€ 03-arquitetura.md                 â† Documento arquitetural
â”œâ”€â”€ diagrams/
â”‚   â”œâ”€â”€ contexto-relatorios.mmd      â† Diagramas Mermaid
â”‚   â”œâ”€â”€ componentes-sistema.mmd
â”‚   â””â”€â”€ fluxo-dados.mmd
â””â”€â”€ adrs/
    â”œâ”€â”€ ADR-001-escolha-cache.md     â† Architecture Decision Records
    â””â”€â”€ ADR-002-estrategia-export.md
```

### **ðŸŽ¯ Dicas de uso:**
- **Inclua restriÃ§Ãµes tÃ©cnicas** conhecidas (.NET version, infraestrutura)
- **Mencione requisitos nÃ£o-funcionais** (performance, escala, seguranÃ§a)
- **Descreva contexto atual** se for refatoraÃ§Ã£o
- **Especifique integraÃ§Ãµes** necessÃ¡rias com sistemas existentes

---

## **5. UX/UI Specialist Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **CriaÃ§Ã£o de wireframes** ASCII versionÃ¡veis no Git
- âœ… **Design de user flows** e arquitetura de informaÃ§Ã£o
- âœ… **DefiniÃ§Ã£o de design system** com tokens e componentes
- âœ… **PrototipaÃ§Ã£o rÃ¡pida** com HTML interativo
- âœ… **Guidelines de acessibilidade** WCAG 2.1 AA
- âœ… **EspecificaÃ§Ãµes para desenvolvedores** com CSS e HTML

### **ðŸ’» Como executar:**

#### **Exemplo 1: Dashboard Executivo Completo**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 03, Activity: dashboard-executivo
Contexto: "Criar interface para dashboard executivo com KPIs real-time, grÃ¡ficos interativos e filtros avanÃ§ados. UsuÃ¡rios: C-Level, gerentes, analistas."

Requisitos UX:
- InformaÃ§Ã£o crÃ­tica "above the fold" 
- MÃ¡ximo 3 cliques para qualquer aÃ§Ã£o
- Responsivo (mobile executives)
- Performance visual < 2s carregamento
- AcessÃ­vel para deficientes visuais

Entrada: 03-arquitetura.md (componentes tÃ©cnicos)
```

#### **Exemplo 2: Sistema de Login Corporativo**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 02, Activity: login-corporativo  
Contexto: "Interface de login empresarial com SSO, 2FA e recuperaÃ§Ã£o de senha. Design moderno mas conservador para ambiente corporativo."

RestriÃ§Ãµes de design:
- Identidade visual existente (logo, cores)
- Compatibilidade IE11+ (legado)
- IntegraÃ§Ã£o com Active Directory
- Auditoria de acessos

Foco: SeguranÃ§a + usabilidade + compliance
```

#### **Exemplo 3: App Mobile de Vendas**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 04, Activity: mobile-vendas
Contexto: "App mobile para vendedores externos: CRM, catÃ¡logo produtos, pedidos offline-first. UsuÃ¡rios com baixa literacy digital."

ConsideraÃ§Ãµes mobile:
- Funciona offline (sync automÃ¡tico)
- Touch-friendly (dedos grandes)
- Leitura sob sol forte (contraste alto)
- Bateria limitada (animaÃ§Ãµes leves)
- ConexÃ£o instÃ¡vel (loading states)

Prioridade: Simplicidade + performance + offline
```

#### **Exemplo 4: Refinar Wireframes Existentes**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 01, Activity: refinar-wireframes-checkout
Contexto: "Melhorar wireframes do checkout baseado em feedback de usabilidade. Principais problemas: abandono no pagamento, formulÃ¡rio confuso."

Entrada: Wireframes atuais + relatÃ³rio de UX research
Problemas identificados:
- Muitos campos obrigatÃ³rios  
- InformaÃ§Ãµes de seguranÃ§a nÃ£o claras
- BotÃ£o "Finalizar" pouco visÃ­vel
- Processo parece longo demais

Foco: ConversÃ£o + confianÃ§a + simplicidade
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/dashboard-executivo/
â”œâ”€â”€ 05-ux-analysis.md                 â† AnÃ¡lise de usuÃ¡rios e jornadas  
â”œâ”€â”€ 05-ux-wireframes.md               â† Wireframes ASCII + Mermaid
â”œâ”€â”€ 04-wireframes/
â”‚   â”œâ”€â”€ ascii/
â”‚   â”‚   â”œâ”€â”€ desktop-layout.md         â† Layout principal
â”‚   â”‚   â”œâ”€â”€ mobile-layout.md          â† VersÃ£o mobile
â”‚   â”‚   â””â”€â”€ component-specs.md        â† EspecificaÃ§Ãµes detalhadas
â”‚   â”œâ”€â”€ mermaid/
â”‚   â”‚   â”œâ”€â”€ user-flow.md              â† Fluxos de navegaÃ§Ã£o
â”‚   â”‚   â”œâ”€â”€ sitemap.md                â† Arquitetura informaÃ§Ã£o
â”‚   â”‚   â””â”€â”€ component-tree.md         â† Hierarquia componentes
â”‚   â”œâ”€â”€ html-preview/
â”‚   â”‚   â”œâ”€â”€ desktop-prototype.html    â† ProtÃ³tipo clicÃ¡vel
â”‚   â”‚   â””â”€â”€ mobile-prototype.html     â† VersÃ£o mobile
â”‚   â””â”€â”€ images/                       â† PNGs exportados (se solicitado)
â”œâ”€â”€ 04-design-system.md               â† Tokens, cores, tipografia
â”œâ”€â”€ 04-component-library.md           â† Specs CSS + HTML semÃ¢ntico
â””â”€â”€ 04-accessibility-guide.md         â† Guidelines WCAG 2.1 AA
```

### **ðŸŽ¯ Dicas de uso:**
- **ForneÃ§a contexto de usuÃ¡rios** especÃ­fico (perfil, skills, limitaÃ§Ãµes)
- **Inclua restriÃ§Ãµes tÃ©cnicas** conhecidas (browsers, devices, performance)
- **Mencione identidade visual** existente se houver
- **Especifique prioridades** (conversÃ£o vs usabilidade vs acessibilidade)
- **Referencie arquitetura** (03-arquitetura.md) para componentes tÃ©cnicos
- **Use apÃ³s Systems Architect** - pode rodar em paralelo ou antes de Testing Specialist
- **SaÃ­das alimentam** Testing Specialist e Expert Developer
- **Encaminhe entregaveis** ao Frontend Specialist para orientar implementacao, versionamento de componentes e checklist de acessibilidade

### **ðŸ› ï¸ Ferramentas complementares:**
```powershell
# Configurar ferramentas de design
.\powershell\setup-design-tools.ps1 -Sprint 03 -Activity dashboard-executivo -GenerateWireframes

# Visualizar no navegador  
.\powershell\view-wireframes.ps1 -Sprint 03 -Activity dashboard-executivo -OpenBrowser

# Exportar para apresentaÃ§Ã£o
.\powershell\view-wireframes.ps1 -Sprint 03 -Activity dashboard-executivo -ExportImages
```

---

## **6. Frontend Specialist Agent**

### **Quando usar individualmente:**
- Desenvolver novas interfaces ou fluxos SPA alinhados ao design system
- Criar provas de conceito frontend para validar requisitos de usabilidade e performance
- Estruturar bibliotecas de componentes reutilizaveis e guidelines de UI compartilhaveis
- Liderar ajustes tecnicos de acessibilidade, performance e observabilidade no frontend

### **Como executar:**

#### **Exemplo 1: Implementacao de dashboard modular**
```
@agents/manual/frontend-specialist.agent.md

Sprint: 07, Activity: analytics-dashboard
Contexto: "Precisamos de um dashboard modular em React com suporte a filtros dinamicos, graficos responsivos e integracao com WebSocket."

Entradas chave:
- 02-requisitos-bdd.md com cenarios de analytics
- 03-arquitetura.md destacando integracoes e limites de performance
```

#### **Exemplo 2: Evolucao de design system**
```
@agents/manual/frontend-specialist.agent.md

Sprint: 05, Activity: ds-refactor
Contexto: "Atualizar o design system PO-UI com novos tokens de cor, componentes de formulario acessiveis e documentacao no Storybook."

Entradas chave:
- Arquivos de UI fornecidos pelo UX/UI Specialist
- Guidelines atuais de branding e acessibilidade
```

#### **Exemplo 3: Analise de migracao tecnologica**
```
@agents/manual/frontend-specialist.agent.md

Sprint: 09, Activity: migrate-angular17
Contexto: "Plano incremental para migrar o portal Angular 12 para Angular 17 com integracao de SSR e testes E2E com Cypress."

Entradas chave:
- Levantamento de arquitetura atual do Systems Architect Agent
- Plano de testes do Testing Specialist Agent para cobrir regressao
```

### **Saidas esperadas:**
```
data/out/sprint07/analytics-dashboard/
- 04-frontend-implementation.md   # Plano detalhado de implementacao
- 04-components/                  # Estrutura de componentes versionada
- 04-ui-guidelines.md             # Guidelines de estilo e tokens
```

### **Dicas de uso:**
- Reforce metas de performance (Largest Contentful Paint, bundle inicial, tempo para interacao)
- Indique navegadores alvo e preferencias de build (Vite, Webpack, Nx)
- Liste dependencias criticas (PO-UI, Material, Redux, NgRx) e restricoes de versao
- Combine com o UX/UI Specialist para garantir coerencia visual e com o Testing Specialist para alinhar cobertura automatizada

### **Checklist rapido entregavel:**
- Plano de componentes com responsabilidades claras
- Sugestoes de testes unitarios (Jest, Vitest ou Karma) e E2E (Cypress ou Playwright)
- Estrategia de monitoramento (Lighthouse, Web Vitals, Sentry) e acessibilidade (WCAG 2.1 AA)
- Orientacoes de deploy e observabilidade frontend integradas ao pipeline
## **7. Testing Specialist Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **Planejamento TDD** - criar plano de testes ANTES da implementaÃ§Ã£o
- âœ… **EstratÃ©gia de testes** para funcionalidades complexas
- âœ… **AnÃ¡lise de cobertura** e identificaÃ§Ã£o de gaps
- âœ… **Testes de edge cases** e cenÃ¡rios extremos
- âœ… **Planos de performance** e testes de carga

### **ðŸ’» Como executar:**

#### **Exemplo 1: Planejamento TDD Completo**
```
@agents/manual/testing-specialist.agent.md

Sprint: 03, Activity: calculo-comissao
Contexto: "Criar plano TDD para cÃ¡lculo de comissÃ£o por vendedor. Regras complexas: base + performance + metas + bÃ´nus trimestral. Meta: 95% cobertura."

CritÃ©rios de aceite:
1. CÃ¡lculo correto conforme RN-0030 a RN-0035
2. Performance < 100ms para 1000 vendedores  
3. Tratamento de cenÃ¡rios extremos (vendas negativas, etc.)
4. Auditoria completa de cÃ¡lculos
```

#### **Exemplo 2: EstratÃ©gia de Testes para IntegraÃ§Ã£o**
```
@agents/manual/testing-specialist.agent.md

Sprint: 04, Activity: teste-integracao-sap  
Contexto: "Plano de testes para integraÃ§Ã£o SAP. CenÃ¡rios: conexÃ£o OK, timeout, dados invÃ¡lidos, volume alto. Incluir testes automatizados e manuais."

Foco: 
- Testes de integraÃ§Ã£o end-to-end
- SimulaÃ§Ã£o de falhas de rede
- Testes de volume (1000+ registros)
- ValidaÃ§Ã£o de retry/fallback
```

#### **Exemplo 3: AnÃ¡lise de Cobertura Existente**
```
@agents/manual/testing-specialist.agent.md

Sprint: 02, Activity: auditoria-testes-pagamento
Contexto: "Auditar cobertura atual do mÃ³dulo de pagamentos. Identificar gaps crÃ­ticos, criar plano para atingir 90%. Priorizar: casos de erro, validaÃ§Ãµes, edge cases."

Entrada: CÃ³digo existente do mÃ³dulo pagamentos
Foco: AnÃ¡lise de gaps + plano de melhoria
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/calculo-comissao/
â”œâ”€â”€ 05-qa-plano.md                    â† Plano de QA detalhado
â”œâ”€â”€ engineering/
â”‚   â””â”€â”€ tests/
â”‚       â”œâ”€â”€ Unit/                     â† Estrutura de testes
â”‚       â”‚   â”œâ”€â”€ Domain/
â”‚       â”‚   â”œâ”€â”€ Application/
â”‚       â”‚   â””â”€â”€ Infrastructure/
â”‚       â”œâ”€â”€ Integration/
â”‚       â””â”€â”€ Performance/
â””â”€â”€ qa-evidence/
    â””â”€â”€ cobertura-alvo-95.md         â† Meta de cobertura
```

### **ðŸŽ¯ Dicas de uso:**
- **Defina metas claras** de cobertura (ex: 95%, 90%)
- **Especifique tipos de teste** (unitÃ¡rio, integraÃ§Ã£o, E2E, performance)  
- **Inclua regras de negÃ³cio** especÃ­ficas (RN-00xx) para validar
- **Mencione cenÃ¡rios crÃ­ticos** que nÃ£o podem falhar

---

## **8. Expert Developer Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **ImplementaÃ§Ã£o guiada por TDD** seguindo plano de testes
- âœ… **RefatoraÃ§Ã£o de cÃ³digo legacy** aplicando SOLID + DDD
- âœ… **ImplementaÃ§Ã£o de funcionalidades complexas** com arquitetura definida
- âœ… **CorreÃ§Ã£o de bugs crÃ­ticos** com abordagem estruturada
- âœ… **Mentoria tÃ©cnica** atravÃ©s de cÃ³digo exemplar

### **ðŸ’» Como executar:**

#### **Exemplo 1: ImplementaÃ§Ã£o TDD Completa**
```
@agents/manual/expert-developer.agent.md

Sprint: 03, Activity: calculo-comissao
Contexto: "Implementar cÃ¡lculo de comissÃ£o seguindo TDD. Usar plano de QA do Testing Specialist. Aplicar Clean Architecture + DDD patterns."

Entrada obrigatÃ³ria:
- 05-qa-plano.md (plano criado pelo Testing Specialist)
- 03-arquitetura.md (design do Systems Architect)  
- 00-acceptance-criteria.md (critÃ©rios de aceite)

Foco: ImplementaÃ§Ã£o test-first, cÃ³digo limpo
```

#### **Exemplo 2: RefatoraÃ§Ã£o Legacy**
```
@agents/manual/expert-developer.agent.md

Sprint: 04, Activity: refactoring-usuarios
Contexto: "Refatorar mÃ³dulo usuÃ¡rios (5 anos, God classes, 0% cobertura). Aplicar SOLID, extrair services, criar testes. Manter compatibilidade API."

Problema atual:
- UsuarioManager com 800+ linhas
- LÃ³gica misturada (validaÃ§Ã£o + persistÃªncia + email)
- DependÃªncias hardcoded
- ImpossÃ­vel testar unitariamente

Meta: Clean Architecture + 90% cobertura
```

#### **Exemplo 3: Feature Complexa com IntegraÃ§Ãµes**  
```
@agents/manual/expert-developer.agent.md

Sprint: 05, Activity: dashboard-executivo
Contexto: "Implementar dashboard executivo: KPIs real-time, grÃ¡ficos interativos, export PDF, cache inteligente, permissÃµes granulares."

Tecnologias:
- Backend: .NET Framework 4.8 + SignalR
- Cache: Redis  
- PDF: iTextSharp
- Charts: Chart.js via Web API

Complexidades: Performance + seguranÃ§a + real-time
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/calculo-comissao/
â”œâ”€â”€ 04-desenvolvimento.md             â† RelatÃ³rio da implementaÃ§Ã£o  
â”œâ”€â”€ engineering/
â”‚   â”œâ”€â”€ src/
â”‚   â”‚   â”œâ”€â”€ Core/
â”‚   â”‚   â”‚   â”œâ”€â”€ Domain/
â”‚   â”‚   â”‚   â”‚   â”œâ”€â”€ Entities/
â”‚   â”‚   â”‚   â”‚   â”œâ”€â”€ ValueObjects/  
â”‚   â”‚   â”‚   â”‚   â””â”€â”€ Services/
â”‚   â”‚   â”‚   â””â”€â”€ Application/
â”‚   â”‚   â”‚       â”œâ”€â”€ Services/
â”‚   â”‚   â”‚       â”œâ”€â”€ DTOs/
â”‚   â”‚   â”‚       â””â”€â”€ Validators/
â”‚   â”‚   â”œâ”€â”€ Infrastructure/
â”‚   â”‚   â”‚   â”œâ”€â”€ Data/
â”‚   â”‚   â”‚   â””â”€â”€ External/
â”‚   â”‚   â””â”€â”€ API/
â”‚   â”‚       â””â”€â”€ Controllers/
â”‚   â””â”€â”€ tests/
â”‚       â”œâ”€â”€ Unit/ (95% cobertura atingida)
â”‚       â”œâ”€â”€ Integration/
â”‚       â””â”€â”€ Performance/
â””â”€â”€ docs/
    â”œâ”€â”€ api-documentation.md
    â””â”€â”€ deployment-guide.md
```

### **ðŸŽ¯ Dicas de uso:**
- **Sempre forneÃ§a o plano de QA** do Testing Specialist como entrada
- **Referencie arquitetura** definida pelo Systems Architect
- **Seja especÃ­fico sobre tecnologias** e restriÃ§Ãµes (.NET Framework 4.8)
- **Mencione compatibilidade** se for refatoraÃ§Ã£o de cÃ³digo existente

---

## **9. Testing Validator Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **ValidaÃ§Ã£o pÃ³s-TDD** - verificar se implementaÃ§Ã£o seguiu o plano
- âœ… **Auditoria de qualidade** de testes implementados
- âœ… **VerificaÃ§Ã£o de cobertura** real vs planejada
- âœ… **ValidaÃ§Ã£o de evidÃªncias** por critÃ©rio de aceite
- âœ… **Parecer tÃ©cnico independente** sobre implementaÃ§Ã£o

### **ðŸ’» Como executar:**

#### **Exemplo 1: ValidaÃ§Ã£o TDD Completa**
```
@agents/manual/testing-validator.agent.md

Sprint: 03, Activity: calculo-comissao
Contexto: "Validar se Expert Developer implementou corretamente o plano de QA. Verificar: todos cenÃ¡rios, cobertura 95%, evidÃªncias por critÃ©rio."

Entrada necessÃ¡ria:
- 05-qa-plano.md (plano original do Testing Specialist)
- 04-desenvolvimento.md (implementaÃ§Ã£o do Expert Developer)
- CÃ³digo implementado com testes

Validar: Conformidade plano â†’ implementaÃ§Ã£o
```

#### **Exemplo 2: Auditoria de Qualidade**
```
@agents/manual/testing-validator.agent.md  

Sprint: 04, Activity: auditoria-modulo-pagamentos
Contexto: "Auditoria independente do mÃ³dulo pagamentos apÃ³s refatoraÃ§Ã£o. Verificar: testes robustos, cobertura real, cenÃ¡rios edge cases implementados."

Foco:
- Qualidade dos testes (nÃ£o apenas quantidade)
- CenÃ¡rios crÃ­ticos cobertos  
- Testes determinÃ­sticos e confiÃ¡veis
- Performance dos testes
```

#### **Exemplo 3: ValidaÃ§Ã£o de EvidÃªncias** 
```
@agents/manual/testing-validator.agent.md

Sprint: 05, Activity: validacao-criterios-dashboard  
Contexto: "Validar evidÃªncias tÃ©cnicas para cada critÃ©rio de aceite do dashboard executivo. Cada critÃ©rio deve ter teste automatizado + prova de funcionamento."

CritÃ©rios para validar:
1. KPIs atualizados em real-time (< 2s)
2. Export PDF funcional (< 5s para 100 registros) 
3. Cache otimizado (hit rate > 80%)
4. PermissÃµes granulares (por usuÃ¡rio/papel)
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/calculo-comissao/
â””â”€â”€ 05.1-testing-validation.md        â† RelatÃ³rio de validaÃ§Ã£o
    â”œâ”€â”€ CenÃ¡rios: 15/15 implementados âœ…
    â”œâ”€â”€ Cobertura: 96% (meta 95%) âœ…  
    â”œâ”€â”€ EvidÃªncias: 4/4 critÃ©rios âœ…
    â””â”€â”€ DECISÃƒO: VALIDAÃ‡ÃƒO APROVADA âœ…
```

### **ðŸŽ¯ Dicas de uso:**
- **Sempre forneÃ§a o plano original** (05-qa-plano.md) para comparaÃ§Ã£o
- **Inclua implementaÃ§Ã£o** (04-desenvolvimento.md) e cÃ³digo fonte
- **Seja especÃ­fico sobre critÃ©rios** que precisam de evidÃªncia tÃ©cnica
- **Use para validaÃ§Ã£o objetiva** - nÃ£o opiniÃ£o, mas conformidade

---

## **10. Code Reviewer Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **Auditoria independente** de qualidade do cÃ³digo
- âœ… **ValidaÃ§Ã£o de padrÃµes** de desenvolvimento
- âœ… **Review de seguranÃ§a** e boas prÃ¡ticas
- âœ… **VerificaÃ§Ã£o de nomenclatura** e convenÃ§Ãµes
- âœ… **AnÃ¡lise de commit messages** e documentaÃ§Ã£o

### **ðŸ’» Como executar:**

#### **Exemplo 1: Auditoria Completa de Qualidade**
```
@agents/manual/code-reviewer.agent.md

Sprint: 03, Activity: review-modulo-comissao
Contexto: "Auditoria independente do mÃ³dulo comissÃ£o apÃ³s implementaÃ§Ã£o. Validar: padrÃµes SOLID, nomenclatura, commits, documentaÃ§Ã£o, warnings."

Foco completo:
- âœ… PadrÃµes de nomenclatura (PascalCase/camelCase)
- âœ… IndentaÃ§Ã£o e formataÃ§Ã£o consistente  
- âœ… Commit messages com gitemoji
- âœ… Estrutura Clean Architecture
- âœ… DocumentaÃ§Ã£o XML adequada
- âœ… Zero warnings de compilaÃ§Ã£o
```

#### **Exemplo 2: Review Focado em SeguranÃ§a**
```
@agents/manual/code-reviewer.agent.md

Sprint: 04, Activity: security-review-auth
Contexto: "Review de seguranÃ§a do mÃ³dulo autenticaÃ§Ã£o. Focar: validaÃ§Ã£o inputs, sanitizaÃ§Ã£o, tokens JWT, logs auditoria, OWASP Top 10."

Foco especÃ­fico:
- Input validation (SQL injection, XSS)
- AutorizaÃ§Ã£o granular  
- Logs de seguranÃ§a
- Tratamento de senhas
- Session management
```

#### **Exemplo 3: Review de ConvenÃ§Ãµes**
```
@agents/manual/code-reviewer.agent.md

Sprint: 02, Activity: padronizacao-codigo  
Contexto: "Validar aderÃªncia Ã s convenÃ§Ãµes do projeto em 5 classes refatoradas. Verificar: nomenclatura English/Portuguese, commits gitemoji, indentaÃ§Ã£o 4 espaÃ§os."

Escopo limitado:
- Apenas convenÃ§Ãµes e formataÃ§Ã£o
- NÃ£o analisar lÃ³gica de negÃ³cio  
- Foco em consistÃªncia com codebase
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/review-modulo-comissao/
â””â”€â”€ 04.1-code-review.md              â† RelatÃ³rio de auditoria
    â”œâ”€â”€ âœ… NOMENCLATURA: Aprovado
    â”œâ”€â”€ âœ… INDENTAÃ‡ÃƒO: Aprovado  
    â”œâ”€â”€ âŒ COMMITS: Necessita correÃ§Ã£o
    â”œâ”€â”€ âœ… ARQUITETURA: Aprovado
    â”œâ”€â”€ âœ… DOCUMENTAÃ‡ÃƒO: Aprovado
    â””â”€â”€ DECISÃƒO: NECESSITA CORREÃ‡Ã•ES (commits)
```

### **ðŸŽ¯ Dicas de uso:**
- **Defina escopo** claramente (completo vs especÃ­fico)
- **Use apÃ³s implementaÃ§Ã£o** para validaÃ§Ã£o independente
- **Ideal para projetos crÃ­ticos** que precisam de qualidade extra
- **Complemente com Testing Validator** para validaÃ§Ã£o tÃ©cnica completa

---

## **11. Product Owner Final Agent**

### **ðŸ“ Quando usar individualmente:**
- âœ… **ValidaÃ§Ã£o final** de critÃ©rios de aceite
- âœ… **Checklist de entrega** antes do go-live
- âœ… **Auditoria de compliance** com requisitos de negÃ³cio
- âœ… **AprovaÃ§Ã£o/rejeiÃ§Ã£o** de entregas
- âœ… **DocumentaÃ§Ã£o de pendÃªncias** e prÃ³ximos passos

### **ðŸ’» Como executar:**

#### **Exemplo 1: ValidaÃ§Ã£o Final Completa**
```
@agents/manual/product-owner-final.agent.md

Sprint: 03, Activity: entrega-sistema-comissao
Contexto: "ValidaÃ§Ã£o final do sistema de comissÃ£o. Verificar CADA critÃ©rio de aceite contra evidÃªncias tÃ©cnicas. Decidir: ENTREGA APROVADA ou PENDÃŠNCIAS."

CritÃ©rios para validar:
1. CÃ¡lculo correto conforme RN-0030 a RN-0035
2. Performance < 100ms para 1000 vendedores
3. Interface responsiva e acessÃ­vel  
4. Auditoria completa implementada
5. Testes automatizados com 95% cobertura

EvidÃªncias disponÃ­veis:
- CÃ³digo implementado + testes
- RelatÃ³rios de performance  
- DocumentaÃ§Ã£o tÃ©cnica
```

#### **Exemplo 2: Checklist de Go-Live**
```
@agents/manual/product-owner-final.agent.md

Sprint: 04, Activity: checklist-dashboard-executivo
Contexto: "Checklist final para go-live do dashboard executivo. Validar: funcionalidades, performance, seguranÃ§a, documentaÃ§Ã£o usuÃ¡rio, plano rollback."

VerificaÃ§Ãµes crÃ­ticas:
- âœ… KPIs real-time funcionais
- âœ… Export PDF em produÃ§Ã£o
- âœ… PermissÃµes granulares testadas
- âœ… Manual usuÃ¡rio criado
- âœ… Plano de rollback documentado
- âœ… Monitoramento configurado
```

#### **Exemplo 3: Auditoria de Compliance**
```
@agents/manual/product-owner-final.agent.md

Sprint: 05, Activity: compliance-audit-pagamentos  
Contexto: "Auditoria de compliance do mÃ³dulo pagamentos para certificaÃ§Ã£o SOC 2. Validar: logs auditoria, retenÃ§Ã£o dados, controles acesso, documentaÃ§Ã£o."

Requisitos compliance:
- Logs estruturados (12 meses retenÃ§Ã£o)
- Controle de acesso granular
- Auditoria de todas transaÃ§Ãµes  
- DocumentaÃ§Ã£o de processos
- Testes de recuperaÃ§Ã£o de desastre
```

### **ðŸ“ SaÃ­das esperadas:**
```
data/out/sprint03/entrega-sistema-comissao/
â””â”€â”€ 99-checklist-final.md             â† Checklist de validaÃ§Ã£o
    â”œâ”€â”€ CritÃ©rio 1: âœ… ATENDIDO + evidÃªncia
    â”œâ”€â”€ CritÃ©rio 2: âœ… ATENDIDO + evidÃªncia
    â”œâ”€â”€ CritÃ©rio 3: âŒ PENDENTE + aÃ§Ã£o
    â”œâ”€â”€ CritÃ©rio 4: âœ… ATENDIDO + evidÃªncia
    â”œâ”€â”€ DECISÃƒO: âŒ NECESSITA CORREÃ‡Ã•ES
    â””â”€â”€ PrÃ³ximos passos: Lista de pendÃªncias
```

### **ðŸŽ¯ Dicas de uso:**
- **Liste todos os critÃ©rios** de aceite explicitamente
- **Referencie evidÃªncias** tÃ©cnicas disponÃ­veis
- **Seja objetivo** - cada critÃ©rio Ã© binÃ¡rio (atendido/nÃ£o atendido)  
- **Use para decisÃ£o final** de entrega/go-live

---

## **ðŸŽ¯ Templates Padronizados de Entrada**

### **Template BÃ¡sico:**
```
@agents/manual/[NOME-AGENTE].agent.md

Sprint: [XX], Activity: [nome-atividade]
Contexto: "[DescriÃ§Ã£o clara do que precisa ser feito e por quÃª]"

[InformaÃ§Ãµes especÃ­ficas conforme o agente]
```

### **Template AvanÃ§ado:**
```
@agents/manual/[NOME-AGENTE].agent.md  

Sprint: [XX], Activity: [nome-atividade]
Contexto: "[DescriÃ§Ã£o detalhada do problema/necessidade]"

Entrada disponÃ­vel:
- [Arquivo 1]: [DescriÃ§Ã£o]
- [Arquivo 2]: [DescriÃ§Ã£o]  

RestriÃ§Ãµes:
- [RestriÃ§Ã£o tÃ©cnica 1]
- [RestriÃ§Ã£o de prazo/orÃ§amento]

Foco especÃ­fico:
- [Aspecto 1 para focar]
- [Aspecto 2 para focar]

CritÃ©rios de sucesso:
- [Como medir o sucesso]
- [MÃ©tricas especÃ­ficas]
```

---

## **ðŸš¨ Troubleshooting Comum**

### **âŒ Problema: Agente nÃ£o entende o contexto**
**âœ… SoluÃ§Ã£o:** 
- Seja mais especÃ­fico na descriÃ§Ã£o
- Inclua informaÃ§Ãµes de domÃ­nio (financeiro, tributÃ¡rio, etc.)
- Referencie documentos/regras existentes (RN-00xx)

### **âŒ Problema: SaÃ­da muito genÃ©rica**  
**âœ… SoluÃ§Ã£o:**
- Defina restriÃ§Ãµes tÃ©cnicas (.NET Framework 4.8, PostgreSQL)
- Especifique mÃ©tricas (performance < 100ms, cobertura 95%)
- Inclua exemplos do que vocÃª espera

### **âŒ Problema: Agente nÃ£o encontra arquivos**
**âœ… SoluÃ§Ã£o:**
- Verifique estrutura de pastas `data/in/sprint{X}/{activity}/`
- Confirme que anexos estÃ£o em `/attachments/`
- Use caminhos absolutos se necessÃ¡rio

### **âŒ Problema: Resultado nÃ£o atende expectativa**
**âœ… SoluÃ§Ã£o:**  
- Re-execute com contexto mais especÃ­fico
- Use Mesa Redonda para decisÃµes complexas
- Combine mÃºltiplos agentes em sequÃªncia

---

## **ðŸ’¡ Dicas Gerais de OtimizaÃ§Ã£o**

### **ðŸŽ¯ Para melhores resultados:**
1. **Seja especÃ­fico** - contexto claro gera saÃ­das precisas
2. **Prepare entradas** - organize arquivos/documentos antes
3. **Defina mÃ©tricas** - nÃºmeros concretos vs "boa performance"  
4. **Use sequencialmente** - cada agente consome saÃ­da do anterior
5. **Valide incrementalmente** - nÃ£o espere o final para revisar

### **âš¡ Para eficiÃªncia:**
1. **Agente individual** para tarefas especÃ­ficas
2. **Mesa Redonda** para decisÃµes/debates  
3. **Fluxo completo** para implementaÃ§Ãµes end-to-end
4. **Combine conforme necessidade** - nÃ£o existe "jeito certo Ãºnico"

### **ðŸŽ¨ Para flexibilidade:**
1. **Ajuste o contexto** conforme seu projeto
2. **Modifique templates** para seu domÃ­nio especÃ­fico  
3. **Combine agentes** em ordens diferentes se necessÃ¡rio
4. **Reutilize saÃ­das** entre diferentes atividades

---

**Este guia garante que vocÃª possa usar qualquer agente individualmente com mÃ¡xima eficÃ¡cia! ðŸš€**

