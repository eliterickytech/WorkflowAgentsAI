param(
  [Parameter(Mandatory=$true)][string]$Sprint,
  [ValidateSet("status", "next", "conflicts", "sync", "reset")][string]$Action = "status",
  [string]$Activity = ""
)

# Configuração
$baseDir = Join-Path (Join-Path $PSScriptRoot "..\data\out") ("sprint" + $Sprint)

if (-not (Test-Path $baseDir)) {
    Write-Error "❌ Sprint $Sprint não encontrada. Execute start-multi-activities.ps1 primeiro."
    exit 1
}

# Detectar atividades existentes
$activities = Get-ChildItem -Path $baseDir -Directory | Where-Object { $_.Name -ne "." -and $_.Name -ne ".." } | Select-Object -ExpandProperty Name

if ($activities.Count -eq 0) {
    Write-Error "❌ Nenhuma atividade encontrada no Sprint $Sprint"
    exit 1
}

# Função para analisar status de uma atividade
function Get-ActivityStatus {
    param([string]$ActivityPath, [string]$ActivityName)
    
    $files = @{
        "00-business-context.md" = "Product Owner"
        "01-ata-mesa-redonda.md" = "Mesa Redonda" 
        "02-requisitos-bdd.md" = "Requirements Analyst"
        "03-arquitetura.md" = "Systems Architect"
        "04-desenvolvimento.md" = "Expert Developer"
        "05-qa-plano.md" = "Testing Specialist"
        "05.1-testing-validation.md" = "Testing Validator"
        "04.1-code-review.md" = "Code Reviewer"
        "99-checklist-final.md" = "Product Owner Final"
    }
    
    $status = @{
        Activity = $ActivityName
        Progress = 0
        CurrentAgent = "Product Owner"
        NextAgent = "Product Owner"
        FilesCompleted = @()
        FilesRemaining = @()
        LastModified = $null
    }
    
    $completedCount = 0
    $totalCount = $files.Count
    
    foreach ($file in $files.Keys) {
        $filePath = Join-Path $ActivityPath $file
        if (Test-Path $filePath) {
            $fileInfo = Get-Item $filePath
            # Verificar se arquivo foi realmente editado (não é só template)
            $content = Get-Content $filePath -Raw
            if ($content.Length -gt 500 -and -not ($content -match "A definir|A completar|\[.*\]")) {
                $status.FilesCompleted += $file
                $completedCount++
                if ($null -eq $status.LastModified -or $fileInfo.LastWriteTime -gt $status.LastModified) {
                    $status.LastModified = $fileInfo.LastWriteTime
                    $status.CurrentAgent = $files[$file]
                }
            } else {
                $status.FilesRemaining += $file
            }
        } else {
            $status.FilesRemaining += $file
        }
    }
    
    $status.Progress = [Math]::Round(($completedCount / $totalCount) * 100)
    
    # Determinar próximo agente
    $agentOrder = @("Product Owner", "Mesa Redonda", "Requirements Analyst", "Systems Architect", "Expert Developer", "Testing Specialist", "Testing Validator", "Code Reviewer", "Product Owner Final")
    $currentIndex = $agentOrder.IndexOf($status.CurrentAgent)
    if ($currentIndex -ge 0 -and $currentIndex -lt ($agentOrder.Count - 1)) {
        $status.NextAgent = $agentOrder[$currentIndex + 1]
    } else {
        $status.NextAgent = "Completo"
    }
    
    return $status
}

