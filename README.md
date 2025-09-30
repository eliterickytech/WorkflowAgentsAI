# Rickytech System AI — Equipe de AGENTES

**Versão:** 2.0.0  
**Autor:** Ricardo Macedo Perdigão  
**Data:** 30 de Setembro de 2025

Time de agentes de desenvolvimento com práticas modernas (Scrum, BDD/Gherkin, DDD, Clean Architecture, SOLID, CQRS, ADRs, Mermaid) e orquestração com CrewAI/AutoGen.

> ⚠️ **ATENÇÃO:** Os processos automáticos utilizando CrewAI e AutoGen estão em **PREVIEW** e ainda não foram completamente testados. Recomendamos o uso do **processo manual com fluxo automatizado** para produção.

## 📚 Índice Geral de Documentação

### 📁 **Documentação Principal**
- **[� docs/fluxo-completo.md](./docs/fluxo-completo.md)** - **GUIA PRINCIPAL: Do zero à mesa redonda**
- **[�📖 docs/README.md](./docs/README.md)** - Índice completo da documentação técnica
- **[📋 docs/resumo-melhorias-setup.md](./docs/resumo-melhorias-setup.md)** - Últimas melhorias implementadas no instalador

### 🛠️ **Prompts e Agentes**
- **[📝 prompts-manual/prompts/README.md](./prompts-manual/prompts/README.md)** - Guia principal dos prompts e agentes
- **[📚 prompts-manual/prompts/reference/README.md](./prompts-manual/prompts/reference/README.md)** - Exemplos de referência para uso individual
- **[📁 prompts-manual/prompts/deprecated/README.md](./prompts-manual/prompts/deprecated/README.md)** - Prompts descontinuados (arquivo histórico)

### 📦 **Resultados**  
- **[📊 out/README.md](./out/README.md)** - Estrutura e organização dos artefatos gerados

### 📄 **Exemplos e Instruções**
- **[💼 docs/exemplo-instrucoes-personalizada.md](./docs/exemplo-instrucoes-personalizada.md)** - Como personalizar agentes para sua empresa
- **[👤 docs/exemplo-product-owner.instructions.md](./docs/exemplo-product-owner.instructions.md)** - Exemplo prático de instruções para Product Owner
- **[🔍 docs/analise-projeto-existente.md](./docs/analise-projeto-existente.md)** - Análise automática de projetos existentes
- **[🤖 docs/integracao-github-copilot.md](./docs/integracao-github-copilot.md)** - **NOVO:** Integração automática com GitHub Copilot

## ⚡ Quick Start (Comando Único)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
```

## 🚀 **NOVO: Fluxo Automatizado com Aprovações**

**Agora o workflow executa automaticamente com controle total em cada etapa!**

```markdown
# Execute APENAS uma vez no VS Code Copilot Chat:
@agents/manual/product-owner.agent.md

"Analise demanda RN-0015 - Sistema de Notificações:
- Contexto: [Seu contexto]
- Stakeholders: [Seus stakeholders]  
- Prioridade: Alta"

# 🔄 O sistema executa automaticamente:
✅ Product Owner → [SIM/NÃO] → Mesa Redonda
✅ Mesa Redonda → [SIM/NÃO] → Requirements  
✅ Requirements → [SIM/NÃO] → Architecture
✅ Architecture → [SIM/NÃO] → Development
✅ Development → [SIM/NÃO] → Testing
✅ Testing → AUTOMÁTICO → PO Final (Checklist)

# 🎯 Resultado: Projeto completo do 00- ao 99-checklist-final.md
```

### **📋 Controle Total:**
- **[SIM]**: Continua automaticamente para próxima etapa
- **[NÃO]**: Para para revisões e ajustes
- **Checklist Final**: Validação completa de critérios de aceite

## 📋 **Instalação Passo a Passo Detalhada**

### **Comando de Instalação:**
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
```

### **Fluxo Interativo Completo:**
```powershell
# 1. Definir caminho de destino
Caminho do projeto .NET (destino da copia): C:\Projetos\MeuSistema\ia

# 2. Verificação automática de pré-requisitos
[INFO] Checando pre-requisitos...

# 3. Escolher modo de operação
Selecione o modo:
  1) Manual (recomendado para comecar)
  2) Automatico (CrewAI)
Digite 1 ou 2: 1

# 4. Configurar parâmetros básicos
Qual o numero da sprint? (ex.: 01): 01
Qual a activity? (ex.: rn0001): rn0001
Qual o nome do projeto? (ex.: CalculationEngine): MeuSistema

# 🆕 5. NOVA FUNCIONALIDADE - Análise de projeto existente
Tipo de trabalho: (1) Projeto novo ou (2) Implementacao em projeto existente? 2
Caminho do projeto existente (.NET/Node/Angular/React): C:\Projetos\MeuSistema

# 6. Análise automática (se projeto existente)
[INFO] Projeto existente encontrado em: C:\Projetos\MeuSistema
[INFO] Tipo de projeto detectado: dotnet
[INFO] GitHub Copilot instructions encontradas e integradas ✅
[INFO] Analise do projeto concluida!
[INFO] Contexto do projeto salvo em: project-analysis.md

# 7. Ambiente Python (opcional)
Criar .venv-1 e instalar requirements agora? (s/n): s

# 8. Personalização de agentes (opcional)  
Deseja enriquecer os agentes com instrucoes personalizadas? (s/n): n

# 9. Execução automática do workflow
Executar o fluxo manual automaticamente agora? (s/n): s
```

