# Super Prompt - Flow 03 (PO > Roundtable > Requirements > Architect > Expert Developer > Code Reviewer > Testing Specialist > PO Final)

Use este template quando ha auditoria de codigo obrigatoria antes da rodada de testes formais.

## Contexto
- Regra alvo: [RN-00xx] - [Descricao da regra]
- Sprint: [01]
- Atividade: [rn0001]
- Projeto: [NomeDoProjeto]
- Diretorios de entrada:
  - data/in/sprint[01]/[rn0001]/business_request/
  - data/in/sprint[01]/[rn0001]/attachments/

## Politica de Execucao
- Nao fazer perguntas; documentar ate 3 suposicoes bem justificadas.
- Expert Developer deve entregar matriz de rastreabilidade por criterio no `04-desenvolvimento.md`.
- Code Reviewer bloqueia andamento ate que todas as pendencias criticas sejam resolvidas.
- Testing Specialist executa testes somente apos receber parecer aprovado do Code Reviewer.

## Cadeia de Execucao
1) Product Owner -> gera `00-requirements-brief.md`, `00-business-context.md`, `00-acceptance-criteria.md`. Executar `@agents/manual/product-owner.agent.md`.
2) Mesa Redonda (Roundtable Facilitator) -> gera `01-ata-mesa-redonda.md`. Executar `@agents/manual/roundtable-facilitator.agent.md`.
3) Requirements Analyst -> gera `02-requisitos-bdd.md` e `features/*.feature`. Executar `@agents/manual/requirements-analyst.agent.md`.
4) Systems Architect -> gera `03-arquitetura.md`, `adrs/`, `diagrams/`. Executar `@agents/manual/systems-architect.agent.md`.
5) Expert Developer -> entrega `04-desenvolvimento.md`, `engineering/src/`, `engineering/tests/`. Executar `@agents/manual/expert-developer.agent.md`.
6) Code Reviewer -> produz `04.1-code-review.md` com parecer independente. Executar `@agents/manual/code-reviewer.agent.md`.
7) Testing Specialist -> gera `05-qa-plano.md` e relatorios em `engineering/reports/`, ajustando cenarios conforme feedback do review. Executar `@agents/manual/testing-specialist.agent.md`.
8) Product Owner Final -> emite `99-checklist-final.md` consolidando aprovacao. Executar `@agents/manual/product-owner-final.agent.md`.

## Criterios de Qualidade
- Code Reviewer avalia cobertura de criterios de aceite e aponta conformidade com padroes internos.
- Nenhum teste e executado antes da aprovacao formal descrita em `04.1-code-review.md`.
- Testing Specialist alinha os cenarios de teste com apontamentos do review para evitar regressao.
- Todos os prompts preenchidos devem ser fornecidos ao cliente na instalacao final.

## Observacoes
- Se o Code Reviewer reprovar algum item, retornar o fluxo ao Expert Developer e repetir as etapas afetadas.
- Registrar no `05-qa-plano.md` quais cenarios foram ajustados devido ao parecer do review para facilitar auditorias futuras.
