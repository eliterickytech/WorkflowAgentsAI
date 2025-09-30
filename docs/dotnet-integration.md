# Integração com um novo projeto .NET

Este guia explica como incorporar este modelo em um projeto .NET existente.

## Pré-requisitos
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
  /in
  /out
  /agents (copiar desta base)
  /orchestrators (copiar desta base)
  /prompts-manual (opcional)
  /prompts (templates BDD/ADR)
```

## Passos
1) Copiar pastas essenciais para o repositório .NET:
- `agents/`, `orchestrators/`, `prompts/`, `prompts-manual/` (se desejar o kit manual)
- `powershell/` (scripts uteis) e `.env.example`

2) Preparar ambiente Python
- Crie `.venv-1` e instale dependências com o Python da venv
- Configure `.env` com seu provedor LLM

3) Conectar artefatos de saída ao repositório .NET
- Aponte `engineering/src` e `engineering/tests` para projetos reais (ex.: `src/CalculationEngine` e `tests/CalculationEngine.Tests`)
- Trate `out/sprint.../adrs` e `out/sprint.../diagrams` como artefatos versionados

4) Fluxo recomendado
- Manual (rápido para onboarding): `powershell/start-manual.ps1` e Super Prompt
- Automático (padronização): `orchestrators/crewai_runner.py` e, se desejar, `autogen_dev_team.py`

## Dicas
- Use `agents/manual/*.agent.md` para fixar comportamento e modelos por papel
- Mantenha entradas em `in/sprint.../attachments` e saídas no `out/sprint...`
- Ajuste providers/modelos no `.env` ou por agente

## Diagramas
- Veja `docs/diagram/process-detailed.mmd`
