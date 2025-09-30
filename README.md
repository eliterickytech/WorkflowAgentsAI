# AgileDevAgent - Agentes de Desenvolvimento Ágil

**Versão:** 2.0.0  
**Autor:** Ricardo Macedo Perdigão  
**Data:** 30 de Setembro de 2025

## 🎯 **O que é o AgileDevAgent?**

O AgileDevAgent é um **sistema de agentes inteligentes** que automatiza o processo completo de desenvolvimento de software seguindo metodologias ágeis. Ele transforma uma simples solicitação de negócio em documentação completa, código implementado e planos de teste.

**Para Desenvolvedores:** Imagine ter uma equipe de especialistas (Product Owner, Arquiteto, Desenvolvedor Sênior, etc.) que trabalha automaticamente para você, gerando toda a documentação e código necessário para implementar uma funcionalidade.

## 🚀 **Como Funciona o Sistema?**

O sistema possui **7 agentes especializados** que trabalham em sequência:

```
1️⃣ Product Owner       → Analisa o negócio
2️⃣ Mesa Redonda       → Alinha tecnicamente  
3️⃣ Requirements       → Cria cenários BDD
4️⃣ Arquiteto          → Define a solução
5️⃣ Desenvolvedor      → Implementa o código
6️⃣ Testador           → Cria planos de teste
7️⃣ PO Final           → Valida tudo
```

**Cada agente pede sua aprovação antes de continuar para o próximo!**

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

## 📋 **Pré-requisitos (O que você precisa ter instalado)**

- **Windows 10/11** com PowerShell
- **Git** (para controle de versão)
- **VS Code** com extensão GitHub Copilot (OBRIGATÓRIO)
- **Conta GitHub** com Copilot ativo

**O sistema instala automaticamente:**
- Python 3.12 (para agentes automáticos)
- Node.js LTS (para diagramas)
- .NET SDK 8 (para projetos .NET)
- Mermaid CLI (para gerar diagramas)

---

## 🚀 **PASSO 1: Instalação (Comando Único)**

**Abra o PowerShell como Administrador e execute:**

```powershell
# Navegue até a pasta do AgileDevAgent
cd "C:\Projetos\EliteRickytech\AgileDevAgent"

# Execute o instalador
powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
```

### 📝 **O que acontece durante a instalação:**

```
1️⃣ Sistema pergunta: "Onde quer que gere os Agentes?"
   → Digite: C:\Projetos\MeuWorkspace\IA

2️⃣ Sistema instala pré-requisitos automaticamente
   → Python, Node.js, Git, .NET SDK

3️⃣ Sistema pergunta: "Selecione o modo:"
   → Digite: 1 (Manual - RECOMENDADO para iniciantes)

4️⃣ Sistema pergunta informações do projeto:
   → Sprint: 01
   → Activity: rn0001  
   → Nome do projeto: MeuSistema

5️⃣ Sistema pergunta: "Tipo de trabalho:"
   → Digite: 1 (Projeto novo) OU 2 (Projeto existente)

6️⃣ Se projeto novo: "Onde CRIAR o novo projeto?"
   → Digite: C:\Projetos\MeuSistema

7️⃣ Se projeto existente: "Onde ESTÁ o projeto existente?"
   → Digite: C:\Projetos\SistemaAtual

8️⃣ Sistema copia agentes e configura tudo automaticamente
```

### ✅ **Resultado da Instalação:**

```
📁 C:\Projetos\MeuWorkspace\IA\     ← AGENTES (onde ficam os workflows)
├── agents/manual/                  ← 7 agentes especializados
├── in/sprint01/rn0001/            ← ENTRADA (você coloca documentos aqui)
│   ├── business_request/          ← Solicitações do cliente
│   └── attachments/               ← Documentos técnicos
├── out/sprint01/rn0001/           ← SAÍDA (agentes geram aqui)
└── powershell/                    ← Scripts de automação

📁 C:\Projetos\MeuSistema\          ← PROJETO (seu código fica aqui)
├── src/                           ← Código-fonte
├── docs/                          ← Documentação do projeto
└── MeuSistema.sln                 ← Solution .NET
```

---

## 🎯 **PASSO 2: Como Usar - Processo Manual (RECOMENDADO)**

**Processo Manual:** Aqui você controla cada etapa e tem total visibilidade do que acontece. É o modo recomendado para começar.

### **📝 2.1: Preparar sua Solicitação**

**Primeiro, crie um documento com sua solicitação:**

```powershell
# Vá para o workspace dos agentes
cd "C:\Projetos\MeuWorkspace\IA"

# Crie um documento com sua solicitação
notepad .\in\sprint01\rn0001\business_request\minha_solicitacao.md
```

