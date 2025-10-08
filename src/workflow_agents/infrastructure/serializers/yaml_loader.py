"""Simple Markdown front matter loader."""
from __future__ import annotations

import re
from pathlib import Path
from typing import Any, Dict

import yaml

FRONT_MATTER_PATTERN = re.compile(r"^---\n(?P<yaml>.*?)\n---", re.DOTALL)


def load_front_matter(path: Path) -> Dict[str, Any]:
    text = path.read_text(encoding="utf-8")
    match = FRONT_MATTER_PATTERN.search(text)
    if not match:
        return {}
    return yaml.safe_load(match.group("yaml")) or {}
