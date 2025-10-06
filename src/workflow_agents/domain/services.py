"""Domain services operating on entities."""
from __future__ import annotations

from typing import Sequence

from ..core.result import Result
from ..core.validation import require
from ..core.exceptions import ValidationError
from .entities import AgentDefinition, WorkflowActivity, WorkflowBlueprint


def validate_agent_definition(agent: AgentDefinition) -> Result[AgentDefinition]:
    try:
        require(agent.identifier.value.isidentifier(), "Agent id must be a valid identifier.")
        require(len(agent.responsibilities) <= 10, "Agent must not declare more than 10 responsibilities.")
    except ValidationError as error:
        return Result.fail(error)
    return Result.ok(agent)


def build_workflow_blueprint(title: str, activities: Sequence[WorkflowActivity]) -> WorkflowBlueprint:
    return WorkflowBlueprint(title=title, activities=tuple(activities))
