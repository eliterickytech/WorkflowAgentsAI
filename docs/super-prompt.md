# Super Prompt — O que é, como funciona e como executar

O Super Prompt orquestra a sequência dos papéis (Requirements → Architect → Developer → Testing) em uma execução manual guiada, garantindo padronização de entradas/saídas por sprint/activity.

## O que é
- Uma especificação única que encadeia os agentes e define onde salvar cada artefato.
- Ajuda a reduzir desvios e acelera execuções repetíveis.

## Como funciona
- Define parâmetros SPRINT e ACTIVITY e a convenção de saída `out/sprint<sprint>[/<activity>]/`.
- Mapeia cada etapa a um artefato (01..05, features/, adrs/, diagrams/).
- Usa os prompts dos papéis como base, podendo ser adaptado para o contexto.

## Como executar
1. Defina Sprint e Activity
2. Crie a pasta de entradas (pasta de origem dos documentos):
	 - Caminho: `in/sprint<sprint>/<activity>/attachments/`
	 - Exemplo: `in/sprint01/RN0002/attachments/`
	 - Coloque aqui os arquivos de origem para análise (Word/Excel/Imagens/Textos), por exemplo:
		 - `.docx` (especificações), `.xlsx` (tabelas), `.txt`/`.md` (anotações), `.html` (páginas exportadas)
		 - `.jpg`/`.png` (imagens de fluxos, prints), outros formatos relevantes do contexto
3. Abra `prompts-manual/prompts/super-prompt.md`
4. Preencha os placeholders e execute cada etapa sequencialmente no seu LLM de preferência
5. Garanta que cada entrega seja salva exatamente nos caminhos indicados

## Referência rápida de saídas
- 01-ata-mesa-redonda.md → out/sprint<sprint>[/<activity>]/01-ata-mesa-redonda.md
- 02-requisitos-bdd.md (+ .feature) → out/sprint<sprint>[/<activity>]/02-requisitos-bdd.md; features/
- 03-arquitetura.md (+ ADRs/diagramas) → out/sprint<sprint>[/<activity>]/03-arquitetura.md; adrs/; diagrams/
- 04-desenvolvimento.md → out/sprint<sprint>[/<activity>]/04-desenvolvimento.md
- 05-qa-plano.md → out/sprint<sprint>[/<activity>]/05-qa-plano.md

## Observações práticas (para quem está começando)
- Sempre crie a pasta `in/sprint.../attachments/` antes de iniciar; os agentes consultam esse caminho quando precisam de insumos.
- Se a Activity não for usada, você pode trabalhar apenas com `in/sprint<sprint>/attachments/` e `out/sprint<sprint>/...` (sem a subpasta da Activity).
- Mantenha nomes de arquivos claros e em ASCII para evitar problemas no PowerShell 5.1.
