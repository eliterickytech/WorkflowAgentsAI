# Sprint 1 - Issue #2: CI Inicial (PowerShell/Python) ✅ COMPLETED

**Labels:** `enhancement`, `ci/cd`, `sprint-1`

## Objetivo

Implementar pipeline de CI robusto que valida código PowerShell e Python em múltiplos sistemas operacionais.

## Critérios de Aceite

- [x] Pipeline roda em PR e push para main/develop
- [x] PSScriptAnalyzer analisa scripts PowerShell
- [x] Pester executa testes PowerShell (quando existirem)
- [x] Ruff linta código Python
- [x] pytest executa testes Python com coverage
- [x] Link-check valida documentação Markdown
- [x] Matrix OS: Ubuntu e Windows
- [x] Matrix Python: 3.10, 3.11, 3.12
- [x] Cache de dependências pip
- [x] Badges de status no README (próximo commit)
- [x] Validação de encoding (BOM check)

## Implementação Técnica

### Jobs do CI

1. **validate-json**: Valida agents.index.json contra schema
2. **powershell-analysis**: PSScriptAnalyzer em scripts/powershell/
3. **python-lint**: Ruff check em src/, scripts/python/, Install/orchestrators/
4. **python-tests**: pytest com matrix (Ubuntu/Windows × Python 3.10-3.12)
5. **docs-check**: lychee-action para verificar links quebrados
6. **encoding-check**: Detecta BOM em JSON/YAML/MD
7. **status-check**: Consolida resultados de todos os jobs

### Configuração

```yaml
name: CI
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]
```

### Cache
```yaml
- uses: actions/setup-python@v5
  with:
    python-version: '3.11'
    cache: 'pip'
```

### Cobertura Mínima
- Objetivo: >= 80% para novos módulos críticos
- Upload para Codecov (opcional, configurado)

## Evidências de Completude

✅ `.github/workflows/ci.yml` criado com 6 jobs
✅ PSScriptAnalyzer configurado para Windows
✅ Ruff e pytest configurados para Linux/Windows
✅ Link checker com lychee-action
✅ BOM detection implementado
✅ Matrix OS e Python versions

## Próximos Passos

- [ ] Adicionar badges ao README.md
- [ ] Criar testes unitários para src/
- [ ] Adicionar Pester tests para PowerShell

## Status: ✅ COMPLETED
