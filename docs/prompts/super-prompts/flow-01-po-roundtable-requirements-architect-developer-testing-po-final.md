# Super Prompt - Flow 01 (PO > Roundtable > Requirements > Architect > Expert Developer > Testing Specialist > PO Final)

Use este template quando a validacao de testes ocorre apos a implementacao principal, com foco em rastreabilidade total.

## Contexto
- Regra alvo: [RN-00xx] - [Descricao da regra]
- Sprint: [01]
- Atividade: [rn0001]
- Projeto: [NomeDoProjeto]
- Diretorios de entrada:
  - data/in/sprint[01]/[rn0001]/business_request/
  - data/in/sprint[01]/[rn0001]/attachments/

## Politica de Execucao
- Nao fazer perguntas; registrar no maximo 3 suposicoes se faltar informacao.
- Manter cada agente focado em seus artefatos oficiais antes de avancar para o proximo passo.
- Salvar todos os arquivos em `data/out/sprint[NN]/[atividade]/` preservando o padrao de nomes.
- Garantir que o Testing Specialist confirme a aderencia aos criterios de aceite apos a entrega do Expert Developer.

## Cadeia de Execucao
1) Product Owner -> gera `00-requirements-brief.md`, `00-business-context.md`, `00-acceptance-criteria.md`. Executar `@agents/manual/product-owner.agent.md`.
2) Mesa Redonda (Roundtable Facilitator) -> gera `01-ata-mesa-redonda.md` consolidando decisoes e riscos. Executar `@agents/manual/roundtable-facilitator.agent.md`.
3) Requirements Analyst -> gera `02-requisitos-bdd.md` e `features/*.feature`. Executar `@agents/manual/requirements-analyst.agent.md`.
4) Systems Architect -> gera `03-arquitetura.md`, `adrs/`, `diagrams/`. Executar `@agents/manual/systems-architect.agent.md`.
5) Expert Developer -> entrega `04-desenvolvimento.md`, `engineering/src/`, `engineering/tests/`. Executar `@agents/manual/expert-developer.agent.md`.
6) Testing Specialist -> produz `05-qa-plano.md` e relatorios em `engineering/reports/`, validando criterios apos o desenvolvimento. Executar `@agents/manual/testing-specialist.agent.md`.
7) Product Owner Final -> consolida `99-checklist-final.md` com parecer final. Executar `@agents/manual/product-owner-final.agent.md`.

## Criterios de Qualidade
- Criterios de aceite rastreados ponta a ponta ate `99-checklist-final.md`.
- Testing Specialist confirma cobertura >= 90% sobre codigo critico e evidencia execucao dos cenarios.
- Nenhum arquivo sobrescreve pastas do cliente fora de `data/out`.
- Toda documentacao referencia a regra `[RN-00xx]` no cabecalho.

## Observacoes
- Se o Testing Specialist identificar gaps, devolver para o Expert Developer antes de acionar o PO Final.
- Durante instalacao no cliente, copiar todos os artefatos gerados para o ambiente destino mantendo a mesma hierarquia.