**Exemplo de conteúdo:**
```markdown
# Solicitação: Login com Google

## O que preciso:
Implementar login com Google OAuth no sistema de vendas

## Por que preciso:
Os usuários querem acessar o sistema usando sua conta Google

## Critérios de sucesso:
- Usuário clica em "Login com Google"
- Sistema redireciona para Google
- Usuário autoriza e volta logado no sistema
```

### **📱 2.2: Iniciar o Processo Manual**

**QUEM INICIA:** Sempre o **Product Owner** (PO)  
**COMO INICIAR:** GitHub Copilot Chat no VS Code

```powershell
# Abra o VS Code no workspace dos agentes
cd "C:\Projetos\MeuWorkspace\IA"
code .
```

**No GitHub Copilot Chat (Ctrl+Shift+I), digite:**

```
@agents/manual/product-owner.agent.md

RN-0001: Implementar login com Google OAuth
Sprint: 01
Activity: rn0001
Sistema: Sistema de Vendas (.NET + React)

Analise a solicitação e prepare a mesa redonda.
```

### **🔄 2.3: Fluxo de Execução Detalhado**

**O que acontece depois que você executa o PO:**

```
🤖 Product Owner analisa e gera:
├── 00-business-context.md        ← Contexto de negócio
├── 00-requirements-brief.md      ← Resumo de requisitos
└── 01-ata-mesa-redonda.md       ← Template da reunião

🤖 Product Owner pergunta:
"Mesa Redonda Preparada - Aguardando Aprovação
Resumo: RN-0001, Média complexidade, OAuth Google, Frontend+Backend
Posso prosseguir? [SIM/NAO/REVISAR]"

� Você responde: SIM

🤖 Sistema executa automaticamente o próximo agente...
```

### **📋 2.4: Sequência Completa de Execução**

**Sequência de Execução:** Cada agente faz uma parte específica do trabalho:

| **Agente** | **O que faz** | **Gera** | **Pergunta** |
|------------|---------------|----------|--------------|
| **1️⃣ Product Owner** | Analisa o negócio | Requirements + Context | Posso fazer mesa redonda? |
| **2️⃣ Mesa Redonda** | Alinha tecnicamente | Ata da reunião | Posso analisar requisitos? |
| **3️⃣ Requirements** | Cria cenários BDD | Features de teste | Posso fazer arquitetura? |
| **4️⃣ Arquiteto** | Define solução | ADRs + Diagramas | Posso implementar código? |
| **5️⃣ Desenvolvedor** | Escreve código | Classes + Testes | Posso fazer plano de QA? |
| **6️⃣ Testador** | Plano de testes | Estratégia QA | Finalização automática |
| **7️⃣ PO Final** | Valida tudo | Checklist final | CONCLUÍDO ✅ |

### **🎮 2.5: Controlando o Fluxo**

**Quando cada agente perguntar, você pode responder:**

- **SIM** → Continua automaticamente para o próximo agente
- **NAO** → Para o fluxo para você revisar e ajustar
- **REVISAR** → Mostra os documentos gerados para validação

**Exemplo prático:**
```
🤖 Requirements Analyst: "Posso prosseguir para arquitetura? [SIM/NAO/REVISAR]"

👤 Se você digitar: REVISAR
🤖 Sistema mostra: "Arquivos gerados: 02-requisitos-bdd.md, features/login.feature"

👤 Se você digitar: SIM  
🤖 Sistema executa: Systems Architect automaticamente

👤 Se você digitar: NAO
🤖 Sistema para: Você pode ajustar os requisitos e reiniciar
```

---

## 🤖 **PASSO 3: Processo Automático (AVANÇADO)**

**Processo Automático:** O processo automático usa IA para executar todos os agentes sem intervenção. Ainda está em testes, recomendamos dominar o processo manual primeiro.

### **⚠️ Status: EM DESENVOLVIMENTO**
- ✅ **Processo Manual**: TESTADO e RECOMENDADO
- ⚠️ **Processo CrewAI**: EM PREVIEW (pode não funcionar)
- ⚠️ **Processo AutoGen**: EM PREVIEW (pode não funcionar)

### **🐍 3.1: Configurar Python (se escolheu na instalação)**

```powershell
# Vá para o workspace dos agentes
cd "C:\Projetos\MeuWorkspace\IA"

# Ativar ambiente Python
.\.venv-1\Scripts\Activate.ps1

# Verificar se está funcionando
python --version
```

### **🚀 3.2: Executar CrewAI (EXPERIMENTAL)**

```powershell
# Configurar variáveis
$env:SPRINT = "01"
$env:OUTPUT_ACTIVITY = "rn0001"
$env:USE_CREWAI = "1"

# Executar agentes automáticos
python .\orchestrators\crewai_runner.py 1
```

**⚠️ ATENÇÃO:** Se der erro, use o processo manual que é garantido funcionar.

---

## 💡 **PASSO 4: Exemplo Prático Completo**

