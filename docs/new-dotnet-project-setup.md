# Adotar o workflow neste repositório em um novo projeto .NET (do zero)

Este guia explica, passo a passo e em linguagem simples, como usar este workflow em um projeto .NET novo que você está criando no VS Code. A ideia é: você tem apenas a especificação e as telas do sistema, e quer usar nossos agentes, prompts e scripts para produzir os artefatos de engenharia (requisitos BDD, ADRs, diagramas, etc.).

Se você é desenvolvedor(a) júnior, siga na sequência. Qualquer dúvida, copie e cole o erro aqui no time e a gente ajuda.

## Duas formas de usar

- Caminho Manual: você copia as pastas necessárias, instala os pré-requisitos por conta própria e roda os scripts conforme este guia.
- Caminho Automático: você executa um PowerShell que faz tudo sozinho (checa/instala pré-requisitos, copia pastas, cria `.venv-1`, instala `requirements.txt` e pode enriquecer os agentes).

Para o modo automático, basta rodar:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
```

## O que você vai copiar para o seu novo projeto

No seu novo repositório .NET, copie (ou adicione como subpasta) os seguintes itens deste repositório:

- Pasta `agents/`
  - Contém os arquivos dos agentes com instruções e preferências de modelo por papel (requirements-analyst, systems-architect, etc.).
- Pasta `orchestrators/`
  - Scripts Python que orquestram os agentes (CrewAI e AutoGen) e geram os artefatos.
- Pasta `powershell/`
  - Scripts úteis para criar estrutura de sprint, ativar venv e renderizar diagramas Mermaid.
- Pasta `src/workflow_agents/assets/references/` (opcional, mas recomendado)
  - Prompts prontos para conduzir o fluxo manual, inclusive o âÃÂ¢?sÃ‚Â¬.?oSuper PromptâÃÂ¢?sÃ‚Â¬,Ã‚Â.
- Pasta `docs/` (opcional, mas recomendado)
  - Guias, exemplos e diagramas Mermaid. Se quiser apenas o essencial, leve pelo menos `docs/diagram/` (os `.mmd`) e use o script de render.
- Arquivos na raiz:
  - `requirements.txt` (dependências Python)
  - `.env.example` (modelo de variáveis de ambiente para LLMs)
  - (opcional) `README.md` como referência

Dica
- Nf'??TO copie a pasta `.venv-1` (ambiente virtual Python). Crie uma nova no repositório do seu projeto.

## Pré-requisitos (Windows + VS Code)

- VS Code instalado
  - Extensões: Python (ms-python.python), Pylance (ms-python.vscode-pylance), PowerShell (ms-vscode.PowerShell)
- .NET SDK (recomendado .NET 8)
- Python 3.10 ou superior
- Node.js LTS (para renderizar diagramas Mermaid em PNG/SVG âÃÂ¢?sÃ‚Â¬ÃÂ¢," opcional mas recomendado)
- Git (opcional, mas prático)

Como instalar (comandos opcionais usando winget)

```powershell
# .NET SDK 8
winget install Microsoft.DotNet.SDK.8

# Python 3 (instalador oficial via winget)
winget install Python.Python.3.12

# Node.js LTS
winget install OpenJS.NodeJS.LTS

# Git
winget install Git.Git
```

## Preparar o seu repositório .NET

1) Crie (ou abra) seu repositório no VS Code
- Ex.: `C:\Projetos\MeuSistema` contendo sua solução .NET (`.sln`) e os projetos (`/src`, `/tests`).

2) Copie as pastas/arquivos indicados
- Copie `agents/`, `orchestrators/`, `powershell/`, `src/workflow_agents/assets/references/` (opcional) e `docs/` (opcional) para a raiz do seu repositório.
- Copie também `requirements.txt` e `.env.example`.

3) Crie o ambiente Python local (.venv-1) e instale as dependências

```powershell
# Na raiz do seu novo repo (.sln)
python -m venv .venv-1

# Ativar o ambiente virtual
.\.venv-1\Scripts\Activate.ps1

# Confirmar Python ativo (deve apontar para .venv-1)
python --version

