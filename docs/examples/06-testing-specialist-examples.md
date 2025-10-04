# Exemplos Práticos - Testing Specialist Agent

Este documento contém exemplos reais de como usar o **Testing Specialist Agent** para criar planos TDD completos ANTES da implementação.

---

## 🧪 **Exemplo 1: Sistema de Cálculo de Comissões**

### **Contexto:**
Planejar testes para sistema complexo de comissões antes da implementação.

### **Prompt:**
```
@agents/manual/testing-specialist.agent.md

Sprint: 03, Activity: plano-tdd-calculo-comissoes
Contexto: "Criar plano TDD COMPLETO para cálculo de comissão de vendedores. Regras complexas: base + performance + metas + bônus trimestral + casos especiais. CRITICAL: testes antes do código."

Critérios de aceite (definidos pelo PO):
1. Cálculo correto conforme RN-0030 (base) a RN-0035 (bônus especiais)
2. Performance < 100ms para lote de 1000 vendedores
3. Tratamento cenários extremos: vendas negativas, metas retroativas, vendedores inativos
4. Auditoria completa: log de cada cálculo com justificativa matemática
5. Relatório gerencial: breakdown por componente da comissão
6. Integração: ERP (vendas) + CRM (metas) + RH (dados funcionários)

Regras de negócio identificadas:
- RN-0030: Base = vendas * percentual_fixo (2.5%)
- RN-0031: Performance = base * multiplicador_meta (0.8 a 1.5x)
- RN-0032: Bônus trimestral = se meta_trimestre > 110% então +R$ 2.000
- RN-0033: Teto máximo = R$ 15.000/mês (compliance)
- RN-0034: Desconto inadimplência = se cliente não pagou, -50% comissão
- RN-0035: Casos especiais = férias, licença, demissão (pro-rata)

Complexidade técnica:
- 15 regras interdependentes + 3 integrações externas
- Dados históricos: 24 meses para cálculo performance
- Volume: 120 vendedores * 12 meses * recálculos retroativos
- Criticidade: Erro = processo trabalhista + desmotivação equipe

Meta de cobertura: 95% (financeiro crítico, auditoria SOX)
Tipos de teste: Unit (70%) + Integration (20%) + E2E (10%) + Performance

Entrada técnica disponível:
- 03-arquitetura.md: Clean Architecture + Domain Services + CQRS
- 02-requisitos-bdd.md: 47 cenários Gherkin já mapeados
- RN-0030.md a RN-0035.md: Regras detalhadas com exemplos

Foco: TDD rigoroso (red-green-refactor) + automação CI/CD + evidências para auditoria
```

### **Resultado Esperado:**
- Plano TDD com 95+ cenários de teste específicos
- Estrutura de testes organizada por domínio
- Casos extremos e edge cases mapeados
- Performance tests com benchmarks
- Evidências automatizadas para auditoria

---

## 🏥 **Exemplo 2: Sistema de Agendamento Médico**

### **Contexto:**
Testes para sistema crítico de agendamento hospitalar.

### **Prompt:**
```
@agents/manual/testing-specialist.agent.md

Sprint: 02, Activity: tdd-agendamento-medico
Contexto: "Plano TDD para sistema de agendamento médico. CRÍTICO: zero erros (vidas humanas). Cenários: consultas, exames, cirurgias, emergências, cancelamentos."

Critérios de aceite críticos:
1. Disponibilidade 99.99% (4min downtime/mês máximo)
2. Concorrência: 500 agendamentos simultâneos sem conflito  
3. Compliance: CFM + ANS + LGPD + auditoria hospitalar
4. Integração: Sistema médico + laboratório + centro cirúrgico
5. Notificações: SMS + email + push para médicos/pacientes
6. Emergência: Prioridade absoluta + override agendas

Cenários críticos identificados:
**Agendamento normal:**
- Consulta disponível → agendar → confirmar → notificar
- Exame com preparo → agendar → enviar instruções → lembrar
- Cirurgia → agendar sala + equipe + materiais + pré-operatório

**Cenários de conflito:**
- Duplo agendamento mesmo horário (race condition)
- Médico cancela última hora (reagendar pacientes)
- Emergência → cancelar/remarcar agenda inteira
- Sistema indisponível → fallback manual

**Cenários compliance:**
- Paciente menor idade → responsável deve aprovar
- Exame com contraste → histórico alergia obrigatório
- Cirurgia → termo consentimento + jejum + exames pré
- LGPD → consentimento dados + direito esquecimento

Integrações críticas:
1. HIS (Hospital Information System): Prontuários + histórico
2. Laboratory System: Exames + resultados + preparo
3. Financial System: Convênios + particular + autorização
4. Notification Service: SMS + email + WhatsApp + push

Riscos de negócio:
- Paciente perde consulta = insatisfação + perda receita
- Médico sem agenda = ociosidade + custos operacionais
- Erro agendamento cirurgia = risco vida + processo médico
- Indisponibilidade = emergências sem atendimento

Meta cobertura: 99% (sistema crítico, vidas humanas)
Testes especiais: Stress (500 concurrent) + Chaos Engineering + Security
```

