# 🎪 Simulação Mesa Redonda - RN-0002 (ICMS com P1/P2)

## 🎯 **PROMPT PARA GPT-5:**

```
Como facilitador master, você coordenará uma mesa redonda técnica entre especialistas de alto nível do projeto Simples Nacional.

FORÇA DO GPT-5: Facilitação superior, síntese inteligente e coordenação de equipes técnicas.

CONTEXTO DA REUNIÃO:
- Regra: RN-0002 - Cálculo ICMS com P1/P2 quando RBAA >= 3.600.000,01
- Documento fonte: references-data/datas/business-rules-files/RN-0002.docx
- Tecnologias: .NET Framework 4.8, DDD, SOLID, PostgreSQL
- Meta: Definir estratégia completa para implementar lógica P1/P2 no CalculationEngine
- Participantes: Requirements Analyst (Gemini), Architect (GPT-5), Developer (Claude), Tester (Claude)
 - Observacao: Use `sinacCode` (3 digitos, ex.: 001, 010, 034) como identificador canonico; Anexo/Secao/Tabela apenas metadados

[... seguir especialização GPT-5 do prompt ...]

Inicie a reunião apresentando o tema e dando a palavra ao Requirements Analyst para a primeira apresentação.
```

---

## 🎭 **SIMULAÇÃO DA RESPOSTA ESPERADA DO GPT-5:**

---

### 🎯 **ABERTURA ESTRATÉGICA**

**Facilitador (GPT-5):** Bem-vindos à mesa redonda técnica para implementação da RN-0002. Esta regra é fundamental para o cálculo de ICMS no Simples Nacional quando empresas ultrapassam o sublimite de R$ 3.600.000,01 em RBAA.

**Objetivo:** Definir estratégia técnica completa para implementar a lógica de segregação P1/P2 no CalculationEngine, mantendo aderência aos padrões DDD/SOLID existentes.

**Agenda:** Cada especialista terá 5 minutos para apresentar sua perspectiva, seguido de discussão livre para convergência técnica.

---

### 📊 **REQUIREMENTS ANALYST (Especialidade: Gemini 2.5)**

**Requirements Analyst:** Analisei profundamente o documento RN-0002.docx e identifiquei complexidades significativas:

**Fórmulas Críticas Extraídas:**
- P1 = min(RPA, Sublimite - RBA_anterior)  
- P2 = max(0, RBA - Sublimite)
- ICMS_P1 = P1 × Alíquota_Normal
- ICMS_P2 = P2 × Alíquota_Específica_Anexo

**Casos Extremos Identificados:**
1. **Início de atividade:** Sublimite proporcional (mês 1 = R$ 300k, mês 6 = R$ 1.8M)
2. **Mudança de anexo:** Recálculo retroativo de P1/P2
3. **RBAA exato = R$ 3.600.000,01:** Threshold crítico
4. **RPA = 0:** P1 pode ser negativo, precisa validação

**Correlações com RN Existentes:**
- RN-0001: Base para cálculo de alíquota efetiva
- RN-0026/0027: Impedimentos que podem afetar P1/P2
- Anexos I-V: Alíquotas específicas para P2

**Ambiguidades Detectadas:**
- Tratamento de receitas de exportação em P1/P2  
- Proporcionalidade do sublimite em mudança de anexo mid-year

**Questionamentos para a equipe:**
1. Como tratar P1 negativo matematicamente?
2. Onde armazenar histórico de P1/P2 para auditoria?
3. Performance: calcular P1/P2 em tempo real ou pré-calcular?

---

### 🏗️ **SYSTEMS ARCHITECT (Especialidade: GPT-5)**

**Systems Architect:** Baseando-me na análise do Requirements Analyst, proponho a seguinte arquitetura estratégica:

**Impactos Arquiteturais Identificados:**

1. **Domain Layer - Novos Componentes:**
```csharp
// Value Objects
P1P2Split(Money P1, Money P2, Money Threshold)
RevenueSegmentation(Money Internal, Money External, AnnexType Annex)

// Entities  
TaxCalculationWithP1P2 : TaxCalculation
CompanyThresholdHistory : Entity

// Domain Services
IP1P2CalculationService
IThresholdProportionalityService
```

2. **Bounded Context Strategy:**
- Manter dentro do TaxCalculation context existente
- Criar sub-aggregate P1P2Calculation
- Event sourcing para rastreabilidade de mudanças

**Trade-offs Arquiteturais:**
- **Performance vs Auditoria:** Armazenar P1/P2 calculado vs recalcular sempre
- **Complexidade vs Flexibilidade:** Service específico vs extensão do existente  
- **Consistência vs Performance:** Transação única vs eventual consistency

