# Exemplos Práticos - Product Owner Agent

Este documento contém exemplos reais de como usar o **Product Owner Agent** para diferentes cenários de negócio.

---

## 🎯 **Exemplo 1: Sistema de Backup Automático**

### **Contexto:**
Cliente precisa implementar backup automático para compliance SOX 404.

### **Prompt:**
```
@agents/manual/product-owner.agent.md

Sprint: 03, Activity: sistema-backup-automatico
Contexto: "Cliente solicita backup automático diário dos dados críticos. Motivação: compliance SOX 404 + recuperação disaster. Valor esperado: reduzir risco operacional de R$ 2M."

Stakeholders: 
- CTO (sponsor e budget owner)
- DBA (responsável pela operação)
- Compliance Officer (auditoria externa)

Prioridade: Alta - regulatory compliance obrigatório
Prazo: 60 dias (auditoria externa agendada para março)
Restrições: 
- Orçamento limitado: R$ 50.000
- Infraestrutura on-premise (não pode usar cloud)
- Janela de manutenção: apenas 2h/dia (01:00-03:00)
- Dados sensíveis (não podem sair do datacenter)
```

### **Resultado Esperado:**
- Análise de valor de negócio focada em compliance
- Identificação de riscos regulatórios
- Priorização por criticidade dos dados
- Definição de RTO/RPO adequados
- Preparação para mesa redonda técnica

---

## 💰 **Exemplo 2: Sistema de Comissões de Vendas**

### **Contexto:**
Automatizar cálculo manual de comissões que consome 40h/mês do financeiro.

### **Prompt:**
```
@agents/manual/product-owner.agent.md

Sprint: 02, Activity: automatizacao-comissoes
Contexto: "Automatizar cálculo de comissões de vendedores. Processo atual: 40h manuais/mês + erros frequentes + reclamações da equipe comercial. ROI esperado: economia R$ 8.000/mês."

Problema atual:
- Planilhas Excel com 15+ fórmulas complexas
- Erros humanos em 12% dos cálculos
- Retrabalho constante (revisões e correções)
- Vendedores questionam valores (falta transparência)
- Atraso nos pagamentos (impacta motivação)

Valor de negócio:
- Economia: R$ 8.000/mês em horas do financeiro
- Redução erros: de 12% para < 1%
- Satisfação vendedores: transparência total
- Compliance: auditoria automatizada

Stakeholders:
- Gerente Financeiro (sponsor)
- Equipe de Vendas (25 vendedores)
- Controller (auditoria interna)
- RH (folha de pagamento)
```

### **Resultado Esperado:**
- Análise de ROI quantificada
- Mapeamento de dor dos stakeholders
- Identificação de regras de negócio complexas
- Definição de transparência necessária

---

## 🏥 **Exemplo 3: Portal do Paciente (Saúde)**

### **Contexto:**
Hospital precisa de portal para pacientes acessarem exames e consultas.

### **Prompt:**
```
@agents/manual/product-owner.agent.md

Sprint: 01, Activity: portal-paciente-digital
Contexto: "Implementar portal web para pacientes consultarem exames, agendarem consultas e acessarem prontuário. Reduzir 30% das ligações na recepção + melhorar satisfação NPS."

Motivação estratégica:
- Redução de custos operacionais (menos calls)
- Melhoria experiência do paciente (self-service)
- Diferencial competitivo (concorrência já tem)
- Preparação para telemedicina

Métricas atuais:
- 450 ligações/dia na recepção
- 65% das ligações são para consultas simples
- NPS atual: 7.2 (meta: 8.5+)
- Tempo médio atendimento: 4.5min

Stakeholders:
- Diretoria Médica (sponsor)
- Pacientes (1.200 ativos/mês)
- Recepção (6 atendentes)
- TI (infraestrutura e LGPD)

Restrições:
- LGPD compliance obrigatório
- Integração com sistema médico existente
- Acessibilidade para idosos (60% dos pacientes)
- Segurança de dados sensíveis
```

### **Resultado Esperado:**
- Foco em redução de custos + satisfação
- Consideração especial para LGPD
- Atenção à acessibilidade para idosos
- Integração com sistemas legados

---

## 🚀 **Exemplo 4: Migração de Sistema Legacy**

### **Contexto:**
Sistema de 8 anos precisa ser modernizado antes que tecnologia se torne insustentável.

