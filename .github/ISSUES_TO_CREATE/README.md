# GitHub Issues - Sprints 1-3

Este diretório contém templates detalhados para todas as issues das 3 sprints planejadas.

## Como Usar

1. **Criar Issues Manualmente:**
   - Copie o conteúdo de cada arquivo `.md`
   - Crie nova issue no GitHub
   - Cole o conteúdo
   - Adicione as labels indicadas

2. **Criar Issues via CLI GitHub:**
   ```bash
   gh issue create --title "Sprint 1 - Issue #1: Corrigir agents.index.json" \
                   --body-file .github/ISSUES_TO_CREATE/sprint1-issue1-fix-agents-json.md \
                   --label bug,priority:critical,sprint-1
   ```

## Status das Sprints

### Sprint 1 - Confiabilidade e Base de Produto ✅ 80% COMPLETE

| Issue | Título | Status | Prioridade |
|-------|--------|--------|------------|
| #1 | Corrigir agents.index.json | ✅ DONE | P0 Critical |
| #2 | CI Inicial (PowerShell/Python) | ✅ DONE | P1 High |
| #3 | Segurança de Supply Chain | ✅ DONE | P1 High |
| #4 | Cross-Platform Bootstrap | ⏭️ DEFERRED | P2 Medium |
| #5 | Versão, Licença e Governança | ✅ DONE | P1 High |

**Deliverables Completos:**
- ✅ agents.index.json corrigido (BOM, vírgulas, schema)
- ✅ CI pipeline completo (.github/workflows/ci.yml)
- ✅ CodeQL + Dependabot
- ✅ LICENSE (Apache 2.0)
- ✅ SECURITY.md, CONTRIBUTING.md, CHANGELOG.md
- ✅ FUNDING.yml
- ✅ Release Drafter

### Sprint 2 - UX/Distribuição 📋 PLANNED

| Issue | Título | Status | Prioridade |
|-------|--------|--------|------------|
| #6 | CLI Unificada (wa) | 📋 Planned | P1 High |
| #7 | VS Code Extension (MVP) | 📋 Planned | P2 Medium |
| #8 | Telemetria (opt-in) | 📋 Planned | P3 Low |
| #9 | Docs First-Run/Troubleshooting | 📋 Planned | P2 Medium |

**Issue #6 (CLI) absorve Issue #4 (Cross-Platform)**

### Sprint 3 - Monetização e GTM 📋 PLANNED

| Issue | Título | Status | Prioridade |
|-------|--------|--------|------------|
| #10 | Open-Core e Planos | 📋 Planned | P1 High |
| #11 | Pricing e Site | 📋 Planned | P2 Medium |
| #12 | Sponsors e Comunidade | 📋 Planned | P2 Medium |
| #13 | Casos de Uso .NET (ICP) | 📋 Planned | P1 High |

## Arquivos Criados

### Sprint 1 ✅
- [x] `sprint1-issue1-fix-agents-json.md` - Bloqueador crítico
- [x] `sprint1-issue2-ci-pipeline.md` - CI/CD completo
- [x] `sprint1-issue3-security-supply-chain.md` - Dependabot + CodeQL
- [x] `sprint1-issue4-cross-platform.md` - Deferred to Sprint 2
- [x] `sprint1-issue5-governance.md` - Licença e governança

### Sprint 2 📋
- [x] `sprint2-issue6-cli-unified.md` - CLI Python (Typer/Click)
- [ ] `sprint2-issue7-vscode-extension.md` - TODO
- [ ] `sprint2-issue8-telemetry.md` - TODO
- [ ] `sprint2-issue9-docs-firstrun.md` - TODO

### Sprint 3 📋
- [ ] `sprint3-issue10-opencore.md` - TODO
- [ ] `sprint3-issue11-pricing-site.md` - TODO
- [ ] `sprint3-issue12-sponsors-community.md` - TODO
- [ ] `sprint3-issue13-dotnet-usecases.md` - TODO

## Labels Sugeridas

Crie estas labels no repositório:

**Sprints:**
- `sprint-1` (🏃 verde)
- `sprint-2` (🚀 azul)
- `sprint-3` (💰 amarelo)

**Prioridade:**
- `priority:critical` (🔥 vermelho)
- `priority:high` (⚠️ laranja)
- `priority:medium` (🟡 amarelo)
- `priority:low` (🟢 verde)

**Tipo:**
- `bug` (🐛)
- `enhancement` (✨)
- `documentation` (📝)
- `security` (🔒)
- `ci/cd` (⚙️)
- `cli` (💻)
- `cross-platform` (🌍)

## Comando Rápido para Criar Labels

```bash
# Sprint labels
gh label create "sprint-1" --color "0E8A16" --description "Sprint 1 - Confiabilidade"
gh label create "sprint-2" --color "1D76DB" --description "Sprint 2 - UX/Distribuição"
gh label create "sprint-3" --color "FBCA04" --description "Sprint 3 - Monetização"

# Priority labels
gh label create "priority:critical" --color "D93F0B" --description "Critical priority"
gh label create "priority:high" --color "FF9800" --description "High priority"
gh label create "priority:medium" --color "FBCA04" --description "Medium priority"
gh label create "priority:low" --color "0E8A16" --description "Low priority"
```

## Ordem de Execução Recomendada

### Fase 1 (Semana 1-2) - ✅ DONE
1. Issue #1 - Corrigir agents.index.json
2. Issue #2 - CI pipeline
3. Issue #3 - Security
4. Issue #5 - Governança

### Fase 2 (Semana 3-4)
5. Issue #6 - CLI unificada (inclui #4)
6. Issue #9 - Documentação first-run

### Fase 3 (Semana 5-7)
7. Issue #7 - VS Code Extension
8. Issue #8 - Telemetria (opcional)

### Fase 4 (Semana 8-10)
9. Issue #13 - Casos de uso .NET
10. Issue #10 - Open-core
11. Issue #11 - Pricing e site
12. Issue #12 - Comunidade

## Milestones Sugeridos

Crie milestones no GitHub:

1. **Sprint 1 - Confiabilidade** (2 semanas) ✅
   - Due date: 2025-01-23
   - Issues: #1-5

2. **Sprint 2 - UX/Distribuição** (2-3 semanas)
   - Due date: 2025-02-13
   - Issues: #6-9

3. **Sprint 3 - Monetização** (2-3 semanas)
   - Due date: 2025-03-06
   - Issues: #10-13

## Próximos Passos

1. ✅ Revisar issues do Sprint 1 (completos)
2. 📝 Criar issues detalhadas para Sprint 2 (#7, #8, #9)
3. 📝 Criar issues detalhadas para Sprint 3 (#10-13)
4. 🏷️ Criar labels no repositório
5. 📅 Criar milestones
6. 🎯 Começar implementação Sprint 2

## Observações

- Issues marcadas como ✅ DONE já foram implementadas nesta PR
- Issue #4 foi absorvida pelo Issue #6 (mais eficiente)
- Prioridades podem ser ajustadas conforme feedback da comunidade
- Sprint 3 pode ser executado em paralelo com Sprint 2 (diferentes pessoas)