**Exemplo Prático:** Aqui está um exemplo completo do início ao fim.

### **🎯 Cenário: Alterar cor de botões de verde para roxo**

**1️⃣ Preparar solicitação:**
```powershell
cd "C:\Projetos\MeuWorkspace\IA"
echo "Preciso trocar a cor dos botões de sucesso de verde para roxo no sistema de vendas" > .\in\sprint01\rn0001\business_request\mudanca_cor.md
```

**2️⃣ Executar Product Owner:**
```
# No VS Code Copilot Chat:
@agents/manual/product-owner.agent.md

RN-0001: Alterar cor botões sucesso verde→roxo
Sprint: 01, Activity: rn0001
Sistema: Sistema Vendas (.NET + React)
```

**3️⃣ O que o PO vai fazer:**
```
🤖 Analisando solicitação...
🤖 Gerando contexto de negócio...
🤖 Criando requirements brief...
🤖 Preparando mesa redonda...

📋 Mesa Redonda Preparada!
Resumo: RN-0001, Baixa complexidade, Mudança visual
Especialistas: Frontend, UX/UI
Posso prosseguir? [SIM/NAO/REVISAR]
```

**4️⃣ Você responde:** SIM

**5️⃣ Sistema continua automaticamente:**
- Mesa Redonda → gera ata da reunião
- Requirements → gera cenários BDD
- Arquiteto → define como alterar CSS
- Desenvolvedor → implementa o código
- Testador → cria planos de teste visual
- PO Final → valida se atende aos critérios

### **📊 Resultado Final:**
```
📁 out/sprint01/rn0001/
├── 00-business-context.md          ← Por que mudar a cor
├── 00-requirements-brief.md        ← O que precisa ser feito  
├── 01-ata-mesa-redonda.md         ← Decisões técnicas
├── 02-requisitos-bdd.md           ← Cenários de teste
├── 03-arquitetura.md              ← Como implementar
├── 04-desenvolvimento.md          ← Código CSS/React
├── 05-qa-plano.md                 ← Como testar
├── 99-checklist-final.md          ← Validação completa ✅
├── features/cor-botoes.feature    ← Testes BDD
├── adrs/adr-001-mudanca-cor.md    ← Decisão arquitetural
└── diagrams/componentes.mmd       ← Diagrama dos componentes
```

---

## 🛠️ **Scripts PowerShell Disponíveis**

**Para Desenvolvedores:** Além do GitHub Copilot, você pode usar scripts PowerShell para automação.

### **📜 Scripts Principais:**

| **Script** | **Para que serve** | **Como usar** |
|------------|-------------------|---------------|
| `setup-workflow.ps1` | Instalar o sistema | `.\Install\setup-workflow.ps1` |
| `start-manual.ps1` | Executar processo manual | `.\powershell\start-manual.ps1 -Sprint 01 -Activity rn0001` |
| `render-diagrams.ps1` | Gerar imagens dos diagramas | `.\powershell\render-diagrams.ps1` |

### **⚡ Execução via PowerShell:**

```powershell
# Processo manual completo
cd "C:\Projetos\MeuWorkspace\IA"
powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\start-manual.ps1 -Sprint 01 -Activity rn0001

# Gerar diagramas em PNG
powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\render-diagrams.ps1
```

**Diferença do PowerShell vs GitHub Copilot:**
- **PowerShell**: Mais automático, menos controle
- **GitHub Copilot**: Mais interativo, controle total de cada etapa

---

---

## ❓ **FAQ - Perguntas Frequentes para Iniciantes**

### **🤔 "Por onde eu começo?"**
1. Execute a instalação: `.\Install\setup-workflow.ps1`
2. Abra VS Code no workspace dos agentes
3. Crie um documento com sua solicitação
4. Execute: `@agents/manual/product-owner.agent.md`

### **🤔 "O que são os 'agentes'?"**
São prompts especializados que simulam pessoas de uma equipe:
- **Product Owner**: Analisa o negócio
- **Arquiteto**: Define a solução técnica
- **Desenvolvedor**: Escreve o código
- **Testador**: Cria estratégias de teste

### **🤔 "Qual a diferença entre processo Manual e Automático?"**
- **Manual**: Você controla cada etapa (RECOMENDADO)
- **Automático**: IA executa tudo sozinha (EM TESTES)

### **🤔 "Onde fico vendo os resultados?"**
Tudo é salvo na pasta `out/sprint01/rn0001/` do seu workspace