# Instalar dependências (atenção: Nf'??TO use "-m python -m pip", use somente pip)
python -m pip install --upgrade pip
python -m pip install -r .\requirements.txt
```

Se aparecer erro de execução de script no PowerShell, use temporariamente:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

4) Configure o arquivo .env

- Duplique `.env.example` e renomeie para `.env`.
- Preencha com seu provedor de LLM:
  - OpenAI: `LLM_PROVIDER=openai`, `OPENAI_API_KEY=...`
  - Azure OpenAI: `LLM_PROVIDER=azure`, `AZURE_OPENAI_ENDPOINT=...`, `AZURE_OPENAI_DEPLOYMENT=...`, `AZURE_OPENAI_API_KEY=...`
  - OpenAI-compatible (ex.: Ollama/LM Studio): `LLM_PROVIDER=openai-compatible`, `OPENAI_BASE_URL=http://localhost:11434/v1`, `OPENAI_API_KEY=dummy`
- Ative integrações desejadas (opcional): `USE_CREWAI=1`, `USE_AUTOGEN=1`

5) Verifique extensões no VS Code

- Pressione Ctrl+Shift+P âÃÂ¢,Ã‚Â ÃÂ¢," âÃÂ¢?sÃ‚Â¬.?oPython: Select InterpreterâÃÂ¢?sÃ‚Â¬,Ã‚Â âÃÂ¢,Ã‚Â ÃÂ¢," escolha `.venv-1` da pasta do seu repo.

## Primeira execução (duas opções)

Você pode usar o instalador (mais rápido), começar pelo fluxo manual (guiado) ou ir direto para o automático (CrewAI). Todos usam a mesma estrutura `in/` e `out/`.

