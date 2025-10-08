# Exemplos - Arquivos `00-*`

Referencias prontas para os artefatos gerados pelo Product Owner:
- `00-requirements-brief.md`
- `00-business-context.md`
- `00-acceptance-criteria.md`

Use estes modelos como guia para validar ou ajustar as saídas iniciais da sprint.

---

## Exemplo `00-requirements-brief.md`
```markdown
# Requirements Brief - Sprint 03 / Activity rn0302

## Visao Geral
- Solicitante: Juliana Costa (Head Comercial)
- Objetivo: Criar dashboard de vendas com metas mensais e acompanhamento diario.
- Valor de negocio: reduzir tempo de analise em 40% e aumentar previsibilidade do pipeline.

## Problema Atual
- Vendedores consolidam dados em 3 planilhas diferentes.
- Ausencia de comparativo entre meta vs realizado.
- Falta de priorizacao de oportunidades criticas.

## Escopo Inicial
- Cards de indicadores principais (meta, realizado, tendencia).
- Filtros por periodo (mensal/semanal) e por regional.
- Lista de oportunidades com status Estagnada ha >14 dias.

## Itens Fora de Escopo
- Aplicativo mobile dedicado.
- Integracoes com plataformas externas alem do CRM Totvs.

## Stakeholders
- Patrocinador: Juliana Costa (Head Comercial)
- Responsavel tecnico: Rodrigo Alves (Coordenador TI)
- Apoio: Time de BI e Marketing

## Riscos e Dependencias
- Dependencia da API `sales-metrics` para dados atualizados.
- Necessita validacao de LGPD para segmentacao por vendedor.
- Risco de indisponibilidade no horario de pico (08h-10h).
```

---

## Exemplo `00-business-context.md`
```markdown
# Business Context - Sprint 03 / Activity rn0302

## Panorama do Cliente
- Setor: SaaS de gestao comercial.
- Equipe comercial: 25 vendedores, 3 gerentes regionais.
- Sistema atual: CRM proprietario com relatórios basicos.

## Motivacao da Demanda
- Comitê executivo solicitou previsibilidade semanal de vendas.
- Auditoria interna apontou falhas no acompanhamento de metas.
- Objetivo trimestral: elevar conversao de propostas em 15%.

## Regras e Politicas
- LGPD: cada usuario visualiza apenas dados do proprio time.
- SLA: dashboard deve estar disponivel com 99,5% uptime.
- Dados de faturamento devem seguir tabela oficial de impostos.

## Metricas Esperadas
- Tempo medio de analise reduzido para <10 minutos por gerente.
- Dashboard carregando em ate 5 segundos com dados do ultimo dia util.
- Exportacao em PDF em ate 2 cliques.

## Consideracoes Operacionais
- Janela de manutencao noturna 01h-03h (horario Brasilia).
- TI precisa de 1 semana para provisionar servidor de BI.
- Time de treinamento fara workshop apos homologacao.
```

---

## Exemplo `00-acceptance-criteria.md`
```markdown
# Acceptance Criteria - Sprint 03 / Activity rn0302

## Lista de Criterios
1. Dashboard exibe cards "Meta Mensal", "Realizado" e "Tendencia" com dados da API `sales-metrics` referentes a data atual.
2. Filtro por periodo permite selecao mensal ou semanal e atualiza os cards em ate 5 segundos.
3. Lista de oportunidades criticas apresenta apenas registros com status Estagnada ha mais de 14 dias e link para detalhe no CRM.
4. Exportacao PDF gera arquivo com data/hora no rodape e resumo dos cards em ate 2 cliques.
5. Controle de acesso respeita perfil do usuario (vendedor visualiza apenas dados do proprio time; gerente visualiza toda a regional).

## Criterios Nao-Funcionais
6. Dashboard responde em ate 5 segundos para volume de 50 mil registros simulados.
7. Interface segue guia de estilo aprovado com contraste minimo 4.5:1.
8. Logs registram usuario, periodo selecionado e horario de exportacao.

## Definition of Done
- Codigo revisado e aprovado.
- Testes automatizados para filtros e exportacao com cobertura minima 80%.
- Homologacao do time comercial documentada.
- Deployment realizado com monitoramento habilitado.

## Evidencias Necessarias
- Capturas de tela dos cards e filtros funcionando.
- Relatorio PDF gerado a partir do ambiente de homologacao.
- Logs de auditoria exportados (trecho de 24h).
- Resultado dos testes automatizados anexados.
```

---

## Checklist de Validação
- [ ] Brief, contexto e criterios usam mesma identificacao de sprint/atividade.
- [ ] Itens fora de escopo e riscos estao claros no brief.
- [ ] Metricas e indicadores mensuraveis aparecem no contexto.
- [ ] Criterios de aceite cobrem aspectos funcionais e nao-funcionais.
- [ ] Definition of Done inclui testes, homologacao e evidencias.
