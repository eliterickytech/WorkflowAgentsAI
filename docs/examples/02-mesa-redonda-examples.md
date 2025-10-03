# Exemplos Práticos - Mesa Redonda Agent

Este documento contém exemplos reais de como usar o **Mesa Redonda Agent** para debates técnicos e decisões arquiteturais.

---

## 🏗️ **Exemplo 1: Microserviços vs Monolito Modular**

### **Contexto:**
Decisão arquitetural para sistema de relatórios com alta demanda.

### **Prompt:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "Decisão arquitetural para módulo de relatórios com 1000+ usuários simultâneos. Avaliar: Microserviços vs Monolito Modular vs Arquitetura Híbrida."

Conflito/Problema: 
- Necessidade de escalabilidade vs complexidade operacional
- Time inexperiente com microserviços
- Infraestrutura on-premise limitada
- Prazo apertado (4 meses para go-live)

Opções consideradas:
1. Microserviços puros: Máxima escalabilidade, alta complexidade deployment
2. Monolito Modular: Média escalabilidade, baixa complexidade deployment  
3. Híbrido: Core monolito + serviços específicos (relatórios, notificações)

Restrições técnicas:
- .NET Framework 4.8 (não pode migrar ainda)
- SQL Server 2019 on-premise
- 2 servidores IIS disponíveis
- Time: 4 desenvolvedores (.NET sênior, 2 plenos, 1 júnior)
- Load balancer F5 existente

Critérios de decisão:
- Manutenibilidade (peso 40%): facilidade de manutenção pelo time atual
- Performance (peso 30%): atender 1000+ usuários simultâneos
- Time skills (peso 30%): curva de aprendizado e produtividade

Prazo crítico: Go-live em 4 meses (não pode atrasar)
```

### **Resultado Esperado:**
- Debate entre especialistas simulando diferentes perspectivas
- Análise de trade-offs técnicos vs operacionais
- Consenso baseado nas restrições reais
- Decisão justificada com próximos passos

---

## ⚡ **Exemplo 2: Cache Strategy para Performance**

### **Contexto:**
API com lentidão precisa de estratégia de cache otimizada.

### **Prompt:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "API REST com performance degradada (5s+ response time). Debater estratégias de cache: Redis vs In-Memory vs CDN vs Database optimization."

Situação crítica:
- API atual: 5-8s response time (meta: <500ms)
- 800 requests/minuto no pico
- Dados semi-estáticos (atualizam 2x/dia)
- Múltiplas queries complexas
- Usuários reclamando de lentidão

Opções de otimização:
1. Redis Cache: Cache distribuído, requer infraestrutura nova
2. In-Memory Cache: Mais simples, mas perda na reinicialização
3. CDN: Para assets estáticos, não resolve queries
4. Database tuning: Índices, query optimization, materialize views
5. Abordagem híbrida: Combinação das anteriores

Restrições técnicas:
- Budget limitado: R$ 15.000 para infraestrutura
- Não pode parar a API (zero-downtime deployment)
- .NET Framework 4.8 + SQL Server 2019
- 2 desenvolvedores sênior disponíveis
- Prazo: 3 semanas (pressão dos usuários)

Dados de uso:
- 70% das queries são idênticas (candidatas a cache)
- Dados críticos: catálogo produtos, preços, estoque
- Atualização: produtos (1x/dia), preços (2x/dia), estoque (real-time)
- Usuários: 250 internos + 50 externos (B2B)

Critérios de sucesso:
- Performance: <500ms 95th percentile
- Disponibilidade: 99.9% (atual 99.5%)
- Simplicidade: time consegue manter
- Custo: <R$ 15.000 setup + <R$ 2.000/mês operação
```

### **Resultado Esperado:**
- Análise técnica de cada opção de cache
- Debate sobre complexidade vs benefício
- Consideração de dados em tempo real vs cache
- Plano de implementação faseado

---

## 🔄 **Exemplo 3: Migração .NET Framework para .NET 8**

### **Contexto:**
Sistema legacy precisa ser migrado antes do fim do suporte.

### **Prompt:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "Migração crítica: Sistema .NET Framework 4.8 para .NET 8. Debater estratégias: Big Bang vs Incremental vs Strangler Fig Pattern."

Situação do sistema:
- 200+ classes, 5 anos de desenvolvimento
- WebForms + Web API + Entity Framework 6
- 15 integrações externas (SOAP + REST)
- 120 usuários ativos diariamente
- Processa R$ 3M/mês em transações

