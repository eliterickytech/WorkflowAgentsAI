# Documentação

Este diretório reúne os guias e diagramas do projeto.

## 🚦 Comece aqui
- Fluxo principal: [Fluxo Completo: Do Zero à Mesa Redonda](./fluxo-completo.md) — LEIA PRIMEIRO
- Exemplos práticos: [Pasta Examples – Exemplos reais dos 10 agentes](./examples/) — templates prontos
- Paralelização: [Guia de Execução Paralela](./guia-paralelizacao.md) — múltiplas atividades simultâneas
- Agentes individuais: [Guia Completo Agentes Individuais](./guia-agentes-individuais.md) — usar agentes separadamente
- Referência rápida: [Guia de Referência Rápida](./guia-referencia-rapida-agentes.md) — prompts dos 10 agentes
- Design & Wireframes: [Guia Design e Wireframes](./guia-design-wireframes.md) — ferramentas visuais
- Novo TDD: [Exemplo Fluxo TDD Completo](./examples/exemplo-fluxo-tdd-completo.md) — com Testing Validator

## Índice rápido
- Processo Automático (CrewAI): ./automatic-process.md
- Processo Manual: ./manual-process.md
- Super Prompt: ./super-prompt.md
- Integração .NET: ./dotnet-integration.md
- Novo projeto .NET (do zero): ./new-dotnet-project-setup.md
  - Instalador PowerShell: ./../Install/setup-workflow.ps1
- Workspace Multi-Projeto: ./workspace-multi-projeto.md — NOVO
- Frontend Specialist: Agente especialista em Angular, React, PO-UI, Material Design
- Atualizar instruções dos agentes: ./updating-agents.md
- Diagramas Mermaid: ./diagram/

## Checklists úteis

### Automático
- [ ] Variáveis definidas: SPRINT, OUTPUT_ACTIVITY (opcional), USE_CREWAI=1
- [ ] Entradas em `data/in/sprint<sprint>/<activity>/attachments/` (se houver)
- [ ] Rodado `Install/orchestrators/crewai_runner.py`
- [ ] Revisado `outcomes/crewai_report.md`
- [ ] (Opcional) Rodado `Install/orchestrators/autogen_dev_team.py`

### Manual
- [ ] Criada estrutura com `powershell/start-manual.ps1`
- [ ] Entradas em `data/in/sprint<sprint>/<activity>/attachments/`
- [ ] Seguido `src/workflow_agents/assets/references/prompts/super-prompt.md`
- [ ] Verificado 01..05 e pastas features/adrs/diagrams/components

## Dica: renderizando diagramas Mermaid
- Opção 1: use extensões do VS Code (ex.: Markdown Preview Mermaid Support) ou ferramentas online para visualizar arquivos .mmd.
- Opção 2: gerar PNG/SVG localmente (recomendado para compartilhar):
  1. Instale Node.js (LTS)
  2. Instale Mermaid CLI: `npm install -g @mermaid-js/mermaid-cli`
  3. Rode o script: `powershell\render-diagrams.ps1`
  4. As imagens serão salvas em `docs/images` (png/svg)
