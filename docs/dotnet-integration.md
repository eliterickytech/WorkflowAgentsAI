# IntegraÃÂ§ÃÂ£o com um novo projeto .NET

Este guia explica como incorporar este modelo em um projeto .NET existente.

## PrÃÂ©-requisitos
- .NET Framework 4.8 (ou adapte para .NET 8 com equivalentes)
- Python 3.10+ e ambiente virtual `.venv-1`
- Acesso a um provedor LLM (OpenAI/Azure/OpenAI-compatible)

## Estrutura sugerida de pastas (exemplo)
```
/SeuProjeto
  /src
    /Domain
    /Application
    /Infrastructure
    /Api
  /tests
  /docs
  /references-data
  /data/in
  /data/out
  /agents (copiar desta base)
  /orchestrators (copiado de `Install/orchestrators` desta base)
  /src/workflow_agents/assets/references (opcional)
  /prompts (templates BDD/ADR)
```

## Passos
1) Copiar pastas essenciais para o repositÃÂ³rio .NET:
- `agents/`, `orchestrators/` (a partir de `Install/orchestrators/`), `prompts/`, `src/workflow_agents/assets/references/` (se desejar o kit manual)
- `powershell/` (scripts ÃÂºteis; a partir de `scripts/powershell/` no repositÃÂ³rio) e `.env.example`

2) Preparar ambiente Python
- Crie `.venv-1` e instale dependências com o Python da venv
- Configure `.env` com seu provedor LLM

3) Conectar artefatos de saÃÂ­da ao repositÃÂ³rio .NET
- Aponte `engineering/src` e `engineering/tests` para projetos reais (ex.: `src/CalculationEngine` e `tests/CalculationEngine.Tests`)
- Trate `data/out/sprint.../adrs` e `data/out/sprint.../diagrams` como artefatos versionados

4) Fluxo recomendado
- Manual (rÃÂ¡pido para onboarding): `powershell/start-manual.ps1` e Super Prompt
- AutomÃÂ¡tico (padronizaÃÂ§ÃÂ£o): `orchestrators/crewai_runner.py` e, se desejar, `autogen_dev_team.py`

## Dicas
- Use `agents/manual/*.agent.md` para fixar comportamento e modelos por papel
- Mantenha entradas em `data/in/sprint.../attachments` e saÃÂ­das no `data/out/sprint...`
- Ajuste providers/modelos no `.env` ou por agente

## Diagramas
- Veja `docs/diagram/process-detailed.mmd`
