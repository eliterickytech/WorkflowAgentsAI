"""Application data transfer objects."""
from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, Sequence


@dataclass(frozen=True)
class RegisterAgentRequest:
    identifier: str
    name: str
    mission: str
    responsibilities: Sequence[str]
    artifacts: Dict[str, str]
    model_preferences: Sequence[str]


@dataclass(frozen=True)
class WorkflowBlueprintResponse:
    title: str
    activities: Sequence[Dict[str, object]]
