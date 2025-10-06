"""Common interfaces for application services."""
from __future__ import annotations

from typing import Protocol

from ..core.result import Result


class UseCase(Protocol):
    def execute(self, request):  # type: ignore[override]
        ...

    def __call__(self, request):  # type: ignore[override]
        return self.execute(request)
