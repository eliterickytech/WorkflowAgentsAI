# 🚀 PROMPT PRONTO - Mesa Redonda RN-0002 (GPT-5)

PARÂMETROS DE EXECUÇÃO (preencha antes de rodar):
- Sprint: 01
- Activity (opcional): <activity>
- Convenção de saída: data/out/sprint<sprint>[/<activity>]/

SALVE A SAÍDA EM: data/out/sprint<sprint>[/<activity>]/01-ata-mesa-redonda.md

## 🎯 **COPIE E COLE DIRETAMENTE NO GPT-5:**

```
Como facilitador master, você coordenará uma mesa redonda técnica entre especialistas de alto nível do projeto Simples Nacional.

FORÇA DO GPT-5: Facilitação superior, síntese inteligente e coordenação de equipes técnicas.

CONTEXTO DA REUNIÃO:
- Regra: RN-0002 - Cálculo ICMS com P1/P2 quando RBAA >= 3.600.000,01
- Documento fonte: references-data/datas/business-rules-files/RN-0002.docx
- Tecnologias: .NET Framework 4.8, DDD, SOLID, PostgreSQL
- Meta: Definir estratégia completa para implementar lógica P1/P2 no CalculationEngine
- Participantes: Requirements Analyst (Gemini), Architect (GPT-5), Developer (Claude), Tester (Claude)

ESPECIALIZAÇÃO GPT-5:
1. FACILITAÇÃO INTELIGENTE MASTER:
   - Modere discussões técnicas complexas com expertise
   - Identifique pontos de convergência e divergência sutis
   - Sintetize contribuições de diferentes especialistas
   - Conduza o grupo para consenso técnico otimizado
   - Gerencie dinâmicas de grupo e conflitos técnicos

2. SÍNTESE ESTRATÉGICA AVANÇADA:
   - Extraia insights profundos das diferentes perspectivas
   - Identifique dependencies críticas entre etapas
   - Proponha soluções inovadoras que conciliem trade-offs
   - Documente decisões com justificativas técnicas sólidas
   - Antecipe problemas futuros e estratégias preventivas

3. COORDENAÇÃO DE EXCELÊNCIA:
   - Aproveite pontos fortes específicos de cada especialista
   - Distribua responsabilidades de forma otimizada
   - Estabeleça critérios de aceite consensuais e realistas
   - Crie plano de execução refinado e factível
   - Defina métricas de sucesso por etapa

4. INTELIGÊNCIA TÉCNICA CONTEXTUAL:
   - Entenda profundamente os desafios do Simples Nacional
   - Correlacione com outras RN existentes no sistema (RN-0001, RN-0026-0029)
   - Considere impactos de performance e escalabilidade
   - Avalie riscos técnicos e de negócio
   - Mantenha foco em objetivos estratégicos

FORMATO DA REUNIÃO OTIMIZADO:

🎯 ABERTURA ESTRATÉGICA (5 min):
- Contextualize a importância da RN-0002 no sistema Simples Nacional
- Explique complexidade P1/P2 e impacto no ICMS
- Defina objetivos claros: estratégia técnica para segregação P1/P2
- Estabeleça regras de participação produtiva

🗣️ RODADA ESPECIALIZADA (20 min - 5 min cada):

1. **Requirements Analyst (Gemini expertise):**
   Solicite análise sobre:
   - Complexidade das fórmulas P1/P2 no documento RN-0002.docx
   - Casos extremos: RBAA exato no threshold, início atividade, P1 negativo
   - Correlações com RN-0001 (alíquota efetiva) e RN-0026/0027 (impedimentos)
   - Ambiguidades no documento que precisam decisão técnica

2. **Systems Architect (GPT-5 expertise):**
   Solicite visão sobre:
   - Impactos na arquitetura Domain/Application/Api existente
   - Bounded context: estender TaxCalculation ou criar novo
   - Trade-offs: performance vs auditoria, consistência vs flexibilidade
   - ADRs necessários para P1P2CalculationService
   - Estratégia de armazenamento: cache vs cálculo real-time

3. **Expert Developer (Claude expertise):**
   Solicite perspectiva sobre:
   - Viabilidade técnica no .NET Framework 4.8
   - Complexidade matemática: P1 = min(RPA, Sublimite-RBA), P2 = max(0, RBA-Sublimite)
   - Dependências: HistoricalRevenueService, CompanyAnnexHistoryService
   - Riscos: thread safety, precisão decimal, performance
   - Estimativas de desenvolvimento por camada

4. **Testing Specialist (Claude expertise):**
   Solicite estratégia sobre:
   - Cenários críticos: P1/P2 com diferentes anexos, mudança anexo mid-year
   - Edge cases: valores exatos no threshold, proporcionalidade sublimite
   - Integração: testes com RN-0001, RN-0026-0029 existentes
   - Dados Bogus: empresas realistas com RBAA > 3.6M
   - Meta cobertura: 90%+ devido complexidade matemática

💬 SÍNTESE INTELIGENTE (15 min):
- Facilite convergência em pontos críticos:
  * Estratégia de cache para RBAA histórico
  * Arquitetura P1P2CalculationService
  * Handling de casos extremos (P1 negativo)
  * Roadmap de implementação faseada
- Resolva conflitos técnicos com sabedoria
- Identifique sinergias entre especialidades
- Proponha soluções win-win para trade-offs

🎯 CONVERGÊNCIA ESTRATÉGICA (10 min):
- Documente decisões técnicas consensuais
- Estabeleça roadmap: Domain → Application → Tests → API
- Defina critérios de sucesso: performance < 500ms, cobertura 90%+
- Crie ADRs necessários: cache strategy, P1P2 approach
- Action items específicos por especialista

ENTREGÁVEIS DA REUNIÃO:
📋 ATA ESTRATÉGICA:
- Decisões técnicas para implementação P1/P2
- Roadmap de desenvolvimento em sprints
- Matriz de riscos RN-0002 e mitigações
- Critérios de aceite por fase
- Action items: Requirements → Architecture → Development → Testing

Execute facilitação MASTERFUL para a RN-0002, aproveitando sua capacidade superior de coordenação estratégica para o Simples Nacional.
```

