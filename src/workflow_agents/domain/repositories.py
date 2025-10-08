"""Domain contracts for persistence adapters."""
from __future__ import annotations

from typing import Iterable, Protocol

from .entities import AgentDefinition
from ..core.result import Result


class AgentDefinitionRepository(Protocol):
    """Minimal contract expected by use cases interacting with agent definitions."""

    def list_all(self) -> Iterable[AgentDefinition]:
        ...

    def get_by_id(self, identifier: str) -> Result[AgentDefinition]:
        ...

    def upsert(self, agent: AgentDefinition) -> Result[AgentDefinition]:
        ...
