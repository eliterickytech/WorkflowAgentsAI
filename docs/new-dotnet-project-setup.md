# Adotar o workflow neste reposit�f�'�,³rio em um novo projeto .NET (do zero)

Este guia explica, passo a passo e em linguagem simples, como usar este workflow em um projeto .NET novo que voc�f�'�,ª est�f�'�,¡ criando no VS Code. A ideia �f�'�,©: voc�f�'�,ª tem apenas a especifica�f�'�,§�f�'�,£o e as telas do sistema, e quer usar nossos agentes, prompts e scripts para produzir os artefatos de engenharia (requisitos BDD, ADRs, diagramas, etc.).

Se voc�f�'�,ª �f�'�,© desenvolvedor(a) j�f�'�,ºnior, siga na sequ�f�'�,ªncia. Qualquer d�f�'�,ºvida, copie e cole o erro aqui no time e a gente ajuda.

## Duas formas de usar

- Caminho Manual: voc�f�'�,ª copia as pastas necess�f�'�,¡rias, instala os pr�f�'�,©-requisitos por conta pr�f�'�,³pria e roda os scripts conforme este guia.
- Caminho Autom�f�'�,¡tico: voc�f�'�,ª executa um PowerShell que faz tudo sozinho (checa/instala pr�f�'�,©-requisitos, copia pastas, cria `.venv-1`, instala `requirements.txt` e pode enriquecer os agentes).

Para o modo autom�f�'�,¡tico, basta rodar:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
```

## O que voc�f�'�,ª vai copiar para o seu novo projeto

No seu novo reposit�f�'�,³rio .NET, copie (ou adicione como subpasta) os seguintes itens deste reposit�f�'�,³rio:

- Pasta `agents/`
  - Cont�f�'�,©m os arquivos dos agentes com instru�f�'�,§�f�'�,µes e prefer�f�'�,ªncias de modelo por papel (requirements-analyst, systems-architect, etc.).
- Pasta `orchestrators/`
  - Scripts Python que orquestram os agentes (CrewAI e AutoGen) e geram os artefatos.
- Pasta `powershell/`
  - Scripts �f�'�,ºteis para criar estrutura de sprint, ativar venv e renderizar diagramas Mermaid.
- Pasta `src/workflow_agents/assets/references/` (opcional, mas recomendado)
  - Prompts prontos para conduzir o fluxo manual, inclusive o �f¢â�?s¬�.�?oSuper Prompt�f¢â�?s¬�,.
- Pasta `docs/` (opcional, mas recomendado)
  - Guias, exemplos e diagramas Mermaid. Se quiser apenas o essencial, leve pelo menos `docs/diagram/` (os `.mmd`) e use o script de render.
- Arquivos na raiz:
  - `requirements.txt` (depend�f�'�,ªncias Python)
  - `.env.example` (modelo de vari�f�'�,¡veis de ambiente para LLMs)
  - (opcional) `README.md` como refer�f�'�,ªncia

Dica
- N�f�'�?�?TO copie a pasta `.venv-1` (ambiente virtual Python). Crie uma nova no reposit�f�'�,³rio do seu projeto.

## Pr�f�'�,©-requisitos (Windows + VS Code)

- VS Code instalado
  - Extens�f�'�,µes: Python (ms-python.python), Pylance (ms-python.vscode-pylance), PowerShell (ms-vscode.PowerShell)
- .NET SDK (recomendado .NET 8)
- Python 3.10 ou superior
- Node.js LTS (para renderizar diagramas Mermaid em PNG/SVG �f¢â�?s¬â�,��" opcional mas recomendado)
- Git (opcional, mas pr�f�'�,¡tico)

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

## Preparar o seu reposit�f�'�,³rio .NET

1) Crie (ou abra) seu reposit�f�'�,³rio no VS Code
- Ex.: `C:\Projetos\MeuSistema` contendo sua solu�f�'�,§�f�'�,£o .NET (`.sln`) e os projetos (`/src`, `/tests`).

2) Copie as pastas/arquivos indicados
- Copie `agents/`, `orchestrators/`, `powershell/`, `src/workflow_agents/assets/references/` (opcional) e `docs/` (opcional) para a raiz do seu reposit�f�'�,³rio.
- Copie tamb�f�'�,©m `requirements.txt` e `.env.example`.

3) Crie o ambiente Python local (.venv-1) e instale as depend�f�'�,ªncias

```powershell
# Na raiz do seu novo repo (.sln)
python -m venv .venv-1

# Ativar o ambiente virtual
.\.venv-1\Scripts\Activate.ps1

# Confirmar Python ativo (deve apontar para .venv-1)
python --version

# Instalar depend�f�'�,ªncias (aten�f�'�,§�f�'�,£o: N�f�'�?�?TO use "-m python -m pip", use somente pip)
python -m pip install --upgrade pip
python -m pip install -r .\requirements.txt
```

Se aparecer erro de execu�f�'�,§�f�'�,£o de script no PowerShell, use temporariamente:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

4) Configure o arquivo .env

- Duplique `.env.example` e renomeie para `.env`.
- Preencha com seu provedor de LLM:
  - OpenAI: `LLM_PROVIDER=openai`, `OPENAI_API_KEY=...`
  - Azure OpenAI: `LLM_PROVIDER=azure`, `AZURE_OPENAI_ENDPOINT=...`, `AZURE_OPENAI_DEPLOYMENT=...`, `AZURE_OPENAI_API_KEY=...`
  - OpenAI-compatible (ex.: Ollama/LM Studio): `LLM_PROVIDER=openai-compatible`, `OPENAI_BASE_URL=http://localhost:11434/v1`, `OPENAI_API_KEY=dummy`
- Ative integra�f�'�,§�f�'�,µes desejadas (opcional): `USE_CREWAI=1`, `USE_AUTOGEN=1`

5) Verifique extens�f�'�,µes no VS Code

