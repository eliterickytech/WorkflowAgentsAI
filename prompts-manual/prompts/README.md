# 📁 Índice de Prompts - Simples Nacional CalculationEngine

## Parâmetros de execução e política

- Parâmetros: informe sempre Sprint (<sprint>) e, se aplicável, Activity (<activity>).
- Convenção de saída: out/sprint<sprint>[/<activity>]/
- Política de execução: não faça perguntas; se faltar informação, adote até 3 suposições razoáveis, liste-as no início e prossiga.

## 🎯 Agentes com Modelos por Papel (RECOMENDADO)

Os prompts especializados por modelo foram incorporados aos agentes em `../../agents/manual/*.agent.md` via `model_preferences` e `prompts.system`.

Links diretos para os agentes:
- Requirements Analyst (Gemini 2.5): `../../agents/manual/requirements-analyst.agent.md`
- Systems Architect (GPT‑5): `../../agents/manual/systems-architect.agent.md`
- Expert Developer (Claude 4): `../../agents/manual/expert-developer.agent.md`
- Testing Specialist (Claude 4): `../../agents/manual/testing-specialist.agent.md`
- Roundtable Facilitator (GPT‑5): `../../agents/manual/roundtable-facilitator.agent.md`

## 🎯 Prompts Genéricos (Backup)

### 📊 Requirements Analyst Agent
**Arquivo:** `requirements-analyst-prompt.md`
**Uso:** Análise de documentos (.docx/.xlsx) → criação de regras RN-00xx.md
**Quando usar:** Transformar especificações em regras estruturadas

### 🏗️ Systems Architect Agent  
**Arquivo:** `systems-architect-prompt.md`
**Uso:** Design arquitetural seguindo DDD/SOLID/Clean Architecture
**Quando usar:** Projetar componentes, definir estruturas, decisões arquiteturais

### 💻 Expert Developer Agent
**Arquivo:** `expert-developer-prompt.md`
**Uso:** Implementação de código .NET Framework 4.8 com padrões do projeto
**Quando usar:** Codificar classes, serviços, controllers, validações

### 🧪 Testing Specialist Agent
**Arquivo:** `testing-specialist-prompt.md`
**Uso:** Criação de testes xUnit com 90%+ cobertura e cenários extremos
**Quando usar:** Implementar suite de testes, validar regras de negócio

## 🚀 Prompts de Orquestração

### 🔗 Super Prompt
**Arquivo:** `super-prompt.md`
**Uso:** Execução sequencial automática de todos os agentes
**Quando usar:** Implementação completa end-to-end com menos intervenções manuais

### 🤝 Mesa Redonda Semântica
**Arquivo:** `mesa-redonda-semantica.md`
**Uso:** Discussão livre entre agentes para alinhamento da solução
**Quando usar:** Antes da implementação para alinhar estratégia e identificar riscos

### 🎭 Mesa Redonda Facilitada
**Arquivo:** `mesa-redonda-facilitada.md`
**Uso:** Reunião estruturada com facilitador para convergir soluções
**Quando usar:** Discussões complexas que precisam de moderação e síntese

## 🎯 Matriz de Otimização
**Arquivo:** `matriz-agente-modelo.md`
**Uso:** Guia para escolher o melhor modelo para cada agente
**Quando usar:** Referência para entender especialidades de cada modelo

## 📋 Fluxos Recomendados Otimizados

### 🎯 Para Nova Funcionalidade Complexa (RN-0002, RN-0028):
1. **🚀 Mesa Redonda GPT-5** - Facilitação master e alinhamento estratégico
2. **🔍 Requirements Analyst Gemini 2.5** - Análise documental profunda  
3. **🚀 Systems Architect GPT-5** - Design arquitetural avançado
4. **🎨 Expert Developer Claude 4** - Implementação impecável
5. **🎨 Testing Specialist Claude 4** - Validação exaustiva

### ⚡ Para Implementação Rápida:
1. **Super Prompt** - Execução automática sequencial  
2. **Ou usar prompts genéricos** sem otimização por modelo

### 🐛 Para Correção de Bug:
1. **🎨 Expert Developer Claude 4** - Correção com código limpo
2. **🎨 Testing Specialist Claude 4** - Testes da correção

### 🔄 Para Refatoração:
1. **🚀 Mesa Redonda GPT-5** (se complexa) - Discussão estratégica
2. **🚀 Systems Architect GPT-5** - Novo design otimizado  
3. **🎨 Expert Developer Claude 4** - Refatoração impecável
4. **🎨 Testing Specialist Claude 4** - Validação completa

## 🎨 Como Personalizar os Prompts

### Substituir Placeholders:
- `[REGRA-ALVO]` → RN-00xx específica
- `[caminho/documento]` → Path real do arquivo  
- `[SINAC envolvidos]` → Lista de `sinacCode` (sempre 3 digitos, ex.: 001, 010, 034). Anexo/Secao/Tabela permanecem como metadados
- `[tipo da regra]` → cálculo/impedimento/validação

### Adaptar Contexto:
- Especificar componentes impactados
- Definir restrições específicas
- Ajustar critérios de qualidade
- Personalizar entregáveis esperados

## 💡 Dicas de Uso

✅ **Sempre personalize** os placeholders com valores específicos
✅ **Revise resultados** entre etapas para manter qualidade  
✅ **Use mesa redonda** para regras complexas ou controversas
✅ **Documente decisões** importantes em ADRs quando necessário
✅ **Mantenha padrões** do projeto (.NET 4.8, DDD, ASCII, etc.)

❌ **Não pule** a personalização dos prompts
❌ **Evite execução cega** sem validação entre etapas
❌ **Não ignore** warnings ou sugestões dos agentes
❌ **Não esqueça** de seguir os critérios de qualidade estabelecidos

---

## 📦 Resultados e Rastreabilidade (out/sprint<sprint>[/<activity>])

Padronizamos a captura dos resultados de cada etapa para facilitar auditoria e versionamento. Use estes arquivos:

- `out/sprint<sprint>[/<activity>]/01-ata-mesa-redonda.md` — ATA padronizada da mesa redonda
- `out/sprint<sprint>[/<activity>]/02-requisitos-bdd.md` — Saída consolidada do Requirements Analyst
- `out/sprint<sprint>[/<activity>]/03-arquitetura.md` — Decisões e direcionamentos arquiteturais
- `out/sprint<sprint>[/<activity>]/04-desenvolvimento.md` — Plano e notas de desenvolvimento
- `out/sprint<sprint>[/<activity>]/05-qa-plano.md` — Plano, execução e métricas de testes
- `out/sprint<sprint>[/<activity>]/engineering/src/` — Código-fonte
- `out/sprint<sprint>[/<activity>]/engineering/tests/` — Testes automatizados
- `out/sprint<sprint>[/<activity>]/engineering/reports/` — Evidências e relatórios de QA
- `out/sprint<sprint>[/<activity>]/adrs/` — ADRs (template Nygard)
- `out/sprint<sprint>[/<activity>]/diagrams/` — Diagramas (Mermaid)
