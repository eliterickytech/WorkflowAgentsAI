"""Application service coordinating workflow assembly."""
from __future__ import annotations

from ...core.result import Result
from ...domain.repositories import AgentDefinitionRepository
from ..dtos import WorkflowBlueprintResponse
from ..use_cases.build_workflow_blueprint import BuildWorkflowBlueprint


class WorkflowBuilderService:
    def __init__(self, repository: AgentDefinitionRepository) -> None:
        self._repository = repository
        self._build_use_case = BuildWorkflowBlueprint()

    def build_from_agents(self, title: str) -> Result[WorkflowBlueprintResponse]:
        agents = list(self._repository.list_all())
        activities = [
            {
                "name": agent.name,
                "description": agent.mission,
                "expected_outputs": [artifact for artifact in agent.artifacts.keys()],
            }
            for agent in agents
        ]
        request = {"title": title, "activities": activities}
        return self._build_use_case.execute(request)
