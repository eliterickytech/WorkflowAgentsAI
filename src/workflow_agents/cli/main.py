"""CLI bootstrap."""
from __future__ import annotations

import argparse
import sys
from typing import Dict

from .commands import COMMANDS


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="workflow-agents")
    subparsers = parser.add_subparsers(dest="command", required=True)

    register_parser = subparsers.add_parser("register-agents", help="Register agents from a JSON file.")
    register_parser.add_argument("--manifest", required=True, help="Path to agents manifest JSON file.")
    register_parser.add_argument("--agents", required=True, help="Path to JSON file with agent definitions.")

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    command = args.command
    handler = COMMANDS.get(command)
    if handler is None:
        parser.error(f"Unknown command: {command}")
    payload: Dict[str, str] = vars(args)
    return handler(payload)


if __name__ == "__main__":
    sys.exit(main())
