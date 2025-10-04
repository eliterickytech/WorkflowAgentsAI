# Exemplos Práticos - UX/UI Specialist Agent

Este documento contém exemplos reais de como usar o **UX/UI Specialist Agent** para criar wireframes, protótipos e design systems.

---

## 🎨 **Exemplo 1: Dashboard Executivo**

### **Contexto:**
Interface para C-Level acompanhar KPIs em tempo real.

### **Prompt:**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 02, Activity: dashboard-executivo-c-level
Contexto: "Criar interface para dashboard executivo com KPIs real-time, gráficos interativos e filtros avançados. Usuários: CEO, diretores, gerentes (baixa literacy digital)."

Usuários-alvo:
- CEO (60 anos, usa tablet iPad, foco em números consolidados)
- CFO (45 anos, desktop/laptop, detalhe financeiro)
- Diretores comercial/operação (35-50 anos, mobile ocasional)
- Gerentes (30-40 anos, uso misto desktop/mobile)

Dispositivos e contextos:
- Desktop: 70% uso (escritório, reuniões com projeção)
- Tablet: 20% uso (home office, viagens)
- Mobile: 10% uso (consultas rápidas, emergências)

Funcionalidades principais:
1. KPIs consolidados: Receita, vendas, margem, inadimplência
2. Gráficos trending: Últimos 30/90/365 dias
3. Drill-down: Clicar KPI → detalhamento por região/produto
4. Alertas visuais: Meta não atingida, problemas críticos
5. Export PDF: Relatório executivo para board

