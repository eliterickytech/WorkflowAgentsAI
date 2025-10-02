# Documentação

Este diretório reúne os guias e diagramas do projeto.

## 🚀 Comece Aqui
- **FLUXO PRINCIPAL:** [Fluxo Completo: Do Zero à Mesa Redonda](./fluxo-completo.md) ← **LEIA PRIMEIRO**

## Índice rápido
- Processo Automático (CrewAI): ./automatic-process.md
- Processo Manual: ./manual-process.md
- Super Prompt: ./super-prompt.md
- Integração .NET: ./dotnet-integration.md
- Novo projeto .NET (do zero): ./new-dotnet-project-setup.md
	- Instalador PowerShell: ./../Install/setup-workflow.ps1
- **🏢 Workspace Multi-Projeto:** ./workspace-multi-projeto.md ← **NOVO**
- **🎨 Frontend Specialist:** Agente especialista em Angular, React, PO-UI, Material Design
- Atualizar instruções dos agentes: ./updating-agents.md
- Diagramas Mermaid: ./diagram/

## Checklists úteis

### Automático
- [ ] Variáveis definidas: SPRINT, OUTPUT_ACTIVITY (opcional), USE_CREWAI=1
- [ ] Entradas em `in/sprint<sprint>/<activity>/attachments/` (se houver)
- [ ] Rodado `orchestrators/crewai_runner.py`
- [ ] Revisado `outcomes/crewai_report.md`
- [ ] (Opcional) Rodado `orchestrators/autogen_dev_team.py`

### Manual
- [ ] Criada estrutura com `powershell/start-manual.ps1`
- [ ] Entradas em `in/sprint<sprint>/<activity>/attachments/`
- [ ] Seguido `prompts-manual/prompts/super-prompt.md`
- [ ] Verificado 01..05 e pastas features/adrs/diagrams/components

## Dica: renderizando diagramas Mermaid
- Opção 1: Use extensões de VS Code (ex.: Markdown Preview Mermaid Support) ou ferramentas online para visualizar *.mmd.
- Opção 2: Gerar PNG/SVG localmente (recomendado para compartilhar):
	1. Instale Node.js (LTS)
	2. Instale Mermaid CLI: `npm install -g @mermaid-js/mermaid-cli`
	3. Rode o script: `powershell\render-diagrams.ps1`
	4. As imagens serão salvas em `docs/images` (png/svg)
