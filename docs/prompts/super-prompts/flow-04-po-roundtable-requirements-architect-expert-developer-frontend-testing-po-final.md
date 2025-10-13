# Super Prompt - Flow 04 (PO > Roundtable > Requirements > Architect > Expert Developer > Frontend Specialist > Testing Specialist > PO Final)

Use este template quando a entrega inclui etapa frontend dedicada apos a implementacao backend.

## Contexto
- Regra alvo: [RN-00xx] - [Descricao da regra]
- Sprint: [01]
- Atividade: [rn0001]
- Projeto: [NomeDoProjeto]
- Diretorios de entrada:
  - data/in/sprint[01]/[rn0001]/business_request/
  - data/in/sprint[01]/[rn0001]/attachments/

## Politica de Execucao
- Nao fazer perguntas; limitar a 3 suposicoes tecnicas registradas.
- Expert Developer prepara contratos de API e camadas de aplicacao que o Frontend Specialist utilizara.
- Frontend Specialist deve documentar estruturas de componentes e guidelines no diretorio `04-components/`.
- Testing Specialist valida integracao fim a fim somente apos receber insumos de backend e frontend.

## Cadeia de Execucao
1) Product Owner -> gera `00-requirements-brief.md`, `00-business-context.md`, `00-acceptance-criteria.md`. Executar `@agents/manual/product-owner.agent.md`.
2) Mesa Redonda (Roundtable Facilitator) -> gera `01-ata-mesa-redonda.md`. Executar `@agents/manual/roundtable-facilitator.agent.md`.
3) Requirements Analyst -> gera `02-requisitos-bdd.md` e `features/*.feature`. Executar `@agents/manual/requirements-analyst.agent.md`.
4) Systems Architect -> gera `03-arquitetura.md`, `adrs/`, `diagrams/`. Executar `@agents/manual/systems-architect.agent.md`.
5) Expert Developer -> entrega `04-desenvolvimento.md`, `engineering/src/`, `engineering/tests/`. Executar `@agents/manual/expert-developer.agent.md`.
6) Frontend Specialist -> produz `04-frontend-implementation.md`, `04-components/` e `04-ui-guidelines.md`. Executar `@agents/manual/frontend-specialist.agent.md`.
7) Testing Specialist -> gera `05-qa-plano.md` e relatorios em `engineering/reports/`, cobrindo cenarios integrados front + back. Executar `@agents/manual/testing-specialist.agent.md`.
8) Product Owner Final -> libera `99-checklist-final.md` confirmando aderencia aos criterios. Executar `@agents/manual/product-owner-final.agent.md`.

## Criterios de Qualidade
- Contratos API e componentes frontend alinhados (referenciar no minimo um contrato por tela critica).
- Testing Specialist cobre cenarios de navegacao, acessibilidade e validacao de regras de negocio.
- Estrutura `04-components/` deve acompanhar README curto descrevendo como importar cada componente.
- Durante instalacao, sincronizar todos os artefatos para o cliente garantindo caminhos relativos identicos.

## Observacoes
- Se o Frontend Specialist depender de ajustes no backend, registrar solicitacoes no `04-desenvolvimento.md` antes de prosseguir.
- Documentar no `05-qa-plano.md` quais testes cobrem fluxo completo cliente-servidor para facilitar auditorias.
