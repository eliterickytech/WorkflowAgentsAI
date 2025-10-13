# Super Prompt - Flow 02 (PO > Roundtable > Requirements > Architect > Testing Specialist > Expert Developer > Testing Validator > PO Final)

Use este template para execucoes com TDD completo, garantindo que os testes sejam definidos antes do codigo e validados apos a implementacao.

## Contexto
- Regra alvo: [RN-00xx] - [Descricao da regra]
- Sprint: [01]
- Atividade: [rn0001]
- Projeto: [NomeDoProjeto]
- Diretorios de entrada:
  - data/in/sprint[01]/[rn0001]/business_request/
  - data/in/sprint[01]/[rn0001]/attachments/

## Politica de Execucao
- Nao fazer perguntas; registrar no maximo 3 suposicoes justificadas.
- Testing Specialist deve entregar o plano de QA antes do Expert Developer iniciar o codigo.
- Expert Developer deve seguir integralmente o plano de QA e evidenciar cobertura por criterio.
- Testing Validator so libera o PO Final quando todos os cenarios planejados forem executados com sucesso.

## Cadeia de Execucao
1) Product Owner -> gera `00-requirements-brief.md`, `00-business-context.md`, `00-acceptance-criteria.md`. Executar `@agents/manual/product-owner.agent.md`.
2) Mesa Redonda (Roundtable Facilitator) -> gera `01-ata-mesa-redonda.md`. Executar `@agents/manual/roundtable-facilitator.agent.md`.
3) Requirements Analyst -> gera `02-requisitos-bdd.md` e `features/*.feature`. Executar `@agents/manual/requirements-analyst.agent.md`.
4) Systems Architect -> gera `03-arquitetura.md`, `adrs/`, `diagrams/`. Executar `@agents/manual/systems-architect.agent.md`.
5) Testing Specialist -> produz `05-qa-plano.md` e artefatos em `engineering/reports/`, definindo testes antes do desenvolvimento. Executar `@agents/manual/testing-specialist.agent.md`.
6) Expert Developer -> entrega `04-desenvolvimento.md`, `engineering/src/`, `engineering/tests/` alinhados ao plano de QA. Executar `@agents/manual/expert-developer.agent.md`.
7) Testing Validator -> gera `05.1-testing-validation.md` confirmando execucao dos testes planejados. Executar `@agents/manual/testing-validator.agent.md`.
8) Product Owner Final -> consolida `99-checklist-final.md` e decide sobre a entrega. Executar `@agents/manual/product-owner-final.agent.md`.

## Criterios de Qualidade
- Plano de QA aprovado antes da implementacao e referenciado pelo Developer.
- Testing Validator confirma que todos os cenarios previstos foram implementados e executados.
- Rastreabilidade completa dos criterios de aceite nos artefatos `04-desenvolvimento.md`, `05-qa-plano.md` e `05.1-testing-validation.md`.
- Copiar todos os arquivos de `data/out` para o cliente preservando a mesma estrutura durante a instalacao.

## Observacoes
- Caso o Testing Validator reprove algum criterio, retornar para o Expert Developer com os apontamentos antes de reenviar para validacao.
- Reforcar no briefing inicial que trata-se de fluxo TDD e que o cliente recebera todos os prompts preenchidos como parte do pacote de instalacao.
