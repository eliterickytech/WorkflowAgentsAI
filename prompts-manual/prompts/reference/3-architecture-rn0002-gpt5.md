# 🚀 PROMPT PRONTO - Systems Architect RN-0002 (GPT-5)

PARÂMETROS DE EXECUÇÃO (preencha antes de rodar):
- Sprint: <sprint>
- Activity (opcional): <activity>
- Convenção de saída: out/sprint<sprint>[/<activity>]/

SALVE AS SAÍDAS EM:
- out/sprint<sprint>[/<activity>]/03-arquitetura.md
- out/sprint<sprint>[/<activity>]/adrs/ (ADRs no template Nygard)
- out/sprint<sprint>[/<activity>]/diagrams/ (diagramas Mermaid)

## 🎯 **COPIE E COLE DIRETAMENTE NO GPT-5:**

```
Como arquiteto de sistemas sênior, você é o Systems Architect Agent com visão estratégica completa.

FORÇA DO GPT-5: Raciocínio arquitetural avançado e planejamento estratégico de sistemas.

CONTEXTO:
- Análise de requisitos: [RESULTADO DO GEMINI 2.5 - arquivo RN-0002.md criado]
- Regra alvo: RN-0002 - Cálculo ICMS com P1/P2 quando RBAA >= 3.600.000,01  
- Componentes impactados: Domain/Application/Infrastructure/Api
- Tipo de mudança: extensão significativa de cálculo tributário existente
- Restrições: .NET Framework 4.8, PostgreSQL, DDD, arquitetura existente CalculationEngine
 - Observacao importante: Padronizar `sinacCode` (3 digitos) como chave canonica em contratos e serviços; manter Anexo/Secao/Tabela como metadados

ESPECIALIZAÇÃO GPT-5 PARA RN-0002:
1. RACIOCÍNIO ARQUITETURAL ESTRATÉGICO P1/P2:
   - Projete bounded contexts considerando segregação P1/P2
   - Analise trade-offs: cache RBAA vs consulta always, atomic vs eventual consistency
   - Antecipe extensibilidade: futuras RN podem usar P1/P2 pattern
   - Considere performance: 10k+ empresas calculando P1/P2 simultaneamente  
   - Avalie impacto: TaxCalculation existente vs novo P1P2Calculation context
   - Planeje integração: como P1/P2 interage com RN-0001 (alíquota efetiva)

2. PLANEJAMENTO SISTÊMICO AVANÇADO RN-0002:
   - Defina roadmap implementação: Domain → Application → Infrastructure → API
   - Identifique riscos arquiteturais específicos:
     * Thread safety em cálculos P1/P2 simultâneos
     * Precisão decimal em operações financeiras P1/P2  
     * Performance consulta RBAA histórico
     * Consistência entre P1/P2 e cálculo principal alíquota
   - Projete abstrações reutilizáveis:
     * IThresholdCalculationService (para futuras RN com thresholds)
     * IP1P2SegmentationService (pattern para outras segregações)
   - Estabeleça métricas: performance < 500ms, availability 99.9%

3. DESIGN PATTERNS EXPERT PARA P1/P2:
   - Aplique DDD com precisão para domínio fiscal:
     * Value Objects: P1P2Split, ThresholdContext, RevenueSegmentation
     * Entities: TaxCalculationWithP1P2, CompanyThresholdHistory  
     * Domain Services: P1P2CalculationService, ThresholdValidationService
     * Aggregates: TaxCalculation extended vs novo P1P2TaxCalculation
   - Implemente SOLID específico para RN-0002:
     * SRP: separar cálculo P1/P2 de aplicação alíquotas
     * OCP: extensível para futuras mudanças threshold/fórmulas
     * LSP: P1P2TaxCalculation deve ser substituível
     * ISP: interfaces específicas IP1Calculator, IP2Calculator
     * DIP: depender de abstrações IHistoricalRevenueService

4. SÍNTESE E DECISÃO TÉCNICA RN-0002:
   - Documente decisões críticas P1/P2:
     * ADR-003: Cache Strategy para RBAA (Redis vs In-Memory vs DB)
     * ADR-004: P1P2 Calculation Approach (real-time vs pre-calculated)
     * ADR-005: Threshold Proportionality Handling (service vs calculator)
     * ADR-006: Integration Strategy com TaxCalculation existente
   - Justifique escolhas com base princípios sólidos:
     * Performance vs Consistency para cálculos P1/P2
     * Auditability vs Simplicity para histórico RBAA
     * Extensibility vs Complexity para future RN integration
   - Estabeleça guidelines implementação P1/P2

ARQUITETURA ESPECÍFICA RN-0002:

DOMAIN LAYER - Novos Componentes:
```csharp
// Value Objects
public record P1P2Split(Money P1, Money P2, Money Threshold);
public record RevenueSegmentation(Money Internal, Money External, AnnexType Annex);
public record ThresholdContext(Money Sublimit, int StartMonth, bool IsProportional);

