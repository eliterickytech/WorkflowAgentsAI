# Sprint 1 - Issue #4: Cross-Platform Bootstrap Mínimo

**Labels:** `enhancement`, `cross-platform`, `sprint-1`, `sprint-2`

## Objetivo

Criar suporte multiplataforma (macOS/Linux) para comandos principais do WorkflowAgentsAI.

## Problema Atual

- Forte dependência em PowerShell/Windows
- `Install/setup-workflow.ps1` (~75 KB) não funciona em macOS/Linux
- Barreira de adoção para times que usam Unix-like systems

## Critérios de Aceite

### MVP (Sprint 1) - DEFERRED para Sprint 2
- [ ] Script `wa.sh` criado em raiz do projeto
- [ ] Comandos básicos implementados:
  - `wa install` - Setup inicial
  - `wa start` - Iniciar workflow manual
  - `wa validate` - Validar configuração
  - `wa analyze` - Analisar projeto existente
- [ ] Fallback para Python quando possível
- [ ] Mensagens de erro claras quando PowerShell necessário
- [ ] README atualizado com instruções macOS/Linux

### Fase 2 (Sprint 2)
- [ ] CLI Python unificada (Issue #6)
- [ ] Comandos avançados:
  - `wa enrich` - Enriquecer agentes
  - `wa start:auto` - Workflow automático
  - `wa new:activity` - Criar atividade
- [ ] Instalador via `pipx install workflow-agents`
- [ ] Testes no CI Ubuntu

## Implementação Técnica

### wa.sh (POSIX shell)

```bash
#!/bin/bash
# WorkflowAgentsAI - Cross-platform bootstrap

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$1" in
  install)
    echo "🚀 Installing WorkflowAgentsAI..."
    python3 -m pip install -r "$SCRIPT_DIR/requirements.txt"
    ;;
  start)
    echo "📋 Starting manual workflow..."
    # Chamar Python ou mostrar instruções
    ;;
  validate)
    python3 "$SCRIPT_DIR/scripts/python/validate_agents_index.py"
    ;;
  analyze)
    echo "🔍 Analyzing existing project..."
    # Implementar análise
    ;;
  *)
    echo "Usage: wa {install|start|validate|analyze}"
    exit 1
    ;;
esac
```

### Portar Comandos Críticos

**Prioridade Alta:**
1. `new-activity.ps1` → Python
2. `start-manual.ps1` → Python (interactive)
3. Validação de agents.index.json → ✅ Já em Python

**Prioridade Média:**
4. `setup-workflow.ps1` → Python installer
5. `render-diagrams.ps1` → Usar mmdc (mermaid-cli)

**Manter em PowerShell:**
- Scripts específicos do Windows
- Integrações com ferramentas Windows-only

### Documentação

Atualizar:
- `README.md` - Seção "Prerequisites" com macOS/Linux
- `docs/` - Novos guias de instalação multiplataforma
- `CONTRIBUTING.md` - Requisitos para contribuidores Unix

## Alternativa: Python-First

Em vez de `wa.sh`, criar CLI Python:
```bash
pipx install workflow-agents
wa install
wa start --manual
```

**Vantagem:**
- Código único para todas as plataformas
- Melhor manutenibilidade
- Empacotamento padrão Python

**Desvantagem:**
- Mais esforço inicial
- Requer refatoração de lógica PowerShell

## Decisão

**DEFERRED para Sprint 2**: Implementar como parte do Issue #6 (CLI Python unificada) é mais eficiente que criar `wa.sh` intermediário.

## Testes

### Ubuntu CI (já existente)
```yaml
runs-on: ubuntu-latest
```

### Testes Manuais
- [ ] macOS 13+ (Ventura)
- [ ] Ubuntu 22.04 LTS
- [ ] Debian 12
- [ ] WSL2 (Windows Subsystem for Linux)

## Status: ⏭️ DEFERRED TO SPRINT 2 (Issue #6)