# Função para detectar conflitos
function Test-ExecutionConflicts {
    param([array]$ActivityStatuses)
    
    $conflicts = @()
    $warnings = @()
    
    # Verificar execuções simultâneas do mesmo agente
    $agentGroups = $ActivityStatuses | Group-Object NextAgent
    foreach ($group in $agentGroups) {
        if ($group.Count -gt 1 -and $group.Name -ne "Completo") {
            $activityNames = $group.Group.Activity -join ", "
            $conflicts += "⚠️ $($group.Name) pode ser executado simultaneamente em: $activityNames"
        }
    }
    
    # Verificar dependências (análise básica por nome)
    foreach ($status in $ActivityStatuses) {
        $activity = $status.Activity
        
        # Detectar dependências por palavras-chave
        if ($activity -match "dashboard|bi|relatorio" -and $status.Progress -lt 60) {
            $loginActivity = $ActivityStatuses | Where-Object { $_.Activity -match "login|auth|usuario" }
            if ($loginActivity -and $loginActivity.Progress -lt $status.Progress) {
                $warnings += "🔗 $activity pode depender de $($loginActivity.Activity) (autenticação)"
            }
        }
        
        if ($activity -match "integracao|sap|erp" -and $status.Progress -gt 50) {
            $apiActivity = $ActivityStatuses | Where-Object { $_.Activity -match "api|servico" }
            if ($apiActivity -and $apiActivity.Progress -lt 30) {
                $warnings += "🔗 $activity pode precisar de APIs base definidas"
            }
        }
    }
    
    return @{
        Conflicts = $conflicts
        Warnings = $warnings
    }
}

