# Diretrizes de Evidências e Relatórios

Este guia consolida as regras obrigatórias para preenchimento dos artefatos disponibilizados ao cliente nas pastas `data/out/evidence` e `data/out/report`. O objetivo é garantir trilha de auditoria completa durante a execução do workflow e relatórios executivos 100% preenchidos na conclusão.

---

## Obrigações por agente

Cada agente responsável por uma etapa do workflow deve atualizar o checklist de evidências correspondente **durante** sua execução. A tabela abaixo mostra o mapeamento oficial:

| Agente | Artefato de evidência |
|--------|----------------------|
| Product Owner | `data/out/evidence/product-owner/test-evidence-checklist.md` |
| Roundtable Facilitator | `data/out/evidence/roundtable-facilitator/test-evidence-checklist.md` |
| Requirements Analyst | `data/out/evidence/requirements-analyst/test-evidence-checklist.md` |
| Systems Architect | `data/out/evidence/systems-architect/test-evidence-checklist.md` |
| Testing Specialist | `data/out/evidence/testing-specialist/test-evidence-checklist.md` |
| Expert Developer | `data/out/evidence/expert-developer/test-evidence-checklist.md` |
| Code Reviewer (opcional) | `data/out/evidence/code-reviewer/test-evidence-checklist.md` |
| Testing Validator | `data/out/evidence/testing-validator/test-evidence-checklist.md` |
| Product Owner Final | `data/out/evidence/product-owner-final/test-evidence-checklist.md` |

Regras:
- Preserve a estrutura, emojis e tabelas originais de cada checklist. Apenas substitua o conteúdo placeholder pelos dados da execução.
- Nunca deixe campos vazios, marcadores como `Status: ?`, `[A ser preenchido]` ou textos similares.
- Registre decisões, métricas e links para evidências (tests, commits, relatórios) que comprovem o atendimento aos critérios de aceite.

---

## Relatórios finais

Após o término da validação técnica (`testing-validator.agent.md`):

1. Preencher `data/out/report/area-atividade-Evidencias-Tecnicas.md` com o consolidado técnico (commits, testes, métricas e builds).
2. Preencher `data/out/report/area-atividade-Relatorio.md` com o resumo executivo para stakeholders.

Esses relatórios são entregues ao cliente, portanto precisam manter exatamente a mesma estrutura, títulos e emojis do modelo original.

---

## Validação automática

Use o script abaixo para garantir que todas as evidências e relatórios estejam completos antes de entregar o pacote ao cliente:

```powershell
cd C:\Projetos\WorkflowAgentsAI
.\scripts\powershell\validate-output-package.ps1
```

O script verifica:
- Presença de placeholders (`<AREA>`, `Status: ?`, `[A ser preenchido]`, etc.).
- Campos obrigatórios sem preenchimento após os dois pontos.
- Células vazias nas tabelas dos relatórios.

Caso algum item esteja pendente, o script lista as correções necessárias e encerra com erro, evitando que o pacote seja distribuído incompleto.

---

## Checklist rápido antes da entrega
- [ ] Todos os agentes atualizaram seus respectivos arquivos em `data/out/evidence/**`.
- [ ] `area-atividade-Evidencias-Tecnicas.md` preenchido logo após a validação final.
- [ ] `area-atividade-Relatorio.md` com resumo executivo completo.
- [ ] `validate-output-package.ps1` executado sem apontar pendências.

Seguindo estas diretrizes, o cliente recebe evidências auditáveis em tempo real e relatórios finais consistentes, com o mesmo formato, emojis e estrutura padronizada.
