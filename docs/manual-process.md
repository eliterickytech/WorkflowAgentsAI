# Processo Manual

## Pr�f�'�,©-requisitos
- Python 3.10+ (para scripts auxiliares se necess�f�'�,¡rio)
- Ambiente virtual: .\.venv-1\Scripts\Activate.ps1 (recomendado)
- Estrutura de pastas criada via script

## Entrada
- Sprint e Activity
- Anexos (documentos de origem) em: `data/in/sprint<sprint>/<activity>/attachments/`
   - Ex.: `data/in/sprint01/RN0002/attachments/`
   - Tipos comuns: .docx, .xlsx, .txt, .md, .html, .jpg, .png

## Passo a passo
1. Execute `powershell/start-manual.ps1` preenchendo Sprint e Activity
2. O script cria `data/out/sprint<sprint>/<activity>/` com:
   - **00-business-context.md, 00-requirements-brief.md** (Product Owner)
   - 01-ata-mesa-redonda.md, 02-requisitos-bdd.md, 03-arquitetura.md, 04-desenvolvimento.md, 04-frontend-implementation.md, 05-qa-plano.md
   - features/, adrs/, diagrams/, 04-components/, engineering/{src,tests,reports}
3. Crie (se necess�f�'�,¡rio) a pasta `data/in/sprint<sprint>/<activity>/attachments/` e adicione seus arquivos de origem
4. **IN�f�'�,CIO OBRIGAT�f�'â�,��"RIO:** Execute o **Product Owner** primeiro para an�f�'�,¡lise de neg�f�'�,³cio
5. Execute **Mesa Redonda** com todos os agentes (incluindo Frontend) baseado no contexto do PO
6. Siga sequ�f�'�,ªncia: Requirements �f¢â�,� â�,��"� Architecture �f¢â�,� â�,��"� Development + Frontend (paralelo) �f¢â�,� â�,��"� QA
7. Use `src/workflow_agents/assets/references/prompts/*` como guias (ou os agentes em `agents/manual/*.agent.md`)
8. Revise e ajuste os artefatos gerados (00..05, features, adrs, diagrams, components)

## Sa�f�'�,­das
- data/out/sprint<sprint>/<activity>/* conforme conven�f�'�,§�f�'�,£o

## Diagrama
- Veja `docs/diagram/flow-manual.mmd`

- ## Checklist r�f�'�,¡pido
- [ ] Pasta `data/in/sprint<sprint>/<activity>/attachments/` criada com os documentos
- [ ] Rodado `powershell/start-manual.ps1`
- [ ] **Product Owner:** Executado primeiro para an�f�'�,¡lise de neg�f�'�,³cio (00-business-context.md)
- [ ] **Mesa Redonda:** Executado com todos os agentes (incluindo Frontend) baseado no contexto do PO
- [ ] Seguido sequ�f�'�,ªncia: Requirements �f¢â�,� â�,��"� Architecture �f¢â�,� â�,��"� Development + Frontend �f¢â�,� â�,��"� QA
- [ ] Verificado 00..05 + features/adrs/diagrams/components em `data/out/sprint...`