// Entities (extend existing or new?)
public class TaxCalculationWithP1P2 : TaxCalculation
public class CompanyThresholdHistory : Entity<CompanyThresholdHistoryId>

// Domain Services  
public interface IP1P2CalculationService
public interface IThresholdProportionalityService
public interface IHistoricalRevenueService // may need create
```

APPLICATION LAYER:
```csharp
// Commands  
public class CalculateICMSWithP1P2Command : IRequest<Result<P1P2TaxResult>>
public class ValidateP1P2ThresholdCommand : IRequest<Result<ThresholdValidation>>

// Handlers
public class CalculateICMSWithP1P2Handler : IRequestHandler<>
public class P1P2ValidationHandler : IRequestHandler<>

// Application Services
public interface IP1P2TaxCalculationService
```

INFRASTRUCTURE LAYER:
```csharp
// Repositories
public interface ICompanyThresholdHistoryRepository  
public class P1P2CalculationRepository : IP1P2CalculationRepository

// External Services
public class HistoricalRevenueService : IHistoricalRevenueService
public class CachedRBAAService : IHistoricalRevenueService // decorator pattern
```

API LAYER:
```csharp
// Controllers
public class P1P2TaxCalculationController : ApiControllerBase
// Endpoints: POST /tax-calculation/p1p2, GET /threshold/history
```

ENTREGÁVEIS PREMIUM RN-0002:
- Estrutura de pastas Domain/Application/Infrastructure/Api otimizada
- Definições precisas de 8+ Value Objects e Entities para P1/P2
- Interfaces e contratos 10+ bem definidos para segregação
- Configuração de DI estruturada para todos serviços P1/P2
- Plano de testes por camada com cenários P1/P2 específicos
- ADRs 003-006 para decisões complexas P1/P2
- Roadmap implementação 4 sprints detalhado

ROADMAP ESPECÍFICO RN-0002:
**Sprint 1 (5 dias):** Domain Layer - Value Objects, Entities, Domain Services P1/P2
**Sprint 2 (5 dias):** Application Layer - Commands, Handlers, Validation P1/P2  
**Sprint 3 (3 dias):** Infrastructure - Repositories, Cache, External Services
**Sprint 4 (2 dias):** API Layer - Controllers, Integration, Performance tuning

Execute design ESTRATÉGICO específico para RN-0002 aproveitando sua capacidade superior de raciocínio arquitetural para implementação P1/P2 no Simples Nacional.
```

---

## 💡 DICA ENTERPRISE - Onde salvar o resultado
- Salve as decisões e especificações em `out/sprint<sprint>/3-architecture-rn0002.md`.
- Se criar ADRs, vincule-os neste arquivo e opcionalmente salve anexos em `in/sprint<sprint>/attachments/` (ADRs ficam em `out/sprint<sprint>[/<activity>]/adrs/`).