Restrições de design:
- Identidade visual: Logo e cores corporativas (azul #1976d2)
- Acessibilidade: WCAG 2.1 AA (contraste, navegação teclado)
- Performance: Carregamento < 2s (executives impaciência)
- Simplicidade: Máximo 3 cliques para qualquer informação
- Confiabilidade: Dados sempre atualizados (indicador timestamp)

Entrada técnica:
- 03-arquitetura.md: SignalR real-time + Cache Redis + APIs REST
- Componentes disponíveis: Chart.js, Bootstrap 5, jQuery
- Dados: PostgreSQL com 5s latência + cache inteligente

Prioridades UX:
- Clareza informação (40%): Numbers fáceis de entender
- Velocidade acesso (30%): Mínimo de cliques/navegação
- Confiança dados (20%): Timestamps, fontes, validação visual
- Acessibilidade (10%): Padrões corporativos
```

### **Resultado Esperado:**
- Wireframes ASCII com layout executivo limpo
- User flow focado em drill-down de KPIs
- Design system corporate com cores e tipografia
- Protótipo HTML com interações reais
- Especificações de acessibilidade implementáveis

---

## 📱 **Exemplo 2: App Mobile para Vendedores**

### **Contexto:**
Interface mobile para vendedores externos com funcionamento offline.

### **Prompt:**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 01, Activity: interface-mobile-vendedores
Contexto: "Criar interface mobile para 25 vendedores externos: CRM, catálogo produtos, pedidos offline-first. Usuários com baixa literacy digital, smartphones básicos."

Usuários-alvo:
- 25 vendedores externos, idade 40-55 anos
- Baixa literacy digital (dificuldade com apps complexos)
- Trabalham 8-12h no campo, sob sol forte
- Usam luvas ou mãos sujas frequentemente
- Pressão por resultados, pouco tempo para aprender

Dispositivos e limitações:
- Smartphones Android básicos (tela 5.5", resolução 720p)
- Conexão 3G instável no interior (offline frequente)
- Bateria limitada (precisa durar dia todo)
- Armazenamento 16-32GB (limitado para cache)
- Processamento lento (evitar animações pesadas)

Funcionalidades principais:
1. Login rápido: Biometria ou PIN (não senha complexa)
2. Catálogo offline: 2000 produtos com fotos e preços
3. Cliente 360: Histórico compras, dados contato, localização
4. Pedido simples: Add produtos, calcular total, confirmar
5. Sync automático: Upload pedidos quando conectar
6. Agenda: Visitas do dia com GPS integrado

Restrições de design:
- Touch-friendly: Botões mínimo 48px (dedos grossos/luvas)
- Alto contraste: Legibilidade sob sol forte
- Offline-first: Tudo funciona sem internet
- Simplicidade extrema: Fluxo linear, sem múltiplas opções
- Feedback visual: Estados loading, sync, offline claros

Contexto de uso:
- Ambiente: Dentro do carro, na rua, estabelecimentos
- Interrupções: Ligações, trânsito, conversas com clientes
- Urgência: Pedidos precisam ser rápidos (cliente esperando)
- Resistência: Preferem papel/telefone (mindset change)

Prioridades UX:
- Simplicidade (50%): Mínimo learning curve
- Performance (25%): Responsividade mesmo offline
- Durabilidade (15%): Resistente a uso intenso
- Confiabilidade (10%): Sync garantido, sem perda dados
```

### **Resultado Esperado:**
- Wireframes mobile-first com navegação simples
- User flow otimizado para uso rápido e interrompido
- Design system com high contrast e large touch targets
- Protótipo PWA com comportamento offline
- Especificações detalhadas de performance e sync

---

## 🏥 **Exemplo 3: Portal do Paciente - Healthcare**

### **Contexto:**
Portal web para pacientes consultarem exames e agendarem consultas.

### **Prompt:**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 03, Activity: portal-paciente-hospital
Contexto: "Portal web para pacientes consultarem exames, agendarem consultas e acessarem prontuário. Foco: acessibilidade para idosos (60% usuários) + LGPD compliance."

Usuários-alvo:
- Pacientes idosos (60-80 anos, 60% da base)
- Familiares cuidadores (30-50 anos, intermediários)
- Pacientes jovens (20-40 anos, tech-savvy, 25% da base)
- Diferentes níveis educação e digital literacy

Dispositivos e contextos:
- Desktop: 60% (casa, rede familiar ajuda)
- Mobile: 35% (consultas rápidas, emergências)
- Tablet: 5% (idosos preferem tela maior)

Funcionalidades principais:
1. Login seguro: CPF + data nascimento (familiar)
2. Exames: Visualizar resultados + download PDF
3. Agendamento: Consultas disponíveis + confirmação
4. Prontuário: Histórico médico básico (não técnico)
5. Receitas: Medicamentos prescritos + posologia
6. Comunicação: Mensagens com equipe médica

Restrições específicas:
- LGPD compliance: Consentimento explícito, dados mínimos
- Acessibilidade WCAG 2.1 AA: Screen reader, navegação teclado
- Linguagem: Termos médicos simplificados
- Segurança: Autenticação forte + timeout sessão
- Privacidade: Dados sensíveis protegidos

Considerações especiais:
- Idosos: Texto grande, contraste alto, navegação simples
- Emergência: Acesso rápido a informações críticas
- Confiança: Design profissional, certificações visíveis
- Suporte: Help contextual, telefone de apoio

Entrada técnica:
- Sistema médico: HL7 FHIR APIs + base dados médica
- Segurança: OAuth 2.0 + encryption + audit logs
- Performance: Cache dados não-críticos + CDN

Prioridades UX:
- Acessibilidade (40%): Conformidade total WCAG
- Simplicidade (30%): Navegação intuitiva para idosos  
- Confiança (20%): Design profissional + segurança
- Compliance (10%): LGPD + regulações médicas
```

### **Resultado Esperado:**
- Wireframes com foco em acessibilidade
- User flow otimizado para diferentes gerações
- Design system healthcare com cores/tipografia médica
- Protótipo com simulação de screen reader
- Checklist completo LGPD + WCAG 2.1 AA

---

## 🎓 **Exemplo 4: Sistema Acadêmico Online**

### **Contexto:**
Plataforma digital para estudantes universitários.

### **Prompt:**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 02, Activity: portal-estudante-faculdade
Contexto: "Portal acadêmico para 2500 estudantes: matrícula online, notas, histórico, declarações. Competir com faculdades que já têm sistemas modernos."

Usuários-alvo:
- Estudantes 18-25 anos (nativos digitais, high expectations)
- Estudantes EAD 25-45 anos (working professionals, tempo limitado)
- Responsáveis financeiros (pais, 45-60 anos, pagam mensalidade)
- Professores (30-65 anos, uso ocasional para comunicação)

Dispositivos e uso:
- Mobile: 80% (students always on phone)
- Desktop: 15% (trabalhos acadêmicos, impressão)
- Tablet: 5% (reading, note-taking)

Funcionalidades acadêmicas:
1. Matrícula/Rematrícula: Wizard step-by-step
2. Notas e frequência: Por disciplina + histórico
3. Histórico escolar: Geração PDF + autenticado
4. Financeiro: Boletos, pagamentos, negociação
5. Declarações: Matrícula, frequência, conclusão
6. Comunicação: Professores, coordenação, financeiro
7. Calendário: Provas, trabalhos, eventos
8. Biblioteca: Reservas, renovações, acervo digital

Expectativas da geração Z:
- Speed: Tudo instantâneo, zero loading
- Mobile-first: App-like experience no browser
- Notificações: Push para prazos, notas, comunicados
- Social: Integration com redes sociais
- Personalização: Dashboard customizável

Diferencial competitivo:
- Concorrência já tem portais modernos
- Students comparam com Netflix, Instagram UX
- Responsáveis comparam com bancos digitais
- Retention: UX ruim = transferência para concorrente

Restrições técnicas:
- Sistema legado: Integração com mainframe IBM
- Performance: 2500 usuários simultâneos (início semestre)
- Compliance: MEC regulations + LGPD
- Infraestrutura: On-premise + budget limitado

Prioridades UX:
- Performance (35%): Speed expectations altíssimas
- Mobile experience (30%): Mobile-first obrigatório
- Intuitividade (20%): Zero learning curve
- Diferenciação (15%): Better than competition
```

### **Resultado Esperado:**
- Wireframes mobile-first com design moderno
- User flow otimizado para diferentes perfis de usuário
- Design system universitário com identidade jovem
- Protótipo PWA com notificações push
- Benchmarking UX com concorrentes

---

## 💼 **Exemplo 5: Sistema de RH Corporativo**

### **Contexte:**
Interface para funcionários e RH gerenciarem processos.

### **Prompt:**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 04, Activity: portal-rh-corporativo
Contexto: "Portal de RH para 500 funcionários + equipe RH. Processos: férias, holerite, benefícios, avaliações, treinamentos. Reduzir 80% calls para RH."

Usuários-alvo:
- 500 funcionários (idades variadas, diferentes níveis hierárquicos)
- Equipe RH (8 pessoas, power users, needs efficiency)
- Gestores (approve requests, team management)
- Diretoria (reports, analytics, strategic decisions)

Segmentação por perfil:
- Operacional (60%): Fábrica, baixa literacy, desktop compartilhado
- Administrativo (30%): Escritório, desktop pessoal, skilled
- Gestores (8%): Multi-device, foco em aprovações
- Executivos (2%): Mobile/tablet, dashboards executivos

Funcionalidades por usuário:
**Funcionários:**
1. Holerite: Download PDF + histórico 12 meses
2. Férias: Solicitar períodos + saldo disponível
3. Benefícios: Plano saúde, VR, VT, convênios
4. Ponto: Consultar batidas + justificar ausências
5. Treinamentos: Cursos obrigatórios + certificados

**Gestores:**
1. Aprovações: Férias, horas-extra, despesas da equipe
2. Avaliações: Performance reviews + metas
3. Relatórios: Indicadores da equipe + comparativos

**RH:**
1. Cadastros: Funcionários, dependentes, benefícios
2. Processos: Admissão, demissão, alterações contratuais
3. Relatórios: Headcount, turnover, absenteísmo, custos

Contexto organizacional:
- Reduzir calls: 150/mês para RH (80% são consultas simples)
- Self-service: Funcionários resolvem sozinhos
- Compliance: CLT + trabalhista + auditoria interna
- Integração: Folha Domínio + banco + plano saúde

Restrições de ambiente:
- Operacional: Computadores compartilhados (login rápido)
- Segurança: Dados pessoais sensíveis (LGPD rigorosa)
- Horários: Turnos diferentes, acesso 24x7
- Infraestrutura: Rede interna + VPN para home office

Prioridades UX:
- Self-service (40%): Reduzir dependência do RH
- Segurança (25%): Proteção dados pessoais
- Eficiência (20%): Processos rápidos e claros
- Inclusão (15%): Acessível para todos os níveis
```

### **Resultado Esperado:**
- Wireframes com diferentes views por perfil de usuário
- User flow otimizado para self-service
- Design system corporativo com hierarquia clara
- Protótipo com simulação de diferentes personas
- Especificações de segurança e compliance LGPD

---

## 🛒 **Exemplo 6: E-commerce B2B**

### **Contexto:**
Plataforma de vendas para distribuidores atacadistas.

### **Prompt:**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 03, Activity: ecommerce-b2b-atacado
Contexto: "E-commerce B2B para distribuidores atacadistas: catálogo 15k produtos, pedidos complexos, crédito/prazo, integração ERP. Competir com marketplace B2B modernos."

Usuários-alvo:
- Compradores B2B (30-50 anos, experienced buyers)
- Assistentes comerciais (25-40 anos, place orders for buyers)
- Gerentes compras (40-60 anos, approve large orders)
- Vendedores internos (support B2B customers via phone)

Comportamento B2B específico:
- Orders: Volumes altos, múltiplos SKUs por pedido
- Frequency: Reposição semanal/mensal (padrões)
- Decision: Committee buying, multiple approvers
- Payment: Crédito 30/60/90 dias, não cartão
- Relationship: Account manager, histórico longo

Funcionalidades B2B:
1. Catálogo avançado: Filtros por categoria, marca, disponibilidade
2. Busca profissional: SKU, código barras, referência cruzada
3. Pedido rápido: CSV upload, copiar pedido anterior
4. Carrinho persistente: Salvar para aprovar depois
5. Crédito: Limite disponível, prazos negociados
6. Histórico: Pedidos anteriores, notas fiscais, tracking
7. Relatórios: Compras por período, análise spend

Complexidades B2B:
- Pricing: Tabelas diferenciadas por cliente
- Availability: Estoque reservado, ATP (available-to-promise)
- Logistics: Frete por região + prazo entrega
- Credit: Approval workflow + risk management
- Integration: ERP, CRM, financeiro, logistics

Diferencial competitivo:
- Marketplace B2B: Mercado Livre B2B, Amazon Business
- Expectativa: User experience consumer-like
- Performance: Catalog search < 1s, order placement < 30s
- Mobile: 40% orders via mobile (field sales)

Restrições técnicas:
- SAP integration: Real-time pricing + availability
- Performance: 15k products + complex filters
- Security: B2B data privacy + competitive info
- Offline: Mobile app works offline (sales visits)

Prioridades UX:
- Efficiency (40%): Fast reordering, bulk operations
- Professional feel (25%): B2B credibility vs consumer
- Mobile optimization (20%): Field sales support
- Integration (15%): Seamless ERP workflow
```

### **Resultado Esperado:**
- Wireframes com foco em eficiência B2B
- User flow otimizado para reordering e bulk operations
- Design system profissional com credibilidade corporativa
- Protótipo com funcionalidades específicas B2B
- Especificações de performance e integração ERP

---

## 🏦 **Exemplo 7: Internet Banking - Fintech**

### **Contexto:**
App bancário digital para competir com bancos tradicionais.

### **Prompt:**
```
@agents/manual/ux-ui-specialist.agent.md

Sprint: 01, Activity: app-banking-digital
Contexto: "App de internet banking para fintech. Competir com Nubank, Inter, C6. Foco: onboarding digital + UX superior + funcionalidades exclusivas para SMEs."

Usuários-alvo:
- Pessoa física (25-45 anos, digital natives, expectativas altas)
- SME owners (30-55 anos, need business banking efficiency)
- Freelancers (25-40 anos, simple banking, low fees)
- Traditional users (45+ anos, migrating from traditional banks)

Benchmarks competitivos:
- Nubank: Simplicidade, roxo, micro-interactions delightful
- Inter: Funcionalidades completas, orange, super-app
- C6: Premium feel, yellow, advanced features
- Banks tradicionais: Complex, slow, mas feature-complete

Funcionalidades core:
1. Onboarding: Abertura conta 100% digital (5 min)
2. Banking básico: Saldo, extrato, transferências, PIX
3. Cartões: Físico/virtual, controle gastos, cashback
4. Investimentos: CDB, fundos, renda variável
5. Empréstimos: Crédito pessoal, antecipação recebíveis
6. Business: Conta PJ, maquininhas, gestão financeira

Diferencial fintech:
- Speed: Abertura conta vs 5 dias banco tradicional
- Fees: Menor custo operacional = menos tarifas
- UX: Mobile-first vs desktop-first traditional
- Innovation: Open banking, PIX, crypto, micro-investing
- Support: Chat 24x7 vs agência física

Regulamentação banking:
- Banco Central: Security requirements específicos
- Open Banking: APIs padronizadas + consent management
- LGPD financeira: Dados sensíveis + audit trail
- Anti-fraud: Biometria + behavioral analytics
- Compliance: Prevenção lavagem dinheiro

Desafios técnicos:
- Security: Banking-grade (99.99% uptime)
- Performance: Latency < 200ms (user expectation)
- Offline: Limited functionality quando sem rede
- Biometrics: Face ID + fingerprint + behavioral
- Real-time: Saldo/extrato updated instantly

Prioridades UX:
- Trust & Security (35%): Banking credibility essencial
- Speed & Performance (30%): Digital-first expectations
- Simplicity (25%): Compete with neobanks UX
- Differentiation (10%): Unique value vs competition
```

### **Resultado Esperado:**
- Wireframes banking com security-first design
- User flow otimizado para onboarding digital
- Design system fintech com credibilidade e modernidade
- Protótipo com biometrics e micro-interactions
- Especificações de compliance bancário e performance

---

## 🎯 **Dicas para Usar UX/UI Specialist Eficientemente:**

### **1. Defina Usuários Específicos:**
- Idade, nível técnico, contexto de uso
- Dispositivos reais que usam
- Limitações físicas ou cognitivas
- Pressões e motivações no uso

### **2. Inclua Restrições Reais:**
- Identidade visual existente
- Compliance (WCAG, LGPD, setorial)
- Tecnologias disponíveis
- Performance requirements específicos

### **3. Priorize com Pesos:**
- Use percentuais para prioridades UX
- Considere trade-offs (speed vs features)
- Adapte para o contexto do negócio
- Inclua diferencial competitivo

### **4. Forneça Contexto Técnico:**
- Referencie arquitetura disponível
- Mencione APIs e integrações
- Inclua limitações de infraestrutura
- Consider existing component libraries

### **5. Pense em Evidências:**
- Como medir sucesso da UX
- Métricas específicas (tempo, erros, satisfação)
- Benchmarks com competidores
- Testes de usabilidade planejados

---

**💡 O UX/UI Specialist cria wireframes profissionais versionáveis e especificações implementáveis pelos desenvolvedores!**