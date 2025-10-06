"""Validation helpers leveraged across layers."""
from __future__ import annotations

from typing import Iterable

from .exceptions import ValidationError


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValidationError(message)


def require_not_empty(values: Iterable[str], message: str) -> None:
    if not any(v.strip() for v in values):
        raise ValidationError(message)