### **🤔 "Posso usar para qualquer tipo de projeto?"**
Sim! O sistema detecta automaticamente:
- .NET (C#, ASP.NET Core)
- Node.js (JavaScript, TypeScript)  
- Angular
- React
- Projetos genéricos

### **🤔 "E se eu errar alguma coisa?"**
Sem problema! Você pode:
- Responder "NAO" para parar o fluxo
- Responder "REVISAR" para ver os arquivos gerados
- Executar novamente com parâmetros diferentes

### **🤔 "Preciso saber programar?"**  
Para **usar** o sistema: NÃO
Para **entender** os resultados: Ajuda, mas não é obrigatório
O sistema gera documentação explicativa para cada parte.

---

## 🚨 **Solução de Problemas Comuns**

### **❌ "Erro: GitHub Copilot não encontrado"**
**Solução:** Instale a extensão GitHub Copilot no VS Code e faça login

### **❌ "Erro: PowerShell não permite execução"**
**Solução:** Execute como Administrador:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
```

### **❌ "Erro: Python não encontrado"**  
**Solução:** O instalador deveria instalar automaticamente. Se não funcionou:
```powershell
winget install Python.Python.3.12
```

### **❌ "Agente não responde ou dá erro"**
**Solução:** 
1. Verifique sua conexão com internet
2. Verifique se GitHub Copilot está ativo
3. Tente executar novamente
4. Use o processo PowerShell alternativo

### **❌ "Não sei o que colocar na solicitação"**
**Exemplos simples:**
- "Criar tela de login"
- "Adicionar botão salvar" 
- "Mudar cor do menu"
- "Criar relatório de vendas"

---

## 📚 **Recursos de Aprendizado**

### **📖 Documentação Básica:**
- [Fluxo Completo Detalhado](./docs/fluxo-completo.md) - Aprenda passo a passo
- [Exemplo Product Owner](./docs/exemplo-product-owner.instructions.md) - Veja um exemplo real
- [Prompts de Referência](./prompts-manual/prompts/reference/README.md) - Exemplos práticos

### **🎯 Para Desenvolvedores Experientes:**
- [Personalização de Agentes](./docs/exemplo-instrucoes-personalizada.md) - Adapte para sua empresa
- [Integração GitHub Copilot](./docs/integracao-github-copilot.md) - Configurações avançadas
- [Análise de Projetos](./docs/analise-projeto-existente.md) - Para projetos existentes

---

## 📊 **Estrutura de Arquivos Gerados**

**Referência:** Aqui está o que cada arquivo faz:

### **📁 Pasta `out/sprint01/rn0001/`:**

| **Arquivo** | **O que contém** | **Quem usa** |
|-------------|------------------|--------------|
| `00-business-context.md` | Por que precisamos desta funcionalidade | Product Owner, Gerentes |
| `00-requirements-brief.md` | Resumo do que precisa ser feito | Toda equipe |
| `01-ata-mesa-redonda.md` | Decisões técnicas da reunião | Arquitetos, Devs |
| `02-requisitos-bdd.md` | Cenários de teste em linguagem natural | Testadores, POs |
| `03-arquitetura.md` | Como a solução será implementada | Desenvolvedores |
| `04-desenvolvimento.md` | Código implementado | Desenvolvedores |
| `05-qa-plano.md` | Estratégia de testes | Testadores |
| `99-checklist-final.md` | Validação se tudo está pronto | Product Owner |

### **📁 Subpastas:**

| **Pasta** | **Contém** | **Para que serve** |
|-----------|------------|-------------------|
| `features/` | Arquivos `.feature` (BDD) | Testes automatizados |
| `adrs/` | Decisões arquiteturais | Documentar escolhas técnicas |
| `diagrams/` | Diagramas `.mmd` (Mermaid) | Visualizar a solução |

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

---

## 👤 **Autor e Informações**

**👨‍💻 Proprietário:** Ricardo Macedo Perdigão  
**�‍🏫 Mentora:** Fabiana Rodrigues Martins  
**�📅 Versão:** 2.0.1 - Documentação do sistema  
**📅 Última atualização:** 30 de Setembro de 2025  
**✅ Status:** Produção (processo manual) | ⚠️ Preview (processos automáticos)

### **🆘 Suporte:**
- **Problemas técnicos:** Veja seção [Solução de Problemas](#-solução-de-problemas-comuns)
- **Dúvidas sobre uso:** Consulte [FAQ](#-faq---perguntas-frequentes-para-iniciantes)
- **Documentação adicional:** [docs/README.md](./docs/README.md)

### **🔄 Atualizações Recentes:**
- ✅ **Instalação simplificada** em um comando
- ✅ **Fluxo com aprovações** para controle total
- ✅ **Detecção automática** de projetos existentes
- ✅ **Integração GitHub Copilot** automática
- ✅ **Documentação para iniciantes** completa

---

**🚀 PRONTO PARA COMEÇAR? Execute a instalação e siga o guia de primeiros passos!**

```powershell
# Comando para começar AGORA:
cd "C:\Projetos\EliteRickytech\AgileDevAgent"
.\Install\setup-workflow.ps1
```