### **Resultado Esperado:**
- Plano TDD com cenários de vida/morte
- Testes de concorrência e race conditions
- Simulação de falhas e disaster recovery
- Compliance médico automatizado
- Performance sob stress extremo

---

## 💰 **Exemplo 3: Sistema de Internet Banking**

### **Contexto:**
Plano de testes para operações financeiras críticas.

### **Prompt:**
```
@agents/manual/testing-specialist.agent.md

Sprint: 01, Activity: tdd-internet-banking
Contexto: "TDD para internet banking: transferências, PIX, investimentos, empréstimos. ZERO tolerância para bugs financeiros. Compliance Banco Central + auditoria + anti-fraude."

Operações críticas para testar:
**Transferências:**
1. TED/DOC: Validação CPF/CNPJ + saldo + limites + horário funcionamento
2. PIX: Instant payment + QR Code + chaves + limite noturno
3. Agendamento: Future transfers + recorrência + feriados
4. Internacional: SWIFT + conversão moeda + compliance FATCA

**Investimentos:**
1. CDB/LCI/LCA: Aplicação + resgate + IR + IOF proporcional
2. Fundos: Cotização D+1 + taxa administração + come-cotas
3. Renda variável: Ordem compra/venda + liquidação D+2 + custódia
4. Tesouro Direto: Integração B3 + marcação mercado + vencimento

**Empréstimos:**
1. Crédito pessoal: Score + renda + garantias + aprovação automática
2. Antecipação recebíveis: Análise duplicatas + desconto + risco
3. Financiamento: FIDC + CET + amortização + seguro prestamista

Compliance obrigatório:
- Banco Central: BACEN regulamentação + reporting + limites
- Anti-lavagem: COAF + PEPs + transações suspeitas + bloqueios
- LGPD financeira: Consentimento + portabilidade + esquecimento dados
- Open Banking: Consent management + APIs padronizadas + security

Cenários de fraude:
- Tentativas força bruta login → bloqueio automático
- Transferências atípicas → análise comportamental → MFA adicional
- Device novo → biometria + SMS + confirmação email
- Transações alto valor → aprovação manual + callback

Performance financeira:
- Transferência: <2s (expectativa cliente digital)
- Saldo atualizado: Real-time após transação
- PIX: <10s (regulamentação Banco Central)
- Disponibilidade: 99.95% (SLA contratual)

Meta cobertura: 99.9% (regulamentação + risco financeiro)
Testes especiais: Security + Penetration + Load + Chaos + Compliance
```

### **Resultado Esperado:**
- Plano TDD banking-grade com security first
- Cenários de compliance automatizados
- Testes anti-fraude e behavioral analytics
- Performance tests com SLA financeiro
- Evidências para auditoria Banco Central

---

## 🛒 **Exemplo 4: E-commerce Black Friday**

### **Contexto:**
Preparação para pico de tráfego sazonal extremo.

