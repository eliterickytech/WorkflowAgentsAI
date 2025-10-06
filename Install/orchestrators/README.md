# Orchestrators (CrewAI / AutoGen)

Scripts de automação para coordenação de múltiplos agentes (localizados em `Install/orchestrators/` no repositório):
- `crewai_runner.py`: executa um fluxo leve com base nos YAMLs em `agents/orchestrator/`
- `autogen_dev_team.py`: experimento para orquestração via AutoGen
- `config.py`: configuração comum (provider de LLM, modelos, chaves via .env)

Entrada/saída esperada:
- Inputs: `data/in/sprint<sprint>/<activity>/` (arquivos de contexto)
- Outputs: `data/out/sprint<sprint>/<activity>/` (artefatos padronizados)

Quando usar:
- Para rodar processos automáticos ponta a ponta sem chat manual
- Para gerar esqueleto de backlog/artefatos e medir viabilidade

Atenção:
- Os papéis, cerimônias e artefatos são definidos em `agents/orchestrator/`
- Mantenha estes YAMLs sincronizados com `agents/manual/*.agent.md`
