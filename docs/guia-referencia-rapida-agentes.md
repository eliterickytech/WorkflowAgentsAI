# 🎯 Referência Rápida: 10 Agentes Especializados

**Versão:** 2.2.0 - **Parallel Execution Edition**  
**Guia de bolso** para executar qualquer agente isoladamente com prompts profissionais.

---

## 📋 **Lista dos 10 Agentes**

| # | Agente | Especialidade | Quando Usar | Arquivo |
|---|---------|--------------|-------------|---------|
| **1** | **Product Owner** | Análise de negócio | Refinar requirements, priorizar backlog | `product-owner.agent.md` |
| **2** | **Mesa Redonda** | Debate técnico | Decisões arquiteturais, resolução conflitos | `roundtable-facilitator.agent.md` |
| **3** | **Requirements** | Análise BDD | Extrair regras, criar cenários Gherkin | `requirements-analyst.agent.md` |
| **4** | **Systems Architect** | Arquitetura técnica | Design de soluções, ADRs, diagramas | `systems-architect.agent.md` |
| **5** | **UX/UI Specialist** | Design e wireframes | Interfaces, user flows, design systems | `ux-ui-specialist.agent.md` |
| **6** | **Testing Specialist** | Plano TDD | Estratégia de testes ANTES implementação | `testing-specialist.agent.md` |
| **7** | **Expert Developer** | Implementação TDD | Código seguindo plano de testes | `expert-developer.agent.md` |
| **8** | **Testing Validator** | Validação pós-TDD | Conformidade implementação vs plano | `testing-validator.agent.md` |
| **9** | **Code Reviewer** | Auditoria qualidade | Padrões, nomenclatura, segurança | `code-reviewer.agent.md` |
| **10** | **PO Final** | Validação aceite | Checklist final antes go-live | `product-owner-final.agent.md` |

---

## 🎯 **Templates de Prompts Profissionais**

### **1️⃣ Product Owner Agent**
```
@agents/manual/product-owner.agent.md

Sprint: [XX], Activity: [nome-funcionalidade]
Contexto: "[Descrição da solicitação de negócio - seja específico sobre o valor esperado]"

Stakeholders: [CEO, usuarios finais, etc.]
Prioridade: [Alta/Média/Baixa - justificar]
Prazo: [Se relevante]
Restrições: [Orçamento, tecnológicas, regulatórias]

Anexar: Documentos do cliente, especificações iniciais
```

**Exemplo Prático:**
```
@agents/manual/product-owner.agent.md

Sprint: 03, Activity: sistema-backup-automatico
Contexto: "Cliente solicita backup automático diário dos dados críticos. Motivação: compliance SOX 404 + recuperação disaster. Valor: reduzir risco operacional de R$ 2M."

Stakeholders: CTO (sponsor), DBA (operação), Compliance (auditoria)
Prioridade: Alta - regulatory compliance obrigatório
Prazo: 60 dias (auditoria externa em março)
Restrições: Orçamento R$ 50K, infraestrutura on-premise, janela manutenção 2h/dia
```

### **2️⃣ Mesa Redonda Agent**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "[Decisão técnica que precisa de múltiplas perspectivas]"

Conflito/Problema: [Descrever o dilema técnico]
Opções consideradas: [Alternativa A vs B vs C]
Restrições: [Tempo, orçamento, skills do time, infraestrutura]
Critérios de decisão: [Performance, manutenibilidade, custo, prazo]

Foco específico: [Se quiser direcionar o debate]
```

**Exemplo Prático:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "Decisão arquitetural para módulo de relatórios com 1000+ usuários simultâneos. Avaliar: Microserviços vs Monolito Modular vs Hybrid approach."

Conflito/Problema: Escalabilidade vs Complexidade de deploy
Opções consideradas: 
- Microserviços (máxima escala, alta complexidade)
- Monolito Modular (média escala, baixa complexidade)  
- Hybrid (core monolito + serviços específicos)

Restrições: .NET Framework 4.8, time 4 devs, infraestrutura on-premise, go-live 4 meses
Critérios de decisão: Manutenibilidade (peso 40%), Performance (peso 30%), Time skills (peso 30%)
```

