param(
  [Parameter(Mandatory=$true)][string]$Sprint,
  [Parameter(Mandatory=$true)][string[]]$Activities,
  [string]$SharedContext = "",
  [switch]$ParallelSetup = $false,
  [switch]$CreatePipeline = $false,
  [switch]$AutoDetectDependencies = $true
)

# Configuração
$baseDir = Join-Path (Join-Path $PSScriptRoot "..\data\out") ("sprint" + $Sprint)
$startManualScript = Join-Path $PSScriptRoot "start-manual.ps1"

Write-Host "🚀 AgileDevAgent - Multi-Activities Setup" -ForegroundColor Green
Write-Host "Sprint: $Sprint | Atividades: $($Activities.Count)" -ForegroundColor Cyan
Write-Host ""

# Validar se start-manual.ps1 existe
if (-not (Test-Path $startManualScript)) {
    Write-Error "❌ Script start-manual.ps1 não encontrado em: $startManualScript"
    exit 1
}

# Criar estrutura para cada atividade
Write-Host "📁 Criando estruturas de atividades..." -ForegroundColor Yellow
$createdActivities = @()

foreach ($activity in $Activities) {
    Write-Host "  📂 Criando: $activity" -ForegroundColor Gray
    
    # Executar start-manual.ps1 para cada atividade
    $context = if ($SharedContext) { "$SharedContext - Atividade: $activity" } else { "Sprint $Sprint - $activity" }
    
    try {
        & $startManualScript -Sprint $Sprint -Activity $activity -Context $context
        $createdActivities += $activity
        Write-Host "    ✅ $activity criada com sucesso" -ForegroundColor Green
    }
    catch {
        Write-Host "    ❌ Erro ao criar $activity`: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "✅ Estruturas criadas: $($createdActivities.Count)/$($Activities.Count)" -ForegroundColor Green

# Análise de dependências automática
$dependencies = @{}
if ($AutoDetectDependencies) {
    Write-Host "🔍 Analisando dependências automáticas..." -ForegroundColor Yellow
    
    # Palavras-chave que indicam dependências
    $depKeywords = @{
        "login|auth|autenticacao|usuario" = @("sistema-login", "autenticacao", "usuarios")
        "relatorio|dashboard|bi" = @("modulo-relatorios", "dashboard", "bi")
        "pagamento|financeiro|cobranca" = @("modulo-pagamentos", "financeiro", "billing")
        "sap|erp|integracao" = @("integracao-sap", "erp", "integracao-externa")
        "api|servico|web" = @("api", "webservice", "microservico")
    }
    
    foreach ($activity in $createdActivities) {
        $deps = @()
        foreach ($keyword in $depKeywords.Keys) {
            if ($activity -match $keyword) {
                $relatedActivities = $depKeywords[$keyword] | Where-Object { $_ -ne $activity -and $createdActivities -contains $_ }
                $deps += $relatedActivities
            }
        }
        $dependencies[$activity] = $deps
    }
}

# Criar contexto compartilhado nos arquivos
if ($SharedContext -or $dependencies.Count -gt 0) {
    Write-Host "🔗 Adicionando contexto compartilhado..." -ForegroundColor Yellow
    
    foreach ($activity in $createdActivities) {
        $businessContextFile = Join-Path $baseDir "$activity\00-business-context.md"
        
        if (Test-Path $businessContextFile) {
            $content = Get-Content $businessContextFile -Raw
            
            $relationSection = @"

---

## 🔗 ATIVIDADES RELACIONADAS

### Contexto Compartilhado
$SharedContext

### Dependências Identificadas
"@

            if ($dependencies[$activity]) {
                foreach ($dep in $dependencies[$activity]) {
                    $relationSection += "`n- **$dep**: Atividade relacionada no mesmo sprint"
                }
            } else {
                $relationSection += "`n- Nenhuma dependência crítica identificada"
            }

            $relationSection += @"

### Outras Atividades do Sprint
"@
            
            $otherActivities = $createdActivities | Where-Object { $_ -ne $activity }
            foreach ($other in $otherActivities) {
                $relationSection += "`n- **$other**: Atividade paralela"
            }

            $content += $relationSection
            $content | Out-File -FilePath $businessContextFile -Encoding utf8
        }
    }
}

# Criar guia de execução paralela
if ($ParallelSetup) {
    Write-Host "⚡ Criando guia de execução paralela..." -ForegroundColor Yellow
    
    $parallelGuide = @"
# 🚀 Guia de Execução Paralela - Sprint $Sprint

**Criado em:** $(Get-Date -Format 'dd/MM/yyyy HH:mm')
**Atividades:** $($createdActivities -join ', ')

## 📊 Status das Atividades

| Atividade | Status | Agente Atual | Próximo Passo |
|-----------|--------|--------------|---------------|
"@

    foreach ($activity in $createdActivities) {
        $parallelGuide += "`n| $activity | 🟡 Criada | Product Owner | Iniciar análise |"
    }

    $parallelGuide += @"

## ⚡ Execução em Paralelo

### ✅ PODE EXECUTAR SIMULTANEAMENTE:

Todos os **Product Owner** podem ser executados em paralelo:

``````
# Terminal/VS Code 1
@agents/manual/product-owner.agent.md
Sprint: $Sprint, Activity: $($createdActivities[0])

# Terminal/VS Code 2  
@agents/manual/product-owner.agent.md
Sprint: $Sprint, Activity: $($createdActivities[1])
"@

    if ($createdActivities.Count -gt 2) {
        for ($i = 2; $i -lt $createdActivities.Count; $i++) {
            $parallelGuide += @"

# Terminal/VS Code $($i + 1)
@agents/manual/product-owner.agent.md  
Sprint: $Sprint, Activity: $($createdActivities[$i])
"@
        }
    }

    $parallelGuide += @"
``````

### ⚠️ SEQUENCIAL (após PO):

Após todos os Product Owner concluírem, execute **Mesa Redonda** para cada:

``````
# Aguardar conclusão de todos os POs, depois:
@agents/manual/roundtable-facilitator.agent.md
Sprint: $Sprint, Activity: $($createdActivities[0])
# [Aguardar conclusão] 

@agents/manual/roundtable-facilitator.agent.md  
Sprint: $Sprint, Activity: $($createdActivities[1])
# [Aguardar conclusão]
``````

## 🎯 Estratégias Recomendadas

### 📈 Pipeline Escalonado:
1. **Semana 1**: Product Owner (todas atividades em paralelo)
2. **Semana 2**: Mesa Redonda + Requirements (sequencial)  
3. **Semana 3**: Systems Architect (sequencial)
4. **Semana 4**: Development + Testing (paralelo para atividades independentes)

### 👥 Multi-Squad:
- **Squad A**: $($createdActivities[0])
- **Squad B**: $($createdActivities[1] ?? 'N/A')
- **Squad C**: $($createdActivities[2] ?? 'N/A')

## 🔍 Monitoramento

### Comandos Úteis:
``````powershell
# Status geral
.\powershell\manage-parallel-execution.ps1 -Sprint $Sprint -Action status

# Próximos passos  
.\powershell\manage-parallel-execution.ps1 -Sprint $Sprint -Action next

# Detectar conflitos
.\powershell\manage-parallel-execution.ps1 -Sprint $Sprint -Action conflicts
``````

## 🚨 Pontos de Atenção

### ❌ NÃO FAÇA:
- Executar múltiplos agentes na **mesma atividade** simultaneamente
- Ignorar dependências entre atividades
- Prosseguir sem validar saídas dos agentes anteriores

### ✅ FAÇA:
- Um agente por atividade por vez
- Valide saídas antes de prosseguir
- Use aprovações [SIM/NÃO] para controle
- Monitore progresso regularmente

---
**Atualizado automaticamente pelos scripts de gerenciamento**
"@

    $parallelGuideFile = Join-Path $baseDir "parallel-execution-guide.md"
    $parallelGuide | Out-File -FilePath $parallelGuideFile -Encoding utf8
    Write-Host "    📋 Guia criado: $parallelGuideFile" -ForegroundColor Green
}

# Criar matriz de dependências
if ($dependencies.Count -gt 0) {
    Write-Host "📊 Criando matriz de dependências..." -ForegroundColor Yellow
    
    $depMatrix = @"
# 🕸️ Matriz de Dependências - Sprint $Sprint

**Análise automática de dependências entre atividades**

## 📊 Resumo

| Atividade | Dependências | Status | Risco |
|-----------|--------------|--------|-------|
"@

    foreach ($activity in $createdActivities) {
        $deps = $dependencies[$activity]
        $depCount = $deps.Count
        $riskLevel = switch ($depCount) {
            0 { "🟢 Baixo" }
            {$_ -le 2} { "🟡 Médio" }
            default { "🔴 Alto" }
        }
        
        $depList = if ($deps.Count -gt 0) { $deps -join ', ' } else { "Nenhuma" }
        $depMatrix += "`n| $activity | $depList | Aguardando | $riskLevel |"
    }

    $depMatrix += @"

## 🎯 Recomendações de Execução

### 🚀 Primeira Onda (Paralelo):
"@

    $independentActivities = $createdActivities | Where-Object { $dependencies[$_].Count -eq 0 }
    foreach ($activity in $independentActivities) {
        $depMatrix += "`n- **$activity** (sem dependências)"
    }

    $depMatrix += @"

### ⏳ Ondas Subsequentes:
"@

    $dependentActivities = $createdActivities | Where-Object { $dependencies[$_].Count -gt 0 }
    foreach ($activity in $dependentActivities) {
        $deps = $dependencies[$activity] -join ', '
        $depMatrix += "`n- **$activity** (aguarda: $deps)"
    }

    $depMatrix += @"

## 🔄 Pipeline Sugerido

``````mermaid
graph TD
"@

    foreach ($activity in $createdActivities) {
        $cleanActivity = $activity -replace '[^a-zA-Z0-9]', ''
        $depMatrix += "`n    $cleanActivity[$activity]"
        
        foreach ($dep in $dependencies[$activity]) {
            $cleanDep = $dep -replace '[^a-zA-Z0-9]', ''
            $depMatrix += "`n    $cleanDep --> $cleanActivity"
        }
    }

    $depMatrix += @"
``````

---
**Matriz gerada automaticamente - Revise e ajuste conforme necessário**
"@

    $depMatrixFile = Join-Path $baseDir "dependency-matrix.md"
    $depMatrix | Out-File -FilePath $depMatrixFile -Encoding utf8
    Write-Host "    🕸️ Matriz criada: $depMatrixFile" -ForegroundColor Green
}

# Criar cronograma de pipeline
if ($CreatePipeline) {
    Write-Host "📅 Criando cronograma de pipeline..." -ForegroundColor Yellow
    
    $pipeline = @"
# 📅 Pipeline Escalonado - Sprint $Sprint

**Cronograma otimizado para máxima eficiência**

## 🎯 Visão Geral

- **Atividades Total**: $($createdActivities.Count)
- **Duração Estimada**: $([Math]::Ceiling($createdActivities.Count / 2) + 2) semanas
- **Paralelização**: Até $([Math]::Min($createdActivities.Count, 3)) atividades simultâneas

## 📊 Cronograma Detalhado

### 📅 Semana 1: Fundação (Paralelo Máximo)
**Objetivo**: Estabelecer contexto e visão de todas as atividades

| Agente | Atividades | Duração | Recursos |
|--------|------------|---------|----------|
| 🎯 Product Owner | Todas ($($createdActivities -join ', ')) | 2-3 dias | $($createdActivities.Count) terminais |
| 🤝 Mesa Redonda | Todas (sequencial) | 2-3 dias | 1 sessão por atividade |

**Comandos da semana:**
``````
# Paralelo - Executar simultaneamente:
"@

    foreach ($activity in $createdActivities) {
        $pipeline += "`n# Terminal $($createdActivities.IndexOf($activity) + 1): $activity"
        $pipeline += "`n@agents/manual/product-owner.agent.md"
        $pipeline += "`nSprint: $Sprint, Activity: $activity`n"
    }

    $pipeline += @"
``````

### 📅 Semana 2: Especificação (Híbrido)
**Objetivo**: Definir requisitos detalhados e iniciar próxima onda

| Agente | Atividades | Estratégia | Paralelismo |
|--------|------------|------------|-------------|
| 📋 Requirements | $($createdActivities[0..1] -join ', ') | Sequencial prioritário | 1 por vez |
| 🎯 Product Owner | Novas atividades | Preparar próxima onda | Paralelo |

### 📅 Semana 3: Arquitetura (Otimizado)  
**Objetivo**: Design técnico e validação de dependências

| Agente | Atividades | Estratégia | Observações |
|--------|------------|------------|-------------|
| 🏗️ Systems Architect | Todas ($($createdActivities -join ', ')) | Sequencial inteligente | Considerar dependências |
| 📋 Requirements | Restantes | Finalizar especificações | Conforme disponibilidade |

### 📅 Semana 4+: Implementação (Pipeline Completo)
**Objetivo**: Desenvolvimento e qualidade

| Agente | Estratégia | Paralelismo | Eficiência |
|--------|------------|-------------|------------|
| 💻 Expert Developer | Atividades independentes em paralelo | 2-3 simultâneas | Alta |
| 🧪 Testing Specialist | Seguir desenvolvimento | Sequencial por atividade | Média |
| 🔍 Testing Validator | Validação pós-implementação | Paralelo com development | Alta |

## 🚀 Otimizações do Pipeline

### ⚡ Paralelização Inteligente:
1. **Product Owner**: Todas atividades simultaneamente (máxima eficiência)
2. **Mesa Redonda**: Sequencial (evita contexto misturado)  
3. **Requirements**: 2 paralelos máximo (qualidade > velocidade)
4. **Architecture**: Sequencial com dependências (consistência)
5. **Development**: Paralelo para independentes (velocidade)

### 🎯 Checkpoints de Sincronização:
- **Fim Semana 1**: Todos POs + Mesa Redonda concluídos
- **Meio Semana 2**: Requirements das atividades prioritárias
- **Fim Semana 3**: Arquiteturas definidas, desenvolvimento pode iniciar
- **Semanal**: Review de progresso e ajuste de prioridades

## 📊 Métricas de Acompanhamento

### KPIs do Pipeline:
- **Throughput**: Atividades concluídas por semana
- **Lead Time**: Tempo médio PO → PO Final
- **Paralelismo**: % tempo com múltiplas atividades ativas
- **Qualidade**: Taxa de retrabalho por atividade

### Dashboard de Progresso:
``````powershell
# Comando para status em tempo real:
.\powershell\manage-parallel-execution.ps1 -Sprint $Sprint -Action status
``````

---
**Pipeline otimizado automaticamente - Ajuste conforme capacidade do time**
"@

    $pipelineFile = Join-Path $baseDir "pipeline-schedule.md"
    $pipeline | Out-File -FilePath $pipelineFile -Encoding utf8
    Write-Host "    📅 Pipeline criado: $pipelineFile" -ForegroundColor Green
}

# Resumo final
Write-Host ""
Write-Host "🎉 Setup completo!" -ForegroundColor Green
Write-Host "📁 Diretório base: $baseDir" -ForegroundColor Cyan
Write-Host "✅ Atividades criadas: $($createdActivities.Count)" -ForegroundColor Green

if ($ParallelSetup) {
    Write-Host "⚡ Guia de execução paralela: parallel-execution-guide.md" -ForegroundColor Yellow
}

if ($dependencies.Count -gt 0) {
    Write-Host "🕸️ Matriz de dependências: dependency-matrix.md" -ForegroundColor Yellow
}

if ($CreatePipeline) {
    Write-Host "📅 Cronograma de pipeline: pipeline-schedule.md" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🚀 Próximos passos:" -ForegroundColor Magenta
Write-Host "1. Execute Product Owner para todas atividades em paralelo" -ForegroundColor White
Write-Host "2. Use os guias gerados para otimizar a execução" -ForegroundColor White  
Write-Host "3. Monitore progresso com manage-parallel-execution.ps1" -ForegroundColor White
Write-Host ""