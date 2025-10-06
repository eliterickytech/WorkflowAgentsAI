"""Domain entities for workflow orchestration."""
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Dict, Sequence

from ..core.validation import require, require_not_empty
from .value_objects import AgentId, ArtifactPath


@dataclass(frozen=True)
class AgentDefinition:
    identifier: AgentId
    name: str
    mission: str
    responsibilities: Sequence[str]
    artifacts: Dict[str, ArtifactPath] = field(default_factory=dict)
    model_preferences: Sequence[str] = field(default_factory=list)

    def __post_init__(self) -> None:
        require(self.name.strip() != "", "Agent name cannot be empty.")
        require(self.mission.strip() != "", "Agent mission cannot be empty.")
        require_not_empty(self.responsibilities, "Agent responsibilities cannot be empty.")

    def to_dict(self) -> Dict[str, object]:
        return {
            "id": self.identifier.value,
            "name": self.name,
            "mission": self.mission,
            "responsibilities": list(self.responsibilities),
            "artifacts": {key: value.path for key, value in self.artifacts.items()},
            "model_preferences": list(self.model_preferences),
        }

    @classmethod
    def from_dict(cls, payload: Dict[str, object]) -> "AgentDefinition":
        identifier = AgentId(str(payload.get("id", "")).strip())
        name = str(payload.get("name", "")).strip()
        mission = str(payload.get("mission", "")).strip()
        responsibilities = tuple(str(item).strip() for item in payload.get("responsibilities", []) or [])
        artifacts = {
            key: ArtifactPath(str(value))
            for key, value in (payload.get("artifacts") or {}).items()
        }
        model_preferences = tuple(str(item) for item in payload.get("model_preferences", []) or [])
        return cls(identifier, name, mission, responsibilities, artifacts, model_preferences)


@dataclass(frozen=True)
class WorkflowActivity:
    name: str
    description: str
    expected_outputs: Sequence[str]

    def __post_init__(self) -> None:
        require(self.name.strip() != "", "Activity name cannot be empty.")
        require_not_empty(self.expected_outputs, "Activity expected outputs cannot be empty.")

    def to_dict(self) -> Dict[str, object]:
        return {
            "name": self.name,
            "description": self.description,
            "expected_outputs": list(self.expected_outputs),
        }


@dataclass(frozen=True)
class WorkflowBlueprint:
    title: str
    activities: Sequence[WorkflowActivity]

    def __post_init__(self) -> None:
        require(self.title.strip() != "", "Workflow blueprint title cannot be empty.")
        require_not_empty(self.activities, "Workflow blueprint requires at least one activity.")

    def to_dict(self) -> Dict[str, object]:
        return {
            "title": self.title,
            "activities": [activity.to_dict() for activity in self.activities],
        }