- Pressione Ctrl+Shift+P �f¢â�,� â�,��"� �f¢â�?s¬�.�?oPython: Select Interpreter�f¢â�?s¬�, �f¢â�,� â�,��"� escolha `.venv-1` da pasta do seu repo.

## Primeira execu�f�'�,§�f�'�,£o (duas op�f�'�,§�f�'�,µes)

Voc�f�'�,ª pode usar o instalador (mais r�f�'�,¡pido), come�f�'�,§ar pelo fluxo manual (guiado) ou ir direto para o autom�f�'�,¡tico (CrewAI). Todos usam a mesma estrutura `in/` e `out/`.

### Op�f�'�,§�f�'�,£o 0 �f¢â�?s¬â�,� Usar o instalador

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
```

O instalador ir�f�'�,¡:
- Checar/instalar pr�f�'�,©-requisitos (Python, Node, .NET SDK, Git)
- Perguntar modo (Manual ou CrewAI), Sprint e Activity
- Configurar vari�f�'�,¡veis de ambiente desta sess�f�'�,£o
- Copiar pastas obrigat�f�'�,³rias e opcionais para o caminho do seu projeto
- (Opcional) Criar `.venv-1` e instalar `requirements.txt`
- (Opcional) Enriquecer agentes com arquivos `*.instructions.md|txt`

### Op�f�'�,§�f�'�,£o A �f¢â�?s¬â�,� Fluxo manual (recomendado para come�f�'�,§ar)

1) Crie a estrutura da sprint com nosso script

```powershell
# Ainda na raiz do repo e com .venv-1 ativo
powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\start-manual.ps1 -Sprint 01 -Activity rn0001
```

O script cria pastas e arquivos base em `data/out/sprint01/rn0001/` e tamb�f�'�,©m diret�f�'�,³rios `adrs/` e `diagrams/`. As entradas devem ficar em `data/in/sprint01/rn0001/attachments/` (coloque l�f�'�,¡ sua especifica�f�'�,§�f�'�,£o, imagens de tela, planilhas etc.).

2) Siga o �f¢â�?s¬�.�?oSuper Prompt�f¢â�?s¬�, e os agentes manuais
- Abra `src/workflow_agents/assets/references/prompts/super-prompt.md` e os arquivos em `agents/manual/*.agent.md`.
- Use os prompts para gerar os artefatos (01..05, features, ADRs, diagramas).

3) Renderize diagramas Mermaid (opcional, mas bacana para o time)

```powershell
# Instale o Mermaid CLI uma vez (se ainda n�f�'�,£o tiver)
npm install -g @mermaid-js/mermaid-cli

# Gere PNG/SVG a partir dos .mmd
powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\render-diagrams.ps1
```

As imagens ser�f�'�,£o salvas em `docs/images`.

### Op�f�'�,§�f�'�,£o B �f¢â�?s¬â�,� Fluxo autom�f�'�,¡tico (CrewAI)

1) Defina as vari�f�'�,¡veis de ambiente m�f�'�,­nimas

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

3) (Opcional) Rodar a prepara�f�'�,§�f�'�,£o de engenharia

```powershell
python .\Install\orchestrators\autogen_dev_team.py 1
```

## Onde ficam entradas e sa�f�'�,­das

- Entradas
  - `data/in/sprint<sprint>/<activity>/attachments/`
  - Exemplo: `data/in/sprint01/rn0001/attachments/` (coloque PDF da especifica�f�'�,§�f�'�,£o, imagens PNG/JPG das telas, planilhas XLSX etc.)

- Sa�f�'�,­das
  - `data/out/sprint<sprint>/<activity>/`
  - Voc�f�'�,ª ver�f�'�,¡ arquivos 01..05, pastas `adrs/`, `diagrams/`, `features/`, e (se usar o runner) `outcomes/` e `engineering/`.

## Ajustando para seu projeto .NET

- Os artefatos s�f�'�,£o auxiliares do trabalho de engenharia. Voc�f�'�,ª pode:
  - Copiar/transformar features BDD em testes automatizados do seu projeto.
  - Mover `adrs/` e `diagrams/` para uma pasta de docs do seu reposit�f�'�,³rio.
  - Usar a pasta `engineering/` para apontar para seu c�f�'�,³digo real em `/src` e `/tests`.
- Se quiser um template de solu�f�'�,§�f�'�,£o .NET (Clean Architecture), crie sua estrutura `/src`, `/tests` e integre os artefatos conforme sua conven�f�'�,§�f�'�,£o.

### Como atualizar as instru�f�'�,§�f�'�,µes dos agentes

Edite os arquivos em `agents/manual/*.agent.md`:

- `requirements-analyst.agent.md`: ajuste regras de an�f�'�,¡lise, formato de BDD, anexos esperados.
- `systems-architect.agent.md`: detalhe padr�f�'�,µes arquiteturais, camadas, conven�f�'�,§�f�'�,µes de projeto.
- `expert-developer.agent.md`: inclua padr�f�'�,µes de c�f�'�,³digo, estrutura de pastas, guidelines de testes.
- `testing-specialist.agent.md`: defina estrat�f�'�,©gia de QA, tipos de teste, ferramentas.
- `roundtable-facilitator.agent.md`: personalize a din�f�'�,¢mica das reuni�f�'�,µes e como consolidar atas.

Nos cabe�f�'�,§alhos (front matter YAML) voc�f�'�,ª pode definir:

- `model_preferences`: trocar o modelo/fornecedor por agente (ex.: openai, azure, openai-compatible).
- `inputs.attachments_path`: confirme a pasta de anexos `data/in/sprint<sprint>/<activity>/attachments/`.
- `outputs`: ajuste nomes/locais de sa�f�'�,­da se necess�f�'�,¡rio.

Dica: O instalador tamb�f�'�,©m pode �f¢â�?s¬�.�?oenriquecer�f¢â�?s¬�, os agentes automaticamente adicionando um bloco �f¢â�?s¬�.�?oCustom Instructions (instalador)�f¢â�?s¬�, no final, a partir de arquivos `*.instructions.md|txt` por papel.

## Dicas e solu�f�'�,§�f�'�,£o de problemas (Windows PowerShell)

- Erro ao executar scripts (ExecutionPolicy)
  - Use `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` na sess�f�'�,£o atual.
- Problemas de encoding
  - Prefira nomes de pastas/arquivos com ASCII simples (sem acentos) quando poss�f�'�,­vel.
- Pip n�f�'�,£o encontra o Python certo
  - Confirme se o terminal mostra `(.venv-1)` no prompt. Se n�f�'�,£o, ative com `.\.venv-1\Scripts\Activate.ps1`.
- Falha ao instalar `requirements.txt`
  - Tente atualizar o pip: `python -m pip install --upgrade pip`
  - Certifique-se que est�f�'�,¡ dentro da `.venv-1` antes de rodar o comando.
- Mermaid CLI n�f�'�,£o encontrado
  - Rode `npm install -g @mermaid-js/mermaid-cli` e execute novamente o script de render.

---

Se quiser ver um passo a passo mais detalhado dos fluxos, consulte:
- Processo Manual: `docs/manual-process.md`
- Processo Autom�f�'�,¡tico (CrewAI): `docs/automatic-process.md`
- Super Prompt: `docs/super-prompt.md`
- Integra�f�'�,§�f�'�,£o .NET (vis�f�'�,£o geral): `docs/dotnet-integration.md`
