"""CLI gateway integrating use cases and command parsing."""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Iterable

from ..application.dtos import RegisterAgentRequest
from ..application.use_cases.register_agent import RegisterAgent
from ..core.result import Result
from ..domain.entities import AgentDefinition
from ..infrastructure.repositories.file_system_agent_repository import FileSystemAgentRepository


@dataclass
class CliGateway:
    manifest_path: Path

    def _repository(self) -> FileSystemAgentRepository:
        return FileSystemAgentRepository(self.manifest_path)

    def register_agents(self, agents: Iterable[dict]) -> list[Result[AgentDefinition]]:
        repository = self._repository()
        results: list[Result[AgentDefinition]] = []
        use_case = RegisterAgent(repository)
        for agent_data in agents:
            request = RegisterAgentRequest(
                identifier=str(agent_data["id"]),
                name=str(agent_data["name"]),
                mission=str(agent_data["mission"]),
                responsibilities=list(agent_data.get("responsibilities", [])),
                artifacts=dict(agent_data.get("artifacts", {})),
                model_preferences=list(agent_data.get("model_preferences", [])),
            )
            results.append(use_case.execute(request))
        return results
