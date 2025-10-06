# Super Prompt - Implementação Completa (Template)

Use este template para orquestrar a execução dos agentes com TDD (tests-first). Substitua os placeholders entre colchetes.

## Contexto
- Regra: [RN-00xx] - [Descrição da regra]
- Sprint: [01]
- Activity: [rn0001]
- Projeto: [NomeDoProjeto]
- Entradas:
  - data/in/sprint[01]/[rn0001]/business_request/
  - data/in/sprint[01]/[rn0001]/attachments/

## Política de Execução
- Não faça perguntas; adote até 3 suposições razoáveis se faltar informação.
- Salve cada etapa nos caminhos indicados.
- Siga TDD: Testing Specialist define testes ANTES do Expert Developer implementar.

## Cadeia de Execução (TDD)
1) Product Owner → out/sprint[01]/[rn0001]/00-requirements-brief.md; 00-business-context.md
2) Requirements Analyst → out/sprint[01]/[rn0001]/02-requisitos-bdd.md; features/*
3) Systems Architect → out/sprint[01]/[rn0001]/03-arquitetura.md; adrs/*; diagrams/*
4) Testing Specialist → out/sprint[01]/[rn0001]/05-qa-plano.md (ANTES do código)
5) Expert Developer → out/sprint[01]/[rn0001]/04-desenvolvimento.md (DEPOIS do plano)
6) Testing Validator → out/sprint[01]/[rn0001]/05.1-testing-validation.md

## Critérios de Qualidade
- Cobertura >= 90% do código crítico
- Testes determinísticos e rastreáveis às histórias/FRs
- Conformidade com 05-qa-plano.md e 03-arquitetura.md

## Observações
- UX/UI Specialist (opcional) pode alimentar Testing/Developer com wireframes
- Nunca sobrescrever .github do projeto destino; seguir instruções Copilot (se houver)