### **3️⃣ Requirements Analyst Agent**
```
@agents/manual/requirements-analyst.agent.md

Sprint: [XX], Activity: [nome-analise]
Contexto: "[O que precisa ser analisado - documentos, regras, cenários]"

Entrada disponível:
- [Documento 1]: [Descrição e localização]
- [Documento 2]: [Descrição e localização]

Foco da análise: [Extrair regras RN-00xx, criar BDD, mapear dependências]
Domínio: [Financeiro, tributário, logístico, etc.]
Saída esperada: [RN-0045 a RN-0052, cenários Gherkin, etc.]
```

**Exemplo Prático:**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 02, Activity: analise-calculo-impostos
Contexto: "Extrair regras de cálculo tributário de documentos da Receita Federal. Transformar em regras estruturadas RN-0030 a RN-0045 + cenários BDD."

Entrada disponível:
- Portaria_RF_2024_Tributacao.pdf: 85 páginas de regras fiscais
- Tabela_Aliquotas_Estados.xlsx: 27 planilhas por UF  
- Casos_Teste_Homologacao.docx: 150 cenários de validação

Foco da análise: Regras de cálculo ICMS, IPI, PIS/COFINS por tipo produto
Domínio: Tributário - varejo multi-estado
Saída esperada: RN-0030 (base cálculo) a RN-0045 (casos especiais) + features BDD
```

### **4️⃣ Systems Architect Agent**
```
@agents/manual/systems-architect.agent.md

Sprint: [XX], Activity: [nome-arquitetura]
Contexto: "[Funcionalidade ou módulo para arquitetar]"

Requisitos não-funcionais:
- Performance: [usuários simultâneos, tempo resposta]
- Escalabilidade: [crescimento esperado]
- Disponibilidade: [uptime exigido]
- Segurança: [compliance, dados sensíveis]

Restrições técnicas:
- Plataforma: [.NET version, cloud/on-premise]
- Integrações: [sistemas existentes]
- Time: [skills disponíveis]
- Infraestrutura: [limitações conhecidas]
```

**Exemplo Prático:**
```
@agents/manual/systems-architect.agent.md

Sprint: 04, Activity: arquitetura-dashboard-executivo
Contexto: "Projetar arquitetura para dashboard executivo real-time com KPIs, gráficos interativos, filtros avançados e export PDF."

Requisitos não-funcionais:
- Performance: 500 usuários simultâneos, carregamento < 2s
- Escalabilidade: Crescimento 100% ao ano (1000 usuários em 2026)
- Disponibilidade: 99.5% uptime (8h downtime/ano máximo)
- Segurança: Dados financeiros sensíveis, LGPD compliance, auditoria SOX

Restrições técnicas:
- Plataforma: .NET Framework 4.8, SQL Server 2019, Windows Server on-premise
- Integrações: ERP SAP (RFC), CRM Salesforce (REST), BI PowerBI (OData)
- Time: 3 devs .NET sênior, 1 front-end React, 1 DBA Oracle
- Infraestrutura: 2 servidores IIS, load balancer F5, storage SAN 10TB
```

### **5️⃣ UX/UI Specialist Agent** 🆕
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: [XX], Activity: [nome-interface]
Contexto: "[Interface ou experiência para criar]"

Usuários-alvo: [Perfis, skills técnicas, limitações]
Dispositivos: [Desktop, mobile, tablet - prioridades]
Funcionalidades principais: [Top 3-5 features críticas]
Restrições de design: [Identidade visual, acessibilidade, performance]

Entrada técnica: [Arquitetura, componentes disponíveis]
Prioridades UX: [Usabilidade vs conversão vs acessibilidade]
```

