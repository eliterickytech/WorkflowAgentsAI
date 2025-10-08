import os
import sys
import json
from pathlib import Path
from glob import glob
import yaml
from datetime import datetime
from typing import Any, Dict

# Tenta reutilizar a configuração de modelo compartilhada
try:
    from config import get_model_kwargs  # executando a partir da pasta orchestrators/
except Exception:
    def get_model_kwargs():
        import os
        provider = os.getenv("LLM_PROVIDER", "openai")
        model = os.getenv("LLM_MODEL", "gpt-4o-mini")
        if provider == "azure":
            return {
                "provider": "azure",
                "azure_endpoint": os.getenv("AZURE_OPENAI_ENDPOINT", ""),
                "azure_deployment": os.getenv("AZURE_OPENAI_DEPLOYMENT", ""),
                "api_key": os.getenv("AZURE_OPENAI_API_KEY", ""),
                "model": model,
            }
        if provider in ("openai-compatible",) or os.getenv("LOCAL_MODE", "0") == "1":
            return {
                "provider": "openai-compatible",
                "base_url": os.getenv("OPENAI_BASE_URL", os.getenv("OLLAMA_BASE_URL", "http://localhost:11434/v1")),
                "api_key": os.getenv("OPENAI_API_KEY", "ollama"),
                "model": model,
            }
        return {"provider": "openai", "api_key": os.getenv("OPENAI_API_KEY", ""), "model": model}

try:
    # Optional: only used when USE_CREWAI=1 and library is installed
    from crewai import Agent, Task, Crew
    CREW_AVAILABLE = True
except Exception:
    CREW_AVAILABLE = False

# Leve skeleton: lê agentes e scrum_flow, depois materializa artefatos base na pasta data/out/sprint<sprint>

ROOT = Path(__file__).resolve().parents[1]
AGENTES_DIR = ROOT / "agentes"
AGENTS_MANUAL_DIR = ROOT / "agents" / "manual"
PROMPTS_DIR = ROOT / "prompts"
OUT_DIR = ROOT / "out"


def load_yaml(path: Path):
    with open(path, "r", encoding="utf-8") as f:
        return yaml.safe_load(f)


def ensure_dir(p: Path):
    p.mkdir(parents=True, exist_ok=True)


