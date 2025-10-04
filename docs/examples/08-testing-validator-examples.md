# Exemplos Práticos - Testing Validator Agent

Este documento contém exemplos reais de como usar o **Testing Validator Agent** para validação independente da implementação vs plano TDD.

---

## 🔍 **Exemplo 1: Validação Sistema de Comissões**

### **Contexto:**
Validar se Expert Developer implementou corretamente o plano TDD para cálculo de comissões.

### **Prompt:**
```
@agents/manual/testing-validator.agent.md

Sprint: 03, Activity: validacao-sistema-comissoes
Contexto: "Validação INDEPENDENTE da implementação do sistema de comissões. Verificar se Expert Developer seguiu RIGOROSAMENTE o plano TDD do Testing Specialist. Análise objetiva: conformidade vs opinião."

Entrada para validação:
- 05-qa-plano.md: Plano TDD com 47 cenários definidos + meta 95% cobertura
- 04-desenvolvimento.md: Implementação alegando 96% cobertura + "todos cenários atendidos"
- engineering/src/Domain/: Entities + ValueObjects + Services (Core business logic)
- engineering/src/Application/: Commands + Queries + Validators + DTOs
- engineering/tests/Unit/: 89 testes unitários implementados
- engineering/tests/Integration/: 12 testes integração com banco + APIs

Critérios objetivos de validação:
1. **Cenários implementados**: TODOS os 47 cenários do plano TDD (0 tolerância para omissões)
2. **Cobertura real**: ≥95% medida por ferramentas (não self-reported)
3. **Qualidade testes**: Determinísticos, rápidos (<5min total), confiáveis
4. **Regras negócio**: RN-0030 a RN-0035 com evidência técnica
5. **Performance**: <100ms para 1000 vendedores (load test executado)
6. **Auditoria**: Log completo cada cálculo + justificativa matemática

Validação por categoria:
**Domain Logic (Crítico):**
- RN-0030 Base calculation: 2.5% * vendas → validar fórmula + edge cases
- RN-0031 Performance multiplier: 0.8x a 1.5x baseado metas → validar boundaries
- RN-0032 Quarterly bonus: >110% meta trimestre = +R$ 2.000 → validar trigger
- RN-0033 Maximum cap: R$ 15.000/mês → validar enforcement
- RN-0034 Default discount: Cliente inadimplente = -50% → validar aplicação
- RN-0035 Special cases: Férias, licença, demissão → validar pro-rata

**Integration Tests:**
- ERP integration: Mock vs real calls + error handling
- CRM meta sync: Data consistency + performance
- HR employee data: Active/inactive status + pro-rata calculations

**Performance Evidence:**
- Load test report: 1000 vendedores processados em <100ms
- Memory usage: Sem vazamentos em processamento lotes
- Database queries: N+1 prevention + indexing optimization

**Audit Trail:**
- Cada cálculo logado: Input + fórmula + output + timestamp
- Rastreabilidade: Mudança regra → reprocessamento histórico
- Compliance: Relatórios gerenciais automáticos + breakdown componentes

Foco validação:
- CONFORMIDADE objetiva (não opinião subjetiva)
- EVIDÊNCIAS automatizadas (não alegações)
- DECISÃO binária: APROVADO ✅ ou REJEITADO ❌
- ZERO tolerância para cenários omitidos ou cobertura fake
```

### **Resultado Esperado:**
- Relatório objetivo de conformidade (APROVADO/REJEITADO)
- Lista específica de cenários validados/faltantes
- Cobertura real medida vs alegada
- Evidências técnicas para cada critério
- Recomendações específicas se rejeitado

---

## 🏥 **Exemplo 2: Validação Sistema Agendamento Médico**

### **Contexto:**
Validar sistema crítico hospitalar após implementação TDD.