**Exemplo Prático:**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 03, Activity: interface-mobile-vendedores
Contexto: "Criar interface mobile para vendedores externos: CRM, catálogo produtos, pedidos offline-first. Foco em simplicidade para usuários com baixa literacy digital."

Usuários-alvo: Vendedores 40-60 anos, smartphones Android básicos, pouca experiência com apps
Dispositivos: Mobile PRIMEIRO (90% uso), tablet ocasional (10%), sem desktop
Funcionalidades principais: Ver catálogo, registrar pedido, consultar histórico, sync offline

Restrições de design: 
- Funciona offline (conexão instável no campo)
- Touch-friendly (dedos grandes, uso com luvas)
- Leitura sob sol (contraste alto)
- Bateria limitada (animações mínimas)

Entrada técnica: 03-arquitetura.md (API REST + sync local), PWA + Service Workers
Prioridades UX: Simplicidade (50%) > Performance (30%) > Conversão (20%)
```

### **6️⃣ Testing Specialist Agent**
```
@agents/manual/testing-specialist.agent.md

Sprint: [XX], Activity: [nome-plano-tdd]
Contexto: "[Funcionalidade para planejar testes ANTES da implementação]"

Critérios de aceite: [Listagem específica e mensurável]
Complexidade: [Regras de negócio, integrações, edge cases]
Meta de cobertura: [% desejada: 90%, 95%]
Tipos de teste: [Unit, Integration, E2E, Performance]

Entrada: [Arquitetura, requisitos, wireframes disponíveis]
Foco: [TDD rigoroso, automação, evidências]
```

**Exemplo Prático:**
```
@agents/manual/testing-specialist.agent.md

Sprint: 03, Activity: plano-tdd-calculo-comissao
Contexto: "Criar plano TDD COMPLETO para cálculo de comissão de vendedores. Regras complexas: base + performance + metas + bônus trimestral + casos especiais."

Critérios de aceite:
1. Cálculo correto conforme RN-0030 (base) a RN-0035 (bônus especiais)
2. Performance < 100ms para lote de 1000 vendedores
3. Tratamento cenários extremos: vendas negativas, metas retroativas, vendedores inativos
4. Auditoria completa: log de cada cálculo com justificativa
5. Relatório gerencial: breakdown por componente da comissão

Complexidade: 15 regras de negócio interdependentes + 3 integrações (ERP, CRM, RH)
Meta de cobertura: 95% (crítico para conformidade financeira)
Tipos de teste: Unit (70%), Integration (20%), E2E (10%), Performance (validação)

Entrada: 03-arquitetura.md (domain design), 02-requisitos-bdd.md (cenários), RN-0030.md a RN-0035.md
Foco: TDD rigoroso (red-green-refactor), automação CI/CD, evidências para auditoria
```

### **7️⃣ Expert Developer Agent**
```
@agents/manual/expert-developer.agent.md

Sprint: [XX], Activity: [nome-implementacao]
Contexto: "[Implementação seguindo TDD + arquitetura definida]"

Entrada OBRIGATÓRIA:
- [05-qa-plano.md]: Plano TDD do Testing Specialist
- [03-arquitetura.md]: Design do Systems Architect  
- [05-ux-wireframes.md]: Specs UI do UX/UI Specialist (se aplicável)

Tecnologias: [Stack técnico específico]
Padrões: [Clean Architecture, SOLID, DDD, etc.]
Restrições: [Compatibilidade, performance, etc.]
```

**Exemplo Prático:**
```
@agents/manual/expert-developer.agent.md

Sprint: 03, Activity: implementacao-sistema-notificacoes
Contexto: "Implementar sistema de notificações real-time seguindo TDD RIGOROSO. Implementar EXATAMENTE conforme plano de QA + arquitetura + wireframes."

