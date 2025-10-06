import os
import sys
from pathlib import Path
from datetime import datetime

AUTOGEN_AVAILABLE = False
LEGACY_AUTOGEN = None
AGENTCHAT = None
CORE = None
try:
    # Prefer legacy 'autogen' if installed (keeps existing code paths)
    import autogen as _legacy
    LEGACY_AUTOGEN = _legacy
    AUTOGEN_AVAILABLE = True
except Exception:
    try:
        # Fallback to new packages autogen-agentchat / autogen-core
        import autogen_agentchat as agentchat  # type: ignore
        import autogen_core as autogen_core  # type: ignore
        AGENTCHAT = agentchat
        CORE = autogen_core
        AUTOGEN_AVAILABLE = True
    except Exception:
        AUTOGEN_AVAILABLE = False

ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "out"

# Skeleton: consome data/out/sprint<sprint>/backlog.md e prepara diretórios para trabalho de engenharia

def ensure_dir(p: Path):
    p.mkdir(parents=True, exist_ok=True)


def write_text(path: Path, content: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def main():
    sprint = os.getenv("SPRINT") or (sys.argv[1] if len(sys.argv) >= 2 else None)
    if not sprint:
        print("Uso: defina SPRINT=<numero> ou passe como argumento: python orchestrators/autogen_dev_team.py <numero_da_sprint>")
        sys.exit(1)

    activity = os.getenv("OUTPUT_ACTIVITY", "").strip()
    run_context = os.getenv("RUN_CONTEXT", "").strip()

    base_dir = OUT_DIR / f"sprint{sprint}"
    sprint_dir = base_dir / activity if activity else base_dir
    backlog = sprint_dir / "backlog.md"

    if not backlog.exists():
        print(f"Backlog não encontrado: {backlog}. Execute o crewai_runner primeiro.")
        sys.exit(2)

    work_dir = sprint_dir / "engineering"
    ensure_dir(work_dir)

    # Preparar pastas para código, testes e relatórios
    ensure_dir(work_dir / "src")
    ensure_dir(work_dir / "tests")
    ensure_dir(work_dir / "reports")

    # Checklist de desenvolvimento (para AutoGen agir)
    checklist = f"""
# Sprint {sprint} - Checklist de Engenharia (AutoGen)

- [ ] Criar branch feature/<ticket>
- [ ] Implementar feature com SOLID/Clean Architecture
- [ ] Escrever testes unitários e integração
- [ ] Coordenar E2E (Cypress) conforme critérios BDD
- [ ] Abrir PR pequeno (trunk-based)
- [ ] Rodar CI, coletar métricas (DORA)
- [ ] Endereçar review automatizado e humano
- [ ] Merge na trunk com flags se necessário

Atualizado em {datetime.utcnow().isoformat()}Z
{f'\nContexto: {run_context}\n' if run_context else ''}
"""
    write_text(work_dir / "CHECKLIST.md", checklist)

    # Opcional: disparar uma sessão simples AutoGen (Dev + Reviewer)
    use_autogen = os.getenv("USE_AUTOGEN", "0") == "1" and os.getenv("ORCHESTRATORS", "1") == "1"
    if use_autogen and AUTOGEN_AVAILABLE:
        session_path = work_dir / "reports" / f"autogen_session_{datetime.utcnow().strftime('%Y%m%dT%H%M%SZ')}.md"
        try:
            with open(backlog, "r", encoding="utf-8") as f:
                backlog_text = f.read()

            if LEGACY_AUTOGEN is not None:
                # Modo legado
                dev = LEGACY_AUTOGEN.AssistantAgent(name="Dev", system_message="Você é um desenvolvedor sênior que implementa com SOLID e Clean Architecture.")
                reviewer = LEGACY_AUTOGEN.AssistantAgent(name="Reviewer", system_message="Você é um revisor de código sênior focado em qualidade e testes.")
                user_proxy = LEGACY_AUTOGEN.UserProxyAgent(name="PO", human_input_mode="NEVER")

                prompt = (
                    "Analise o backlog abaixo, proponha um plano sucinto de implementação (tarefas, testes) "
                    "e gere uma lista de PRs pequenos no estilo trunk-based.\n\n" + backlog_text
                )
                user_proxy.initiate_chat(reviewer, message=prompt)
                reviewer.initiate_chat(dev, message="Valide e refine o plano com foco em testes e pequenos PRs.")
            elif AGENTCHAT is not None and CORE is not None:
                # Modo novo (autogen-agentchat)
                # Observação: esta é uma sessão placeholder apenas para evidenciar o fallback
                plan = (
                    "# Plano de Implementação (rascunho)\n"
                    "- Ler backlog e quebrar em tarefas pequenas\n"
                    "- Definir testes e critérios BDD\n"
                    "- Abrir PRs pequenos (trunk-based)\n"
                )
                write_text(session_path, plan + "\n\n" + backlog_text)
                print("autogen-agentchat fallback: sessão simplificada registrada.")
            else:
                write_text(work_dir / "reports" / "autogen_error.log", "Bibliotecas AutoGen indisponíveis.\n")
                return

            # Log padrão ao final (independente do caminho)
            logs = [
                f"# AutoGen Session — Sprint {sprint}\n",
                f"Início: {datetime.utcnow().isoformat()}Z\n",
                "(Stub simplificado; ajuste para seu provedor/modelo)\n\n",
                "- Reviewer analisou backlog e sugeriu plano.\n",
                "- Dev refinou com foco em testes e PRs pequenos.\n",
            ]
            # Anexa ao arquivo de sessão se já criado
            if session_path.exists():
                with open(session_path, "a", encoding="utf-8") as out:
                    out.write("\n" + "\n".join(logs))
            else:
                write_text(session_path, "\n".join(logs))
        except Exception as e:
            write_text(work_dir / "reports" / "autogen_error.log", f"Erro AutoGen: {e}\n")

    print(f"Ambiente de engenharia preparado em: {work_dir}")


if __name__ == "__main__":
    main()