Risco do status quo:
- .NET Framework: suporte limitado após 2026
- Segurança: patches apenas críticos
- Performance: inferior ao .NET 8
- Cloud: incompatível com containers modernos
- Talentos: developers preferem stack moderna

Estratégias de migração:
1. Big Bang: Reescrever tudo, deploy único, alto risco, rápido
2. Incremental: Módulo por módulo, baixo risco, longo prazo
3. Strangler Fig: Nova API cerca antiga, gradual, complexo inicial
4. Lift and Shift: Minimal changes, depois otimizar

Restrições críticas:
- Zero downtime: Sistema não pode parar (24x7)
- Orçamento: R$ 200.000 total
- Time: 3 developers .NET (2 sênior, 1 pleno)
- Prazo: 8 meses (antes da renovação de licenças)
- Compliance: Auditoria SOX não pode ser impactada

Dependências técnicas:
- Banco: SQL Server 2019 (pode manter)
- Integrações: SAP, Salesforce, sistemas internos
- Autenticação: Active Directory (deve migrar para Azure AD)
- Relatórios: Crystal Reports (precisa alternativa)
- Deploy: IIS (pode migrar para containers)

Critérios de decisão:
- Risco técnico (peso 35%): impacto na operação
- Prazo (peso 25%): cumprir deadline
- Custo (peso 20%): dentro do orçamento
- Manutenibilidade futura (peso 20%): facilitar evoluções
```

### **Resultado Esperado:**
- Comparação detalhada das estratégias
- Análise de riscos vs benefícios
- Plano de migração faseado
- Consideração de rollback se necessário

---

## 📊 **Exemplo 4: GraphQL vs REST vs gRPC**

### **Contexto:**
Nova API para frontend mobile e web, debater protocolo ideal.

### **Prompt:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "Nova API para aplicações mobile (React Native) e web (Angular). Debater protocolo: REST vs GraphQL vs gRPC para máxima performance e flexibilidade."

Necessidades do frontend:
- Mobile: Offline-first, dados mínimos (3G lento)
- Web: Rich interface, dashboards complexos
- Realtime: Notificações push, updates automáticos
- Flexibilidade: Filtros dinâmicos, paginação customizada

Opções técnicas:
1. REST + JSON: Familiar, múltiplos endpoints, over-fetching possível
2. GraphQL: Queries flexíveis, single endpoint, complexidade server
3. gRPC: Performance máxima, binary, learning curve alta
4. Híbrido: REST para CRUD + GraphQL para queries + WebSockets para realtime

Contexto do time:
- Frontend: 2 developers (Angular + React Native experientes)
- Backend: 3 developers (.NET, pouca experiência GraphQL/gRPC)
- Mobile: Conexão instável, battery concerns
- Web: Rich dashboards, nested data requirements

Restrições técnicas:
- .NET 8 + Entity Framework Core
- PostgreSQL + Redis
- Azure deployment
- TypeScript no frontend
- Prazo: 3 meses MVP + 2 meses full features

Critérios importantes:
- Performance mobile: Minimal data transfer
- Developer experience: Produtividade do time
- Manutenibilidade: Long-term maintenance
- Flexibilidade: Future requirements evolution
- Time to market: Rapidez de desenvolvimento
```

### **Resultado Esperado:**
- Análise técnica de cada protocolo
- Consideração das necessidades específicas (mobile vs web)
- Debate sobre curva de aprendizado vs benefícios
- Decisão baseada no contexto do time e prazo

---

## 🔐 **Exemplo 5: Segurança: JWT vs Session-based Authentication**

### **Contexto:**
Sistema web precisa de autenticação segura com múltiplas aplicações.

### **Prompt:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "Implementar autenticação segura para ecosistema com 5 aplicações web. Debater: JWT vs Session-based vs OAuth 2.0 + OIDC para SSO corporativo."

Ecossistema atual:
- App Principal: .NET MVC (usuários internos)
- API Mobile: .NET Web API (vendedores externos)
- Portal Cliente: Angular SPA (clientes B2B)  
- Dashboard BI: Power BI Embedded
- Admin Panel: Blazor (administradores)

Requisitos de segurança:
- SSO: Login único entre aplicações
- MFA: Autenticação multifator obrigatória
- Audit: Log completo de acessos
- Session management: Timeout automático
- API security: Rate limiting + authorization

Opções de autenticação:
1. JWT: Stateless, escalável, token management complexo
2. Session cookies: Stateful, simples, não escalável
3. OAuth 2.0 + OIDC: Padrão industry, setup complexo
4. Azure AD B2C: Managed service, vendor lock-in
5. IdentityServer: Self-hosted, controle total, manutenção

