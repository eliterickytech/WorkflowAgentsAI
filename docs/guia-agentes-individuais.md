# 🎯 Guia Completo: Executando Agentes Individuais

**Versão:** 2.1.0  
**Data:** 30 de Setembro de 2025

Este guia detalha como usar **cada um dos 10 agentes de forma independente**, com exemplos práticos, contextos específicos e casos de uso reais.

---

## 📋 **Índice dos Agentes**

1. [🎯 Product Owner Agent](#1-product-owner-agent)
2. [🤝 Mesa Redonda Agent](#2-mesa-redonda-agent)  
3. [📊 Requirements Analyst Agent](#3-requirements-analyst-agent)
4. [🏗️ Systems Architect Agent](#4-systems-architect-agent)
5. [🎨 UX/UI Specialist Agent](#5-uxui-specialist-agent)
6. [🧪 Testing Specialist Agent](#6-testing-specialist-agent)
7. [💻 Expert Developer Agent](#7-expert-developer-agent)
8. [🔍 Testing Validator Agent](#8-testing-validator-agent)
9. [🛡️ Code Reviewer Agent](#9-code-reviewer-agent)
10. [✅ Product Owner Final Agent](#10-product-owner-final-agent)

---

## **1. 🎯 Product Owner Agent**

### **📝 Quando usar individualmente:**
- ✅ **Refinamento de backlog** - transformar ideias vagas em requirements
- ✅ **Análise de viabilidade** - entender impacto e prioridade
- ✅ **Comunicação com stakeholders** - traduzir técnico para negócio
- ✅ **Validação de escopo** - confirmar entendimento antes do desenvolvimento

### **💻 Como executar:**

#### **Exemplo 1: Análise de Nova Funcionalidade**
```
@agents/manual/product-owner.agent.md

Sprint: 03, Activity: sistema-backup  
Contexto: "Cliente solicita backup automático dos dados. Preciso entender: requisitos, prioridade, impacto nos usuários e viabilidade técnica."
```

#### **Exemplo 2: Refinamento de User Story Vaga**
```  
@agents/manual/product-owner.agent.md

Sprint: 02, Activity: melhorias-performance
Contexto: "Stakeholder reclama que 'sistema está lento'. Preciso transformar isso em requirements específicos com critérios mensuráveis."
```

#### **Exemplo 3: Validação de Escopo Complexo**
```
@agents/manual/product-owner.agent.md

Sprint: 04, Activity: integracao-erp
Contexto: "Integração com SAP ERP. Múltiplos stakeholders, requisitos conflitantes. Preciso alinhar visão e priorizar funcionalidades."

Anexos necessários:
- Documento de requisitos inicial (se houver)
- Lista de stakeholders e suas necessidades
- Restrições técnicas conhecidas
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/sistema-backup/
├── 00-business-context.md      ← Análise do contexto de negócio
└── 00-requirements-brief.md    ← Requirements estruturados
```

### **🎯 Dicas de uso:**
- **Seja específico no contexto** - quanto mais informações, melhor a análise
- **Inclua anexos** se tiver documentos existentes
- **Mencione stakeholders** e suas necessidades específicas
- **Defina prazo/urgência** se relevante

---

## **2. 🤝 Mesa Redonda Agent** 

### **📝 Quando usar individualmente:**
- ✅ **Decisões arquiteturais complexas** - precisa de múltiplas perspectivas
- ✅ **Resolução de conflitos técnicos** - diferentes abordagens possíveis  
- ✅ **Brainstorming de soluções** - explorar alternativas antes de decidir
- ✅ **Validação de estratégias** - confirmar direção técnica
- ✅ **Análise de trade-offs** - avaliar prós/contras de decisões

### **💻 Como executar:**

#### **Exemplo 1: Decisão Arquitetural**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "Decisão: Microserviços vs Monolito Modular para novo módulo de relatórios. Avaliar: escalabilidade, complexidade, time skills, prazo 6 meses."

Foco: arquitetura, escalabilidade, manutenibilidade
```

#### **Exemplo 2: Resolução de Conflito Técnico**
```
@agents/manual/roundtable-facilitator.agent.md  

Contexto: "Conflito: Frontend quer GraphQL, Backend prefere REST para nova API. Considerar: performance, curva aprendizado, ecosistema .NET."

Foco: APIs, performance, produtividade  
```

#### **Exemplo 3: Estratégia de Migração**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "Migração .NET Framework 4.8 → .NET 8. 200+ classes, 5 anos legacy. Estratégia: big-bang vs incremental vs strangler fig pattern."

Foco: migração, riscos, estratégia
```

#### **Exemplo 4: Mesa Focada em Problema Específico**
```
@agents/manual/roundtable-facilitator.agent.md

"Redebater apenas performance e caching - sistema com 10k usuários simultâneos"

Foco: performance, caching, otimização
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/decisao-arquitetura/
└── 01-ata-mesa-redonda.md     ← Debate registrado com consenso
```

### **🎯 Dicas de uso:**
- **Defina o foco** claramente (ex: "apenas performance", "só frontend")
- **Inclua restrições** conhecidas (orçamento, prazo, skills do time)
- **Mencione contexto** do projeto (tamanho, criticidade, usuários)
- **Use para decisões importantes** - não para implementações simples

---

## **3. 📊 Requirements Analyst Agent**

### **📝 Quando usar individualmente:**
- ✅ **Análise de documentos** .docx/.xlsx para extrair regras
- ✅ **Criação de arquivos RN-00xx.md** padronizados
- ✅ **Mapeamento de dependências** entre regras de negócio
- ✅ **Validação de consistência** terminológica
- ✅ **Transformação BDD** de requisitos em cenários Gherkin

### **💻 Como executar:**

#### **Exemplo 1: Extração de Regras de Documento**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 02, Activity: calculo-impostos
Contexto: "Transformar documento 'Regras_Tributacao_2024.docx' em regras estruturadas RN-0045 a RN-0052. Focar em: alíquotas, isenções, casos especiais."

Arquivos de entrada:
- references-data/datas/business-rules-files/Regras_Tributacao_2024.docx
- references-data/datas/tables/validation-business-rules-files/casos_teste_tributacao.xlsx
```

#### **Exemplo 2: Criação de Cenários BDD**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 03, Activity: workflow-aprovacao  
Contexto: "Criar cenários BDD para workflow de aprovação em 3 níveis. Regras: Valor < 1000 (auto), 1000-10000 (gestor), >10000 (diretor)."

Entrada: Especificação textual do workflow
Saída: Cenários Gherkin estruturados
```

#### **Exemplo 3: Mapeamento de Dependências**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 04, Activity: auditoria-regras
Contexto: "Mapear dependências entre RN-0001 (cálculo base) e RN-0015 a RN-0025 (regras derivadas). Identificar impactos de mudanças."

Foco: análise de impacto, dependências
```

### **📁 Saídas esperadas:**
```
data/out/sprint02/calculo-impostos/
├── 02-requisitos-bdd.md               ← Análise estruturada
├── features/
│   ├── calculo-aliquota.feature      ← Cenários Gherkin
│   └── casos-especiais.feature       
└── references-data/business-rules/
    ├── RN-0045.md                    ← Regras extraídas
    ├── RN-0046.md
    └── ...
```

### **🎯 Dicas de uso:**
- **Prepare os arquivos** nas pastas corretas antes de executar
- **Seja específico** sobre quais regras extrair (números RN-00xx)
- **Inclua contexto de domínio** (financeiro, tributário, etc.)
- **Valide termologia** - use termos consistentes com o sistema

---

## **4. 🏗️ Systems Architect Agent**

### **📝 Quando usar individualmente:**
- ✅ **Design de arquitetura** para novas funcionalidades
- ✅ **Refatoração arquitetural** de módulos existentes
- ✅ **Definição de bounded contexts** e agregados (DDD)
- ✅ **Estratégias de integração** com sistemas externos
- ✅ **Decisões técnicas estruturais** (patterns, frameworks)

### **💻 Como executar:**

#### **Exemplo 1: Arquitetura Nova Funcionalidade**
```
@agents/manual/systems-architect.agent.md

Sprint: 03, Activity: modulo-relatorios
Contexto: "Projetar arquitetura para módulo de relatórios customizáveis. Requisitos: 500+ usuários simultâneos, exportação PDF/Excel, agendamento, cache inteligente."

Restrições:
- .NET Framework 4.8
- PostgreSQL existente
- Infraestrutura on-premise
- Time conhece Entity Framework
```

#### **Exemplo 2: Refatoração de Módulo Legacy**
```
@agents/manual/systems-architect.agent.md  

Sprint: 04, Activity: refactoring-pagamentos
Contexto: "Refatorar módulo de pagamentos de 3 anos. Problemas: God classes, dependências circulares, difícil testar. Meta: Clean Architecture + SOLID."

Contexto atual:
- 15 classes principais
- Lógica espalhada nas Controllers  
- Sem testes unitários
- Performance degradada
```

#### **Exemplo 3: Integração Sistema Externo**
```
@agents/manual/systems-architect.agent.md

Sprint: 05, Activity: integracao-sap
Contexto: "Integração bi-direcional com SAP ERP. Sincronizar: produtos, clientes, pedidos. Requisitos: real-time crítico, fallback offline, auditoria completa."

Considerações:
- SAP RFC vs Web Services  
- Estratégia de retry/circuit breaker
- Mapeamento de entidades
- Tratamento de conflitos
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/modulo-relatorios/
├── 03-arquitetura.md                 ← Documento arquitetural
├── diagrams/
│   ├── contexto-relatorios.mmd      ← Diagramas Mermaid
│   ├── componentes-sistema.mmd
│   └── fluxo-dados.mmd
└── adrs/
    ├── ADR-001-escolha-cache.md     ← Architecture Decision Records
    └── ADR-002-estrategia-export.md
```

### **🎯 Dicas de uso:**
- **Inclua restrições técnicas** conhecidas (.NET version, infraestrutura)
- **Mencione requisitos não-funcionais** (performance, escala, segurança)
- **Descreva contexto atual** se for refatoração
- **Especifique integrações** necessárias com sistemas existentes

---

## **5. 🎨 UX/UI Specialist Agent**

### **📝 Quando usar individualmente:**
- ✅ **Criação de wireframes** ASCII versionáveis no Git
- ✅ **Design de user flows** e arquitetura de informação
- ✅ **Definição de design system** com tokens e componentes
- ✅ **Prototipação rápida** com HTML interativo
- ✅ **Guidelines de acessibilidade** WCAG 2.1 AA
- ✅ **Especificações para desenvolvedores** com CSS e HTML

### **💻 Como executar:**

#### **Exemplo 1: Dashboard Executivo Completo**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 03, Activity: dashboard-executivo
Contexto: "Criar interface para dashboard executivo com KPIs real-time, gráficos interativos e filtros avançados. Usuários: C-Level, gerentes, analistas."

Requisitos UX:
- Informação crítica "above the fold" 
- Máximo 3 cliques para qualquer ação
- Responsivo (mobile executives)
- Performance visual < 2s carregamento
- Acessível para deficientes visuais

Entrada: 03-arquitetura.md (componentes técnicos)
```

#### **Exemplo 2: Sistema de Login Corporativo**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 02, Activity: login-corporativo  
Contexto: "Interface de login empresarial com SSO, 2FA e recuperação de senha. Design moderno mas conservador para ambiente corporativo."

Restrições de design:
- Identidade visual existente (logo, cores)
- Compatibilidade IE11+ (legado)
- Integração com Active Directory
- Auditoria de acessos

Foco: Segurança + usabilidade + compliance
```

#### **Exemplo 3: App Mobile de Vendas**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 04, Activity: mobile-vendas
Contexto: "App mobile para vendedores externos: CRM, catálogo produtos, pedidos offline-first. Usuários com baixa literacy digital."

Considerações mobile:
- Funciona offline (sync automático)
- Touch-friendly (dedos grandes)
- Leitura sob sol forte (contraste alto)
- Bateria limitada (animações leves)
- Conexão instável (loading states)

Prioridade: Simplicidade + performance + offline
```

#### **Exemplo 4: Refinar Wireframes Existentes**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 01, Activity: refinar-wireframes-checkout
Contexto: "Melhorar wireframes do checkout baseado em feedback de usabilidade. Principais problemas: abandono no pagamento, formulário confuso."

Entrada: Wireframes atuais + relatório de UX research
Problemas identificados:
- Muitos campos obrigatórios  
- Informações de segurança não claras
- Botão "Finalizar" pouco visível
- Processo parece longo demais

Foco: Conversão + confiança + simplicidade
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/dashboard-executivo/
├── 05-ux-analysis.md                 ← Análise de usuários e jornadas  
├── 05-ux-wireframes.md               ← Wireframes ASCII + Mermaid
├── 04-wireframes/
│   ├── ascii/
│   │   ├── desktop-layout.md         ← Layout principal
│   │   ├── mobile-layout.md          ← Versão mobile
│   │   └── component-specs.md        ← Especificações detalhadas
│   ├── mermaid/
│   │   ├── user-flow.md              ← Fluxos de navegação
│   │   ├── sitemap.md                ← Arquitetura informação
│   │   └── component-tree.md         ← Hierarquia componentes
│   ├── html-preview/
│   │   ├── desktop-prototype.html    ← Protótipo clicável
│   │   └── mobile-prototype.html     ← Versão mobile
│   └── images/                       ← PNGs exportados (se solicitado)
├── 04-design-system.md               ← Tokens, cores, tipografia
├── 04-component-library.md           ← Specs CSS + HTML semântico
└── 04-accessibility-guide.md         ← Guidelines WCAG 2.1 AA
```

### **🎯 Dicas de uso:**
- **Forneça contexto de usuários** específico (perfil, skills, limitações)
- **Inclua restrições técnicas** conhecidas (browsers, devices, performance)
- **Mencione identidade visual** existente se houver
- **Especifique prioridades** (conversão vs usabilidade vs acessibilidade)
- **Referencie arquitetura** (03-arquitetura.md) para componentes técnicos
- **Use após Systems Architect** - pode rodar em paralelo ou antes de Testing Specialist
- **Saídas alimentam** Testing Specialist e Expert Developer

### **🛠️ Ferramentas complementares:**
```powershell
# Configurar ferramentas de design
.\powershell\setup-design-tools.ps1 -Sprint 03 -Activity dashboard-executivo -GenerateWireframes

# Visualizar no navegador  
.\powershell\view-wireframes.ps1 -Sprint 03 -Activity dashboard-executivo -OpenBrowser

# Exportar para apresentação
.\powershell\view-wireframes.ps1 -Sprint 03 -Activity dashboard-executivo -ExportImages
```

---

## **6. 🧪 Testing Specialist Agent**

### **📝 Quando usar individualmente:**
- ✅ **Planejamento TDD** - criar plano de testes ANTES da implementação
- ✅ **Estratégia de testes** para funcionalidades complexas
- ✅ **Análise de cobertura** e identificação de gaps
- ✅ **Testes de edge cases** e cenários extremos
- ✅ **Planos de performance** e testes de carga

### **💻 Como executar:**

#### **Exemplo 1: Planejamento TDD Completo**
```
@agents/manual/testing-specialist.agent.md

Sprint: 03, Activity: calculo-comissao
Contexto: "Criar plano TDD para cálculo de comissão por vendedor. Regras complexas: base + performance + metas + bônus trimestral. Meta: 95% cobertura."

Critérios de aceite:
1. Cálculo correto conforme RN-0030 a RN-0035
2. Performance < 100ms para 1000 vendedores  
3. Tratamento de cenários extremos (vendas negativas, etc.)
4. Auditoria completa de cálculos
```

#### **Exemplo 2: Estratégia de Testes para Integração**
```
@agents/manual/testing-specialist.agent.md

Sprint: 04, Activity: teste-integracao-sap  
Contexto: "Plano de testes para integração SAP. Cenários: conexão OK, timeout, dados inválidos, volume alto. Incluir testes automatizados e manuais."

Foco: 
- Testes de integração end-to-end
- Simulação de falhas de rede
- Testes de volume (1000+ registros)
- Validação de retry/fallback
```

#### **Exemplo 3: Análise de Cobertura Existente**
```
@agents/manual/testing-specialist.agent.md

Sprint: 02, Activity: auditoria-testes-pagamento
Contexto: "Auditar cobertura atual do módulo de pagamentos. Identificar gaps críticos, criar plano para atingir 90%. Priorizar: casos de erro, validações, edge cases."

Entrada: Código existente do módulo pagamentos
Foco: Análise de gaps + plano de melhoria
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/calculo-comissao/
├── 05-qa-plano.md                    ← Plano de QA detalhado
├── engineering/
│   └── tests/
│       ├── Unit/                     ← Estrutura de testes
│       │   ├── Domain/
│       │   ├── Application/
│       │   └── Infrastructure/
│       ├── Integration/
│       └── Performance/
└── qa-evidence/
    └── cobertura-alvo-95.md         ← Meta de cobertura
```

### **🎯 Dicas de uso:**
- **Defina metas claras** de cobertura (ex: 95%, 90%)
- **Especifique tipos de teste** (unitário, integração, E2E, performance)  
- **Inclua regras de negócio** específicas (RN-00xx) para validar
- **Mencione cenários críticos** que não podem falhar

---

## **7. 💻 Expert Developer Agent**

### **📝 Quando usar individualmente:**
- ✅ **Implementação guiada por TDD** seguindo plano de testes
- ✅ **Refatoração de código legacy** aplicando SOLID + DDD
- ✅ **Implementação de funcionalidades complexas** com arquitetura definida
- ✅ **Correção de bugs críticos** com abordagem estruturada
- ✅ **Mentoria técnica** através de código exemplar

### **💻 Como executar:**

#### **Exemplo 1: Implementação TDD Completa**
```
@agents/manual/expert-developer.agent.md

Sprint: 03, Activity: calculo-comissao
Contexto: "Implementar cálculo de comissão seguindo TDD. Usar plano de QA do Testing Specialist. Aplicar Clean Architecture + DDD patterns."

Entrada obrigatória:
- 05-qa-plano.md (plano criado pelo Testing Specialist)
- 03-arquitetura.md (design do Systems Architect)  
- 00-acceptance-criteria.md (critérios de aceite)

Foco: Implementação test-first, código limpo
```

#### **Exemplo 2: Refatoração Legacy**
```
@agents/manual/expert-developer.agent.md

Sprint: 04, Activity: refactoring-usuarios
Contexto: "Refatorar módulo usuários (5 anos, God classes, 0% cobertura). Aplicar SOLID, extrair services, criar testes. Manter compatibilidade API."

Problema atual:
- UsuarioManager com 800+ linhas
- Lógica misturada (validação + persistência + email)
- Dependências hardcoded
- Impossível testar unitariamente

Meta: Clean Architecture + 90% cobertura
```

#### **Exemplo 3: Feature Complexa com Integrações**  
```
@agents/manual/expert-developer.agent.md

Sprint: 05, Activity: dashboard-executivo
Contexto: "Implementar dashboard executivo: KPIs real-time, gráficos interativos, export PDF, cache inteligente, permissões granulares."

Tecnologias:
- Backend: .NET Framework 4.8 + SignalR
- Cache: Redis  
- PDF: iTextSharp
- Charts: Chart.js via Web API

Complexidades: Performance + segurança + real-time
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/calculo-comissao/
├── 04-desenvolvimento.md             ← Relatório da implementação  
├── engineering/
│   ├── src/
│   │   ├── Core/
│   │   │   ├── Domain/
│   │   │   │   ├── Entities/
│   │   │   │   ├── ValueObjects/  
│   │   │   │   └── Services/
│   │   │   └── Application/
│   │   │       ├── Services/
│   │   │       ├── DTOs/
│   │   │       └── Validators/
│   │   ├── Infrastructure/
│   │   │   ├── Data/
│   │   │   └── External/
│   │   └── API/
│   │       └── Controllers/
│   └── tests/
│       ├── Unit/ (95% cobertura atingida)
│       ├── Integration/
│       └── Performance/
└── docs/
    ├── api-documentation.md
    └── deployment-guide.md
```

### **🎯 Dicas de uso:**
- **Sempre forneça o plano de QA** do Testing Specialist como entrada
- **Referencie arquitetura** definida pelo Systems Architect
- **Seja específico sobre tecnologias** e restrições (.NET Framework 4.8)
- **Mencione compatibilidade** se for refatoração de código existente

---

## **8. 🔍 Testing Validator Agent**

### **📝 Quando usar individualmente:**
- ✅ **Validação pós-TDD** - verificar se implementação seguiu o plano
- ✅ **Auditoria de qualidade** de testes implementados
- ✅ **Verificação de cobertura** real vs planejada
- ✅ **Validação de evidências** por critério de aceite
- ✅ **Parecer técnico independente** sobre implementação

### **💻 Como executar:**

#### **Exemplo 1: Validação TDD Completa**
```
@agents/manual/testing-validator.agent.md

Sprint: 03, Activity: calculo-comissao
Contexto: "Validar se Expert Developer implementou corretamente o plano de QA. Verificar: todos cenários, cobertura 95%, evidências por critério."

Entrada necessária:
- 05-qa-plano.md (plano original do Testing Specialist)
- 04-desenvolvimento.md (implementação do Expert Developer)
- Código implementado com testes

Validar: Conformidade plano → implementação
```

#### **Exemplo 2: Auditoria de Qualidade**
```
@agents/manual/testing-validator.agent.md  

Sprint: 04, Activity: auditoria-modulo-pagamentos
Contexto: "Auditoria independente do módulo pagamentos após refatoração. Verificar: testes robustos, cobertura real, cenários edge cases implementados."

Foco:
- Qualidade dos testes (não apenas quantidade)
- Cenários críticos cobertos  
- Testes determinísticos e confiáveis
- Performance dos testes
```

#### **Exemplo 3: Validação de Evidências** 
```
@agents/manual/testing-validator.agent.md

Sprint: 05, Activity: validacao-criterios-dashboard  
Contexto: "Validar evidências técnicas para cada critério de aceite do dashboard executivo. Cada critério deve ter teste automatizado + prova de funcionamento."

Critérios para validar:
1. KPIs atualizados em real-time (< 2s)
2. Export PDF funcional (< 5s para 100 registros) 
3. Cache otimizado (hit rate > 80%)
4. Permissões granulares (por usuário/papel)
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/calculo-comissao/
└── 05.1-testing-validation.md        ← Relatório de validação
    ├── Cenários: 15/15 implementados ✅
    ├── Cobertura: 96% (meta 95%) ✅  
    ├── Evidências: 4/4 critérios ✅
    └── DECISÃO: VALIDAÇÃO APROVADA ✅
```

### **🎯 Dicas de uso:**
- **Sempre forneça o plano original** (05-qa-plano.md) para comparação
- **Inclua implementação** (04-desenvolvimento.md) e código fonte
- **Seja específico sobre critérios** que precisam de evidência técnica
- **Use para validação objetiva** - não opinião, mas conformidade

---

## **9. 🛡️ Code Reviewer Agent**

### **📝 Quando usar individualmente:**
- ✅ **Auditoria independente** de qualidade do código
- ✅ **Validação de padrões** de desenvolvimento
- ✅ **Review de segurança** e boas práticas
- ✅ **Verificação de nomenclatura** e convenções
- ✅ **Análise de commit messages** e documentação

### **💻 Como executar:**

#### **Exemplo 1: Auditoria Completa de Qualidade**
```
@agents/manual/code-reviewer.agent.md

Sprint: 03, Activity: review-modulo-comissao
Contexto: "Auditoria independente do módulo comissão após implementação. Validar: padrões SOLID, nomenclatura, commits, documentação, warnings."

Foco completo:
- ✅ Padrões de nomenclatura (PascalCase/camelCase)
- ✅ Indentação e formatação consistente  
- ✅ Commit messages com gitemoji
- ✅ Estrutura Clean Architecture
- ✅ Documentação XML adequada
- ✅ Zero warnings de compilação
```

#### **Exemplo 2: Review Focado em Segurança**
```
@agents/manual/code-reviewer.agent.md

Sprint: 04, Activity: security-review-auth
Contexto: "Review de segurança do módulo autenticação. Focar: validação inputs, sanitização, tokens JWT, logs auditoria, OWASP Top 10."

Foco específico:
- Input validation (SQL injection, XSS)
- Autorização granular  
- Logs de segurança
- Tratamento de senhas
- Session management
```

#### **Exemplo 3: Review de Convenções**
```
@agents/manual/code-reviewer.agent.md

Sprint: 02, Activity: padronizacao-codigo  
Contexto: "Validar aderência às convenções do projeto em 5 classes refatoradas. Verificar: nomenclatura English/Portuguese, commits gitemoji, indentação 4 espaços."

Escopo limitado:
- Apenas convenções e formatação
- Não analisar lógica de negócio  
- Foco em consistência com codebase
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/review-modulo-comissao/
└── 04.1-code-review.md              ← Relatório de auditoria
    ├── ✅ NOMENCLATURA: Aprovado
    ├── ✅ INDENTAÇÃO: Aprovado  
    ├── ❌ COMMITS: Necessita correção
    ├── ✅ ARQUITETURA: Aprovado
    ├── ✅ DOCUMENTAÇÃO: Aprovado
    └── DECISÃO: NECESSITA CORREÇÕES (commits)
```

### **🎯 Dicas de uso:**
- **Defina escopo** claramente (completo vs específico)
- **Use após implementação** para validação independente
- **Ideal para projetos críticos** que precisam de qualidade extra
- **Complemente com Testing Validator** para validação técnica completa

---

## **10. ✅ Product Owner Final Agent**

### **📝 Quando usar individualmente:**
- ✅ **Validação final** de critérios de aceite
- ✅ **Checklist de entrega** antes do go-live
- ✅ **Auditoria de compliance** com requisitos de negócio
- ✅ **Aprovação/rejeição** de entregas
- ✅ **Documentação de pendências** e próximos passos

### **💻 Como executar:**

#### **Exemplo 1: Validação Final Completa**
```
@agents/manual/product-owner-final.agent.md

Sprint: 03, Activity: entrega-sistema-comissao
Contexto: "Validação final do sistema de comissão. Verificar CADA critério de aceite contra evidências técnicas. Decidir: ENTREGA APROVADA ou PENDÊNCIAS."

Critérios para validar:
1. Cálculo correto conforme RN-0030 a RN-0035
2. Performance < 100ms para 1000 vendedores
3. Interface responsiva e acessível  
4. Auditoria completa implementada
5. Testes automatizados com 95% cobertura

Evidências disponíveis:
- Código implementado + testes
- Relatórios de performance  
- Documentação técnica
```

#### **Exemplo 2: Checklist de Go-Live**
```
@agents/manual/product-owner-final.agent.md

Sprint: 04, Activity: checklist-dashboard-executivo
Contexto: "Checklist final para go-live do dashboard executivo. Validar: funcionalidades, performance, segurança, documentação usuário, plano rollback."

Verificações críticas:
- ✅ KPIs real-time funcionais
- ✅ Export PDF em produção
- ✅ Permissões granulares testadas
- ✅ Manual usuário criado
- ✅ Plano de rollback documentado
- ✅ Monitoramento configurado
```

#### **Exemplo 3: Auditoria de Compliance**
```
@agents/manual/product-owner-final.agent.md

Sprint: 05, Activity: compliance-audit-pagamentos  
Contexto: "Auditoria de compliance do módulo pagamentos para certificação SOC 2. Validar: logs auditoria, retenção dados, controles acesso, documentação."

Requisitos compliance:
- Logs estruturados (12 meses retenção)
- Controle de acesso granular
- Auditoria de todas transações  
- Documentação de processos
- Testes de recuperação de desastre
```

### **📁 Saídas esperadas:**
```
data/out/sprint03/entrega-sistema-comissao/
└── 99-checklist-final.md             ← Checklist de validação
    ├── Critério 1: ✅ ATENDIDO + evidência
    ├── Critério 2: ✅ ATENDIDO + evidência
    ├── Critério 3: ❌ PENDENTE + ação
    ├── Critério 4: ✅ ATENDIDO + evidência
    ├── DECISÃO: ❌ NECESSITA CORREÇÕES
    └── Próximos passos: Lista de pendências
```

### **🎯 Dicas de uso:**
- **Liste todos os critérios** de aceite explicitamente
- **Referencie evidências** técnicas disponíveis
- **Seja objetivo** - cada critério é binário (atendido/não atendido)  
- **Use para decisão final** de entrega/go-live

---

## **🎯 Templates Padronizados de Entrada**

### **Template Básico:**
```
@agents/manual/[NOME-AGENTE].agent.md

Sprint: [XX], Activity: [nome-atividade]
Contexto: "[Descrição clara do que precisa ser feito e por quê]"

[Informações específicas conforme o agente]
```

### **Template Avançado:**
```
@agents/manual/[NOME-AGENTE].agent.md  

Sprint: [XX], Activity: [nome-atividade]
Contexto: "[Descrição detalhada do problema/necessidade]"

Entrada disponível:
- [Arquivo 1]: [Descrição]
- [Arquivo 2]: [Descrição]  

Restrições:
- [Restrição técnica 1]
- [Restrição de prazo/orçamento]

Foco específico:
- [Aspecto 1 para focar]
- [Aspecto 2 para focar]

Critérios de sucesso:
- [Como medir o sucesso]
- [Métricas específicas]
```

---

## **🚨 Troubleshooting Comum**

### **❌ Problema: Agente não entende o contexto**
**✅ Solução:** 
- Seja mais específico na descrição
- Inclua informações de domínio (financeiro, tributário, etc.)
- Referencie documentos/regras existentes (RN-00xx)

### **❌ Problema: Saída muito genérica**  
**✅ Solução:**
- Defina restrições técnicas (.NET Framework 4.8, PostgreSQL)
- Especifique métricas (performance < 100ms, cobertura 95%)
- Inclua exemplos do que você espera

### **❌ Problema: Agente não encontra arquivos**
**✅ Solução:**
- Verifique estrutura de pastas `data/in/sprint{X}/{activity}/`
- Confirme que anexos estão em `/attachments/`
- Use caminhos absolutos se necessário

### **❌ Problema: Resultado não atende expectativa**
**✅ Solução:**  
- Re-execute com contexto mais específico
- Use Mesa Redonda para decisões complexas
- Combine múltiplos agentes em sequência

---

## **💡 Dicas Gerais de Otimização**

### **🎯 Para melhores resultados:**
1. **Seja específico** - contexto claro gera saídas precisas
2. **Prepare entradas** - organize arquivos/documentos antes
3. **Defina métricas** - números concretos vs "boa performance"  
4. **Use sequencialmente** - cada agente consome saída do anterior
5. **Valide incrementalmente** - não espere o final para revisar

### **⚡ Para eficiência:**
1. **Agente individual** para tarefas específicas
2. **Mesa Redonda** para decisões/debates  
3. **Fluxo completo** para implementações end-to-end
4. **Combine conforme necessidade** - não existe "jeito certo único"

### **🎨 Para flexibilidade:**
1. **Ajuste o contexto** conforme seu projeto
2. **Modifique templates** para seu domínio específico  
3. **Combine agentes** em ordens diferentes se necessário
4. **Reutilize saídas** entre diferentes atividades

---

**Este guia garante que você possa usar qualquer agente individualmente com máxima eficácia! 🚀**