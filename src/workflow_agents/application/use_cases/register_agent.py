"""Use case for registering or updating agent definitions."""
from __future__ import annotations

from dataclasses import asdict

from ...core.result import Result
from ...domain.entities import AgentDefinition
from ...domain.repositories import AgentDefinitionRepository
from ...domain.services import validate_agent_definition
from ..dtos import RegisterAgentRequest


class RegisterAgent:
    def __init__(self, repository: AgentDefinitionRepository) -> None:
        self._repository = repository

    def execute(self, request: RegisterAgentRequest) -> Result[AgentDefinition]:
        agent = AgentDefinition.from_dict(asdict(request))
        validation = validate_agent_definition(agent)
        if validation.is_failure:
            return validation
        return self._repository.upsert(agent)
