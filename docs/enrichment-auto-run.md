# Enriquecimento Automático por Etapa

Este documento descreve como acionar o enriquecimento (RAG) automaticamente ao final de cada etapa de agente, sem alterar `prompts.system`.

## Componentes

- `scripts/powershell/enrich-after-step.ps1`: Hook que ingere arquivos recentes no RAG e gera um bundle de pré-visualização para a próxima etapa.
- `agents/manual/expert-developer.enrichment.yaml`: Template por agente para orientar fontes, filtros e forma de injeção (o orquestrador lê este YAML).

## Fluxo sugerido

1) Ao finalizar um agente (ex.: Systems Architect), o orquestrador chama:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/powershell/enrich-after-step.ps1 -AgentId systems-architect -Sprint 01 -Activity 02 -RagEndpoint http://127.0.0.1:8088 -Rerank -TopK 8
```

2) O script:
- Chama `POST /ingest` com `docs`, `agents/manual` e `data/out/sprint{Sprint}/{Activity}`.
- Faz `POST /query` de aquecimento para gerar `_last-<agent>.json` em `data/out/sprint{Sprint}/{Activity}/enrichment/`.

3) Na próxima execução, o orquestrador lê `agents/manual/<agent>.enrichment.yaml`, resolve `{sprint}/{activity}`, busca os trechos com RAG e injeta como mensagem `developer` após o `system`.

## Boas práticas

- Mantenha `prompts.system` imutável; use apenas a injeção via `enrichment`.
- Limite `maxTokens` e use `rerank` para perguntas complexas.
- Use filtros por `role`, `sprint`, `activity` para contexto preciso.
- Registre `_last-*.json` para auditoria e troubleshooting.

## Próximos

- Replicar `<agent>.enrichment.yaml` para os demais agentes.
- Opcional: adicionar variações por sprint/atividade em `data/out/sprint{}/{} /enrichment/*.yaml`.
