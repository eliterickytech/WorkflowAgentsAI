#!/usr/bin/env python3
"""
Validate agents.index.json against its schema.
Used in CI and can be run locally.

Usage:
    python scripts/python/validate_agents_index.py
"""
import json
import sys
from pathlib import Path

def validate_agents_index():
    """Validate agents.index.json against agents.schema.json."""
    try:
        from jsonschema import validate, ValidationError
    except ImportError:
        print("❌ Error: jsonschema package not installed")
        print("Install with: pip install jsonschema")
        return 1
    
    root_dir = Path(__file__).parent.parent.parent
    schema_path = root_dir / "agents.schema.json"
    index_path = root_dir / "agents.index.json"
    
    # Check files exist
    if not schema_path.exists():
        print(f"❌ Error: Schema file not found: {schema_path}")
        return 1
    
    if not index_path.exists():
        print(f"❌ Error: Index file not found: {index_path}")
        return 1
    
    # Check for BOM
    with open(index_path, 'rb') as f:
        first_bytes = f.read(3)
        if first_bytes == b'\xef\xbb\xbf':
            print(f"❌ Error: BOM detected in {index_path}")
            print("   File must be UTF-8 without BOM")
            return 1
    
    # Load schema
    try:
        with open(schema_path, 'r', encoding='utf-8') as f:
            schema = json.load(f)
    except json.JSONDecodeError as e:
        print(f"❌ Error: Invalid JSON in schema: {e}")
        return 1
    
    # Load agents index
    try:
        with open(index_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except json.JSONDecodeError as e:
        print(f"❌ Error: Invalid JSON in agents.index.json: {e}")
        print(f"   Line {e.lineno}, Column {e.colno}: {e.msg}")
        return 1
    
    # Validate
    try:
        validate(instance=data, schema=schema)
    except ValidationError as e:
        print(f"❌ Validation error: {e.message}")
        if e.path:
            print(f"   Path: {' > '.join(str(p) for p in e.path)}")
        return 1
    
    # Success
    print("✅ agents.index.json is valid")
    print(f"   ✓ No BOM detected")
    print(f"   ✓ Valid JSON syntax")
    print(f"   ✓ Schema validation passed")
    print(f"   ✓ {len(data.get('agents', []))} agents defined")
    return 0

if __name__ == '__main__':
    sys.exit(validate_agents_index())