Considerações específicas:
- Compliance: LGPD + auditoria SOX
- Usuários: 500 internos + 1200 externos
- Devices: Web browsers + mobile apps + APIs
- Network: On-premise + Azure hybrid
- Integração: Active Directory existente

Critérios de decisão:
- Segurança (peso 40%): Proteção adequada
- Simplicidade (peso 25%): Facilidade implementação
- Escalabilidade (peso 20%): Crescimento futuro
- Manutenção (peso 15%): Esforço operacional

Restrições:
- Budget: R$ 50.000 para licenças
- Time: 2 developers .NET security
- Prazo: 2 meses implementação
- Compliance: Auditoria em 4 meses
```

### **Resultado Esperado:**
- Análise de segurança de cada opção
- Consideração de compliance e auditoria
- Debate sobre complexidade vs controle
- Plano de implementação com fases de segurança

---

## 🚀 **Exemplo 6: Database Strategy: SQL vs NoSQL**

### **Contexto:**
E-commerce com crescimento exponencial, avaliar estratégia de dados.

### **Prompt:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "E-commerce B2B crescendo 300%/ano. Avaliar estratégia de dados: manter SQL Server vs migrar NoSQL vs arquitetura polígota para escalabilidade."

Situação atual:
- SQL Server 2019: 2TB dados, 50k produtos, 5k clientes
- Performance: Queries complexas 2-5s (meta: <500ms)
- Growth: 300% ao ano (projeta 15TB em 2 anos)
- Uso: 80% reads, 20% writes
- Complexidade: Joins multi-tabela, relatórios analíticos

Challenges identificados:
- Catálogo produtos: JSON attributes, busca full-text
- Logs de atividade: Time-series data, volume alto
- Cache de sessão: Key-value store, TTL automático
- Imagens/docs: Blob storage necessário
- Analytics: OLAP queries, aggregations pesadas

Opções de arquitetura:
1. SQL Server otimizado: Índices, partições, read replicas
2. NoSQL puro: MongoDB/CosmosDB para flexibilidade
3. Polígota: SQL (transacional) + NoSQL (catálogo) + Redis (cache)
4. Data Lake: SQL Server + Azure Data Lake + Analytics
5. Hybrid cloud: On-premise + cloud data services

Restrições e contextos:
- Team skills: 2 DBAs SQL Server experientes, zero NoSQL
- Infraestrutura: On-premise hoje, pode considerar cloud
- Budget: R$ 100.000 para nova infraestrutura
- Compliance: Dados no Brasil (LGPD)
- Integração: ERP SAP + CRM + BI existentes

Critérios críticos:
- Performance (peso 35%): Response time <500ms
- Escalabilidade (peso 30%): Suportar crescimento 300%/ano
- Manutenção (peso 20%): Team consegue operar
- Custo (peso 15%): TCO dentro do orçamento

Deadline: Decisão em 1 mês, implementação 4 meses
```

### **Resultado Esperado:**
- Análise técnica de cada opção de dados
- Consideração de skills do time vs necessidades
- Debate sobre migração gradual vs revolução
- Plano de POC para validar performance

---

## 💡 **Exemplo 7: Frontend Framework: React vs Angular vs Vue**

### **Contexto:**
Reescrita de frontend legacy, escolher framework moderno.

### **Prompt:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "Reescrita completa de frontend (atual: jQuery + Bootstrap 3). Debater framework moderno: React vs Angular vs Vue.js para máxima produtividade e manutenibilidade."

Sistema atual (problemas):
- jQuery spaghetti code (5 anos acumulados)
- Bootstrap 3 (desatualizado, não responsivo)
- Performance ruim (DOM manipulation excessivo)  
- Manutenção difícil (sem testes, sem modularização)
- UX inconsistente (sem design system)

Requisitos do novo frontend:
- SPA moderna com roteamento
- Componentes reutilizáveis
- State management robusto
- TypeScript obrigatório
- Responsive + PWA capabilities
- Integração com API .NET

Opções de framework:
1. React + Redux: Ecossistema rico, learning curve média
2. Angular: Framework completo, opinionated, TypeScript nativo
3. Vue.js + Vuex: Simplicidade, performance, menor ecossistema
4. Blazor: .NET puro, mas limitações browser/performance
5. Svelte: Performance máxima, mas ecossistema pequeno

