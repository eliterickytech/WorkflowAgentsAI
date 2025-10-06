"""Use case responsible for materialising workflow blueprints."""
from __future__ import annotations

from typing import Iterable

from ...core.result import Result
from ...domain.entities import WorkflowActivity
from ...domain.services import build_workflow_blueprint
from ..dtos import WorkflowBlueprintResponse


class BuildWorkflowBlueprint:
    def execute(self, request: dict) -> Result[WorkflowBlueprintResponse]:
        title = str(request.get("title", "")).strip()
        raw_activities: Iterable[dict] = request.get("activities", []) or []
        activities = [
            WorkflowActivity(
                name=str(item.get("name", "")).strip(),
                description=str(item.get("description", "")).strip(),
                expected_outputs=tuple(str(val) for val in item.get("expected_outputs", []) or []),
            )
            for item in raw_activities
        ]
        blueprint = build_workflow_blueprint(title, activities)
        return Result.ok(
            WorkflowBlueprintResponse(
                title=blueprint.title,
                activities=[activity.to_dict() for activity in blueprint.activities],
            )
        )
