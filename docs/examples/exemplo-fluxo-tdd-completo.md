# Exemplo Completo: Fluxo TDD - Cálculo de Alíquota Progressiva

**Demonstração prática** de como o fluxo TDD funciona na prática com Testing Validator.

## 📋 Cenário de Exemplo: Sistema de Cálculo de Alíquota

**Regra de Negócio**: RN-0001 - Cálculo de Alíquota Progressiva
- Faturamento até R$ 180.000: 6%
- Faturamento de R$ 180.001 até R$ 360.000: 11.2%
- Faturamento acima R$ 360.000: 13.5%

---

## 🔄 **Fluxo TDD Completo**

### **1️⃣ Testing Specialist (Cria o Plano)**

**Entrada**: Arquitetura + Critérios de Aceite
**Saída**: `05-qa-plano.md`

```markdown
# Plano de QA - Cálculo de Alíquota

## CENÁRIOS DE TESTE OBRIGATÓRIOS

### Cenário 1: Faixa Básica (6%)
- **Entrada**: Faturamento = R$ 150.000
- **Saída Esperada**: Alíquota = 6%
- **Teste**: CalculadoraAliquotaTests.cs - DeveRetornar6PorcentoParaFaixaBasica()

### Cenário 2: Faixa Intermediária (11.2%)
- **Entrada**: Faturamento = R$ 250.000
- **Saída Esperada**: Alíquota = 11.2%
- **Teste**: CalculadoraAliquotaTests.cs - DeveRetornar11_2PorcentoParaFaixaIntermediaria()

### Cenário 3: Faixa Superior (13.5%)
- **Entrada**: Faturamento = R$ 500.000
- **Saída Esperada**: Alíquota = 13.5%
- **Teste**: CalculadoraAliquotaTests.cs - DeveRetornar13_5PorcentoParaFaixaSuperior()

### Cenário 4: Limites Exatos
- **Entrada**: Faturamento = R$ 180.000 (exato)
- **Saída Esperada**: Alíquota = 6%
- **Teste**: CalculadoraAliquotaTests.cs - DeveRetornar6PorcentoParaLimiteExato180k()

### Cenário 5: Entrada Inválida
- **Entrada**: Faturamento = R$ -1.000 (negativo)
- **Saída Esperada**: Exception com mensagem específica
- **Teste**: CalculadoraAliquotaTests.cs - DeveLancarExceptionParaFaturamentoNegativo()

## META DE COBERTURA: 95%

## FERRAMENTAS OBRIGATÓRIAS:
- xUnit para testes unitários
- Bogus para geração de dados
- FluentAssertions para assertions
- Coverage analysis
```

---

### **2️⃣ Expert Developer (Implementa Seguindo o Plano)**

**Entrada**: Plano de QA + Arquitetura
**Saída**: `04-desenvolvimento.md` + Código + Testes

```markdown
# Desenvolvimento - Cálculo de Alíquota

## IMPLEMENTAÇÃO SEGUINDO TDD

### ✅ TODOS OS TESTES IMPLEMENTADOS CONFORME PLANO:

#### Teste 1: Faixa Básica ✅
```
[Fact]
public void DeveRetornar6PorcentoParaFaixaBasica()
{
	// Arrange
	var calculadora = new CalculadoraAliquota();
	var faturamento = 150000m;

	// Act
	var resultado = calculadora.CalcularAliquota(faturamento);

	// Assert
	resultado.Should().Be(0.06m);
}
```

#### Teste 2: Faixa Intermediária ✅
```
[Fact]
public void DeveRetornar11_2PorcentoParaFaixaIntermediaria()
{
	// Arrange
	var calculadora = new CalculadoraAliquota();
	var faturamento = 250000m;

	// Act
	var resultado = calculadora.CalcularAliquota(faturamento);

	// Assert
	resultado.Should().Be(0.112m);
}
```

#### [... todos os outros testes conforme plano]

### 📊 COBERTURA ALCANÇADA: 96% ✅ (Meta: 95%)

### 🏗️ IMPLEMENTAÇÃO PRINCIPAL:
```
public class CalculadoraAliquota
{
	public decimal CalcularAliquota(decimal faturamento)
	{
		if (faturamento < 0)
			throw new ArgumentException("Faturamento não pode ser negativo");

		if (faturamento <= 180000m)
			return 0.06m;
		else if (faturamento <= 360000m)
			return 0.112m;
		else
			return 0.135m;
	}
}
```

## ✅ AUTO-VERIFICAÇÃO CONCLUÍDA:
- Todos os cenários do plano implementados
- Cobertura de 96% (acima da meta de 95%)
- Todos os testes passando
- Código compila sem warnings
```