# Executar ação solicitada
switch ($Action) {
    "status" {
        Write-Host "📊 SPRINT $Sprint - Status das Atividades" -ForegroundColor Green
        Write-Host "Última verificação: $(Get-Date -Format 'dd/MM/yyyy HH:mm')" -ForegroundColor Gray
        Write-Host ""
        
        $allStatuses = @()
        foreach ($activity in $activities) {
            $activityPath = Join-Path $baseDir $activity
            $status = Get-ActivityStatus -ActivityPath $activityPath -ActivityName $activity
            $allStatuses += $status
            
            # Barra de progresso visual
            $progressBar = ""
            $filled = [Math]::Floor($status.Progress / 10)
            $empty = 10 - $filled
            $progressBar = "█" * $filled + "░" * $empty
            
            $lastMod = if ($status.LastModified) { $status.LastModified.ToString("dd/MM HH:mm") } else { "Não iniciada" }
            
            Write-Host "$activity" -ForegroundColor Cyan
            Write-Host "  [$progressBar] $($status.Progress)% - $($status.CurrentAgent)" -ForegroundColor White
            Write-Host "  Próximo: $($status.NextAgent) | Última alteração: $lastMod" -ForegroundColor Gray
            Write-Host ""
        }
        
        # Resumo geral
        $avgProgress = [Math]::Round(($allStatuses | Measure-Object Progress -Average).Average)
        $completedActivities = ($allStatuses | Where-Object { $_.Progress -eq 100 }).Count
        
        Write-Host "📈 RESUMO GERAL:" -ForegroundColor Yellow
        Write-Host "  Progresso médio: $avgProgress%" -ForegroundColor White
        Write-Host "  Atividades completas: $completedActivities/$($activities.Count)" -ForegroundColor White
        Write-Host "  Atividades ativas: $(($allStatuses | Where-Object { $_.Progress -gt 0 -and $_.Progress -lt 100 }).Count)" -ForegroundColor White
    }
    
    "next" {
        Write-Host "🚀 PRÓXIMAS EXECUÇÕES RECOMENDADAS - Sprint $Sprint" -ForegroundColor Green
        Write-Host ""
        
        $allStatuses = @()
        foreach ($activity in $activities) {
            $activityPath = Join-Path $baseDir $activity
            $status = Get-ActivityStatus -ActivityPath $activityPath -ActivityName $activity
            $allStatuses += $status
        }
        
        # Agrupar por próximo agente
        $nextActions = $allStatuses | Where-Object { $_.NextAgent -ne "Completo" } | Group-Object NextAgent
        
        if ($nextActions.Count -eq 0) {
            Write-Host "🎉 Todas as atividades estão completas!" -ForegroundColor Green
            return
        }
        
        foreach ($agentGroup in $nextActions) {
            $agent = $agentGroup.Name
            $activities = $agentGroup.Group
            
            Write-Host "🎯 $agent ($($activities.Count) atividade(s)):" -ForegroundColor Yellow
            
            if ($activities.Count -gt 1) {
                Write-Host "  ✅ PODE EXECUTAR EM PARALELO:" -ForegroundColor Green
            }
            
            foreach ($activity in $activities) {
                $agentFile = switch ($agent) {
                    "Product Owner" { "product-owner.agent.md" }
                    "Mesa Redonda" { "roundtable-facilitator.agent.md" }
                    "Requirements Analyst" { "requirements-analyst.agent.md" }
                    "Systems Architect" { "systems-architect.agent.md" }
                    "Expert Developer" { "expert-developer.agent.md" }
                    "Testing Specialist" { "testing-specialist.agent.md" }
                    "Testing Validator" { "testing-validator.agent.md" }
                    "Code Reviewer" { "code-reviewer.agent.md" }
                    "Product Owner Final" { "product-owner-final.agent.md" }
                    default { "unknown.agent.md" }
                }
                
                Write-Host ""
                Write-Host "  📋 $($activity.Activity) (Progresso: $($activity.Progress)%)" -ForegroundColor Cyan
                Write-Host "  @agents/manual/$agentFile" -ForegroundColor White
                Write-Host "  Sprint: $Sprint, Activity: $($activity.Activity)" -ForegroundColor Gray
            }
            Write-Host ""
        }
        
        # Detectar e mostrar conflitos
        $conflictAnalysis = Test-ExecutionConflicts -ActivityStatuses $allStatuses
        
        if ($conflictAnalysis.Warnings.Count -gt 0) {
            Write-Host "⚠️ ATENÇÃO - Dependências Identificadas:" -ForegroundColor Yellow
            foreach ($warning in $conflictAnalysis.Warnings) {
                Write-Host "  $warning" -ForegroundColor Yellow
            }
            Write-Host ""
        }
    }
    
    "conflicts" {
        Write-Host "🔍 ANÁLISE DE CONFLITOS - Sprint $Sprint" -ForegroundColor Red
        Write-Host ""
        
        $allStatuses = @()
        foreach ($activity in $activities) {
            $activityPath = Join-Path $baseDir $activity
            $status = Get-ActivityStatus -ActivityPath $activityPath -ActivityName $activity
            $allStatuses += $status
        }
        
        $conflictAnalysis = Test-ExecutionConflicts -ActivityStatuses $allStatuses
        
        Write-Host "✅ EXECUÇÃO PARALELA SEGURA:" -ForegroundColor Green
        $safeGroups = $allStatuses | Where-Object { $_.NextAgent -ne "Completo" } | Group-Object NextAgent
        foreach ($group in $safeGroups) {
            if ($group.Count -gt 1) {
                $activityNames = $group.Group.Activity -join ", "
                Write-Host "  $($group.Name): $activityNames" -ForegroundColor Green
            }
        }
        Write-Host ""
        
        if ($conflictAnalysis.Warnings.Count -gt 0) {
            Write-Host "⚠️ POSSÍVEIS DEPENDÊNCIAS:" -ForegroundColor Yellow
            foreach ($warning in $conflictAnalysis.Warnings) {
                Write-Host "  $warning" -ForegroundColor Yellow
            }
        } else {
            Write-Host "✅ Nenhuma dependência crítica detectada" -ForegroundColor Green
        }
        Write-Host ""
        
        Write-Host "❌ CONFLITOS CRÍTICOS:" -ForegroundColor Red
        if ($conflictAnalysis.Conflicts.Count -gt 0) {
            foreach ($conflict in $conflictAnalysis.Conflicts) {
                Write-Host "  $conflict" -ForegroundColor Red
            }
        } else {
            Write-Host "  ✅ Nenhum conflito crítico encontrado" -ForegroundColor Green
        }
    }
    
    "sync" {
        Write-Host "🔄 SINCRONIZANDO STATUS - Sprint $Sprint" -ForegroundColor Cyan
        Write-Host ""
        
        # Atualizar parallel-execution-guide.md se existir
        $parallelGuideFile = Join-Path $baseDir "parallel-execution-guide.md"
        if (Test-Path $parallelGuideFile) {
            Write-Host "📋 Atualizando guia de execução paralela..." -ForegroundColor Yellow
            
            $allStatuses = @()
            foreach ($activity in $activities) {
                $activityPath = Join-Path $baseDir $activity
                $status = Get-ActivityStatus -ActivityPath $activityPath -ActivityName $activity
                $allStatuses += $status
            }
            
            # Ler arquivo existente e atualizar tabela de status
            $content = Get-Content $parallelGuideFile -Raw
            
            # Gerar nova tabela de status
            $newStatusTable = @"
| Atividade | Status | Agente Atual | Próximo Passo |
|-----------|--------|--------------|---------------|
"@
            
            foreach ($status in $allStatuses) {
                $statusEmoji = switch ($status.Progress) {
                    0 { "⚪" }
                    {$_ -lt 30} { "🟡" }
                    {$_ -lt 70} { "🔵" }
                    {$_ -lt 100} { "🟠" }
                    100 { "🟢" }
                }
                
                $nextStep = if ($status.NextAgent -eq "Completo") { "✅ Finalizada" } else { $status.NextAgent }
                $newStatusTable += "`n| $($status.Activity) | $statusEmoji $($status.Progress)% | $($status.CurrentAgent) | $nextStep |"
            }
            
            # Substituir tabela no arquivo
            $updatedContent = $content -replace '(?s)\| Atividade.*?\n(?:\|.*?\n)*', "$newStatusTable`n"
            $updatedContent | Out-File -FilePath $parallelGuideFile -Encoding utf8
            
            Write-Host "  ✅ Guia atualizado com status atual" -ForegroundColor Green
        }
        
        Write-Host "✅ Sincronização concluída" -ForegroundColor Green
    }
    
    "reset" {
        if ($Activity) {
            Write-Host "🔄 Resetando atividade: $Activity" -ForegroundColor Yellow
            $activityPath = Join-Path $baseDir $Activity
            
            if (Test-Path $activityPath) {
                # Fazer backup antes de resetar
                $backupPath = "$activityPath.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
                Copy-Item -Path $activityPath -Destination $backupPath -Recurse
                Write-Host "📦 Backup criado: $backupPath" -ForegroundColor Gray
                
                # Resetar arquivos para templates
                $templateFiles = @("00-business-context.md", "01-ata-mesa-redonda.md", "02-requisitos-bdd.md", "03-arquitetura.md", "04-desenvolvimento.md", "05-qa-plano.md", "99-checklist-final.md")
                foreach ($file in $templateFiles) {
                    $filePath = Join-Path $activityPath $file
                    if (Test-Path $filePath) {
                        Remove-Item $filePath -Force
                        Write-Host "  🗑️ $file removido" -ForegroundColor Gray
                    }
                }
                
                # Re-executar start-manual.ps1 para recriar templates
                $startManualScript = Join-Path $PSScriptRoot "start-manual.ps1"
                if (Test-Path $startManualScript) {
                    & $startManualScript -Sprint $Sprint -Activity $Activity -Context "Reset - $(Get-Date)"
                    Write-Host "  ✅ Templates recriados" -ForegroundColor Green
                }
                
                Write-Host "🔄 Reset concluído para: $Activity" -ForegroundColor Green
            } else {
                Write-Error "❌ Atividade '$Activity' não encontrada"
            }
        } else {
            Write-Error "❌ Parâmetro -Activity é obrigatório para reset"
        }
    }
}

Write-Host ""