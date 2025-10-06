# 🎨 PROMPT PRONTO - Expert Developer RN-0002 (Claude 4)

PARÂMETROS DE EXECUÇÃO (preencha antes de rodar):
- Sprint: <sprint>
- Activity (opcional): <activity>
- Convenção de saída: data/out/sprint<sprint>[/<activity>]/

SALVE AS SAÍDAS EM:
- data/out/sprint<sprint>[/<activity>]/04-desenvolvimento.md
- data/out/sprint<sprint>[/<activity>]/engineering/src/
- data/out/sprint<sprint>[/<activity>]/engineering/tests/

## 🎯 **COPIE E COLE DIRETAMENTE NO CLAUDE 4:**

```
Como desenvolvedor sênior especialista, você é o Expert Developer Agent com foco em código de excelência.

FORÇA DO CLAUDE 4: Geração de código limpo, estruturado e altamente testável.

CONTEXTO:
- Especificação arquitetural: [RESULTADO DO GPT-5 - design P1/P2 completo]
- Regra de negócio: RN-0002 - Cálculo ICMS com P1/P2 quando RBAA >= 3.600.000,01
- Camadas alvo: Domain/Application/Infrastructure/Api (implementação completa)
- Padrões: .NET Framework 4.8, DDD, SOLID, FluentValidation, PostgreSQL

ESPECIALIZAÇÃO CLAUDE 4 PARA RN-0002:
1. CÓDIGO DE EXCELÊNCIA SUPREMA P1/P2:
   - Implemente Value Objects P1P2Split, ThresholdContext com invariantes matemáticas
   - Aplique Domain Services com lógica P1/P2 precisa: P1 = Math.Max(0, Math.Min(RPA, Sublimite - RBA_anterior))
   - Crie Entity TaxCalculationWithP1P2 com responsabilidades P1/P2 claras
   - Garanta SOLID total: cada classe P1/P2 com propósito único e bem definido
   - Otimize performance: cálculos decimais precisos, sem boxing/unboxing

2. IMPLEMENTAÇÃO TÉCNICA SUPERIOR RN-0002:
   - Documentação XML completa em TODOS os membros P1/P2:
     ```csharp
     /// <summary>
     /// Calcula segregacao P1/P2 conforme RN-0002 para ICMS Simples Nacional
     /// </summary>
     /// <param name="rpa">Receita periodo apuracao</param>
     /// <param name="rbaa">Receita bruta ano anterior</param>
     /// <param name="threshold">Sublimite R$ 3.600.000,00 ou proporcional</param>
     ```
   - Tratamento de erros robusto específico P1/P2:
     * ValidationException para P1 negativo
     * BusinessRuleException para RBAA inconsistente
     * ArgumentException para threshold inválido
   - Logging estruturado Serilog para auditoria P1/P2:
     ```csharp
     _logger.LogInformation("Calculando P1/P2 - RBAA: {RBAA}, RPA: {RPA}, P1: {P1}, P2: {P2}",
                           rbaa, rpa, result.P1, result.P2);
     ```
   - FluentValidation comprehensive para todas regras P1/P2

3. PADRÕES AVANÇADOS .NET PARA P1/P2:
   - Decimal precision para cálculos financeiros P1/P2:
     ```csharp
     public record P1P2Split(
         [property: Column(TypeName = "decimal(18,2)")] decimal P1,
         [property: Column(TypeName = "decimal(18,2)")] decimal P2,
         [property: Column(TypeName = "decimal(18,2)")] decimal Threshold);
     ```
   - Async/await otimizado para consultas RBAA históricas
   - Result pattern para operações P1/P2 que podem falhar
   - Memory management eficiente para cálculos bulk P1/P2

4. TESTABILIDADE MÁXIMA P1/P2:
   - Interfaces granulares para mock específico:
     ```csharp
     public interface IP1Calculator
     public interface IP2Calculator
     public interface IThresholdCalculator
     public interface IHistoricalRBAAProvider
     ```
   - Factory pattern para criação controlada de objetos P1/P2
   - Builder pattern para cenários de teste complexos P1/P2

IMPLEMENTAÇÃO ESPECÍFICA RN-0002:

DOMAIN LAYER - Código Pronto:
```csharp
// Value Objects com invariantes
public record P1P2Split
{
    public decimal P1 { get; }
    public decimal P2 { get; }
    public decimal Threshold { get; }