**ADR Necessários:**
- ADR-003: Estratégia de armazenamento P1/P2
- ADR-004: Handling de thresholds proporcionais
- ADR-005: Event sourcing para mudanças retroativas

**Roadmap de Implementação:**
1. **Fase 1:** Value Objects e Domain Services (1 sprint)
2. **Fase 2:** Integration com TaxCalculation existente (1 sprint)  
3. **Fase 3:** API endpoints e validações (0.5 sprint)
4. **Fase 4:** Testes e otimização (0.5 sprint)

**Questionamentos:**
1. Aceitar eventual consistency para performance?
2. Criar bounded context separado ou estender existente?
3. Como garantir atomicidade entre P1/P2 e cálculo principal?

---

### 💻 **EXPERT DEVELOPER (Especialidade: Claude 4)**

**Expert Developer:** Analisando a proposta arquitetural, vejo viabilidade técnica alta com alguns desafios:

**Complexidade de Implementação (Escala 1-10): 7**

**Implementação Prioritária:**
```csharp
// Domain - Alta complexidade matemática
public class P1P2CalculationService : IP1P2CalculationService  
{
    public P1P2Split Calculate(RevenueData revenue, ThresholdContext threshold)
    {
        // Lógica crítica: P1 nunca negativo
        var p1 = Math.Max(0, Math.Min(revenue.RPA, threshold.Available));
        var p2 = Math.Max(0, revenue.RBA - threshold.Sublimit);
        return new P1P2Split(p1, p2, threshold.Sublimit);
    }
}

// Application - Orquestração complexa  
public class CalculateICMSWithP1P2CommandHandler
{
    // Coordenar: Threshold → P1P2 → Alíquota → Resultado
}
```

**Riscos Técnicos Identificados:**
1. **Precisão decimal:** Cálculos financeiros requerem decimal(18,2)
2. **Thread safety:** Múltiplos cálculos simultâneos da mesma empresa
3. **Validação complexa:** 15+ regras de validação interdependentes  
4. **Performance:** Consulta histórica RBAA pode ser lenta

**Dependências Críticas:**
- HistoricalRevenueService (pode não existir)
- CompanyAnnexHistoryService (precisa criar)
- ThresholdCalculationService (novo)

**Estimativas:**
- **Domain Services:** 2-3 dias (alta complexidade matemática)
- **Application Layer:** 1-2 dias (orquestração)  
- **Validações:** 2 dias (muitas regras interdependentes)
- **Infrastructure:** 1 dia (repositories simples)

**Questionamentos:**
1. Performance: cache de RBAA ou consulta sempre?
2. Existe serviço de histórico de receitas implementado?
3. Como tratar concorrência em cálculos da mesma empresa?

---

### 🧪 **TESTING SPECIALIST (Especialidade: Claude 4)**

**Testing Specialist:** A estratégia de testes para RN-0002 será crítica devido à complexidade matemática:

**Cenários Críticos Identificados (25+ cenários):**

1. **Happy Path (5 cenários):**
   - RBAA = R$ 4M, RPA = R$ 100k → P1/P2 calculado corretamente
   - Diferentes anexos (I-V) com P2 específico

2. **Edge Cases Matemáticos (8 cenários):**
   - RBAA exatamente R$ 3.600.000,01
   - P1 calculado negativo (deve ser 0)
   - RPA > Sublimite disponível
   - Início atividade: sublimite proporcional

3. **Cenários Temporais (7 cenários):**
   - Janeiro: RBAA vs RBA diferentes
   - Mudança anexo mid-year: recálculo P1/P2
   - Empresa criada em junho: proporcionalidade

4. **Integração com RN Existentes (5 cenários):**
   - RN-0026: Impedimento + P1/P2
   - RN-0001: Alíquota efetiva + P1/P2  
   - Fator R < 0.28 + P2 específico

**Estratégia de Dados de Teste:**
```csharp
// Builders com Bogus
P1P2ScenarioBuilder()
    .WithRBAA(4_000_000m)
    .WithRPA(150_000m)  
    .WithAnnex(AnnexType.I)
    .WithStartMonth(1)
    .Build();

// Fixtures para casos extremos
ThresholdEdgeCasesFixture.RBAA_Exactly_Threshold()
ProportionalThresholdFixture.StartInJune()  
```

**Métricas de Cobertura Esperadas:**
- **Domain Services:** 95%+ (lógica crítica)
- **Application Handlers:** 90%+ (orquestração)
- **Validações:** 100% (compliance obrigatório)
- **Edge Cases:** 100% dos 25+ cenários

**Complexidade de Testes (Escala 1-10): 8**

**Questionamentos:**
1. Dados de teste: usar valores reais de empresas (anonimizados)?
2. Performance tests: qual volume simular (1k, 10k empresas)?
3. Como testar cenários retroativos de mudança de anexo?

