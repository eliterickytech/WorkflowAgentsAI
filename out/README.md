# 📦 Resultados e Artefatos (Enterprise)

Este diretório armazena os artefatos gerados em cada etapa do fluxo Enterprise (Mesa Redonda → Requirements → Architecture → Development → Testing) para rastreabilidade e auditoria.

## 📁 Estrutura Recomendada (nova)
```
out/sprint<sprint>
├── 1-ata-mesa-redonda-<rn0002>.md
├── 2-requirements-rn0002.md
├── 3-architecture-rn0002.md
├── 4-development-rn0002-notes.md
├── 5-testing-rn0002-report.md
└── attachments/               # diagramas/imagens anexas (opcional)
```

## 🧭 Convenções de Nomenclatura
- Prefixo numérico reflete a etapa (1..5)
- Sufixo com identificador da RN (ex.: rn0002)
- Extensão `.md` para fácil versionamento

## 📝 Conteúdo Mínimo por Arquivo
- 1-ata-mesa-redonda-rn0002.md: ATA padronizada (template do prompt)
- 2-requirements-rn0002.md: RN-0002.md consolidado do analista
- 3-architecture-rn0002.md: Decisões + ADRs + esboços de componentes
- 4-development-rn0002-notes.md: pontos de implementação, pendências
- 5-testing-rn0002-report.md: matriz de cenários, cobertura, resultados

## ✅ Boas Práticas
- Anexe artefatos relevantes em `attachments/`
- Evite informações sensíveis (segredos/CPFs) nos arquivos
- Mantenha ASCII em títulos e conteúdo conforme guia do projeto
- Commits pequenos e descritivos ao adicionar resultados
