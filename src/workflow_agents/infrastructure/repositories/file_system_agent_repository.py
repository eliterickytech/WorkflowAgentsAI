"""File system backed repository for agent definitions."""
from __future__ import annotations

import json
from pathlib import Path
from typing import Iterable, List

from ...core.exceptions import RepositoryError
from ...core.result import Result
from ...domain.entities import AgentDefinition
from ...domain.repositories import AgentDefinitionRepository
from ...shared.fs import ensure_directory
from ...shared.logging import get_logger

LOGGER = get_logger(__name__)


class FileSystemAgentRepository(AgentDefinitionRepository):
    def __init__(self, manifest_path: Path, encoding: str = "utf-8") -> None:
        self._manifest_path = manifest_path
        self._encoding = encoding

    def list_all(self) -> Iterable[AgentDefinition]:
        data = self._load_manifest()
        return [AgentDefinition.from_dict(item) for item in data]

    def get_by_id(self, identifier: str) -> Result[AgentDefinition]:
        for agent in self.list_all():
            if agent.identifier.value == identifier:
                return Result.ok(agent)
        return Result.fail(RepositoryError(f"Agent not found: {identifier}"))

    def upsert(self, agent: AgentDefinition) -> Result[AgentDefinition]:
        payload = list(self._load_manifest())
        updated: List[dict] = []
        replaced = False
        for item in payload:
            if str(item.get("id")) == agent.identifier.value:
                updated.append(agent.to_dict())
                replaced = True
            else:
                updated.append(item)
        if not replaced:
            updated.append(agent.to_dict())
        self._write_manifest(updated)
        LOGGER.info("Persisted agent %s", agent.identifier.value)
        return Result.ok(agent)

    def _load_manifest(self) -> List[dict]:
        if not self._manifest_path.exists():
            return []
        with self._manifest_path.open("r", encoding=self._encoding) as handle:
            try:
                data = json.load(handle)
            except json.JSONDecodeError as error:
                raise RepositoryError(f"Cannot parse manifest: {error}") from error
        if not isinstance(data, list):
            raise RepositoryError("Agent manifest must be a JSON array.")
        return data

    def _write_manifest(self, payload: List[dict]) -> None:
        ensure_directory(self._manifest_path.parent)
        with self._manifest_path.open("w", encoding=self._encoding) as handle:
            json.dump(payload, handle, indent=2, ensure_ascii=False)