### **🎯 Resultado da Instalação:**
- ✅ **Estrutura completa** copiada para destino
- ✅ **Projeto existente analisado** (tecnologias, padrões, convenções)
- ✅ **GitHub Copilot integrado** automaticamente (se encontrado)
- ✅ **Agentes contextualizados** com conhecimento unificado do projeto
- ✅ **Ambiente configurado** e pronto para uso
- ✅ **Workflow executado** automaticamente (se escolhido)
- ✅ **🆕 Fluxo com aprovações** implementado para controle total

---

## � **Fluxo Automatizado Detalhado**

### **🎯 Como Funciona:**

```
1️⃣ PO (Análise de Negócio)
   ↓ [SIM/NÃO]
2️⃣ Mesa Redonda (Alinhamento Técnico)  
   ↓ [SIM/NÃO]
3️⃣ Requirements Analyst (BDD + Cenários)
   ↓ [SIM/NÃO]  
4️⃣ Systems Architect (Design + ADRs)
   ↓ [SIM/NÃO]
5️⃣ Expert Developer (Código + Testes)
   ↓ [SIM/NÃO]
6️⃣ Testing Specialist (Plano QA)
   ↓ AUTOMÁTICO
7️⃣ PO Final (Checklist Completo ✅)
```

### **📁 Artefatos Gerados:**
- `00-business-context.md` + `00-requirements-brief.md`
- `01-ata-mesa-redonda.md`  
- `02-requisitos-bdd.md` + `features/*.feature`
- `03-arquitetura.md` + `adrs/` + `diagrams/`
- `04-desenvolvimento.md` + `engineering/src/` + `engineering/tests/`
- `05-qa-plano.md` + `engineering/reports/`
- `99-checklist-final.md` ← **NOVO: Validação completa**

### **🎮 Controle Total:**
- **[SIM]**: Prossegue automaticamente
- **[NÃO]**: Para para ajustes e revisões  
- **Você decide** o ritmo e qualidade de cada etapa
- **Checklist final** com todos os critérios de aceite validados

---

## �🔧 Quick Start Manual (Alternativo)

Se preferir executar passos manualmente:

1) Criar `.env` (a partir de `.env.example`) e configurar seu provedor LLM:

```powershell
Copy-Item .\.env.example .\.env
# Edite .env e preencha: LLM_PROVIDER/LLM_MODEL e suas credenciais (OpenAI/Azure/compatível)
```

2) Escolher modo e executar:
- Manual:
  ```powershell
  powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\start-manual.ps1 -Sprint 01 -Activity rn0001
  ```
- CrewAI: ⚠️ **PREVIEW - NÃO TESTADO**
  ```powershell
  $env:USE_CREWAI = "1"; $env:SPRINT = "01"; $env:OUTPUT_ACTIVITY = "rn0001"
  python .\orchestrators\crewai_runner.py 1
  ```

3) Colocar insumos em `in/sprint01/rn0001/attachments/` (PDF, imagens, planilhas, etc.).

