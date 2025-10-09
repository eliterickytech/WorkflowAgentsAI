# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- JSON Schema validation for agents.index.json ([agents.schema.json](agents.schema.json))
- Python validation script ([scripts/python/validate_agents_index.py](scripts/python/validate_agents_index.py))
- Comprehensive CI/CD pipeline with GitHub Actions
  - JSON validation job
  - PowerShell analysis with PSScriptAnalyzer
  - Python linting with Ruff
  - Cross-platform Python tests (Ubuntu/Windows, Python 3.10-3.12)
  - Documentation link checking
  - Encoding standards validation (BOM detection)
- Security infrastructure
  - Dependabot configuration for GitHub Actions and Python dependencies
  - CodeQL analysis for Python code
  - Security policy (SECURITY.md)
- Governance documentation
  - Apache License 2.0 (LICENSE)
  - Contributing guidelines (CONTRIBUTING.md)
  - This changelog (CHANGELOG.md)

### Fixed
- **[CRITICAL]** agents.index.json corruption issues
  - Removed UTF-8 BOM (byte order mark)
  - Fixed 4 missing commas (lines 81, 145, 163, 245)
  - Removed duplicate keys automatically via JSON normalization
  - File now validates against schema
- Encoding standardization across repository

### Changed
- agents.index.json now follows strict UTF-8 without BOM standard
- All JSON files use LF line endings and 2-space indentation

## [2.2.0] - 2025-09-30 - Parallel Execution Edition

### Added
- Parallel execution support for multiple activities
- Enhanced orchestration capabilities
- Quick-start script improvements
- Mesa Redonda (roundtable) workflow support
- GitHub Copilot integration documentation

### Changed
- Improved agent workflow with TDD-first approach
- Enhanced documentation structure
- Better error handling in PowerShell scripts

## [2.1.0] - 2025-09-15

### Added
- TDD workflow with Testing Specialist running before Expert Developer
- Testing Validator agent for post-implementation validation
- Enhanced agent definitions with better specialties

### Changed
- Reorganized agent execution sequence
- Improved agent playbooks with more detailed prompts

## [2.0.0] - 2025-08-01

### Added
- Complete rewrite with 11 specialized agents
- Clean Architecture and DDD patterns enforcement
- BDD scenario generation with Gherkin
- Automated documentation generation
- Integration with GitHub Copilot

### Changed
- New directory structure (agents/, data/, scripts/)
- Improved installer (Install/setup-workflow.ps1)
- Better encoding standards documentation

### Removed
- Legacy single-agent approach
- Old manual workflow scripts

## [1.0.0] - 2025-05-01

### Added
- Initial release
- Basic agent framework
- PowerShell automation scripts
- Manual workflow support

---

## How to Use This Changelog

### For Contributors
When adding changes:
1. Add under [Unreleased] section
2. Use categories: Added, Changed, Deprecated, Removed, Fixed, Security
3. Link to relevant issues or PRs
4. Follow format: `- Brief description ([#issue](link))`

### For Maintainers
When releasing:
1. Move [Unreleased] items to new version section
2. Add version number and date: `## [X.Y.Z] - YYYY-MM-DD`
3. Update [Unreleased] link at bottom
4. Create git tag: `git tag -a vX.Y.Z -m "Version X.Y.Z"`

### Version Numbering

We follow [Semantic Versioning](https://semver.org/):
- **MAJOR** (X.0.0): Breaking changes
- **MINOR** (0.X.0): New features, backwards compatible
- **PATCH** (0.0.X): Bug fixes, backwards compatible

Examples:
- `2.2.0` → `2.2.1`: Bug fixes
- `2.2.1` → `2.3.0`: New features
- `2.3.0` → `3.0.0`: Breaking changes

[Unreleased]: https://github.com/eliterickytech/WorkflowAgentsAI/compare/v2.2.0...HEAD
[2.2.0]: https://github.com/eliterickytech/WorkflowAgentsAI/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/eliterickytech/WorkflowAgentsAI/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/eliterickytech/WorkflowAgentsAI/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/eliterickytech/WorkflowAgentsAI/releases/tag/v1.0.0
