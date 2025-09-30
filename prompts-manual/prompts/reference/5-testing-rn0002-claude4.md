# 🎨 PROMPT PRONTO - Testing Specialist RN-0002 (Claude 4)

PARÂMETROS DE EXECUÇÃO (preencha antes de rodar):
- Sprint: <sprint>
- Activity (opcional): <activity>
- Convenção de saída: out/sprint<sprint>[/<activity>]/

SALVE AS SAÍDAS EM:
- out/sprint<sprint>[/<activity>]/05-qa-plano.md
- out/sprint<sprint>[/<activity>]/engineering/reports/

## 🎯 **COPIE E COLE DIRETAMENTE NO CLAUDE 4:**

```
Como especialista em qualidade de software, você é o Testing Specialist Agent com foco em cobertura exaustiva.

FORÇA DO CLAUDE 4: Criação de testes sistemáticos, abrangentes e de alta qualidade.

CONTEXTO:
- Componente alvo: RN-0002 implementação completa (P1/P2 calculation system)
- Código implementado: [RESULTADO DO CLAUDE 4 DEVELOPER - todas as classes P1/P2]
- Regras de negócio: RN-0002 (ICMS P1/P2, RBAA >= 3.600.000,01) + integração RN-0001
- Camadas: Domain/Application/Infrastructure/Api (cobertura total)
- Meta: 90%+ cobertura + casos extremos P1/P2 + integração RN existentes

ESPECIALIZAÇÃO CLAUDE 4 PARA RN-0002:
1. COBERTURA SISTEMÁTICA AVANÇADA P1/P2:
   - Analise TODOS os caminhos execução P1/P2:
     * P1 calculation: RPA <= threshold available
     * P2 calculation: RBA > sublimit total  
     * Edge cases: P1 negativo, P2 zero, threshold proporcional
     * Integration paths: P1/P2 + RN-0001 alíquota efetiva
   - Identifique edge cases não óbvios RN-0002:
     * RBAA exatamente R$ 3.600.000,01 (threshold exato)
     * Empresa início atividade mês 8: sublimite proporcional R$ 1.5M
     * Mudança anexo mid-year: recálculo P1/P2 retroativo
     * RPA = R$ 0: P1 deve ser zero, P2 baseado em RBA acumulada
     * Múltiplas receitas mesmo mês: agregação correta P1/P2
   - Crie matriz completa cenários RN-0002 (30+ cenários):
  * 5 cenários por SINAC com P1/P2
     * 5 cenários edge cases matemáticos  
     * 5 cenários integração com RN-0001/0026/0027
   - Valide TODAS as regras RN-0002 sistematicamente

2. QUALIDADE DE TESTES SUPERIOR P1/P2:
   - Testes unitários com assertions precisas P1/P2:
     ```csharp
     [Test]
     public void Calculate_P1P2_WithRBAAAboveThreshold_ShouldSegregateCorrectly()
     {
         // Arrange - Cenário RN-0002
         var rbaa = 4_000_000m;  // Acima threshold
         var rpa = 150_000m;
         var expectedP1 = 150_000m; // RPA menor que disponível
         var expectedP2 = 400_000m; // Excesso sobre threshold
         
         // Act
         var result = _p1p2Calculator.Calculate(rbaa, rpa);
         
         // Assert - Validação matemática precisa
         result.P1.Should().Be(expectedP1);
         result.P2.Should().Be(expectedP2);
         result.Threshold.Should().Be(3_600_000m);
     }
     ```
   - Fixtures realistas com Bogus para domínio fiscal:
     ```csharp
     public class P1P2CompanyDataGenerator
     {
         private static readonly Faker<P1P2TestCompany> _faker = new Faker<P1P2TestCompany>()
             .RuleFor(c => c.RBAA, f => f.Random.Decimal(3_600_001, 10_000_000))
             .RuleFor(c => c.RPA, f => f.Random.Decimal(50_000, 500_000))  
             .RuleFor(c => c.AnnexType, f => f.PickRandom<AnnexType>());
     }
     ```
   - Cenários integração P1/P2 + RN-0001:
     ```csharp
     [Test]  
     public async Task CalculateICMS_P1P2WithEffectiveRate_ShouldIntegrateCorrectly()
     {
         // Arrange - P1/P2 + Alíquota Efetiva RN-0001
         var company = P1P2CompanyGenerator.WithAnnexI().WithRBAA(5_000_000m);
         
         // Act - Cálculo integrado  
         var result = await _taxCalculationService.CalculateWithP1P2(company);
         
         // Assert - Verificar P1 alíquota normal + P2 alíquota específica
         result.ICMS_P1.Should().BeGreaterThan(0);
         result.ICMS_P2.Should().BeGreaterThan(0); 
         result.EffectiveRate.Should().BeInRange(0.04m, 0.33m); // SINAC equivalente a antigo Anexo I
     }
     ```

3. ESTRATÉGIA DE DADOS INTELIGENTE RN-0002:
   - Builders específicos P1/P2 por cenário:
     ```csharp
     public class P1P2ScenarioBuilder
     {
         public static P1P2Scenario ThresholdExact() =>
             new P1P2ScenarioBuilder()
                 .WithRBAA(3_600_000.01m)  // Exatamente threshold
                 .WithRPA(100_000m)
                 .Build();
                 
         public static P1P2Scenario StartupProportional(int startMonth) =>
             new P1P2ScenarioBuilder()
                 .WithRBAA(5_000_000m)
                 .WithProportionalThreshold(startMonth)
                 .Build();
     }
     ```
   - Dados teste realistas empresas Simples Nacional:
  * SINAC comercio: RBAA 4-8M, RPA 100-300k
  * SINAC servicos (fator R): RBAA 3.6-6M, Fator R variado
  * SINAC servicos complexos: RBAA ate 4.8M, complexidade maior
   - Cenários extremos com edge cases reais:
     * Empresa oscilando threshold: anos alternados acima/abaixo
     * Sazonalidade: RPA alto dezembro, baixo janeiro-fevereiro
     * Mudanças anexo: impacto P1/P2 recalcular retroativo

4. ANÁLISE CRÍTICA PROFUNDA RN-0002:
   - Identifique gaps cobertura específicos P1/P2:
     * Paths não testados em cálculos condicionais
     * Exception handling scenarios P1/P2
     * Performance degradation com volumes altos
   - Analise qualidade testes existentes:
     * Assertions fracas vs precisas
     * Cenários incompletos vs comprehensive  
     * Setup complexo vs builders elegantes
   - Sugira melhorias testabilidade P1/P2:
     * Interfaces granulares para mock específico
     * Factory methods para cenários padrão
     * Test data builders para complexidade

5. TESTES ESPECIALIZADOS POR CAMADA RN-0002:

   **DOMAIN LAYER - P1/P2 Core Logic:**
   ```csharp
   public class P1P2CalculationServiceTests
   {
       [TestCase(4_000_000, 100_000, 100_000, 400_000)] // P1 normal  
       [TestCase(3_600_001, 50_000, 50_000, 1)]        // Threshold mínimo
       [TestCase(5_000_000, 0, 0, 1_400_000)]          // RPA zero
       public void Calculate_VariousScenarios_ShouldReturnCorrectP1P2(
           decimal rbaa, decimal rpa, decimal expectedP1, decimal expectedP2)
   }
   ```
   
   **APPLICATION LAYER - Command Handlers:**
   ```csharp  
   public class CalculateICMSWithP1P2HandlerTests
   {
       [Test] public async Task Handle_ValidP1P2Command_ShouldReturnSuccess()
       [Test] public async Task Handle_InvalidRBAA_ShouldReturnFailure() 
       [Test] public async Task Handle_IntegrationWithRN0001_ShouldCalculateCorrect()
   }
   ```
   
   **INFRASTRUCTURE LAYER - Repositories/Cache:**
   ```csharp
   public class HistoricalRBAAServiceTests  
   {
       [Test] public async Task GetRBAA_WithCache_ShouldReturnCachedValue()
       [Test] public async Task GetRBAA_CacheMiss_ShouldQueryDatabase()
   }
   ```
   
   **API LAYER - Controllers/Integration:**
   ```csharp
   public class P1P2TaxCalculationControllerTests : IntegrationTestBase
   {
       [Test] public async Task CalculateP1P2_ValidRequest_ShouldReturn200WithCorrectP1P2()
       [Test] public async Task CalculateP1P2_InvalidRBAA_ShouldReturn400WithValidationErrors()
   }
   ```

CENÁRIOS CRÍTICOS ESPECÍFICOS RN-0002 (30+ obrigatórios):

**Matematicos (8 cenários):**
- RBAA = 3.600.000,01 (threshold exato)
- P1 negativo calculado (deve ser zero)  
- P2 quando RBA < threshold (deve ser zero)
- Proporcionalidade início atividade
- Múltiplas receitas mesmo período
- Valores decimais precisão (centavos)
- Overflow protection cálculos grandes
- Underflow protection cálculos pequenos

**Temporais (7 cenários):**
- Janeiro vs demais meses (RBAA vs RBA)  
- Mudança anexo mid-year recálculo
- Empresa criada mês 6: threshold proporcional
- Ano bissexto: proporcionalidade correta
- Múltiplos períodos mesmo ano
- Retroativo: recálculo P1/P2 histórico
- Forward: projeção P1/P2 futura

**Integração RN (8 cenários):**
- RN-0001: P1/P2 + alíquota efetiva  
- RN-0026: impedimento ICMS + P1/P2
- RN-0027: impedimento meses + P1/P2
- RN-0028/0029: conflitos possíveis
- Fator R + P1/P2 específico anexos
- Receitas exportação tratamento P1/P2
- Múltiplos anexos empresa: P1/P2 segregado  
- Consolidação: P1/P2 múltiplas empresas

**SINAC Específicos (7 cenários):**
- SINAC comercio: P1/P2 tipico
- SINAC industria: P1/P2 especifico  
- SINAC servicos (Fator R): P1/P2 + Fator R
- SINAC servicos especiais
- SINAC servicos (complexidade alta)
- Mudança anexo: P1/P2 recálculo impacto
- Múltiplos anexos: P1/P2 segregação correta

CRITÉRIOS QUALIDADE PREMIUM RN-0002:
- Cobertura mínima 90% código P1/P2 (target: 95%+)
- Casos extremos 100% dos 30+ cenários obrigatórios
- Testes validação TODAS as regras RN-0002 + integrações
- Dados teste realistas domínio Simples Nacional  
- Assertions claras: Should().Be() vs Should().BeApproximately()
- Testes independentes: sem shared state P1/P2
- Performance: suite completa < 30s execução
- Documentação: cenários complexos P1/P2 explicados
- Builders elegantes: fácil criar novos cenários
- Mock strategy: isolamento dependências externas

ENTREGÁVEIS ESPECÍFICOS RN-0002:
- 50+ testes unitários Domain P1/P2 services
- 25+ testes Application handlers P1/P2 
- 15+ testes Infrastructure repositories/cache
- 10+ testes Integration API endpoints P1/P2
- 30+ cenários edge cases documentados e cobertos
- Fixtures/Builders para todos cenários P1/P2  
- Performance tests: 1000+ cálculos simultâneos P1/P2
- Relatório cobertura detalhado por componente
- Documentação test scenarios complexos P1/P2

Execute validação EXAUSTIVA da RN-0002 aproveitando sua capacidade superior de análise sistemática para garantir qualidade máxima do sistema P1/P2 no Simples Nacional.
```

---

## 💡 DICA ENTERPRISE - Onde salvar o resultado
- Gere um relatório objetivo do plano e da execução em `out/sprint<sprint>/5-testing-rn0002-report.md`.
- Se houver evidências (prints, tabelas), salve em `in/sprint<sprint>/attachments/`.