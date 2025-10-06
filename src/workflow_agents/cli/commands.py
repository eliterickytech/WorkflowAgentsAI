"""CLI command registration."""
from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Callable, Dict

from ..interfaces.cli_gateway import CliGateway

CommandHandler = Callable[[Dict[str, Any]], int]


def register_agent_command(payload: Dict[str, Any]) -> int:
    manifest = Path(payload["manifest"])
    agents_path = Path(payload["agents"])
    agents_data = json.loads(agents_path.read_text(encoding="utf-8"))
    gateway = CliGateway(manifest)
    results = gateway.register_agents(agents_data)
    failures = [result for result in results if result.is_failure]
    if failures:
        for failure in failures:
            err = failure.error
            if err:
                print(f"Error: {err}")
        return 1
    return 0


COMMANDS: Dict[str, CommandHandler] = {
    "register-agents": register_agent_command,
}