Contexto do time:
- 2 Developers frontend (jQuery/Bootstrap experientes)
- 1 Designer (precisa de component library)
- Backend team: .NET (preferem tipos/contracts)
- Prazo: 6 meses reescrita completa
- Budget: R$ 80.000 (incluindo treinamento)

Aplicação características:
- CRUD pesado: 15 telas principais
- Dashboards: Charts + real-time data
- Forms complexos: Validação + wizard multi-step
- Tabelas: Pagination + filtering + sorting avançado
- Mobile: Responsivo obrigatório (50% acessos)

Critérios de decisão:
- Produtividade (peso 30%): Time delivery speed
- Learning curve (peso 25%): Treinamento necessário
- Ecosystem (peso 20%): Libraries e community
- Performance (peso 15%): Runtime speed
- Hiring (peso 10%): Disponibilidade de talentos no mercado
```

### **Resultado Esperado:**
- Comparação técnica de cada framework
- Análise de curva de aprendizado vs produtividade
- Consideração do mercado de trabalho local
- Plano de migração e treinamento do time

---

## 📱 **Exemplo 8: Mobile Strategy: Native vs Hybrid vs PWA**

### **Contexto:**
App mobile para vendedores, escolher tecnologia ideal.

### **Prompt:**
```
@agents/manual/roundtable-facilitator.agent.md

Contexto: "App mobile para 50 vendedores externos. Debater estratégia: Native (iOS + Android) vs React Native vs Flutter vs PWA para máxima performance offline."

Necessidades específicas:
- Offline-first: Funcionamento sem internet (interior)
- Sync automático: Quando conectar, sincronizar dados
- Camera: Foto produtos + comprovantes
- GPS: Tracking de visitas + otimização rotas
- Push notifications: Alertas de pedidos/estoque

Perfil dos usuários:
- 50 vendedores, idade 35-55 anos
- Devices: Android básicos (R$ 300-800)
- Conexão: 3G instável no interior
- Usage: 8-12 horas/dia uso intenso
- Tech skills: Baixa literacy digital

Opções tecnológicas:
1. Native Android: Performance máxima, custo desenvolvimento alto
2. React Native: Code sharing, performance boa, ecosystem rico
3. Flutter: Performance nativa, Dart learning curve
4. PWA: Web technology, offline limitado, sem app store
5. Ionic: Web + mobile, performance média, simplicidade alta

Restrições técnicas:
- Team: 1 developer mobile (Android experiente)
- Backend: .NET Web API ready
- Budget: R$ 120.000 desenvolvimento
- Prazo: 4 meses MVP + 2 meses refinamento
- Manutenção: Mesmo developer vai manter

Funcionalidades críticas:
- Catálogo offline: 5000 produtos com fotos
- Pedidos offline: CRUD local + sync
- Cliente 360: Histórico + dados + geolocalização
- Relatórios: Daily activity + photos
- Integração: CRM + ERP + estoque real-time

Performance requirements:
- Startup: <3 segundos (devices básicos)
- Offline: 100% funcional por 48 horas
- Sync: Background automático + manual
- Storage: 500MB dados offline
- Battery: Uso 8h sem drain excessivo
```

### **Resultado Esperado:**
- Análise de cada tecnologia mobile
- Consideração específica de offline-first
- Debate sobre performance vs produtividade
- Plano de desenvolvimento e deployment

---

## 🎯 **Dicas para Usar Mesa Redonda Eficientemente:**

### **1. Seja Específico no Contexto:**
- Descreva o problema técnico claramente
- Inclua todas as restrições conhecidas
- Mencione skills e experiência do time

### **2. Liste Opções Consideradas:**
- Pelo menos 2-3 alternativas viáveis
- Inclua a opção "não fazer nada" se relevante
- Mencione opções já descartadas e por quê

### **3. Defina Critérios Objetivos:**
- Use pesos para critérios (performance 40%, custo 30%, etc.)
- Inclua métricas quantificáveis quando possível
- Considere impacto no time e operação

### **4. Inclua Restrições Reais:**
- Budget específico (não "orçamento limitado")
- Prazo com justificativa (auditoria, go-live, etc.)
- Skills técnicas atuais do time
- Infraestrutura e integrações existentes

### **5. Foque em Trade-offs:**
- Use quando há conflito real entre opções
- Evite para decisões óbvias ou já tomadas
- Perfeito para situações com múltiplas variáveis

---

**💡 A Mesa Redonda é ideal para decisões complexas onde você precisa de múltiplas perspectivas técnicas!**