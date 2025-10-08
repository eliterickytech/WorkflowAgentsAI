"""Shared exception hierarchy for workflow agents."""


class WorkflowAgentsError(Exception):
    """Base exception for domain specific errors."""


class ValidationError(WorkflowAgentsError):
    """Raised when domain validation fails."""


class RepositoryError(WorkflowAgentsError):
    """Raised when repository operations cannot be completed."""


class ConfigurationError(WorkflowAgentsError):
    """Raised when configuration loading fails."""
