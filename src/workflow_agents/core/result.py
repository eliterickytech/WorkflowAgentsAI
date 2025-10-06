"""Utility Result type used to signal operation outcomes."""
from __future__ import annotations

from dataclasses import dataclass
from typing import Generic, Optional, TypeVar

T = TypeVar("T")
E = TypeVar("E", bound=Exception)


@dataclass(frozen=True)
class Result(Generic[T]):
    """Represents the outcome of an operation with optional value or error."""

    is_success: bool
    value: Optional[T] = None
    error: Optional[Exception] = None

    @property
    def is_failure(self) -> bool:
        return not self.is_success

    @classmethod
    def ok(cls, value: Optional[T] = None) -> "Result[T]":
        return cls(is_success=True, value=value)

    @classmethod
    def fail(cls, error: Exception) -> "Result[T]":
        return cls(is_success=False, error=error)

    def unwrap(self) -> T:
        if self.is_failure:
            raise self.error if self.error else RuntimeError("Operation failed without error context.")
        return self.value  # type: ignore[return-value]