### **Prompt:**
```
@agents/manual/product-owner.agent.md

Sprint: 04, Activity: migracao-sistema-vendas
Contexto: "Migrar sistema de vendas (.NET Framework 2.0 + WebForms + SQL Server 2008) para tecnologia moderna. Riscos: descontinuação suporte, vulnerabilidades, dificuldade manutenção."

Situação crítica:
- .NET Framework 2.0: sem suporte desde 2016
- SQL Server 2008: fim do suporte em abril/2025
- 0 desenvolvedores no mercado conhecem WebForms
- Custo manutenção: R$ 25.000/mês (freelancers especializados)
- 3 incidentes críticos nos últimos 6 meses

Impacto no negócio:
- Sistema processa R$ 2M/mês em vendas
- 45 usuários ativos diariamente  
- Integração com 5 sistemas externos
- 8 anos de dados históricos críticos

Opções consideradas:
1. Migração completa (.NET 8 + React)
2. Modernização gradual (strangler fig pattern)
3. Comprar solução pronta (ERP)

Stakeholders:
- CTO (decisor técnico)
- Gerente Comercial (usuário principal)
- CFO (aprovação orçamento)
- TI (execução e manutenção)
```

### **Resultado Esperado:**
- Análise de risco técnico vs negócio
- Comparação de estratégias de migração
- Avaliação de impacto na operação
- Planejamento de transição

---

## 📊 **Exemplo 5: Dashboard Executivo**

### **Contexto:**
Diretoria precisa de visão consolidada dos KPIs em tempo real.

### **Prompt:**
```
@agents/manual/product-owner.agent.md

Sprint: 02, Activity: dashboard-executivo-kpis
Contexto: "Criar dashboard executivo com KPIs consolidados em tempo real. Eliminar reuniões semanais de 2h + decisões mais rápidas baseadas em dados atualizados."

Dor atual:
- Relatórios manuais em Excel (desatualizados)
- Reuniões semanais de 2h para alinhamento
- Decisões baseadas em dados com 1 semana de atraso
- Cada diretor pede relatórios customizados
- Analistas gastam 16h/semana gerando relatórios

KPIs críticos identificados:
- Receita: diária, mensal, anual vs meta
- Vendas: pipeline, conversão, ticket médio
- Financeiro: fluxo de caixa, inadimplência, margem
- Operacional: produtividade, qualidade, SLA
- RH: turnover, satisfação, absenteísmo

Stakeholders:
- CEO (usuário principal)
- Diretores (5 áreas: comercial, financeiro, operações, RH, TI)
- Analistas (responsáveis pelos dados)
- Controller (validação financeira)

Valor esperado:
- Economia 16h/semana de analistas (R$ 12.800/mês)
- Decisões 5x mais rápidas (dados real-time)
- Eliminação de reuniões desnecessárias
- Visão unificada da empresa
```

### **Resultado Esperado:**
- Foco na economia de tempo executivo
- Identificação de KPIs realmente críticos
- Consideração de fontes de dados múltiplas
- Atenção à usabilidade para executives

---

## 🔐 **Exemplo 6: Implementação de SSO Corporativo**

### **Contexto:**
Funcionários usam 12 sistemas diferentes com senhas separadas.

### **Prompt:**
```
@agents/manual/product-owner.agent.md

Sprint: 03, Activity: sso-corporativo-unificado
Contexto: "Implementar Single Sign-On (SSO) para unificar acesso aos 12 sistemas corporativos. Reduzir calls de reset de senha + melhorar segurança + compliance LGPD."

Problema identificado:
- 12 sistemas com logins separados
- 85 calls/mês para reset de senha (TI sobrecarregada)
- Senhas fracas (usuários reutilizam entre sistemas)
- Auditoria de acesso fragmentada
- Onboarding novos funcionários: 2 dias

Sistemas para integrar:
1. ERP (SAP) - 120 usuários
2. CRM (Salesforce) - 45 usuários
3. Email (Office 365) - 180 usuários
4. Sistema Vendas (interno) - 80 usuários
5. BI (Power BI) - 25 usuários
6. RH (interno) - 15 usuários
7. Financeiro (interno) - 12 usuários
8. Estoque (WMS) - 35 usuários
9. Qualidade (interno) - 8 usuários
10. Portaria (interno) - 6 usuários
11. Manutenção (interno) - 15 usuários
12. Backup (Veeam) - 3 usuários

Benefícios esperados:
- Redução 90% calls reset senha
- Onboarding: de 2 dias para 2 horas
- Auditoria centralizada de acessos
- Compliance LGPD (controle granular)
- Segurança: MFA obrigatório

Stakeholders:
- CISO (sponsor e segurança)
- TI (implementação e suporte)
- RH (onboarding/offboarding)
- Todos usuários finais (180 pessoas)
```