### Opção 0 âÃÂ¢?sÃ‚Â¬ÃÂ¢,Ã‚Â Usar o instalador

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
```

O instalador irá:
- Checar/instalar pré-requisitos (Python, Node, .NET SDK, Git)
- Perguntar modo (Manual ou CrewAI), Sprint e Activity
- Configurar variáveis de ambiente desta sessão
- Copiar pastas obrigatórias e opcionais para o caminho do seu projeto
- (Opcional) Criar `.venv-1` e instalar `requirements.txt`
- (Opcional) Enriquecer agentes com arquivos `*.instructions.md|txt`

### Opção A âÃÂ¢?sÃ‚Â¬ÃÂ¢,Ã‚Â Fluxo manual (recomendado para começar)

1) Crie a estrutura da sprint com nosso script

```powershell
# Ainda na raiz do repo e com .venv-1 ativo
powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\start-manual.ps1 -Sprint 01 -Activity rn0001
```

O script cria pastas e arquivos base em `data/out/sprint01/rn0001/` e também diretórios `adrs/` e `diagrams/`. As entradas devem ficar em `data/in/sprint01/rn0001/attachments/` (coloque lá sua especificação, imagens de tela, planilhas etc.).

2) Siga o âÃÂ¢?sÃ‚Â¬.?oSuper PromptâÃÂ¢?sÃ‚Â¬,Ã‚Â e os agentes manuais
- Abra `src/workflow_agents/assets/references/prompts/super-prompt.md` e os arquivos em `agents/manual/*.agent.md`.
- Use os prompts para gerar os artefatos (01..05, features, ADRs, diagramas).

3) Renderize diagramas Mermaid (opcional, mas bacana para o time)

```powershell
# Instale o Mermaid CLI uma vez (se ainda não tiver)
npm install -g @mermaid-js/mermaid-cli

# Gere PNG/SVG a partir dos .mmd
powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\render-diagrams.ps1
```

As imagens serão salvas em `docs/images`.

### Opção B âÃÂ¢?sÃ‚Â¬ÃÂ¢,Ã‚Â Fluxo automático (CrewAI)

1) Defina as variáveis de ambiente mínimas

```powershell
# Exemplo: usar CrewAI e deixar a Activity opcional
$env:USE_CREWAI = "1"; $env:SPRINT = "01"; $env:OUTPUT_ACTIVITY = "rn0001"
```

2) Rode o orquestrador

```powershell
python .\Install\orchestrators\crewai_runner.py 1
```

Ele vai:
- Ler os agentes em `agents/manual/*.agent.md` (incluindo modelos preferidos por papel)
- Construir tarefas e executar o fluxo
- Escrever artefatos (backlog, ceremonies, outcomes) em `data/out/sprint01/rn0001/`

3) (Opcional) Rodar a preparação de engenharia

```powershell
python .\Install\orchestrators\autogen_dev_team.py 1
```

## Onde ficam entradas e saídas

- Entradas
  - `data/in/sprint<sprint>/<activity>/attachments/`
  - Exemplo: `data/in/sprint01/rn0001/attachments/` (coloque PDF da especificação, imagens PNG/JPG das telas, planilhas XLSX etc.)

- Saídas
  - `data/out/sprint<sprint>/<activity>/`
  - Você verá arquivos 01..05, pastas `adrs/`, `diagrams/`, `features/`, e (se usar o runner) `outcomes/` e `engineering/`.

## Ajustando para seu projeto .NET

- Os artefatos são auxiliares do trabalho de engenharia. Você pode:
  - Copiar/transformar features BDD em testes automatizados do seu projeto.
  - Mover `adrs/` e `diagrams/` para uma pasta de docs do seu repositório.
  - Usar a pasta `engineering/` para apontar para seu código real em `/src` e `/tests`.
- Se quiser um template de solução .NET (Clean Architecture), crie sua estrutura `/src`, `/tests` e integre os artefatos conforme sua convenção.

### Como atualizar as instruções dos agentes

Edite os arquivos em `agents/manual/*.agent.md`:

- `requirements-analyst.agent.md`: ajuste regras de análise, formato de BDD, anexos esperados.
- `systems-architect.agent.md`: detalhe padrões arquiteturais, camadas, convenções de projeto.
- `expert-developer.agent.md`: inclua padrões de código, estrutura de pastas, guidelines de testes.
- `testing-specialist.agent.md`: defina estratégia de QA, tipos de teste, ferramentas.
- `roundtable-facilitator.agent.md`: personalize a dinâmica das reuniões e como consolidar atas.

Nos cabeçalhos (front matter YAML) você pode definir:

- `model_preferences`: trocar o modelo/fornecedor por agente (ex.: openai, azure, openai-compatible).
- `inputs.attachments_path`: confirme a pasta de anexos `data/in/sprint<sprint>/<activity>/attachments/`.
- `outputs`: ajuste nomes/locais de saída se necessário.

Dica: O instalador também pode âÃÂ¢?sÃ‚Â¬.?oenriquecerâÃÂ¢?sÃ‚Â¬,Ã‚Â os agentes automaticamente adicionando um bloco âÃÂ¢?sÃ‚Â¬.?oCustom Instructions (instalador)âÃÂ¢?sÃ‚Â¬,Ã‚Â no final, a partir de arquivos `*.instructions.md|txt` por papel.

## Dicas e solução de problemas (Windows PowerShell)

- Erro ao executar scripts (ExecutionPolicy)
  - Use `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` na sessão atual.
- Problemas de encoding
  - Prefira nomes de pastas/arquivos com ASCII simples (sem acentos) quando possível.
- Pip não encontra o Python certo
  - Confirme se o terminal mostra `(.venv-1)` no prompt. Se não, ative com `.\.venv-1\Scripts\Activate.ps1`.
- Falha ao instalar `requirements.txt`
  - Tente atualizar o pip: `python -m pip install --upgrade pip`
  - Certifique-se que está dentro da `.venv-1` antes de rodar o comando.
- Mermaid CLI não encontrado
  - Rode `npm install -g @mermaid-js/mermaid-cli` e execute novamente o script de render.

---

Se quiser ver um passo a passo mais detalhado dos fluxos, consulte:
- Processo Manual: `docs/manual-process.md`
- Processo Automático (CrewAI): `docs/automatic-process.md`
- Super Prompt: `docs/super-prompt.md`
- Integração .NET (visão geral): `docs/dotnet-integration.md`
