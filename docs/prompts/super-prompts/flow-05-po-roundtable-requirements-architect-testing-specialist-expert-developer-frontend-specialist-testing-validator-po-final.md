# Super Prompt - Flow 05 (PO > Roundtable > Requirements > Architect > Testing Specialist > Expert Developer > Frontend Specialist > Testing Validator > PO Final)

Use este template em entregas completas com TDD, implementacao backend e frontend especializada antes da validacao final.

## Contexto
- Regra alvo: [RN-00xx] - [Descricao da regra]
- Sprint: [01]
- Atividade: [rn0001]
- Projeto: [NomeDoProjeto]
- Diretorios de entrada:
  - data/in/sprint[01]/[rn0001]/business_request/
  - data/in/sprint[01]/[rn0001]/attachments/

## Politica de Execucao
- Nao fazer perguntas; limitar a 3 suposicoes justificadas por etapa.
- Testing Specialist define o plano de QA e skeletons de teste antes de qualquer implementacao.
- Expert Developer deve alinhar contratos e APIs para viabilizar a etapa de frontend.
- Frontend Specialist documenta componentes, guidelines e integra com APIs fornecidas.
- Testing Validator garante que tudo o que foi planejado pelo Testing Specialist foi de fato entregue e testado.

## Cadeia de Execucao
1) Product Owner -> gera `00-requirements-brief.md`, `00-business-context.md`, `00-acceptance-criteria.md`. Executar `@agents/manual/product-owner.agent.md`.
2) Mesa Redonda (Roundtable Facilitator) -> gera `01-ata-mesa-redonda.md`. Executar `@agents/manual/roundtable-facilitator.agent.md`.
3) Requirements Analyst -> gera `02-requisitos-bdd.md` e `features/*.feature`. Executar `@agents/manual/requirements-analyst.agent.md`.
4) Systems Architect -> gera `03-arquitetura.md`, `adrs/`, `diagrams/`. Executar `@agents/manual/systems-architect.agent.md`.
5) Testing Specialist -> produz `05-qa-plano.md` e relatorios preliminares em `engineering/reports/`, definindo testes e cenarios. Executar `@agents/manual/testing-specialist.agent.md`.
6) Expert Developer -> entrega `04-desenvolvimento.md`, `engineering/src/`, `engineering/tests/` alinhados ao plano de QA. Executar `@agents/manual/expert-developer.agent.md`.
7) Frontend Specialist -> produz `04-frontend-implementation.md`, `04-components/`, `04-ui-guidelines.md` conectando com as APIs expostas. Executar `@agents/manual/frontend-specialist.agent.md`.
8) Testing Validator -> gera `05.1-testing-validation.md` confirmando execucao dos testes e cobrindo backend + frontend. Executar `@agents/manual/testing-validator.agent.md`.
9) Product Owner Final -> emite `99-checklist-final.md` concluindo a entrega. Executar `@agents/manual/product-owner-final.agent.md`.

## Criterios de Qualidade
- Plano de QA aprovado e seguido por backend e frontend sem desvios nao registrados.
- Testing Validator confirma que todos os cenarios implementados no frontend estao cobertos por testes.
- Rastreabilidade cruzada entre `04-desenvolvimento.md`, `04-frontend-implementation.md`, `05-qa-plano.md` e `05.1-testing-validation.md`.
- Todos os artefatos devem ser copiados para o ambiente do cliente durante a instalacao mantendo a estrutura original.

## Observacoes
- Caso o Testing Validator identifique falhas, retornar primeiro ao Expert Developer ou Frontend Specialist conforme o item apontado.
- Registrar no `05.1-testing-validation.md` qualquer desvio do plano original para orientar auditorias futuras do cliente.