### **Prompt:**
```
@agents/manual/testing-specialist.agent.md

Sprint: 04, Activity: tdd-ecommerce-black-friday
Contexto: "Plano TDD para Black Friday: 50x tráfego normal, promoções complexas, estoque limitado, pagamentos sob stress. Falha = perda R$ 2M receita."

Cenários de pico identificados:
**Tráfego extremo:**
- Normal: 1.000 usuários simultâneos
- Black Friday: 50.000 usuários simultâneos (pico às 00h)
- Conversão: 15x volume pedidos normal
- Pageviews: 100x catálogo + busca

**Funcionalidades sob stress:**
1. Catálogo: Busca + filtros + ordenação com 50k users
2. Carrinho: Add/remove produtos com race conditions
3. Checkout: Pagamento + estoque + frete simultâneo
4. Promoções: Cupons limitados + primeira compra + frete grátis
5. Estoque: Reserva + liberação + overselling prevention

Regras promocionais complexas:
- Desconto progressivo: 10% (2 itens), 15% (3 itens), 20% (5+ itens)
- Cupom limitado: 1000 cupons "SAVE50" → esgota em minutos
- Frete grátis: Compra >R$ 150 + CEPs específicos
- Combo produtos: Compre X leve Y + estoque sincronizado
- Flash deals: Ofertas por 30min + countdown timer

Pontos de falha críticos:
1. **Estoque negativo:** Vender mais que disponível
2. **Pagamento timeout:** Gateway sob stress → abandono
3. **Carrinho perdido:** Session expire → frustração cliente
4. **Preço errado:** Cache desatualizado → prejuízo
5. **Site down:** Infraestrutura não aguenta → perda total

Performance requirements:
- Homepage: <1s load time (50k concurrent)  
- Search: <500ms response (complex filters)
- Checkout: <3s complete flow (payment stress)
- Availability: 99.99% durante 48h evento

Testes especiais necessários:
- Load: Simular 50k usuarios reais (não bots)
- Spike: Pico instantâneo 00h (worst case)
- Endurance: 48h continuous high load
- Chaos: Failures during peak traffic
- Recovery: Failover + data consistency

Meta cobertura: 98% (revenue crítico)
Monitoramento: Real-time dashboards + alerts + war room
```

### **Resultado Esperado:**
- Plano TDD para evento crítico sazonal
- Testes de carga e spike extremos
- Cenários de failover e disaster recovery
- Monitoramento em tempo real
- Plano de contingência para falhas

---

## 🏭 **Exemplo 5: Sistema de Controle Industrial**

### **Contexto:**
IoT e automação industrial com safety crítico.

### **Prompt:**
```
@agents/manual/testing-specialist.agent.md

Sprint: 03, Activity: tdd-controle-industrial
Contexto: "Sistema controle industrial: sensores IoT, automação fábrica, safety systems. CRÍTICO: falha = acidentes + parada produção R$ 500K/dia."

Sistemas críticos integrados:
**Sensores IoT (500+ devices):**
- Temperatura: Fornos 1200°C + alerta >1250°C → shutdown automático
- Pressão: Caldeiras + válvulas segurança + emergency release
- Vibração: Máquinas rotativas + predictive maintenance
- Gases: CO, CO2, H2S + alarmes + evacuação área

**Automação (PLCs + SCADA):**
- Processo produção: Sequência automática + override manual
- Controle qualidade: Reject automático + stats + traceability  
- Logística interna: WMS + robôs + AGVs + traffic control
- Energia: Load balancing + backup generators + brownout

**Safety Systems (SIL-rated):**
- Emergency shutdown: <2s response + fail-safe state
- Fire suppression: Detecção + alarm + sprinklers automático
- Access control: Áreas restritas + PPE detection + lockout/tagout
- Environmental: Efluentes + emissões + compliance ambiental

Cenários de teste críticos:
**Safety scenarios:**
- Sensor failure → backup sensor + alarm + manual intervention
- Temperature spike → cascade shutdown + cooling + investigation
- Gas leak → isolation + ventilation + evacuation + external alert
- Power outage → UPS + generators + graceful shutdown + data integrity

**Operational scenarios:**
- Production sequence: Raw material → process → quality → shipping
- Maintenance mode: Planned shutdown + lockout + testing + restart
- Quality failure: Stop line + quarantine + root cause + restart
- Supply chain: Just-in-time + inventory + shortage → alternative

Integrações complexas:
1. ERP: Production orders + materials + costs + scheduling
2. MES: Manufacturing execution + real-time + traceability
3. Laboratory: Quality tests + certificates + batch release
4. Maintenance: CMMS + work orders + spare parts + history
5. Regulatory: Environmental reports + safety + compliance

Performance industrial:
- Sensor readings: <100ms response (real-time critical)
- Alarm response: <2s (safety regulation)
- Data logging: 100% integrity (compliance + investigation)
- Availability: 99.98% (planned maintenance 8h/month)

Meta cobertura: 99.95% (safety + regulatory + financial risk)
Compliance: ISO 9001 + ISO 14001 + OSHA + EPA + local regulations
```

### **Resultado Esperado:**
- Plano TDD para sistemas safety-critical
- Testes de failover e emergency procedures
- Simulação de cenários industriais perigosos
- Compliance automatizado para múltiplas normas
- Integração com sistemas de monitoramento industrial

---

