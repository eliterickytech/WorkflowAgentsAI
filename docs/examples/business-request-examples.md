# Business Request - Templates e Exemplos

Este material ajuda a estruturar arquivos em `business_request/`, garantindo que o Product Owner tenha dados claros antes de acionar os demais agentes.

---

## Como usar
- Copie um dos templates abaixo para um novo arquivo dentro de `business_request/`.
- Ajuste campos conforme a demanda real (sempre em primeira pessoa ou na voz do solicitante).
- Anexe documentos complementares em `attachments/` e cite-os quando relevantes.

---

## Template Geral (copie e adapte)
```markdown
# Business Request: [Nome curto da demanda]

## Resumo
- Objetivo principal:
- Problema atual:
- Valor para o cliente/negocio:

## Contexto
- Onde ocorre:
- Quem sao os usuarios impactados:
- Regras ou restricoes conhecidas:
- Sistemas ou dependencias relacionadas:

## Stakeholders
- Patrocinador principal:
- Responsavel tecnico:
- Outros envolvidos:

## Escopo desejado
- Funcionalidades essenciais:
- Itens fora de escopo:
- Prazo alvo ou marco importante:

## Criterios de sucesso
- Indicadores mensuraveis:
- Evidencias esperadas na entrega:

## Materiais anexados
- [Arquivo] - breve descricao
- [Arquivo] - breve descricao
```

---

## Exemplo 1 - Nova Funcionalidade (Dashboard Vendas)
```markdown
# Business Request: Dashboard vendas com metas

## Resumo
- Objetivo principal: disponibilizar um dashboard unificado com metas mensais.
- Problema atual: vendedores acessam tres planilhas diferentes e nao conseguem comparar desempenho semanal.
- Valor para o cliente/negocio: reduzir tempo de analise em 40% e aumentar previsibilidade do pipeline.

## Contexto
- Onde ocorre: equipe comercial da regional SP utilizando CRM interno.
- Usuarios impactados: 25 vendedores + 3 gerentes regionais.
- Regras ou restricoes conhecidas: dados devem respeitar LGPD, exibir apenas informacoes do proprio time.
- Sistemas ou dependencias relacionadas: CRM Totvs, API interna `sales-metrics`, planilha metas.xlsx (attachments).

## Stakeholders
- Patrocinador principal: Juliana Costa (Head Comercial).
- Responsavel tecnico: Rodrigo Alves (Coordenador TI).
- Outros envolvidos: time de BI (consulta de dados), marketing (definicao de metas).

## Escopo desejado
- Funcionalidades essenciais:
  - Cards com meta mensal vs realizado.
  - Filtro por periodo (mensal/semanal).
  - Lista de oportunidades criticas (status Estagnada ha >14 dias).
- Itens fora de escopo:
  - Modulo mobile dedicado.
  - Integracao com sistemas externos alem do CRM.
- Prazo alvo ou marco importante: entrega ate 15/11 para apresentacao em comite.

## Criterios de sucesso
- Gerentes conseguem exportar PDF com consolidado em ate 2 cliques.
- Dashboard carrega em ate 5 segundos com dados do ultimo dia util.
- Metricas batem com planilha validada pelo BI (anexo metas.xlsx).

## Materiais anexados
- metas.xlsx - metas historicas 2022-2024.
- mockup-dashboard.pdf - rascunho de layout enviado pelo marketing.
```

---

