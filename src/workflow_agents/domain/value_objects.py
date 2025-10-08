"""Value objects representing immutable concepts."""
from __future__ import annotations

from dataclasses import dataclass
from typing import Tuple

from ..core.validation import require


@dataclass(frozen=True)
class AgentId:
    value: str

    def __post_init__(self) -> None:
        require(bool(self.value.strip()), "Agent id cannot be empty.")


@dataclass(frozen=True)
class ArtifactPath:
    path: str

    def parts(self) -> Tuple[str, ...]:
        return tuple(self.path.split("/"))