def write_text(path: Path, content: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def render_header(title: str) -> str:
    return f"# {title}\n\nGerado em {datetime.utcnow().isoformat()}Z\n\n"


def parse_front_matter_md(path: Path) -> Dict[str, Any]:
    """Parseia front matter YAML de um arquivo .md e retorna dict; ignora corpo."""
    with open(path, "r", encoding="utf-8") as f:
        txt = f.read()
    if not txt.startswith("---"):
        return {}
    # encontra bloco entre os dois primeiros '---' no início
    parts = txt.split("\n---", 2)
    if len(parts) < 2:
        return {}
    yaml_block = parts[0].lstrip("-").strip() if parts[0].strip() != "---" else parts[1].strip()
    try:
        data = yaml.safe_load(yaml_block)
        return data or {}
    except Exception:
        return {}


def load_manual_agents() -> Dict[str, Dict[str, Any]]:
    """Carrega agentes de agents/manual/*.agent.md (front matter)."""
    result: Dict[str, Dict[str, Any]] = {}
    if not AGENTS_MANUAL_DIR.exists():
        return result
    for fp in glob(str(AGENTS_MANUAL_DIR / "*.agent.md")):
        p = Path(fp)
        data = parse_front_matter_md(p)
        if not data:
            continue
        aid = data.get("id") or p.stem.replace(".agent", "")
        result[aid] = data
    return result


def build_llm_for_agent(agent_cfg: Dict[str, Any]):
    """Constroi uma instância CrewAI LLM para um agente com base em model_preferences + env defaults.
    Retorna None se não conseguir ou se CrewAI não estiver disponível.
    """
    if not CREW_AVAILABLE:
        return None
    try:
        from crewai import LLM  # type: ignore
    except Exception:
        return None

    # Defaults vindos do .env
    mk_env = get_model_kwargs()

    # Preferência do agente
    prefs = agent_cfg.get("model_preferences") or []
    chosen = None
    if isinstance(prefs, list) and prefs:
        # escolhe purpose=default, senão o primeiro
        for p in prefs:
            if isinstance(p, dict) and p.get("purpose", "").lower() == "default":
                chosen = p
                break
        if chosen is None:
            chosen = prefs[0] if isinstance(prefs[0], dict) else None

    provider = (chosen or {}).get("provider", mk_env.get("provider"))
    model = (chosen or {}).get("model", mk_env.get("model"))

    # Monta kwargs do LLM combinando com env (chaves/base_url)
    llm_kwargs: Dict[str, Any] = {"model": model}
    if provider == "openai-compatible":
        base_url = mk_env.get("base_url") or os.getenv("OPENAI_BASE_URL") or os.getenv("OLLAMA_BASE_URL") or "http://localhost:11434/v1"
        api_key = mk_env.get("api_key") or os.getenv("OPENAI_API_KEY") or "ollama"
        llm_kwargs.update({"base_url": base_url, "api_key": api_key})
    elif provider == "azure":
        api_key = os.getenv("AZURE_OPENAI_API_KEY", mk_env.get("api_key", ""))
        azure_endpoint = os.getenv("AZURE_OPENAI_ENDPOINT", mk_env.get("azure_endpoint", ""))
        if api_key:
            llm_kwargs["api_key"] = api_key
        if azure_endpoint:
            llm_kwargs["base_url"] = azure_endpoint
        # deployment pode ser exigido via env pela lib
    else:  # openai
        api_key = os.getenv("OPENAI_API_KEY", mk_env.get("api_key", ""))
        if api_key:
            llm_kwargs["api_key"] = api_key

    try:
        return LLM(**llm_kwargs)
    except Exception:
        return None


def main():
    # SPRINT via env preferencialmente; fallback para argv
    sprint = os.getenv("SPRINT") or (sys.argv[1] if len(sys.argv) >= 2 else None)
    if not sprint:
        print("Uso: defina SPRINT=<numero> ou passe como argumento: python orchestrators/crewai_runner.py <numero_da_sprint>")
        sys.exit(1)

    activity = os.getenv("OUTPUT_ACTIVITY", "").strip()
    run_context = os.getenv("RUN_CONTEXT", "").strip()

    base_dir = OUT_DIR / f"sprint{sprint}"
    sprint_dir = base_dir / activity if activity else base_dir
    ensure_dir(sprint_dir)

    # Carrega definições dos agentes: prioriza agents/manual/*.agent.md; fallback agentes/*.yaml
    agents = load_manual_agents()
    source = "manual"
    if not agents:
        for f in ["po.yaml", "analista.yaml", "dev_sr_1.yaml", "dev_sr_2.yaml", "qa_sr.yaml"]:
            p = AGENTES_DIR / f
            if p.exists():
                data = load_yaml(p)
                agents[data.get("id", p.stem)] = data
        source = "yaml"

    scrum_flow = load_yaml(AGENTES_DIR / "scrum_flow.yaml") if (AGENTES_DIR / "scrum_flow.yaml").exists() else {}

    # Artefatos base: backlog da sprint e checklist de cerimônias
    backlog_md = render_header(f"Sprint {sprint} — Backlog e Itens DoR")
    if run_context:
        backlog_md += f"Contexto: {run_context}\n\n"
    backlog_md += "## Itens (exemplo)\n- [ ] HIST-001 — <Título> — DoR? — Tamanho: M\n- [ ] HIST-002 — <Título> — DoR? — Tamanho: S\n\n"
    backlog_md += "## Critérios de aceite (BDD)\nVer templates em `prompts/templates/feature.feature`.\n\n"
    write_text(sprint_dir / "backlog.md", backlog_md)

    ceremonies_md = render_header(f"Sprint {sprint} — Cerimônias e Gates")
    if run_context:
        ceremonies_md += f"Contexto: {run_context}\n\n"
    if scrum_flow.get("ceremonies"):
        ceremonies_md += "## Cerimônias\n"
        for name, cfg in scrum_flow["ceremonies"].items():
            ceremonies_md += f"### {name}\n"
            ceremonies_md += f"Participantes: {', '.join(cfg.get('participants', []))}\n\n"
            ceremonies_md += f"Entradas: {', '.join(cfg.get('inputs', []))}\n\n"
            ceremonies_md += f"Saídas: {', '.join(cfg.get('outputs', []))}\n\n"
            if cfg.get("gates"):
                ceremonies_md += "Gates:\n" + "\n".join([f"- {g}" for g in cfg["gates"]]) + "\n\n"
    else:
        ceremonies_md += "(Defina `agentes/scrum_flow.yaml` para listar cerimônias.)\n"
    write_text(sprint_dir / "ceremonies.md", ceremonies_md)

    # Opcional: executar um fluxo CrewAI simples
    use_crewai = os.getenv("USE_CREWAI", "0") == "1" and os.getenv("ORCHESTRATORS", "1") == "1"
    if use_crewai and CREW_AVAILABLE:
        outcomes_dir = sprint_dir / "outcomes"
        ensure_dir(outcomes_dir)

        # Tenta configurar LLM do CrewAI com base no provider
        llm_instance = None  # default para quando não houver preferência por agente

        def mk_agent(a: Dict[str, Any]):
            kwargs: Dict[str, Any] = dict(
                role=a.get("name", a.get("id", "Agente")),
                goal=a.get("mission", "Contribuir para a sprint"),
                backstory="\n".join(a.get("responsibilities", []))[:2000],
                verbose=True,
            )
            # Per-agent LLM (se definido via front matter); fallback para env default (llm_instance = None)
            per_llm = build_llm_for_agent(a)
            if per_llm is not None:
                kwargs["llm"] = per_llm
            elif llm_instance is not None:
                kwargs["llm"] = llm_instance
            return Agent(**kwargs)

        # Construir todos agentes carregados
        agent_objs: Dict[str, Any] = {}
        for _k, a in agents.items():
            agent_objs[a.get("id", _k)] = mk_agent(a)

        tasks = []
        # Se houver scrum_flow com cerimônias, cria tasks para PO; além disso, cria tasks específicas por agente manual
        if scrum_flow.get("ceremonies"):
            for name, cfg in scrum_flow.get("ceremonies", {}).items():
                description = f"Cerimônia: {name}. Produzir um breve relatório com Participantes, Entradas, Saídas e Gates, alinhado à sprint {sprint}."
                agent_for_task = next(iter(agent_objs.values()))
                tasks.append(Task(description=description, agent=agent_for_task, expected_output="Relatório em Markdown"))

        # Tarefas por agente manual, respeitando 'prompts.task_template' quando disponível
        for _k, a in agents.items():
            prompts_cfg = a.get("prompts", {}) if isinstance(a, dict) else {}
            task_template = prompts_cfg.get("task_template") if isinstance(prompts_cfg, dict) else None
            name = a.get("name", a.get("id", "Agente"))
            if task_template:
                # Render mínimo substituindo {sprint} e {activity}
                rendered = task_template.replace("{sprint}", sprint).replace("{activity}", activity)
                # Substitui campos artifacts/outputs conhecidos
                for key in ["dev_notes_path", "src_dir", "tests_dir", "attachments_path", "bdd_path", "features_glob",
                            "architecture_path", "adrs_dir", "diagrams_dir", "qa_plan_path", "reports_dir"]:
                    val = (a.get("artifacts", {}) or {}).get(key) or (a.get("outputs", {}) or {}).get(key)
                    if isinstance(val, str):
                        rendered = rendered.replace("{" + key + "}", val.replace("{sprint}", sprint).replace("{activity}", activity))
                description = f"{name}: {rendered}"
            else:
                description = f"{name}: Contribuir com entregáveis específicos da sprint {sprint}."
            agent_for_task = agent_objs.get(a.get("id", _k)) or next(iter(agent_objs.values()))
            tasks.append(Task(description=description, agent=agent_for_task, expected_output="Markdown conciso com caminhos gerados"))

        if tasks:
            crew = Crew(agents=list(agent_objs.values()) or None, tasks=tasks)
            try:
                result = crew.kickoff()
                md = render_header(f"Sprint {sprint} — CrewAI Relatório") + str(result)
                write_text(outcomes_dir / "crewai_report.md", md)
            except Exception as e:
                write_text(outcomes_dir / "crewai_error.log", f"Falha ao rodar CrewAI: {e}\n")

    # ADR e Diagramas: agora sprint-locais; garantir diretórios caso usados
    ensure_dir(sprint_dir / "adrs")
    ensure_dir(sprint_dir / "diagrams")

    # Manifesto simples de contexto
    manifest = {
        "sprint": sprint,
        "agents": list(agents.keys()),
        "agents_source": source,
        "artifacts": [str((sprint_dir / "backlog.md").relative_to(ROOT)), str((sprint_dir / "ceremonies.md").relative_to(ROOT))],
    }
    write_text(sprint_dir / "manifest.json", json.dumps(manifest, indent=2, ensure_ascii=False))

    print(f"Artefatos iniciais criados em: {sprint_dir}")


if __name__ == "__main__":
    main()
