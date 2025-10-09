# Sprint 2 - Issue #6: CLI Unificada (wa)

**Labels:** `enhancement`, `cli`, `sprint-2`, `cross-platform`

## Objetivo

Criar CLI Python multiplataforma unificando todos os comandos do WorkflowAgentsAI.

## Problema Atual

- Scripts PowerShell dispersos em `scripts/powershell/`
- Barreira de entrada para usuários macOS/Linux
- Difícil de distribuir e instalar
- Experiência inconsistente

## Critérios de Aceite

### MVP
- [ ] CLI `wa` instalável via `pipx install workflow-agents`
- [ ] Subcomandos principais:
  - `wa install` - Setup inicial
  - `wa start manual` - Workflow manual interativo
  - `wa start auto` - Workflow automático (CrewAI/AutoGen)
  - `wa new activity` - Criar nova atividade
  - `wa enrich` - Enriquecer agentes com instruções
  - `wa analyze` - Analisar projeto existente
  - `wa validate` - Validar configuração
- [ ] Help claro (`wa --help`, `wa start --help`)
- [ ] Mensagens de erro com sugestões de correção
- [ ] Configuração via arquivo `.wa/config.yml`
- [ ] Cross-platform (Windows, macOS, Linux)

### Avançado
- [ ] `wa config` - Gerenciar configuração
- [ ] `wa agent run <agent-id>` - Executar agente individual
- [ ] `wa status` - Status do workflow atual
- [ ] `wa clean` - Limpar arquivos temporários
- [ ] Progress bars para operações longas
- [ ] Colored output com Rich
- [ ] Logs estruturados

## Implementação Técnica

### Stack

**Framework:** [Typer](https://typer.tiangolo.com/) ou [Click](https://click.palletsprojects.com/)
- Typer: Moderno, type hints, auto-docs
- Click: Maduro, amplamente usado

**UI:** [Rich](https://rich.readthedocs.io/)
- Tabelas, progress bars, syntax highlighting
- Colored output, panels, trees

**Config:** [Pydantic Settings](https://docs.pydantic.dev/latest/concepts/pydantic_settings/)
- Validação de configuração
- Suporte a YAML/JSON/ENV

### Estrutura

```
src/workflow_agents/
├── cli/
│   ├── __init__.py
│   ├── main.py           # Entry point
│   ├── commands/
│   │   ├── __init__.py
│   │   ├── install.py
│   │   ├── start.py
│   │   ├── new.py
│   │   ├── enrich.py
│   │   ├── analyze.py
│   │   └── validate.py
│   ├── utils.py
│   └── config.py
├── pyproject.toml        # Adicionar [project.scripts]
└── ...
```

### Entry Point (pyproject.toml)

```toml
[project.scripts]
wa = "workflow_agents.cli.main:app"
```

### Comando Principal (main.py)

```python
import typer
from rich.console import Console

app = typer.Typer(
    name="wa",
    help="WorkflowAgentsAI - Intelligent Development Agents",
    add_completion=True,
)
console = Console()

@app.command()
def install(
    path: Path = typer.Option(Path.cwd(), "--path", "-p"),
    force: bool = typer.Option(False, "--force", "-f"),
):
    """Setup WorkflowAgentsAI in the current directory."""
    console.print("[bold green]Installing WorkflowAgentsAI...[/]")
    # Implementação
    
@app.command()
def start(
    mode: str = typer.Argument("manual", help="manual or auto"),
    sprint: str = typer.Option(..., "--sprint", "-s"),
    activity: str = typer.Option(..., "--activity", "-a"),
):
    """Start a workflow."""
    if mode == "manual":
        # Workflow manual interativo
        pass
    elif mode == "auto":
        # Workflow automático (CrewAI/AutoGen)
        pass
```

### Comandos Start Manual (Interactive)

```python
from rich.prompt import Prompt, Confirm
from rich.table import Table

def start_manual_interactive():
    console.print("[bold]WorkflowAgentsAI - Manual Workflow[/]\n")
    
    sprint = Prompt.ask("Sprint number", default="01")
    activity = Prompt.ask("Activity name")
    
    # Criar estrutura
    create_activity_structure(sprint, activity)
    
    # Executar agentes sequencialmente
    agents = [
        "Product Owner",
        "Requirements Analyst",
        "Systems Architect",
        # ...
    ]
    
    for agent in agents:
        console.print(f"\n[bold cyan]Running {agent}...[/]")
        # Executar agente
        # Aguardar aprovação
        continue_workflow = Confirm.ask(f"Continue to next agent?")
        if not continue_workflow:
            break
```

### Configuração (.wa/config.yml)

```yaml
version: "1.0"
workspace:
  root: "."
  input_dir: "data/in"
  output_dir: "data/out"
  agents_dir: "agents/manual"

agents:
  timeout: 300
  auto_approve: false

orchestrators:
  default: "manual"
  crewai:
    enabled: false
  autogen:
    enabled: false

ui:
  color: true
  progress_bars: true
```

### Instalação

**Via pipx (recomendado):**
```bash
pipx install workflow-agents
wa --version
```

**Via pip:**
```bash
pip install workflow-agents
```

**Desenvolvimento:**
```bash
pip install -e .
```

## Migração de Scripts PowerShell

### Prioridade Alta
1. `new-activity.ps1` → `wa new activity`
2. `start-manual.ps1` → `wa start manual`
3. `quick-start.ps1` → Menu interativo no `wa start`

### Prioridade Média
4. `setup-workflow.ps1` → `wa install`
5. `manage-parallel-execution.ps1` → `wa status`, `wa manage`

### Manter Compatibilidade
- PowerShell scripts continuam funcionando
- CLI chama PowerShell quando necessário (Windows)
- Documentação clara de ambas as opções

## Testes

```python
# tests/cli/test_main.py
from typer.testing import CliRunner
from workflow_agents.cli.main import app

runner = CliRunner()

def test_install_command():
    result = runner.invoke(app, ["install", "--help"])
    assert result.exit_code == 0
    assert "Setup WorkflowAgentsAI" in result.stdout
```

## Documentação

- [ ] README atualizado com CLI
- [ ] `docs/cli/` - Guia completo da CLI
- [ ] `docs/cli/commands.md` - Referência de comandos
- [ ] `docs/cli/config.md` - Configuração
- [ ] Screencasts de uso

## Distribuição

### PyPI
```bash
python -m build
twine upload dist/*
```

### GitHub Releases
- Binary via PyInstaller (opcional)
- Homebrew formula (macOS)
- Chocolatey package (Windows)

## Métricas de Sucesso

- [ ] >= 80% dos usuários preferem CLI vs PowerShell
- [ ] Redução de 50% em issues "como instalar"
- [ ] Adoção em >= 3 ambientes não-Windows

## Status: 📋 PLANNED FOR SPRINT 2