### **Resultado Esperado:**
- Análise de complexidade de integração
- Foco em segurança e compliance
- Consideração de mudança organizacional
- Planejamento de rollout gradual

---

## 📱 **Exemplo 7: App Mobile para Vendedores**

### **Contexto:**
Vendedores externos precisam acessar CRM via mobile.

### **Prompt:**
```
@agents/manual/product-owner.agent.md

Sprint: 01, Activity: app-mobile-vendedores-externos
Contexto: "Desenvolver app mobile para 25 vendedores externos acessarem CRM, catálogo e fazerem pedidos offline. Aumentar 20% produtividade + reduzir erros de pedidos."

Situação atual:
- Vendedores usam caderno + telefone
- Pedidos feitos por WhatsApp/ligação
- 15% erro em pedidos (produto, preço, estoque)
- Relatórios de visita em papel
- Sem visibilidade da agenda/rotas

Perfil dos vendedores:
- Idade: 35-55 anos (baixa literacy digital)
- Smartphones: Android básicos (não iPhones)
- Conexão: instável no interior
- Trabalho: 8-10 visitas/dia
- Meta: R$ 50.000/mês por vendedor

Funcionalidades críticas:
- Consultar estoque em tempo real
- Fazer pedidos offline (sync posterior)
- Ver histórico do cliente
- Catálogo com fotos e preços
- Agenda de visitas
- Relatório diário de atividades

Valor de negócio:
- Redução erros: de 15% para <3%
- Aumento produtividade: +20% (menos retrabalho)
- Visibilidade gerencial: relatórios automáticos
- Satisfação cliente: pedidos mais precisos

Stakeholders:
- Gerente Comercial (sponsor)
- 25 Vendedores (usuários finais)
- Suporte TI (deploy e manutenção)
- Estoque (integração disponibilidade)
```

### **Resultado Esperado:**
- Foco na simplicidade para usuários com baixa literacy
- Ênfase na funcionalidade offline
- Consideração de dispositivos básicos
- ROI baseado em redução de erros

---

## 🎓 **Exemplo 8: Sistema Acadêmico Online**

### **Contexto:**
Faculdade precisa digitalizar processos acadêmicos pós-pandemia.

### **Prompt:**
```
@agents/manual/product-owner.agent.md

Sprint: 02, Activity: sistema-academico-digital
Contexto: "Digitalizar processos acadêmicos da faculdade: matrícula online, histórico digital, declarações automáticas. Reduzir 70% atendimento presencial + satisfação estudante."

Motivação pós-pandemia:
- Estudantes esperam serviços digitais
- Concorrência já oferece (perda competitiva)
- Redução custos operacionais
- Preparação para EAD expandido

Processos para digitalizar:
1. Matrícula/Rematrícula (atualmente 3h presencial)
2. Solicitação de declarações (5 dias úteis)
3. Consulta notas e frequência
4. Histórico escolar digital
5. Boleto/financeiro online
6. Comunicação professor-aluno
7. Avaliação institucional
8. Calendário acadêmico

Números atuais:
- 2.500 alunos ativos
- 850 matrículas por semestre
- 1.200 declarações/mês
- 6 atendentes presenciais
- Custo atendimento: R$ 18.000/mês

Stakeholders principais:
- Reitoria (sponsor e visão estratégica)
- Secretaria Acadêmica (operação)
- 2.500 Estudantes (usuários finais)
- 120 Professores (usuários secundários)
- TI (infraestrutura e manutenção)

Benefícios esperados:
- Redução 70% atendimento presencial
- Satisfação estudante: de 6.8 para 8.5+
- Economia R$ 12.000/mês (4 atendentes)
- Diferencial competitivo
- Base para expansão EAD
```

### **Resultado Esperado:**
- Análise de competitividade educacional
- Foco na experiência do estudante
- Consideração de integração acadêmica
- Preparação para futuras modalidades

---

## ⚡ **Dicas para Usar os Exemplos:**

### **1. Adapte o Contexto:**
- Substitua os números pelos da sua empresa
- Ajuste stakeholders conforme sua organização
- Modifique tecnologias conforme seu stack

### **2. Seja Específico:**
- Use valores quantificados (ROI, economia, métricas)
- Mencione prazos reais e restrições conhecidas
- Identifique dores específicas dos usuários

### **3. Inclua Stakeholders:**
- Liste todos os envolvidos e seus interesses
- Identifique sponsors e decisores
- Considere usuários finais e suas necessidades

### **4. Foque no Valor:**
- Quantifique benefícios esperados
- Identifique riscos de não fazer
- Compare com situação atual (baseline)

---

**💡 Use estes exemplos como base e adapte para seus cenários específicos!**