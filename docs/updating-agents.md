# Atualizando as instruções dos agentes (passo a passo)

Este guia ensina duas formas simples de atualizar os agentes:
- Editando os arquivos manualmente (controle total)
- Usando o instalador para enriquecer os agentes automaticamente (mais rápido)

## 1) Atualizar manualmente

Arquivos dos agentes (abra e edite no VS Code):
- `agents/manual/requirements-analyst.agent.md`
- `agents/manual/systems-architect.agent.md`
- `agents/manual/expert-developer.agent.md`
- `agents/manual/testing-specialist.agent.md`
- `agents/manual/roundtable-facilitator.agent.md`

O que mudar:
- Corpo do arquivo (texto): escreva as instruções do papel com a sua realidade (tecnologias, padrões, priorização, exemplos).
- Cabeçalho (YAML front matter):
  - `model_preferences`: escolha o modelo do LLM para este agente (ex.: openai, azure, openai-compatible)
  - `inputs.attachments_path`: mantenha ou ajuste a pasta de anexos (ex.: `data/in/sprint<sprint>/<activity>/attachments/`)
  - `outputs`: ajuste os diretórios/nomes de saída se quiser (ex.: adrs, diagrams, features)

Dica: Faça commit das mudanças para versionar o conhecimento do time.

## 2) Enriquecer automaticamente com o instalador

Quando você tem novos arquivos de instrução (por papel), o instalador pode anexá-los aos agentes.

Passos:
1. Crie uma pasta com arquivos por papel (use estes nomes):
   - `expert-developer.instructions.md` (ou `.txt`)
   - `systems-architect.instructions.md`
   - `requirements-analyst.instructions.md`
   - `testing-specialist.instructions.md`
   - `roundtable-facilitator.instructions.md`
2. Rode o instalador:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
   ```
3. Responda "s" para enriquecer os agentes e informe o caminho da pasta do passo 1.

O que o instalador faz:
- Abre cada arquivo de agente e procura o bloco "### Custom Instructions (instalador)".
- Se existir, substitui o conteúdo (idempotente, não duplica).
- Se não existir, acrescenta o bloco ao final do arquivo.

## Dúvidas comuns

- Posso mudar o modelo de LLM por agente?
  - Sim, edite `model_preferences` no cabeçalho (YAML) de cada `*.agent.md`.
- Onde coloco anexos para os agentes lerem?
  - Em `data/in/sprint<sprint>/<activity>/attachments/`.
- Onde vejo os resultados?
  - Em `data/out/sprint<sprint>/<activity>/` (arquivos 01..05, `adrs/`, `diagrams/`, `features/`, e `outcomes/`/`engineering/` quando usar orquestradores).

Para um guia completo do fluxo, veja:
- Manual: `docs/manual-process.md`
- Automático (CrewAI): `docs/automatic-process.md`
- Novo projeto do zero: `docs/new-dotnet-project-setup.md`