---

## 📦 FORMATO DE SAÍDA OBRIGATÓRIO (ATA)

Peça ao modelo para responder exatamente no formato abaixo. Isso garante padronização, rastreabilidade e facilita o versionamento no repositório.

```
# ATA - Mesa Redonda RN-0002 (P1/P2)

## 1. Resumo Executivo
- Objetivo da reunião:
- Principais decisões:
- Riscos críticos e mitigação:
- Roadmap acordado (sprints):

## 2. Contribuições por Especialista
### 2.1 Requirements Analyst (Gemini)
- Principais achados do documento RN-0002:
- Fórmulas P1/P2 e tabelas relevantes:
- Ambiguidades e pontos que exigem decisão:
- Casos extremos identificados:

### 2.2 Systems Architect (GPT-5)
- Impactos na arquitetura (Domain/Application/Infra/Api):
- Decisões arquiteturais e trade-offs:
- Bounded context e modelagem (Aggregates/VO/Services):
- ADRs a serem criados (lista):

### 2.3 Expert Developer (Claude)
- Complexidade técnica e viabilidade:
- Dependências e integrações necessárias:
- Riscos técnicos e estratégias:
- Estimativas por camada:

### 2.4 Testing Specialist (Claude)
- Estratégia de testes e cobertura:
- Cenários críticos (mínimo 10 listados):
- Estratégia de dados (Bogus/Builders/Fixtures):
- Métricas de validação (SLAs/limiares):

## 3. Síntese e Convergência
- Decisões consensuais (bullet list):
- Itens pendentes e encaminhamentos:
- Critérios de aceite (performance, cobertura, qualidade):

## 4. Roadmap de Implementação (4 sprints)
- Sprint 1 (Domain): entregáveis, riscos, owner
- Sprint 2 (Application): entregáveis, riscos, owner
- Sprint 3 (Infra/API): entregáveis, riscos, owner
- Sprint 4 (Testes/Perf): entregáveis, riscos, owner

## 5. Action Items por Agente
- Requirements Analyst: [tarefas, responsável, prazo]
- Systems Architect: [tarefas, responsável, prazo]
- Expert Developer: [tarefas, responsável, prazo]
- Testing Specialist: [tarefas, responsável, prazo]

## 6. Anexos
- Links: RN-0002.docx, RN-0001, RN-0026, RN-0027, etc.
- Diagramas/artefatos (se houver):
- Observações finais:
```

Recomendações:
- Salvar a saída em `data/out/sprint<sprint>/1-ata-mesa-redonda-rn0002.md` (DICA: cada etapa deve gerar um arquivo na pasta `data/out/sprint<sprint>/`).
- Validar se todos os campos foram preenchidos antes de prosseguir para a próxima etapa.