### **Prompt:**
```
@agents/manual/testing-validator.agent.md

Sprint: 02, Activity: validacao-agendamento-hospitalar
Contexto: "Validação CRÍTICA sistema agendamento médico. ZERO tolerância para bugs (vidas humanas). Verificar se implementação atende 99% dos cenários TDD + compliance CFM."

Entrada crítica para validação:
- 05-qa-plano.md: 127 cenários TDD incluindo emergências + compliance médico
- 04-desenvolvimento.md: Implementação com alegada conformidade total
- engineering/src/: Sistema completo com integrações HIS + laboratório
- engineering/tests/: 340+ testes cobrindo cenários normais + emergência
- Load test reports: 500 agendamentos simultâneos testados
- Security audit: Penetration testing + LGPD compliance validation

Validação cenários críticos:
**Disponibilidade sistema (99.99%):**
- ✅ Testado: Failover automático + recovery < 4min
- ✅ Testado: Load balancing + database replication
- ⚠️ VERIFICAR: Disaster recovery end-to-end real
- ❌ FALTANDO: Chaos engineering (network partitions)

**Concorrência (500 simultâneos):**
- ✅ Testado: Race conditions prevenidas + database locks
- ✅ Testado: Duplo agendamento mesmo horário impossível
- ✅ Testado: Performance mantida sob carga máxima
- ⚠️ VERIFICAR: Memory leaks em processamento prolongado

**Compliance médico:**
- ✅ CFM: Prontuário integrado + assinatura digital certificada
- ✅ LGPD: Consentimento + auditoria + direito esquecimento
- ✅ ANS: Relatórios automáticos + indicadores qualidade
- ❌ FALTANDO: Notificação ANVISA para eventos adversos

**Cenários emergência:**
- ✅ Testado: Prioridade absoluta emergency + override agenda
- ✅ Testado: Notificação equipe médica + SMS + push
- ✅ Testado: Protocolo Manchester + triagem automática
- ⚠️ VERIFICAR: Integração SAMU + ambulâncias tempo real

**Integrações críticas:**
- ✅ HIS: Prontuários + histórico + medicamentos + alergias
- ✅ Laboratory: Exames + resultados + preparos + contraindicações  
- ✅ Financial: Convênios + autorização + particular + cobrança
- ❌ FALTANDO: Centro cirúrgico + materiais + equipe + sala

Evidências de qualidade:
**Code coverage:** 97.8% (meta 99% atingida ❌ - faltam 1.2%)
**Performance:** 487ms average response (meta <500ms ✅)
**Security:** Penetration test passed + OWASP Top 10 ok ✅
**Reliability:** MTBF 720 horas + MTTR 3.2min ✅

Não conformidades identificadas:
1. **CRÍTICO:** Centro cirúrgico integration não testado (risco vida)
2. **ALTO:** Chaos engineering ausente (falha rede não testada)
3. **MÉDIO:** ANVISA notification missing (compliance gap)
4. **BAIXO:** Code coverage 1.2% abaixo meta (edge cases)

Decisão validação:
❌ **REJEITADO** - Não conformidades CRÍTICAS impedem go-live
- Centro cirúrgico integration é life-critical
- Chaos testing obrigatório para 99.99% availability
- Prazo correção: 2 semanas + re-validação completa
```

### **Resultado Esperado:**
- Decisão binária clara (APROVADO/REJEITADO)
- Classificação de não conformidades por criticidade
- Evidências objetivas para cada critério
- Plano de correção com prazos específicos
- Re-validação necessária após correções

---

## 🏦 **Exemplo 3: Validação Internet Banking**

### **Contexto:**
Validar sistema bancário antes do go-live regulatório.

