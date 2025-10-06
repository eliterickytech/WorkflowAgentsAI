"""Builds orchestration pipelines integrating use cases."""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

from ..application.services.workflow_builder import WorkflowBuilderService
from ..infrastructure.repositories.file_system_agent_repository import FileSystemAgentRepository


@dataclass
class WorkflowPipeline:
    manifest_path: Path

    def build(self, title: str):
        repository = FileSystemAgentRepository(self.manifest_path)
        builder = WorkflowBuilderService(repository)
        return builder.build_from_agents(title)