    public P1P2Split(decimal p1, decimal p2, decimal threshold)
    {
        if (threshold <= 0) throw new ArgumentException("Threshold deve ser positivo");
        if (p1 < 0) throw new ArgumentException("P1 nao pode ser negativo");
        if (p2 < 0) throw new ArgumentException("P2 nao pode ser negativo");

        P1 = p1;
        P2 = p2;
        Threshold = threshold;
    }
}

// Domain Service principal
public class P1P2CalculationService : IP1P2CalculationService
{
    private readonly IHistoricalRBAAProvider _rbaaProvider;
    private readonly IThresholdCalculator _thresholdCalculator;

    public P1P2Split Calculate(CompanyId companyId, Period period, Money rpa)
    {
        var rbaa = await _rbaaProvider.GetRBAAAsync(companyId, period.PreviousYear);
        var threshold = _thresholdCalculator.Calculate(period, rbaa);

        // RN-0002: P1 = min(RPA, disponível no threshold)
        var availableThreshold = Math.Max(0, threshold.Value - rbaa.Value);
        var p1 = Math.Max(0, Math.Min(rpa.Value, availableThreshold));
        var p2 = Math.Max(0, rbaa.Value + rpa.Value - threshold.Value);

        return new P1P2Split(p1, p2, threshold.Value);
    }
}
```

APPLICATION LAYER - Handlers:
```csharp
public class CalculateICMSWithP1P2Handler : IRequestHandler<CalculateICMSWithP1P2Command, Result<P1P2TaxResult>>
{
    public async Task<Result<P1P2TaxResult>> Handle(CalculateICMSWithP1P2Command command, CancellationToken cancellationToken)
    {
        try
        {
            var p1p2Split = await _p1p2Service.Calculate(command.CompanyId, command.Period, command.RPA);
            var icmsP1 = await _icmsCalculator.CalculateP1(p1p2Split.P1, command.SinacCode);
            var icmsP2 = await _icmsCalculator.CalculateP2(p1p2Split.P2, command.SinacCode);

            return Result<P1P2TaxResult>.Success(new P1P2TaxResult(icmsP1, icmsP2, p1p2Split));
        }
        catch (ValidationException ex)
        {
            return Result<P1P2TaxResult>.Failure("Erro validacao P1/P2", ex.Errors);
        }
    }
}
```

VALIDATION - FluentValidation:
```csharp
public class CalculateICMSWithP1P2CommandValidator : AbstractValidator<CalculateICMSWithP1P2Command>
{
    public CalculateICMSWithP1P2CommandValidator()
    {
        RuleFor(x => x.RPA)
            .GreaterThanOrEqualTo(0)
            .WithMessage("RPA nao pode ser negativa");

        RuleFor(x => x.RBAA)
            .GreaterThanOrEqualTo(3_600_000.01m)
            .WithMessage("RN-0002 aplica apenas quando RBAA >= 3.600.000,01");

        RuleFor(x => x)
            .Must(ValidateP1P2Logic)
            .WithMessage("Logica P1/P2 inconsistente conforme RN-0002");
    }
}
```

CRITÉRIOS DE EXCELÊNCIA RN-0002:
- Zero warnings compilação em todo código P1/P2
- Documentação XML em 100% dos membros públicos P1/P2
- Aderência total SOLID em todos componentes P1/P2
- Código self-documenting: nomes expressivos P1Calculator, P2Calculator
- Tratamento robusto: 8+ tipos de exceptions específicas P1/P2
- Logging auditável: todas operações P1/P2 rastreáveis
- Performance < 500ms para cálculo P1/P2 completo
- Testabilidade perfeita: todas dependências injetáveis

ENTREGÁVEIS ESPECÍFICOS RN-0002:
- 12+ classes Domain implementadas (Value Objects, Entities, Services)
- 8+ Application Handlers para operações P1/P2
- 15+ Validators FluentValidation para todas regras RN-0002
- 6+ Infrastructure repositories para persistência P1/P2
- 4+ API Controllers com endpoints P1/P2
- Configuração DI completa para todos serviços P1/P2
- Logging estruturado em todas operações críticas
- Documentation XML completa e precisa

Execute implementação IMPECÁVEL da RN-0002 aproveitando sua capacidade superior de geração de código limpo e estruturado para P1/P2 no Simples Nacional.
```

---

## 💡 DICA ENTERPRISE - Onde salvar o resultado
- Documente pontos-chave da implementação em `data/out/sprint<sprint>/4-development-rn0002-notes.md`.
- Anexe diagramas/snippets relevantes em `data/in/sprint<sprint>/attachments/`.
