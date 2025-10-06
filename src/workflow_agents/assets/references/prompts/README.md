# Prompt References

## Como usar
- Informe sempre Sprint (<sprint>) e, se aplicavel, Activity (<activity>).
- Estrutura de saida: `data/out/sprint<sprint>[/<activity>]/`.
- Politica de execucao: nao faca perguntas; assuma ate tres pontos, documente-os e siga com a entrega.

## Integracao com os agentes
Os prompts especializados estao incorporados aos arquivos `agents/manual/*.agent.md` via `model_preferences` e se alinham com as referencias abaixo.

## Biblioteca principal (`reference/`)
- `1-mesa-redonda-rn0002-gpt5.md` – roteiro da mesa redonda.
- `2-requirements-rn0002-gemini.md` – analise BDD orientada a Gemini 2.5.
- `3-architecture-rn0002-gpt5.md` – pasta tecnica para o Systems Architect.
- `4-development-rn0002-claude4.md` – guia de implementacao para Expert Developer.
- `5-testing-rn0002-claude4.md` – checklist de testes para Testing Specialist.
- `README-execucao.md` – resumo rapido para iniciar o workflow manual.

## Super prompt e templates
- `super-prompt.md` – prompt completo com contexto do projeto.
- `template-mesa-redonda-gpt5.md` – modelo condensado para facilitacao rápida.