Entrada OBRIGATÓRIA:
- 05-qa-plano.md: Plano TDD com 47 cenários de teste definidos
- 03-arquitetura.md: Clean Architecture + Event Sourcing + CQRS
- 05-ux-wireframes.md: Specs UI com componentes React + design tokens

Tecnologias: .NET 8, SignalR, PostgreSQL, Redis, Docker, React 18, TypeScript
Padrões: Clean Architecture + DDD + SOLID + CQRS + Domain Events
Restrições: Compatibilidade Chrome 90+, performance < 500ms, offline-capable

Implementar: TDD estrito (red-green-refactor) + cobertura 95% + documentação XML
```

### **8️⃣ Testing Validator Agent** 🆕
```
@agents/manual/testing-validator.agent.md

Sprint: [XX], Activity: [nome-validacao]
Contexto: "[Validação independente de implementação vs plano TDD]"

Entrada para validação:
- [05-qa-plano.md]: Plano original do Testing Specialist
- [04-desenvolvimento.md]: Implementação do Expert Developer
- [Código fonte]: Localização dos arquivos implementados

Critérios de validação: [Conformidade, cobertura, qualidade]
Foco: [Objetivo vs subjetivo, evidências técnicas]
```

**Exemplo Prático:**
```
@agents/manual/testing-validator.agent.md

Sprint: 03, Activity: validacao-modulo-pagamentos
Contexto: "Validação INDEPENDENTE da implementação do módulo pagamentos. Verificar se Expert Developer seguiu RIGOROSAMENTE o plano TDD do Testing Specialist."

Entrada para validação:
- 05-qa-plano.md: 23 cenários TDD definidos + meta 95% cobertura
- 04-desenvolvimento.md: Implementação com alegados 96% cobertura
- engineering/src/: Código-fonte implementado (Core + Infrastructure + API)
- engineering/tests/: Testes unitários + integração implementados

Critérios de validação:
1. TODOS os 23 cenários implementados (0 tolerância para omissões)
2. Cobertura REAL ≥ 95% (não apenas alegada, mas medida)
3. Testes determinísticos e confiáveis (sem flakiness)
4. Evidências técnicas para cada critério de aceite

Foco: Conformidade objetiva (não opinião) + evidências automatizadas + decisão binária
```

### **9️⃣ Code Reviewer Agent**
```
@agents/manual/code-reviewer.agent.md

Sprint: [XX], Activity: [nome-review]
Contexto: "[Auditoria independente de qualidade do código]"

Escopo da revisão: [Completo vs específico - segurança, padrões, etc.]
Padrões do projeto: [Nomenclatura, indentação, commits, etc.]
Foco específico: [Se houver áreas críticas ou problemas conhecidos]
Nível de rigor: [Audit corporativo vs review casual]
```

**Exemplo Prático:**
```
@agents/manual/code-reviewer.agent.md

Sprint: 04, Activity: audit-modulo-financeiro
Contexto: "AUDITORIA CORPORATIVA do módulo financeiro antes da certificação SOC 2. Validação rigorosa de segurança + qualidade + conformidade."

Escopo da revisão: COMPLETO - segurança + padrões + performance + documentação
Padrões do projeto: 
- Nomenclatura: English para código, Portuguese para user messages
- Commits: Gitemoji + conventional commits
- Indentação: 4 espaços, sem tabs
- Documentação: XML comments obrigatórios para public members

Foco específico: 
- Segurança: Input validation, SQL injection, XSS, autorização granular
- LGPD: Tratamento de dados pessoais, logs de auditoria, consentimento
- Performance: N+1 queries, memory leaks, caching strategy

Nível de rigor: AUDIT CORPORATIVO (zero tolerância para vulnerabilidades críticas)
```

### **🔟 Product Owner Final Agent**
```
@agents/manual/product-owner-final.agent.md

Sprint: [XX], Activity: [nome-validacao-final]
Contexto: "[Validação final de todos os critérios de aceite antes go-live]"

