# Processo Automático (CrewAI)

## Pré-requisitos
- Python 3.10+
- Ambiente virtual ativado: .\.venv-1\Scripts\Activate.ps1
- Dependências instaladas: .\.venv-1\Scripts\python.exe -m pip install -r .\requirements.txt
- .env configurado (exemplos):
  - LLM_PROVIDER, LLM_MODEL, OPENAI_API_KEY
  - Para Azure: AZURE_OPENAI_ENDPOINT, AZURE_OPENAI_DEPLOYMENT, AZURE_OPENAI_API_KEY
  - Para OpenAI-compatible: OPENAI_BASE_URL, OPENAI_API_KEY (ex.: "ollama")

## Entrada
- Sprint e Activity via variáveis de ambiente: SPRINT, OUTPUT_ACTIVITY
- Insumos (documentos de origem) em: `data/in/sprint<sprint>/<activity>/attachments/`
  - Ex.: `data/in/sprint01/RN0002/attachments/`
  - Tipos comuns: .docx, .xlsx, .txt, .md, .html, .jpg, .png

## Passo a passo
1. Defina as variáveis de ambiente: SPRINT, OUTPUT_ACTIVITY (opcional), USE_CREWAI=1
2. Execute: `python .\Install\orchestrators\crewai_runner.py <sprint>`
3. O runner:
   - Carrega `agents/manual/*.agent.md`
   - Instancia LLM por agente conforme `model_preferences`
   - Monta tarefas com base em `prompts.task_template`
  - Gera `data/out/sprint<sprint>[/<activity>]/backlog.md` e `ceremonies.md`
   - Se CrewAI habilitado, executa e grava `outcomes/crewai_report.md`
4. (Opcional) Execute `python .\Install\orchestrators\autogen_dev_team.py <sprint>` para preparar `engineering/`
5. Confira as saídas em `data/out/sprint<sprint>[/<activity>]/...` e avalie `outcomes/crewai_report.md` (se CrewAI habilitado)

> Importante: o instalador NUNCA copia/overwrite a pasta `.github` deste repositório para o projeto destino. A `.github` do projeto cliente é sempre preservada como fonte da verdade (inclusive `copilot-instructions.md`).

## Saídas
- data/out/sprint<sprint>[/<activity>]/backlog.md
- data/out/sprint<sprint>[/<activity>]/ceremonies.md
- data/out/sprint<sprint>[/<activity>]/outcomes/crewai_report.md (se CrewAI)
- data/out/sprint<sprint>[/<activity>]/engineering/* (se AutoGen)

## Diagrama
- Veja `docs/diagram/flow-automatic-crewai.mmd`

## Checklist rápido
- [ ] SPRINT, OUTPUT_ACTIVITY e USE_CREWAI=1 definidos
- [ ] Entradas (se houver) em `data/in/sprint<sprint>/<activity>/attachments/`
- [ ] Executado `Install/orchestrators/crewai_runner.py <sprint>` (no repositório) ou `orchestrators/crewai_runner.py` (no projeto cliente)
- [ ] Conferido `outcomes/crewai_report.md` (se CrewAI)
