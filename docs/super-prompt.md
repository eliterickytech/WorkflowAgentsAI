# Super Prompt �f¢â�?s¬â�,� O que �f�'�,©, como funciona e como executar

O Super Prompt orquestra a sequ�f�'�,ªncia dos pap�f�'�,©is (Requirements �f¢â�,� â�,��"� Architect �f¢â�,� â�,��"� Developer �f¢â�,� â�,��"� Testing) em uma execu�f�'�,§�f�'�,£o manual guiada, garantindo padroniza�f�'�,§�f�'�,£o de entradas/sa�f�'�,­das por sprint/activity.

## O que �f�'�,©
- Uma especifica�f�'�,§�f�'�,£o �f�'�,ºnica que encadeia os agentes e define onde salvar cada artefato.
- Ajuda a reduzir desvios e acelera execu�f�'�,§�f�'�,µes repet�f�'�,­veis.

## Como funciona
- Define par�f�'�,¢metros SPRINT e ACTIVITY e a conven�f�'�,§�f�'�,£o de sa�f�'�,­da `data/out/sprint<sprint>[/<activity>]/`.
- Mapeia cada etapa a um artefato (01..05, features/, adrs/, diagrams/).
- Usa os prompts dos pap�f�'�,©is como base, podendo ser adaptado para o contexto.

## Como executar
1. Defina Sprint e Activity
2. Crie a pasta de entradas (pasta de origem dos documentos):
	 - Caminho: `data/in/sprint<sprint>/<activity>/attachments/`
	 - Exemplo: `data/in/sprint01/RN0002/attachments/`
	 - Coloque aqui os arquivos de origem para an�f�'�,¡lise (Word/Excel/Imagens/Textos), por exemplo:
		 - `.docx` (especifica�f�'�,§�f�'�,µes), `.xlsx` (tabelas), `.txt`/`.md` (anota�f�'�,§�f�'�,µes), `.html` (p�f�'�,¡ginas exportadas)
		 - `.jpg`/`.png` (imagens de fluxos, prints), outros formatos relevantes do contexto
3. Abra `src/workflow_agents/assets/references/prompts/super-prompt.md`
4. Preencha os placeholders e execute cada etapa sequencialmente no seu LLM de prefer�f�'�,ªncia
5. Garanta que cada entrega seja salva exatamente nos caminhos indicados

## Refer�f�'�,ªncia r�f�'�,¡pida de sa�f�'�,­das
- 01-ata-mesa-redonda.md �f¢â�,� â�,��"� data/out/sprint<sprint>[/<activity>]/01-ata-mesa-redonda.md
- 02-requisitos-bdd.md (+ .feature) �f¢â�,� â�,��"� data/out/sprint<sprint>[/<activity>]/02-requisitos-bdd.md; features/
- 03-arquitetura.md (+ ADRs/diagramas) �f¢â�,� â�,��"� data/out/sprint<sprint>[/<activity>]/03-arquitetura.md; adrs/; diagrams/
- 04-desenvolvimento.md �f¢â�,� â�,��"� data/out/sprint<sprint>[/<activity>]/04-desenvolvimento.md
- 05-qa-plano.md �f¢â�,� â�,��"� data/out/sprint<sprint>[/<activity>]/05-qa-plano.md

## Observa�f�'�,§�f�'�,µes pr�f�'�,¡ticas (para quem est�f�'�,¡ come�f�'�,§ando)
- Sempre crie a pasta `data/in/sprint.../attachments/` antes de iniciar; os agentes consultam esse caminho quando precisam de insumos.
- Se a Activity n�f�'�,£o for usada, voc�f�'�,ª pode trabalhar apenas com `data/in/sprint<sprint>/attachments/` e `data/out/sprint<sprint>/...` (sem a subpasta da Activity).
- Mantenha nomes de arquivos claros e em ASCII para evitar problemas no PowerShell 5.1.