Critérios de aceite originais: [Lista específica e mensurável]
Evidências disponíveis: [Código, testes, documentação, relatórios]
Tipo de validação: [Go-live, entrega cliente, auditoria, etc.]
Tolerância: [Zero defeitos vs aceitável com plano correção]
```

**Exemplo Prático:**
```
@agents/manual/product-owner-final.agent.md

Sprint: 04, Activity: go-live-dashboard-executivo
Contexto: "VALIDAÇÃO FINAL do dashboard executivo antes do go-live em produção. Cada critério deve ter EVIDÊNCIA TÉCNICA comprovada. Decisão binária: APROVAR ou REJEITAR."

Critérios de aceite originais:
1. KPIs atualizados em real-time (< 2s lag)
2. Suporte 500 usuários simultâneos (95th percentile < 3s)
3. Export PDF funcional (< 5s para 1000 registros)
4. Acessibilidade WCAG 2.1 AA (score 100% axe-core)
5. Segurança: Autenticação 2FA + autorização granular
6. Monitoramento: Alertas configurados + dashboards operacionais

Evidências disponíveis:
- Código-fonte + testes (96% cobertura)
- Relatórios Lighthouse (performance)
- Testes E2E Cypress (funcionalidade)
- Audit acessibilidade axe-core
- Testes carga JMeter (500 usuários)
- Documentação operacional

Tipo de validação: GO-LIVE PRODUÇÃO (alto risco financeiro)
Tolerância: ZERO defeitos críticos (pode ter pequenas melhorias não-bloqueantes)
```

---

## 🎯 **Fluxo de Execução Completo (Sequencial)**

```powershell
# 1. Product Owner - Analisa solicitação
@agents/manual/product-owner.agent.md
"Sprint X, Activity Y: [Contexto negócio]"

# 2. Mesa Redonda - Debate técnico (OPCIONAL)  
@agents/manual/roundtable-facilitator.agent.md
"Debater arquitetura/tecnologias para Activity Y"

# 3. Requirements Analyst - BDD + Regras
@agents/manual/requirements-analyst.agent.md
"Extrair regras + cenários BDD baseado na ata"

# 4. Systems Architect - Arquitetura técnica
@agents/manual/systems-architect.agent.md
"Projetar solução baseada nos requisitos"

# 5. UX/UI Specialist - Wireframes + Design 🆕
@agents/manual/ux-ui-specialist.agent.md  
"Criar interface baseada na arquitetura"

# 6. Testing Specialist - Plano TDD
@agents/manual/testing-specialist.agent.md
"Criar plano ANTES da implementação"

# 7. Expert Developer - Implementação TDD
@agents/manual/expert-developer.agent.md
"Implementar seguindo o plano TDD"

# 8. Testing Validator - Validação pós-implementação 🆕
@agents/manual/testing-validator.agent.md
"Validar conformidade implementação vs plano"

# 9. Code Reviewer - Auditoria qualidade (OPCIONAL)
@agents/manual/code-reviewer.agent.md
"Auditoria independente de qualidade"

# 10. Product Owner Final - Aprovação final
@agents/manual/product-owner-final.agent.md
"Validar critérios de aceite + decidir go-live"
```

## 🛠️ **Ferramentas Complementares**

```powershell
# Para UX/UI Specialist - Setup de wireframes
.\powershell\setup-design-tools.ps1 -Sprint XX -Activity YY -GenerateWireframes

# Visualização de wireframes  
.\powershell\view-wireframes.ps1 -Sprint XX -Activity YY -OpenBrowser

# Múltiplas atividades paralelas
.\powershell\start-multi-activities.ps1 -Sprint XX -Activities @("A", "B", "C")

# Monitoramento paralelo
.\powershell\manage-parallel-execution.ps1 -Sprint XX -Action status
```

---

**📋 Este guia garante uso profissional e eficiente de todos os 10 agentes! 🚀**