## 🎓 **Exemplo 6: Sistema Acadêmico - EAD**

### **Contexto:**
Plataforma de ensino online com milhares de estudantes.

### **Prompt:**
```
@agents/manual/testing-specialist.agent.md

Sprint: 02, Activity: tdd-plataforma-ead
Contexto: "TDD para plataforma EAD: 10.000 alunos simultâneos, vídeo-aulas, provas online, anti-cola, certificação digital. Falha = perda semestre letivo."

Funcionalidades críticas EAD:
**Streaming de vídeo:**
- 10.000 alunos simultâneos assistindo diferentes aulas
- Adaptive bitrate: Ajustar qualidade conforme conexão
- Progress tracking: Marcar assistido + tempo mínimo obrigatório
- Speed control: 0.5x a 2x + sincronização legendas
- Download offline: Temporário + DRM + expiração automática

**Avaliações online:**
- Provas: Tempo limitado + anti-cola + randomização questões
- Trabalhos: Upload arquivos + plagiarism detection + deadline rígido
- Fóruns: Discussões + moderação + participação obrigatória
- Simulados: Unlimited attempts + feedback instantâneo

**Anti-cola systems:**
- Browser lockdown: Fullscreen + disable copy/paste + no alt-tab
- Webcam proctoring: Face detection + suspicious behavior alert
- Question randomization: Pool 500 questões → 20 aleatórias
- Time pressure: Insufficient time para consulta externa
- Plagiarism detection: Turnitin integration + similarity report

Cenários críticos acadêmicos:
**Durante provas:**
- 5.000 alunos fazendo prova simultânea → sem degradação
- Internet instável → auto-save + recuperar progresso
- Sistema indisponível → backup + extensions + notificação
- Bateria acabou → mobile app + cloud sync + fair grading

**Compliance educacional:**
- MEC regulations: Carga horária + frequência + aproveitamento
- Accessibility: WCAG 2.1 AA + screen readers + closed captions
- LGPD estudantil: Dados menores + consentimento pais + portability
- Certificação digital: ICP-Brasil + hash blockchain + verification

Performance acadêmica:
- Video start: <3s (student patience limited)
- Concurrent streams: 10.000 without buffering
- Exam submission: <1s (deadline anxiety)
- Grade calculation: Real-time após submissão

Integrações educacionais:
1. SIS (Student Information System): Matriculas + histórico + transcripts
2. LTI (Learning Tools Interoperability): Third-party tools integration
3. Video CDN: Global distribution + caching + analytics
4. Payment gateway: Mensalidades + installments + discounts
5. Certificate authority: Digital signatures + blockchain + verification

Meta cobertura: 97% (semestre letivo não pode repetir)
Testes especiais: Concurrent users + video streaming + exam stress
```

### **Resultado Esperado:**
- Plano TDD para ambiente educacional crítico
- Testes de concurrent streaming e assessments
- Scenarios anti-cola e proctoring
- Compliance educacional automatizado
- Performance sob carga acadêmica extrema

---

## 🎯 **Dicas para Criar Planos TDD Eficazes:**

### **1. Comece com Critérios de Aceite:**
- Liste TODOS os critérios mensuráveis
- Inclua performance específica (não "boa performance")
- Adicione compliance e regulatory requirements
- Considere cenários de falha e recovery

### **2. Identifique Cenários Críticos:**
- Happy path (caso normal)
- Edge cases (limites do sistema)
- Error scenarios (falhas esperadas)
- Abuse cases (uso malicioso/incorreto)
- Integration failures (sistemas externos)

### **3. Defina Cobertura por Risco:**
- Sistemas críticos: 95-99% cobertura
- Sistemas importantes: 85-90% cobertura  
- Sistemas auxiliares: 70-80% cobertura
- Priorize por impacto no negócio

### **4. Planeje Tipos de Teste:**
- **Unit (60-70%):** Lógica de negócio + regras + cálculos
- **Integration (20-30%):** APIs + banco + sistemas externos
- **E2E (5-15%):** User journeys + workflows críticos
- **Performance:** Load + stress + spike + endurance
- **Security:** Authentication + authorization + data protection

### **5. Considere Automação:**
- CI/CD pipeline integration
- Testes executam a cada commit
- Evidências automatizadas para auditoria
- Métricas coletadas automaticamente
- Alertas para degradação de cobertura

---

**💡 O Testing Specialist garante que TODOS os cenários sejam pensados ANTES da implementação, seguindo TDD rigoroso!**