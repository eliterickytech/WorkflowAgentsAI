# Orchestrator agent configs (YAML)

Esta pasta contém definições em YAML usadas por orquestradores automáticos (ex.: CrewAI/AutoGen) para descrever papéis, responsabilidades e o fluxo Scrum de alto nível.

- Fonte da verdade para o conteúdo dos agentes: `agents/manual/*.agent.md`
- Estes YAMLs devem refletir os mesmos papéis e termos utilizados nos agentes manuais.

## Política de sincronização com `agents/manual`

Sempre que alterar um agente manual:
1) Verifique se existe um YAML equivalente aqui (ex.: `po.yaml`, `analista.yaml`, `qa_sr.yaml`).
2) Sincronize os campos: id, name, mission/responsibilities, inputs/outputs, rituals/practices.
3) Garanta que artefatos de saída apontem para `data/out/sprint{sprint}/{activity}/...`.
4) Se adicionar novo papel, crie um YAML correspondente e referencie-o no `scrum_flow.yaml` quando aplicável.

Checklist rápido:
- [ ] IDs consistentes entre manual e YAML
- [ ] Responsabilidades e rituais equivalentes
- [ ] I/O padronizado (data/in -> data/out)
- [ ] Termos de domínio e vocabulário iguais

## Arquivos existentes
- `scrum_flow.yaml`: cerimônias e artefatos padrão do fluxo
- `po.yaml`, `analista.yaml`, `dev_sr_1.yaml`, `dev_sr_2.yaml`, `qa_sr.yaml`: papéis do time

## Quando usar
- Execuções automáticas via `orchestrators/` (CrewAI/AutoGen)
- Geração de esqueleto de pastas/artefatos seguindo nosso padrão `data/out/sprint...`

Para prompts e execução manual, utilize os agentes em `agents/manual/`.
