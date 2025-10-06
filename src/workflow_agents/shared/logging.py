"""Central logging configuration for the package."""
from __future__ import annotations

import logging
from typing import Optional

_LOGGER_NAME = "workflow_agents"


def get_logger(name: Optional[str] = None) -> logging.Logger:
    logger_name = name or _LOGGER_NAME
    logger = logging.getLogger(logger_name)
    if not logger.handlers:
        handler = logging.StreamHandler()
        formatter = logging.Formatter("[%(levelname)s] %(name)s - %(message)s")
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        logger.setLevel(logging.INFO)
    return logger