### **Prompt:**
```
@agents/manual/testing-validator.agent.md

Sprint: 01, Activity: validacao-internet-banking
Contexto: "Validação FINAL internet banking antes go-live. Compliance Banco Central obrigatório + auditoria externa + certificação. Uma falha = multa R$ 2M + reputação."

Entrada regulatória:
- 05-qa-plano.md: 89 cenários banking + 45 security + 23 compliance BCB
- 04-desenvolvimento.md: Banking app com alegada conformidade 100%
- Penetration test report: Security audit externa (mandatória BCB)
- Load test report: 10.000 usuários simultâneos + peak scenarios
- Compliance checklist: BCB + LGPD + Anti-lavagem + COAF

Validação operações bancárias:
**Transferências (CRÍTICO):**
- ✅ TED/DOC: Validação CPF + saldo + limites + horário funcionamento
- ✅ PIX: <10s processing + QR Code + chaves + limite noturno  
- ✅ Agendamento: Futuro + recorrência + feriados + cancelamento
- ✅ Internacional: SWIFT + conversão + FATCA compliance
- **Evidência:** 127 cenários executados automaticamente ✅

**Investimentos (ALTO RISCO):**
- ✅ CDB/LCI: Aplicação + resgate + IR + IOF + marcação mercado
- ✅ Fundos: Cotização D+1 + taxa admin + come-cotas + suitability
- ⚠️ VERIFICAR: Renda variável liquidação D+2 + custódia B3
- ❌ FALTANDO: Tesouro Direto integração + vencimento automático

**Anti-fraude (OBRIGATÓRIO BCB):**
- ✅ Brute force protection: Bloqueio 5 tentativas + captcha
- ✅ Behavioral analysis: Transações atípicas + MFA adicional
- ✅ Device fingerprinting: Novo device + biometria + confirmação
- ✅ High-value transactions: >R$ 10K = callback + confirmação manual

Compliance validado:
**Banco Central:**
- ✅ Regulamentação 4.658: API security + mTLS + rate limiting
- ✅ Circular 3.909: Prevenção lavagem + PEPs + transações suspeitas
- ✅ Resolução 4.893: Open Banking Phase 2 + consent management
- ❌ FALTANDO: Relatório 4040 automático (prazo mensal BCB)

**LGPD Financeira:**
- ✅ Consentimento: Granular + revogável + audit trail completo
- ✅ Portabilidade: Export dados + formato estruturado + 30 dias
- ✅ Esquecimento: Delete + anonimização + compliance legal
- ⚠️ VERIFICAR: DPO notification + breach detection automático

Performance banking:
**SLA contratual:** 99.95% availability (measured 99.97% ✅)
**Response time:** <2s transfers (measured 1.7s average ✅)  
**PIX compliance:** <10s BCB requirement (measured 3.2s ✅)
**Concurrent users:** 10K simultaneous (tested 12K peak ✅)

Security validation:
**Penetration test:** PASSED + 0 critical vulnerabilities ✅
**OWASP Top 10:** All items addressed + automated scanning ✅
**Data encryption:** AES-256 + TLS 1.3 + key rotation ✅
**Backup security:** Encrypted + tested + recovery <4h ✅

Não conformidades críticas:
1. **BLOQUEADOR:** Relatório 4040 BCB missing (multa certa)
2. **ALTO:** Tesouro Direto integration incomplete (revenue loss)
3. **MÉDIO:** DPO notification automation (LGPD compliance)

Decisão final:
❌ **REJEITADO** - Relatório 4040 é compliance obrigatório BCB
- Implementar integração automática relatório 4040
- Completar Tesouro Direto (revenue impact significativo)
- Prazo correção: 10 dias úteis + certificação externa
- Re-validação: Auditoria completa + BCB compliance check
```

### **Resultado Esperado:**
- Decisão regulatória clara (CONFORME/NÃO CONFORME)
- Mapeamento de riscos regulatórios vs implementação
- Evidências para auditoria Banco Central
- Timeline de correções obrigatórias
- Certificação externa necessária

---

## 🛒 **Exemplo 4: Validação E-commerce Black Friday**

### **Contexto:**
Validar preparação para pico sazonal crítico de vendas.