---

### 💬 **SÍNTESE INTELIGENTE - DISCUSSÃO LIVRE**

**Facilitador (GPT-5):** Excelentes apresentações! Identifiquei convergências e alguns pontos críticos para resolver:

**CONVERGÊNCIAS IDENTIFICADAS:**
✅ Arquitetura dentro do bounded context existente  
✅ P1 nunca negativo (Math.Max necessário)
✅ Necessidade de ADRs para decisões complexas
✅ Cobertura de testes alta (90%+) obrigatória

**DIVERGÊNCIAS A RESOLVER:**

**1. Performance vs Auditoria**
- **Architect:** Prefere eventual consistency
- **Developer:** Preocupado com thread safety
- **Tester:** Quer dados determinísticos

**Proposta de Convergência:** Usar cache com TTL de 1h para RBAA, mantendo auditoria completa

**2. Histórico de Receitas**
- **Requirements:** Precisa para casos retroativos  
- **Developer:** Service pode não existir
- **Architect:** Pode ser complexo demais

**Proposta de Convergência:** Implementar HistoricalRevenueService mínimo apenas para RBAA

**3. Estratégia de Validação**
- **Requirements:** 15+ regras identificadas
- **Developer:** Estimou 2 dias só para validações
- **Tester:** Quer 100% cobertura

**Proposta de Convergência:** FluentValidation com rules modulares reutilizáveis

---

### 🎯 **CONVERGÊNCIA ESTRATÉGICA - DECISÕES FINAIS**

**DECISÕES TÉCNICAS CONSENSUAIS:**

1. **Arquitetura Aprovada:**
   - Bounded context: Extend TaxCalculation  
   - Value Objects: P1P2Split, RevenueSegmentation
   - Domain Service: P1P2CalculationService
   - Cache Strategy: RBAA cached 1h, P1/P2 sempre calculado

2. **Implementação Faseada Aprovada:**
   - **Sprint 1:** Domain + Application (Developer foco)
   - **Sprint 2:** Validações + Infrastructure  
   - **Sprint 3:** API + Tests (Tester intensivo)
   - **Sprint 4:** Performance + Optimizations

3. **ADRs Necessários:**
   - ADR-003: Cache strategy para RBAA
   - ADR-004: P1P2 calculation approach  
   - ADR-005: Historical data minimal implementation

4. **Critérios de Aceite:**
   - ✅ 25+ cenários de teste documentados e passando
   - ✅ Performance: < 500ms para cálculo P1/P2
   - ✅ Cobertura: 90%+ em Domain, 95%+ em validações
   - ✅ Zero warnings de compilação
   - ✅ Documentação XML completa

**PRÓXIMOS PASSOS IMEDIATOS:**

1. **Requirements Analyst (Gemini):** Criar RN-0002.md detalhado com todos os casos identificados
2. **Systems Architect (GPT-5):** Elaborar ADRs 003-005 e especificação técnica  
3. **Expert Developer (Claude 4):** Implementar Domain Services e Value Objects
4. **Testing Specialist (Claude 4):** Preparar 25+ cenários e builders Bogus

**RISCOS MITIGADOS:**
- ✅ Performance: Cache strategy definida
- ✅ Complexidade: Implementação faseada  
- ✅ Qualidade: Critérios aceite claros
- ✅ Manutenibilidade: ADRs documentados

---

### 📋 **ATA ESTRATÉGICA**

**Data:** 23/09/2025  
**Participantes:** Requirements Analyst, Systems Architect, Expert Developer, Testing Specialist  
**Facilitador:** GPT-5 Mesa Redonda Agent

**Implementação RN-0002 - APROVADA com roadmap de 4 sprints**

**Action Items:**
- [ ] **Requirements Analyst:** RN-0002.md completo (2 dias)
- [ ] **Systems Architect:** ADRs 003-005 + specs técnicas (3 dias)  
- [ ] **Expert Developer:** Domain implementation start (5 dias)
- [ ] **Testing Specialist:** Test scenarios preparation (3 dias)

**Próxima reunião:** Checkpoint em 1 semana para validar progresso da Fase 1.

---

## 🎯 **RESULTADO DA SIMULAÇÃO:**

Esta mesa redonda **GPT-5 facilitada** produziu:
- ✅ **Estratégia técnica clara e consensual**
- ✅ **Roadmap de 4 sprints bem definido**  
- ✅ **Riscos identificados e mitigados**
- ✅ **Action items específicos por especialista**
- ✅ **Critérios de aceite mensuráveis**

**Próximo passo:** Executar os action items usando os prompts otimizados específicos de cada modelo! 🚀