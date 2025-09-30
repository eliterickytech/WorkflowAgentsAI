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
- Insumos (documentos de origem) em: `in/sprint<sprint>/<activity>/attachments/`
  - Ex.: `in/sprint01/RN0002/attachments/`
  - Tipos comuns: .docx, .xlsx, .txt, .md, .html, .jpg, .png

## Passo a passo
1. Defina as variáveis de ambiente: SPRINT, OUTPUT_ACTIVITY (opcional), USE_CREWAI=1
2. Execute: `python .\orchestrators\crewai_runner.py <sprint>`
3. O runner:
   - Carrega `agents/manual/*.agent.md`
   - Instancia LLM por agente conforme `model_preferences`
   - Monta tarefas com base em `prompts.task_template`
   - Gera `out/sprint<sprint>[/<activity>]/backlog.md` e `ceremonies.md`
   - Se CrewAI habilitado, executa e grava `outcomes/crewai_report.md`
4. (Opcional) Execute `python .\orchestrators\autogen_dev_team.py <sprint>` para preparar `engineering/`
5. Confira as saídas em `out/sprint<sprint>[/<activity>]/...` e avalie `outcomes/crewai_report.md` (se CrewAI habilitado)

## Saídas
- out/sprint<sprint>[/<activity>]/backlog.md
- out/sprint<sprint>[/<activity>]/ceremonies.md
- out/sprint<sprint>[/<activity>]/outcomes/crewai_report.md (se CrewAI)
- out/sprint<sprint>[/<activity>]/engineering/* (se AutoGen)

## Diagrama
- Veja `docs/diagram/flow-automatic-crewai.mmd`

## Checklist rápido
- [ ] SPRINT, OUTPUT_ACTIVITY e USE_CREWAI=1 definidos
- [ ] Entradas (se houver) em `in/sprint<sprint>/<activity>/attachments/`
- [ ] Executado `orchestrators/crewai_runner.py <sprint>`
- [ ] Conferido `outcomes/crewai_report.md` (se CrewAI)
