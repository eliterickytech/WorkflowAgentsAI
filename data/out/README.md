# 📦 Resultados e Artefatos (data/out)

Este é o diretório CANÔNICO para todos os artefatos gerados pelos agentes.

Use sempre: `data/out/sprint<sprint>/<activity>/`

Exemplo: `data/out/sprint01/rn0001/`

## 📁 Estrutura Recomendada
```
data/out/sprint<sprint>/<activity>/
├── 00-business-context.md
├── 00-requirements-brief.md
├── 01-ata-mesa-redonda.md
├── 02-requisitos-bdd.md
├── 03-arquitetura.md
├── 04-desenvolvimento.md
├── 05-qa-plano.md
├── 99-checklist-final.md
├── features/                  # arquivos .feature (BDD)
├── adrs/                      # Architecture Decision Records
├── diagrams/                  # diagramas Mermaid (.mmd) e imagens
├── engineering/               # código e testes gerados
└── reports/                   # evidências, cobertura, performance
```

## 🧭 Convenções de Nomenclatura
- Prefixo numérico reflete a etapa do fluxo (00..99)
- Nomes em português para documentos de usuário; código em inglês
- Diretórios técnicos em inglês (features, adrs, diagrams, engineering)

## ✅ Boas Práticas
- Evite informações sensíveis (segredos/CPFs) nos arquivos
- Siga o guia de encoding do repositório (UTF-8 sem BOM; CRLF em .md)
- Mantenha a estrutura por sprint e activity para rastreabilidade
- Gere evidências em `data/out/evidence` quando aplicável