### **Prompt:**
```
@agents/manual/testing-validator.agent.md

Sprint: 04, Activity: validacao-black-friday-readiness
Contexto: "Validação FINAL preparação Black Friday. Falha = perda R$ 5M receita + reputação. 50x tráfego normal + promoções complexas + estoque crítico."

Entrada pico sazonal:
- 05-qa-plano.md: 78 cenários high-load + 34 promotional rules + 23 fallback procedures
- 04-desenvolvimento.md: E-commerce otimizado para Black Friday 2024
- Load test reports: 50K concurrent users + realistic scenarios
- Chaos engineering: Network failures + database issues + payment gateway down
- Monitoring setup: Real-time dashboards + alerting + war room procedures

Validação capacidade pico:
**Traffic scaling (50K concurrent):**
- ✅ Homepage: <1s load time under peak load (measured 0.8s avg)
- ✅ Search: <500ms complex filters (measured 380ms p95)
- ✅ Checkout: <3s complete flow (measured 2.1s average)
- ✅ CDN: 95% cache hit rate + global distribution
- **Evidência:** Load test 72h continuous + spike tests ✅

**Promotional rules engine:**
- ✅ Progressive discount: 10%/15%/20% based on quantity
- ✅ Limited coupons: 1000x "SAVE50" + atomic counters
- ✅ Free shipping: R$ 150+ + specific ZIP codes validation
- ✅ Flash deals: 30min countdown + real-time inventory sync
- ❌ FALTANDO: Combo products (Buy X Get Y) edge cases

**Inventory management:**
- ✅ Overselling prevention: Atomic reservations + race conditions
- ✅ Real-time sync: ERP integration + 5s latency max
- ✅ Stock alerts: Low inventory + automatic reorder triggers
- ⚠️ VERIFICAR: Negative stock scenarios + manual override

**Payment processing:**
- ✅ Gateway failover: 3 providers + automatic switching
- ✅ Timeout handling: 30s timeout + retry logic + user feedback
- ✅ High throughput: 1000 transactions/minute sustained
- ❌ FALTANDO: Partial payment failures + reconciliation

Disaster recovery:
**Infrastructure resilience:**
- ✅ Auto-scaling: Kubernetes HPA + vertical scaling + cluster auto-scaler
- ✅ Database: Read replicas + connection pooling + query optimization  
- ✅ Monitoring: Real-time alerts + automated remediation + escalation
- ⚠️ VERIFICAR: Complete site down scenario + static fallback page

**Business continuity:**
- ✅ War room: 24/7 staffing + escalation procedures + decision authority
- ✅ Communication: Customer notifications + social media + status page
- ✅ Rollback: Feature flags + database migration rollback + DNS switching
- ❌ FALTANDO: Manual order processing backup procedures

Performance evidence:
**Peak load sustained:** 52K concurrent users × 4 hours ✅
**Error rate:** <0.01% during peak (measured 0.007%) ✅  
**Revenue processing:** R$ 2M/hour sustained + payment reconciliation ✅
**Customer satisfaction:** Response time P95 < 2s ✅

Não conformidades identificadas:
1. **ALTO RISCO:** Combo products edge cases (revenue impact)
2. **MÉDIO RISCO:** Payment reconciliation incomplete (financial risk)  
3. **BAIXO RISCO:** Manual backup procedures missing (contingency)

Decisão Black Friday readiness:
⚠️ **APROVADO COM RESTRIÇÕES** - Ready com mitigações específicas
- Combo products: Disable feature during peak hours (risk mitigation)
- Payment reconciliation: Manual monitoring + post-event cleanup
- Manual procedures: Document + train team + hot-standby
- Go/No-Go decision: 48h before event + final load test
```

### **Resultado Esperado:**
- Avaliação de readiness para evento crítico
- Plano de mitigação para riscos identificados
- Monitoramento em tempo real durante evento
- Procedures de escalation e rollback
- Go/No-Go decision criteria definidos

---

## 🎯 **Dicas para Validação Objetiva e Eficaz:**

### **1. Foque em Evidências, Não Alegações:**
- Meça cobertura com ferramentas (SonarQube, Jacoco)
- Execute testes automaticamente, não confie em reports
- Valide performance com load tests reais
- Confirme integração com sistemas externos funcionando

### **2. Use Critérios Binários:**
- ATENDIDO ✅ ou NÃO ATENDIDO ❌ (sem "parcialmente")
- Defina métricas objetivas (95% cobertura, <500ms response)
- Evidência técnica obrigatória para cada critério
- Zero tolerância para cenários críticos omitidos

### **3. Classifique Não Conformidades:**
- **BLOQUEADOR:** Impede go-live (compliance, security crítico)
- **ALTO:** Risco significativo (revenue, reputação)
- **MÉDIO:** Risco controlável (workarounds possíveis)
- **BAIXO:** Melhorias desejáveis (post-release)

### **4. Considere Contexto de Negócio:**
- Sistemas críticos: Zero tolerância (banking, healthcare)
- Sistemas importantes: Riscos calculados aceitáveis
- Eventos sazonais: Mitigações específicas durante pico
- Compliance regulatório: Não negociável

### **5. Documente Decisão e Justificativas:**
- Decisão clara: APROVADO/REJEITADO/APROVADO COM RESTRIÇÕES
- Lista específica de evidências validadas
- Plano de correção com prazos para itens rejeitados
- Critérios para re-validação se necessária

---

**💡 O Testing Validator garante validação independente e objetiva da qualidade da implementação vs plano TDD!**