"""Application level configuration objects."""
from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path
from typing import Optional

from ..core.exceptions import ConfigurationError
from ..shared.fs import ensure_directory, load_json


@dataclass(frozen=True)
class WorkflowAgentsSettings:
    root_dir: Path
    agents_dir: Path
    references_dir: Path
    manifest_path: Path
    encoding: str = "utf-8"

    @classmethod
    def from_root(cls, root: Path, references_subdir: str = "src/workflow_agents/assets/references") -> "WorkflowAgentsSettings":
        manifest = root / "agents.index.json"
        references_dir = root / references_subdir
        agents_dir = root / "agents" / "manual"
        return cls(
            root_dir=root,
            agents_dir=agents_dir,
            references_dir=references_dir,
            manifest_path=manifest,
        )


def load_settings(root: Optional[Path] = None) -> WorkflowAgentsSettings:
    root_dir = Path(root or os.getenv("WORKFLOW_AGENTS_ROOT", Path.cwd()))
    if not root_dir.exists():
        raise ConfigurationError(f"Root directory not found: {root_dir}")
    settings = WorkflowAgentsSettings.from_root(root_dir)
    ensure_directory(settings.references_dir)
    return settings


def load_manifest(settings: WorkflowAgentsSettings) -> dict:
    payload = load_json(settings.manifest_path)
    if payload is None:
        return {}
    if not isinstance(payload, dict):
        raise ConfigurationError("Manifest content must be a JSON object.")
    return payload