---

### **3️⃣ Testing Validator (Valida Implementação)**

**Entrada**: Plano Original + Implementação
**Saída**: `05.1-testing-validation.md`

```markdown
# Validação TDD - Cálculo de Alíquota

## COMPARATIVO: PLANEJADO vs IMPLEMENTADO

### ✅ Cenários Implementados vs. Planejados:
- ✅ Cenário 1: Faixa Básica → IMPLEMENTADO e PASSA
- ✅ Cenário 2: Faixa Intermediária → IMPLEMENTADO e PASSA
- ✅ Cenário 3: Faixa Superior → IMPLEMENTADO e PASSA
- ✅ Cenário 4: Limites Exatos → IMPLEMENTADO e PASSA
- ✅ Cenário 5: Entrada Inválida → IMPLEMENTADO e PASSA

### 📊 Cobertura de Código:
- **Planejado**: 95%
- **Atingido**: 96%
- **Status**: ✅ ACIMA DA META

### 🎯 Evidências por Critério de Aceite:
- ✅ Critério 1: Cálculo correto faixa básica → VALIDADO
- ✅ Critério 2: Cálculo correto faixa intermediária → VALIDADO
- ✅ Critério 3: Cálculo correto faixa superior → VALIDADO
- ✅ Critério 4: Tratamento de erros → VALIDADO
- ✅ Critério 5: Performance < 100ms → VALIDADO (15ms medido)

### 🔍 EXECUÇÃO DE TODOS OS TESTES:
```
Executando: dotnet test --collect:"XPlat Code Coverage"
✅ DeveRetornar6PorcentoParaFaixaBasica - PASSOU
✅ DeveRetornar11_2PorcentoParaFaixaIntermediaria - PASSOU
✅ DeveRetornar13_5PorcentoParaFaixaSuperior - PASSOU
✅ DeveRetornar6PorcentoParaLimiteExato180k - PASSOU
✅ DeveLancarExceptionParaFaturamentoNegativo - PASSOU

Resultado: 5/5 testes passaram
Cobertura: 96.2%
```

## DECISÃO FINAL:
✅ **IMPLEMENTAÇÃO APROVADA**

**Justificativa**:
- Todos os cenários planejados foram implementados
- Cobertura excede a meta estabelecida
- Todos os testes executam com sucesso
- Evidências completas para todos os critérios
- Implementação segue exatamente o plano de QA

## 🎯 PRÓXIMO PASSO:
Executar Product Owner Final para validação dos critérios de aceite
```

---

## **💡 Vantagens do Fluxo TDD com Testing Validator**

### **🎯 Para o Testing Specialist:**
- Cria plano **ANTES** da implementação
- Define cenários obrigatórios e metas de cobertura
- **Roadmap claro** para o desenvolvedor

### **🎯 Para o Expert Developer:**
- Tem **roteiro completo** de testes para implementar
- Não precisa "adivinhar" o que testar
- **Desenvolvimento guiado** por testes específicos

### **🎯 Para o Testing Validator:**
- **Valida conformidade** com o plano original
- **Execução independente** dos testes
- **Parecer técnico objetivo** baseado em evidências

### **🎯 Para o Product Owner Final:**
- Recebe implementação **já validada tecnicamente**
- Foca apenas nos **critérios de aceite de negócio**
- **Maior confiança** na qualidade da entrega

---

## **🚀 Como Usar Este Fluxo**

### **1. Executar Testing Specialist:**
```
@agents/manual/testing-specialist.agent.md

Sprint: 02, Activity: calculo-aliquota
Contexto: "Criar plano de QA TDD para RN-0001 - Cálculo de Alíquota Progressiva conforme arquitetura definida"
```

### **2. Executar Expert Developer:**
```
@agents/manual/expert-developer.agent.md

Sprint: 02, Activity: calculo-aliquota
Contexto: "Implementar RN-0001 seguindo EXATAMENTE o plano de QA definido em 05-qa-plano.md - TDD rigoroso"
```

### **3. Executar Testing Validator:**
```
@agents/manual/testing-validator.agent.md

Sprint: 02, Activity: calculo-aliquota
Contexto: "Validar se implementação seguiu o plano de QA definido - todos os testes foram implementados corretamente?"
```

### **4. Executar Product Owner Final:**
```
@agents/manual/product-owner-final.agent.md

Sprint: 02, Activity: calculo-aliquota
Contexto: "Validar CADA critério de aceite da RN-0001 contra as evidências da equipe técnica"
```

---

**✨ Resultado**: Implementação com qualidade garantida, testes completos e validação em múltiplas camadas!


