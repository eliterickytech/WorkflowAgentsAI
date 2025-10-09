# Sprint 1 - Issue #1: Corrigir agents.index.json (BLOQUEADOR) ✅ COMPLETED

**Labels:** `bug`, `priority:critical`, `sprint-1`

## Problema

O arquivo `agents.index.json` contém:
1. BOM (Byte Order Mark - `ef bb bf`) na linha 1
2. 4 vírgulas faltantes causando erro de parsing JSON (linhas 81, 145, 163, 245)
3. Chaves duplicadas em cada objeto de agente (`name`, `playbook`, `inputs`, `outputs`)
4. Falta de validação estrutural

Isso impede:
- Parsing correto do JSON por ferramentas
- Sincronização com MCP e GitHub Copilot
- Validação automatizada no CI

## Critérios de Aceite

- [x] Arquivo `agents.index.json` é JSON válido
- [x] Sem BOM (UTF-8 sem BOM)
- [x] Sem chaves duplicadas
- [x] JSON Schema criado (`agents.schema.json`)
- [x] Script de validação Python (`scripts/python/validate_agents_index.py`)
- [x] Validação integrada no CI

## Implementação Técnica

### 1. Remover BOM
```python
# Detectar e remover ef bb bf
with open('agents.index.json', 'rb') as f:
    content = f.read()
if content.startswith(b'\xef\xbb\xbf'):
    content = content[3:]
```

### 2. Corrigir vírgulas faltantes
- Linha 81: `"references-data/datas/tables/validation-business-rules-files/"`
- Linha 145: `"adr"`
- Linha 163: `"Padroes e convencoes do projeto"`
- Linha 245: `"references-data/business-rules/"`

### 3. Deduplicar chaves
`json.load()` automaticamente mantém apenas a última ocorrência de chaves duplicadas.

### 4. Criar JSON Schema
Validar estrutura:
- Root: `agentsDirectory`, `lastUpdated`, `agents`, `integrationPoints`, `qualityGates`, `workflowPatterns`
- Cada agent: `id`, `name`, `description`, `playbook`, `specialties`, `inputs`, `outputs`, `triggers`, `keyReferences` (opcional)

### 5. CI Validation
Adicionar job no `.github/workflows/ci.yml`:
```yaml
- name: Validate agents.index.json
  run: python scripts/python/validate_agents_index.py
```

## Evidências de Completude

✅ Script de fix executado com sucesso
✅ JSON válido confirmado
✅ 7 agentes carregados corretamente
✅ Schema criado e validação passa
✅ CI job criado

## Status: ✅ COMPLETED
