# Contributing to WorkflowAgentsAI

Thank you for your interest in contributing to WorkflowAgentsAI! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Commit Convention](#commit-convention)
- [Pull Request Process](#pull-request-process)
- [Issue Guidelines](#issue-guidelines)

## Code of Conduct

This project adheres to a Code of Conduct. By participating, you are expected to uphold this code. Please be respectful and constructive in all interactions.

## Getting Started

### Prerequisites

- Windows 10/11 with PowerShell (for full functionality)
- Git
- VS Code with GitHub Copilot (recommended)
- Python 3.10+
- .NET Framework 4.8 or .NET 8+ (for .NET projects)

### Repository Setup

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/WorkflowAgentsAI.git
   cd WorkflowAgentsAI
   ```

3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/eliterickytech/WorkflowAgentsAI.git
   ```

4. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## How to Contribute

### Types of Contributions

We welcome various types of contributions:

- 🐛 **Bug Reports**: Report issues or unexpected behavior
- ✨ **Feature Requests**: Suggest new features or improvements
- 📝 **Documentation**: Improve or fix documentation
- 🔧 **Code**: Fix bugs or implement features
- 🧪 **Tests**: Add or improve test coverage
- 🎨 **Design**: Improve UI/UX or create wireframes
- 🌍 **Translations**: Translate documentation or messages

### Good First Issues

Look for issues labeled `good first issue` for beginner-friendly tasks:
- [Good First Issues](https://github.com/eliterickytech/WorkflowAgentsAI/labels/good%20first%20issue)

## Development Workflow

### 1. Create a Branch

Always create a branch for your work:

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/issue-number-description
```

Branch naming conventions:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Test additions or changes

### 2. Make Your Changes

Follow the [Coding Standards](#coding-standards) below.

### 3. Test Your Changes

- Run existing tests
- Add new tests for new features
- Validate JSON files: `python scripts/python/validate_agents_index.py`
- Check PowerShell scripts: `Invoke-ScriptAnalyzer -Path ./scripts/powershell`

### 4. Commit Your Changes

Follow the [Commit Convention](#commit-convention).

### 5. Push and Create Pull Request

```bash
git push origin your-branch-name
```

Then create a Pull Request on GitHub.

## Coding Standards

### File Encoding Standards

**Critical**: All files must follow proper encoding standards. See [docs/PADRAO-ENCODING-FORMATACAO.md](./docs/PADRAO-ENCODING-FORMATACAO.md) for details.

| File Type | Encoding | BOM | Line Ending | Indent |
|-----------|----------|-----|-------------|--------|
| Markdown (.md) | UTF-8 | ❌ NO | CRLF | 2 spaces |
| PowerShell (.ps1) | UTF-8 | ❌ NO | CRLF | 4 spaces |
| YAML (.yml) | UTF-8 | ❌ NO | LF | 2 spaces |
| JSON (.json) | UTF-8 | ❌ NO | LF | 2 spaces |
| Python (.py) | UTF-8 | ❌ NO | LF | 4 spaces |
| C# (.cs) | UTF-8 | ✅ YES | CRLF | 4 spaces |

### Python Code

- Follow PEP 8
- Use type hints
- Maximum line length: 100 characters
- Use docstrings for functions and classes
- Run `ruff check` before committing

Example:
```python
def validate_agents_index(schema_path: Path, index_path: Path) -> bool:
    """
    Validate agents index file against JSON schema.
    
    Args:
        schema_path: Path to JSON schema file
        index_path: Path to agents index file
        
    Returns:
        True if validation passes, False otherwise
    """
    # Implementation here
    pass
```

### PowerShell Code

- Use PascalCase for functions
- Use approved verbs (Get-, Set-, New-, etc.)
- Include comment-based help
- Run PSScriptAnalyzer before committing

Example:
```powershell
function Get-AgentDefinition {
    <#
    .SYNOPSIS
        Retrieves agent definition from index
    
    .PARAMETER AgentId
        The ID of the agent to retrieve
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$AgentId
    )
    
    # Implementation here
}
```

### Agent Definitions

When creating or modifying agent files:

1. Follow YAML frontmatter structure
2. Include all required fields: id, name, description, playbook, etc.
3. Update agents.index.json
4. Validate with schema: `python scripts/python/validate_agents_index.py`

## Commit Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/) with emoji prefixes:

```
[emoji-code] type: short description

Longer description if needed
```

### Emoji Codes

- `:sparkles:` (✨) - New feature
- `:bug:` (🐛) - Bug fix
- `:memo:` (📝) - Documentation
- `:white_check_mark:` (✅) - Tests
- `:recycle:` (♻️) - Refactoring
- `:wrench:` (🔧) - Configuration
- `:art:` (🎨) - UI/UX improvements
- `:zap:` (⚡) - Performance improvements
- `:lock:` (🔒) - Security fixes
- `:arrow_up:` (⬆️) - Dependencies upgrade

### Examples

```bash
git commit -m ":sparkles: feat: Add validation script for agents.index.json"
git commit -m ":bug: fix: Remove BOM from agents.index.json"
git commit -m ":memo: docs: Update contributing guidelines"
git commit -m ":white_check_mark: test: Add unit tests for validation"
```

## Pull Request Process

### Before Submitting

1. ✅ Ensure all tests pass
2. ✅ Update documentation if needed
3. ✅ Follow encoding standards
4. ✅ Follow commit conventions
5. ✅ Add tests for new features
6. ✅ Run linters (ruff, PSScriptAnalyzer)

### PR Template

When creating a PR, include:

- **Description**: What does this PR do?
- **Related Issue**: Link to related issue (if any)
- **Type of Change**: Bug fix, feature, docs, etc.
- **Checklist**: 
  - [ ] Tests pass
  - [ ] Documentation updated
  - [ ] Follows coding standards
  - [ ] No breaking changes (or documented)

### Review Process

1. At least one maintainer approval required
2. All CI checks must pass
3. No merge conflicts
4. Follows project conventions

## Issue Guidelines

### Creating Issues

Use issue templates when available:
- [Bug Report](.github/ISSUE_TEMPLATE/bug_report.md)
- [Feature Request](.github/ISSUE_TEMPLATE/feature_request.md)
- [Custom](.github/ISSUE_TEMPLATE/custom.md)

### Issue Labels

We use labels to organize issues:
- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Documentation improvements
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed
- `question` - Further information requested
- `wontfix` - This will not be worked on

## Community

### Communication Channels

- **GitHub Discussions**: For questions and general discussions
- **Issues**: For bug reports and feature requests
- **Pull Requests**: For code contributions

### Getting Help

If you need help:
1. Check existing documentation
2. Search closed issues
3. Ask in GitHub Discussions
4. Create a new issue with the `question` label

## Recognition

Contributors are recognized in:
- Release notes
- CHANGELOG.md
- GitHub contributors page

## License

By contributing to WorkflowAgentsAI, you agree that your contributions will be licensed under the Apache License 2.0.

---

Thank you for contributing to WorkflowAgentsAI! 🎉
