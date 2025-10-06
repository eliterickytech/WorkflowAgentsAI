"""Runtime helper to coordinate workflow execution."""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Optional

from ..core.result import Result
from ..application.dtos import WorkflowBlueprintResponse
from .pipeline import WorkflowPipeline


@dataclass
class WorkflowRuntime:
    manifest_path: Path
    pipeline: Optional[WorkflowPipeline] = None

    def __post_init__(self) -> None:
        if self.pipeline is None:
            self.pipeline = WorkflowPipeline(self.manifest_path)

    def generate_blueprint(self, title: str) -> Result[WorkflowBlueprintResponse]:
        assert self.pipeline is not None
        return self.pipeline.build(title)