4) Ver artefatos em `out/sprint01/rn0001/` (01..05, features, adrs, diagrams, outcomes/engineering). Opcional: renderizar diagramas:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\render-diagrams.ps1
```

## 🚀 Comece por aqui

### **Primeiro uso:**
1. **[� Fluxo Completo: Do Zero à Mesa Redonda](./docs/fluxo-completo.md)** ← **COMECE AQUI**
2. **[�📖 Índice Geral de Documentação](#-índice-geral-de-documentação)** ⬆️ - Navegue por toda a documentação
3. **[🆕 Novo projeto .NET](./docs/new-dotnet-project-setup.md)** - Guia técnico detalhado
4. **[⚡ Instalador PowerShell](./Install/setup-workflow.ps1)** - Configuração automática

### **Para usuários avançados:**
- **[📋 Documentação técnica completa](./docs/README.md)** - Todos os processos e integrações
- **[🎯 Personalização de agentes](./docs/exemplo-instrucoes-personalizada.md)** - Adapte para sua empresa

## Documentação principal

- **Processo Manual (RECOMENDADO):** [`docs/manual-process.md`](./docs/manual-process.md) ✅ **TESTADO E FUNCIONAL**
- Processo Automático (CrewAI): [`docs/automatic-process.md`](./docs/automatic-process.md) ⚠️ **PREVIEW - NÃO TESTADO**
- Super Prompt (como usar): [`docs/super-prompt.md`](./docs/super-prompt.md)
- Integração com projeto .NET: [`docs/dotnet-integration.md`](./docs/dotnet-integration.md)
- Atualizar instruções dos agentes: [`docs/updating-agents.md`](./docs/updating-agents.md)
- Diagramas Mermaid (.mmd): [`docs/diagram/`](./docs/diagram/)
  - Imagens geradas: [`docs/images/`](./docs/images/)

## Agentes

- Pasta com os agentes manuais: [`agents/manual`](./agents/manual)
  - **🆕 Product Owner**: [`agents/manual/product-owner.agent.md`](./agents/manual/product-owner.agent.md) - **Início automático**
  - **🆕 Product Owner Final**: [`agents/manual/product-owner-final.agent.md`](./agents/manual/product-owner-final.agent.md) - **Checklist final**
  - Roundtable Facilitator: [`agents/manual/roundtable-facilitator.agent.md`](./agents/manual/roundtable-facilitator.agent.md)
  - Requirements Analyst: [`agents/manual/requirements-analyst.agent.md`](./agents/manual/requirements-analyst.agent.md)
  - Systems Architect: [`agents/manual/systems-architect.agent.md`](./agents/manual/systems-architect.agent.md)
  - Expert Developer: [`agents/manual/expert-developer.agent.md`](./agents/manual/expert-developer.agent.md)
  - Testing Specialist: [`agents/manual/testing-specialist.agent.md`](./agents/manual/testing-specialist.agent.md)

### **🔄 Fluxo Automatizado:**
Todos os agentes agora **pedem aprovação [SIM/NÃO]** e **executam o próximo automaticamente** após confirmação.

Observações:
- Defina modelos por agente em `model_preferences` (front matter YAML) nos arquivos acima.
- Entradas padrão: `in/sprint<sprint>/<activity>/attachments/`. Saídas: `out/sprint<sprint>/<activity>/`.

## Orquestração (scripts)

- **⚠️ CrewAI (PREVIEW):** [`orchestrators/crewai_runner.py`](./orchestrators/crewai_runner.py) - **NÃO TESTADO**
- **⚠️ AutoGen (PREVIEW):** [`orchestrators/autogen_dev_team.py`](./orchestrators/autogen_dev_team.py) - **NÃO TESTADO**
- **✅ Scripts manuais (RECOMENDADO):** [`powershell/`](./powershell/) - **TESTADO E FUNCIONAL**

Detalhes de execução e variáveis de ambiente estão nos guias da seção “Documentação principal”.

## Ambiente e configuração

- Exemplo de variáveis: [`.env.example`](./.env.example)
- Ambiente Python recomendado: `./.venv-1`
- Pré-requisitos e instalação: veja o guia de novo projeto e/ou use o instalador.

## 🧭 Navegação Rápida

| Precisa de... | Vá para... |
|---------------|------------|
| **Entender o fluxo completo** | [🚀 Fluxo Completo](./docs/fluxo-completo.md) |
| **Instalar o sistema** | [🆕 Novo projeto .NET](./docs/new-dotnet-project-setup.md) |
| **Executar o workflow** | [📋 Processos](./docs/README.md#processos) |
| **🆕 Fluxo automatizado** | [🚀 Novo fluxo com aprovações](#-novo-fluxo-automatizado-com-aprovações) |
| **Personalizar agentes** | [💼 Instruções personalizadas](./docs/exemplo-instrucoes-personalizada.md) |
| **Ver exemplos práticos** | [📚 Prompts de referência](./prompts-manual/prompts/reference/README.md) |
| **Analisar projeto existente** | [🔍 Análise automática](./docs/analise-projeto-existente.md) |
| **Integrar com GitHub Copilot** | [🤖 Integração automática](./docs/integracao-github-copilot.md) |
| **Entender a estrutura** | [📊 Organização dos resultados](./out/README.md) |
| **Resolver problemas** | [📋 Melhorias recentes](./docs/resumo-melhorias-setup.md) |

---

## 📋 **Status dos Processos**

| Processo | Status | Recomendação |
|----------|--------|--------------|
| **🚀 Manual com Fluxo Automatizado** | ✅ **TESTADO E FUNCIONAL** | **RECOMENDADO PARA PRODUÇÃO** |
| **🤖 CrewAI** | ⚠️ **PREVIEW** | Aguardar testes completos |
| **🔄 AutoGen** | ⚠️ **PREVIEW** | Aguardar testes completos |

---

## 👤 Autor e Informações

**Proprietário do projeto:** Ricardo Macedo Perdigão  
**Versão do documento:** 2.0.0  
**Última atualização:** 30 de Setembro de 2025  
**Status:** Produção (processo manual) / Preview (processos automáticos)
