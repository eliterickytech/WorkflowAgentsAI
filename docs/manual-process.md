# Processo Manual

## Pré-requisitos
- Python 3.10+ (para scripts auxiliares se necessário)
- Ambiente virtual: .\.venv-1\Scripts\Activate.ps1 (recomendado)
- Estrutura de pastas criada via script

## Entrada
- Sprint e Activity
- Anexos (documentos de origem) em: `in/sprint<sprint>/<activity>/attachments/`
   - Ex.: `in/sprint01/RN0002/attachments/`
   - Tipos comuns: .docx, .xlsx, .txt, .md, .html, .jpg, .png

## Passo a passo
1. Execute `powershell/start-manual.ps1` preenchendo Sprint e Activity
2. O script cria `out/sprint<sprint>/<activity>/` com:
   - **00-business-context.md, 00-requirements-brief.md** (Product Owner)
   - 01-ata-mesa-redonda.md, 02-requisitos-bdd.md, 03-arquitetura.md, 04-desenvolvimento.md, 05-qa-plano.md
   - features/, adrs/, diagrams/, engineering/{src,tests,reports}
3. Crie (se necessário) a pasta `in/sprint<sprint>/<activity>/attachments/` e adicione seus arquivos de origem
4. **INÍCIO OBRIGATÓRIO:** Execute o **Product Owner** primeiro para análise de negócio
5. Execute **Mesa Redonda** com todos os agentes baseado no contexto do PO
6. Siga sequência: Requirements → Architecture → Development → QA
7. Use `prompts-manual/prompts/*` como guias (ou os agentes em `agents/manual/*.agent.md`)
8. Revise e ajuste os artefatos gerados (00..05, features, adrs, diagrams)

## Saídas
- out/sprint<sprint>/<activity>/* conforme convenção

## Diagrama
- Veja `docs/diagram/flow-manual.mmd`

## Checklist rápido
- [ ] Pasta `in/sprint<sprint>/<activity>/attachments/` criada com os documentos
- [ ] Rodado `powershell/start-manual.ps1`
- [ ] **Product Owner:** Executado primeiro para análise de negócio (00-business-context.md)
- [ ] **Mesa Redonda:** Executado com todos os agentes baseado no contexto do PO
- [ ] Seguido sequência: Requirements → Architecture → Development → QA
- [ ] Verificado 00..05 + features/adrs/diagrams em `out/sprint...`
