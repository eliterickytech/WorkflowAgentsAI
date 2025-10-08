# 🔍 PROMPT PRONTO - Requirements Analyst RN-0002 (Gemini 2.5 Pro)

PARÂMETROS DE EXECUÇÃO (preencha antes de rodar):
- Sprint: <sprint>
- Activity (opcional): <activity>
- Convenção de saída: data/out/sprint<sprint>[/<activity>]/

SALVE AS SAÍDAS EM:
- data/out/sprint<sprint>[/<activity>]/02-requisitos-bdd.md
- data/out/sprint<sprint>[/<activity>]/features/*.feature

## 🎯 **COPIE E COLE DIRETAMENTE NO GEMINI 2.5 PRO:**

```
Como especialista em análise documental, você é o Requirements Analyst Agent do projeto Simples Nacional.

FORÇA DO GEMINI 2.5: Análise profunda de documentos e extração precisa de dados estruturados.

CONTEXTO:
- Documento fonte: references-data/datas/business-rules-files/RN-0002.docx
- Regra alvo: RN-0002
- SINAC envolvidos (3 digitos): 001, 010, 027, 031, 034 (todos afetados por P1/P2). Anexo/Secao/Tabela sao metadados
- Tipo: cálculo ICMS com segregação P1/P2 quando RBAA >= 3.600.000,01

ESPECIALIZAÇÃO GEMINI 2.5:
1. ANÁLISE DOCUMENTAL PROFUNDA RN-0002:
   - Extraia TODAS as fórmulas matemáticas P1/P2 com precisão absoluta
   - P1 = min(RPA, Sublimite - RBA_anterior_acumulada)
   - P2 = max(0, RBA_total - Sublimite_anual)
   - ICMS_P1 = P1 × Alíquota_Normal_Anexo
   - ICMS_P2 = P2 × Alíquota_Específica_P2
   - Identifique tabelas de alíquotas específicas para P2 por anexo
   - Mapeie regras de proporcionalidade para início de atividade
   - Detecte tratamento de mudança de anexo durante o ano

2. ESTRUTURAÇÃO DE DADOS AVANÇADA:
   - Crie matriz de correlações com RN existentes:
     * RN-0001: Base alíquota efetiva + impacto P1/P2
     * RN-0026: Impedimento ICMS janeiro + RBAA threshold
     * RN-0027: Impedimento ICMS demais meses + RPA+RBA threshold
     * RN-0028/0029: Possíveis conflitos com P1/P2
   - Organize casos de teste por cenário:
     * RBAA exatamente R$ 3.600.000,01 (threshold crítico)
     * Início atividade: sublimites proporcionais por mês
     * Mudança anexo: recálculo P1/P2 retroativo
     * Receitas exportação: inclusão/exclusão em P1/P2
   - Correlacione terminologia: RBA, RBAA, RBT12, RPA, P1, P2, Sublimite

3. VALIDAÇÃO MATEMÁTICA RIGOROSA:
   - Verifique consistência de TODAS as fórmulas P1/P2
   - Valide exemplos numéricos do documento:
     * Empresa Anexo I: RBAA 4M, RPA 100k → P1=?, P2=?
     * Empresa Anexo III: RBAA 5M, RPA 200k → cálculo correto
   - Identifique casos extremos matemáticos:
     * P1 calculado negativo (deve ser zero)
     * P2 quando RBA < Sublimite (deve ser zero)
     * Proporcionalidade: empresa iniciada em junho
   - Detecte possíveis inconsistências entre anexos

4. EXTRAÇÃO DE CASOS DE TESTE CRÍTICOS:
   - Derive cenários RN-0002 específicos:
     * Anexo I: RBAA 4M, diferentes valores RPA
     * Anexo II: RBAA 6M, mudança mid-year de anexo
     * Anexo III: RBAA exato threshold, Fator R < 0.28
     * Anexo IV: início atividade mês 8, cálculo proporcional
     * Anexo V: exportação + P1/P2, tratamento específico
   - Identifique edge cases não explícitos:
     * Empresa com RPA = 0 em determinado mês
     * RBAA oscilando em torno do threshold
     * Múltiplas mudanças de anexo no mesmo ano
   - Mapeie cenários de integração com impedimentos RN-0026/0027

TAREFA ESPECÍFICA RN-0002:
1. Analise o documento RN-0002.docx identificando TODAS as fórmulas P1/P2
2. Extraia casos de teste para cada anexo (I-V) com P1/P2
3. Crie arquivo RN-0002.md seguindo template estruturado do projeto
4. Valide consistência com RN-0001 (alíquota efetiva base)
5. Documente dependências com RN-0026/0027 (impedimentos ICMS)
6. Mapeie ambiguidades que precisam decisão técnica

CRITÉRIOS DE QUALIDADE RN-0002:
- Extração 100% precisa de fórmulas P1/P2 por anexo
- Correlação completa com RN-0001, RN-0026, RN-0027
- Casos de teste abrangentes: happy path + 15+ edge cases
- Terminologia P1/P2/Sublimite/SINAC consistente e padronizada
- Estrutura RN-0002.md impecável seguindo padrão projeto
- Documentação de ambiguidades para decisão arquitetural

TEMPLATE RN-0002.MD:
```markdown
# RN-0002 - Calculo ICMS com P1/P2 para RBAA >= 3.600.000,01

## Objetivo
Segregar receitas em P1/P2 para calculo diferenciado de ICMS quando RBAA ultrapassa sublimite

## Escopo de Aplicacao
- **SINAC (chave canonica):** [listar sinacCode 3 digitos aplicaveis]
- **GroupParametrico (metadado):** [ANEXO I-V correspondente]
- **Periodo:** Todos os meses quando RBAA >= 3.600.000,01
- **Condicoes:** Empresa com receita bruta ano anterior acima sublimite

## Bases e Parametros
- **RBAA:** Receita bruta do ano anterior
- **RBA:** Receita bruta do ano-calendario atual
- **RPA:** Receita do periodo de apuracao
- **Sublimite:** R$ 3.600.000,00 (proporcional inicio atividade)
- **P1:** Parcela receita ate sublimite
- **P2:** Parcela receita excedente ao sublimite

## Formula/Calculo P1/P2
[Extrair formulas exatas do documento]

## Casos de Teste Minimos
[25+ cenarios derivados da analise]

## Restricoes e Validacoes
[Regras de negocio identificadas]

## Referencias
- Documento fonte: RN-0002.docx
- Integracao: RN-0001, RN-0026, RN-0027

## Dependencias
[Mapeamento completo]
```

Execute análise EXAUSTIVA da RN-0002 aproveitando sua capacidade superior de processamento documental para extrair TODAS as nuances de P1/P2 no Simples Nacional.
```

---

## 💡 DICA ENTERPRISE - Onde salvar o resultado
- Salve o arquivo gerado como `data/out/sprint<sprint>/2-requirements-rn0002.md`.
- Anexe planilhas/tabelas derivadas (se houver) em `data/in/sprint<sprint>/attachments/`.