## Exemplo 2 - Ajuste UX (Portal do Cliente)
```markdown
# Business Request: Melhorar fluxo de redefinicao de senha

## Resumo
- Objetivo principal: reduzir chamados no suporte relacionados a esqueci minha senha.
- Problema atual: usuarios nao recebem feedback visual apos solicitar redefinicao.
- Valor para o cliente/negocio: diminuir volume de tickets em 30% e melhorar NPS do portal.

## Contexto
- Onde ocorre: portal do cliente (SPA React) modulo autenticacao.
- Usuarios impactados: todos os clientes externos (~12 mil ativos).
- Regras ou restricoes conhecidas: obedecer politica de seguranca 2FA, manter logs de auditoria.
- Sistemas ou dependencias relacionadas: servico `identity-api`, provider de email SendGrid, Google reCAPTCHA.

## Stakeholders
- Patrocinador principal: Marcelo Ribeiro (Diretor de Atendimento).
- Responsavel tecnico: Camila Souza (Tech Lead Identity).
- Outros envolvidos: equipe de CS (acompanha impacto), seguranca da informacao.

## Escopo desejado
- Funcionalidades essenciais:
  - Modal com confirmacao de envio e tempo estimado.
  - Email transacional com passo a passo e validade do token.
  - Pagina de redefinicao com validacao visual do token.
- Itens fora de escopo:
  - Alteracoes no fluxo de cadastro.
  - Mudancas na politica de expiracao de tokens.
- Prazo alvo ou marco importante: antes da campanha black friday (30/10).

## Criterios de sucesso
- Taxa de sucesso no reset sobe de 55% para 85%.
- Chamados categoria senha caem de 320 para <200/mensal.
- Logs registram solicitante, IP e timestamp (conferir com seguranca).

## Materiais anexados
- cs-report-agosto.pdf - analise de chamados do suporte.
- gravacao_fluxo_atual.mp4 - video mostrando a experiencia atual.
```

---

## Exemplo 3 - Correcao Tecnica Urgente (Sistema Financeiro)
```markdown
# Business Request: Corrigir arredondamento nas notas fiscais

## Resumo
- Objetivo principal: ajustar calculo de aliquota ISS em notas fiscais municipais.
- Problema atual: arredondamento para cima em algumas faixas gera divergencia de centavos com prefeitura.
- Valor para o cliente/negocio: evitar autuacoes e multas estimadas em R$ 150 mil/ano.

## Contexto
- Onde ocorre: modulo emissao fiscal do ERP (WinForms .NET).
- Usuarios impactados: equipe fiscal (8 pessoas) e contabilidade externa.
- Regras ou restricoes conhecidas: seguir decreto municipal 18.452/2023 e tabela de aliquotas atualizada.
- Sistemas ou dependencias relacionadas: servico `TaxCalculation`, integracao prefeitura via webservice SOAP.

## Stakeholders
- Patrocinador principal: Ana Luiza Martins (CFO).
- Responsavel tecnico: Pedro Ramos (Coordenador ERP).
- Outros envolvidos: consultoria fiscal Exato (valida resultados).

## Escopo desejado
- Funcionalidades essenciais:
  - Aplicar regra de arredondamento para baixo quando diferenca < 0,005.
  - Registrar nos logs valor calculado e valor ajustado.
  - Atualizar relatorio mensal com coluna "Ajuste ISS".
- Itens fora de escopo:
  - Revisao de PIS/COFINS.
  - Migracao do modulo fiscal para web.
- Prazo alvo ou marco importante: implantacao ate 07/10 antes do fechamento contabile.

## Criterios de sucesso
- 100% das notas emitidas com valores identicos ao simulador da prefeitura.
- Logs auditaveis disponiveis para consulta por 6 meses.
- CFO aprova nota de homologacao assinada pela consultoria Exato.

## Materiais anexados
- decreto-18452-2023.pdf - regras oficiais.
- tabela-aliquotas.xlsx - planilha com faixas atualizadas.
- relatorio-divergencias.csv - notas com erro no ultimo mes.
```

---

## Checklist rapido antes de enviar
- [ ] Titulo descreve claramente o pedido.
- [ ] Objetivos, problema e valor estao explicitos.
- [ ] Stakeholders e prazos estao identificados.
- [ ] Dependencias e anexos foram mencionados.
- [ ] Criterios de sucesso sao mensuraveis/testaveis.
