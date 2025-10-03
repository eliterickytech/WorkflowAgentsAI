param(
  [Parameter(Mandatory=$true)][string]$Sprint
)

# Configuração
$scriptDir = $PSScriptRoot

Write-Host ""
Write-Host "🚀 AgileDevAgent - Quick Start" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green
Write-Host "Sprint: $Sprint" -ForegroundColor Cyan
Write-Host ""

Write-Host "Escolha o modo de operação:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. 📝 Atividade única (modo tradicional)" -ForegroundColor White
Write-Host "2. ⚡ Múltiplas atividades em paralelo" -ForegroundColor White  
Write-Host "3. 📊 Gerenciar atividades existentes" -ForegroundColor White
Write-Host "4. 🔄 Pipeline escalonado avançado" -ForegroundColor White
Write-Host "5. 🎯 Mesa Redonda apenas (decisão específica)" -ForegroundColor White
Write-Host "6. ❓ Ajuda e documentação" -ForegroundColor White
Write-Host ""

$escolha = Read-Host "Digite sua escolha (1-6)"

switch ($escolha) {
    "1" {
        Write-Host ""
        Write-Host "📝 MODO: Atividade Única" -ForegroundColor Cyan
        Write-Host ""
        
        $activity = Read-Host "Nome da atividade (ex: sistema-login, modulo-relatorios)"
        $context = Read-Host "Contexto/descrição (opcional)"
        
        if ($activity) {
            Write-Host ""
            Write-Host "🏗️ Criando atividade única..." -ForegroundColor Yellow
            
            $startManualScript = Join-Path $scriptDir "start-manual.ps1"
            & $startManualScript -Sprint $Sprint -Activity $activity -Context $context
            
            Write-Host ""
            Write-Host "✅ Atividade criada!" -ForegroundColor Green
            Write-Host ""
            Write-Host "🎯 Próximo passo:" -ForegroundColor Yellow
            Write-Host "@agents/manual/product-owner.agent.md" -ForegroundColor White
            Write-Host "Sprint: $Sprint, Activity: $activity" -ForegroundColor Gray
        } else {
            Write-Host "❌ Nome da atividade é obrigatório" -ForegroundColor Red
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "⚡ MODO: Múltiplas Atividades Paralelas" -ForegroundColor Cyan
        Write-Host ""
        
        Write-Host "Digite as atividades separadas por vírgula:" -ForegroundColor Yellow
        Write-Host "Exemplo: sistema-login, modulo-relatorios, integracao-sap" -ForegroundColor Gray
        $activitiesInput = Read-Host "Atividades"
        
        if ($activitiesInput) {
            $activities = $activitiesInput -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
            
            Write-Host ""
            Write-Host "Configurações opcionais:" -ForegroundColor Yellow
            $sharedContext = Read-Host "Contexto compartilhado (opcional)"
            
            Write-Host ""
            Write-Host "Opções avançadas:" -ForegroundColor Yellow
            Write-Host "1. Básico (apenas criar estruturas)" -ForegroundColor White
            Write-Host "2. Com guia de paralelização" -ForegroundColor White
            Write-Host "3. Com pipeline completo" -ForegroundColor White
            Write-Host "4. Configuração completa (recomendado)" -ForegroundColor White
            
            $config = Read-Host "Configuração desejada (1-4, padrão: 4)"
            if (-not $config) { $config = "4" }
            
            # Preparar parâmetros
            $params = @{
                Sprint = $Sprint
                Activities = $activities
            }
            
            if ($sharedContext) { $params.SharedContext = $sharedContext }
            
            switch ($config) {
                "2" { $params.ParallelSetup = $true }
                "3" { $params.CreatePipeline = $true }
                "4" { 
                    $params.ParallelSetup = $true
                    $params.CreatePipeline = $true
                }
            }
            
            Write-Host ""
            Write-Host "🏗️ Criando $($activities.Count) atividades..." -ForegroundColor Yellow
            
            $multiActivitiesScript = Join-Path $scriptDir "start-multi-activities.ps1"
            & $multiActivitiesScript @params
            
            Write-Host ""
            Write-Host "✅ Múltiplas atividades criadas!" -ForegroundColor Green
            Write-Host ""
            Write-Host "🎯 Próximos passos:" -ForegroundColor Yellow
            Write-Host "Execute Product Owner em paralelo para cada atividade:" -ForegroundColor White
            
            foreach ($activity in $activities) {
                Write-Host ""
                Write-Host "# Terminal/VS Code: $activity" -ForegroundColor Cyan
                Write-Host "@agents/manual/product-owner.agent.md" -ForegroundColor White
                Write-Host "Sprint: $Sprint, Activity: $activity" -ForegroundColor Gray
            }
            
            if ($config -in @("2", "3", "4")) {
                Write-Host ""
                Write-Host "📋 Arquivos de apoio criados:" -ForegroundColor Yellow
                Write-Host "- parallel-execution-guide.md (guia de execução)" -ForegroundColor White
                if ($config -in @("3", "4")) {
                    Write-Host "- pipeline-schedule.md (cronograma otimizado)" -ForegroundColor White
                    Write-Host "- dependency-matrix.md (análise de dependências)" -ForegroundColor White
                }
            }
        } else {
            Write-Host "❌ Lista de atividades é obrigatória" -ForegroundColor Red
        }
    }
    
    "3" {
        Write-Host ""
        Write-Host "📊 MODO: Gerenciar Atividades Existentes" -ForegroundColor Cyan
        Write-Host ""
        
        $manageScript = Join-Path $scriptDir "manage-parallel-execution.ps1"
        
        if (-not (Test-Path $manageScript)) {
            Write-Host "❌ Script de gerenciamento não encontrado" -ForegroundColor Red
            return
        }
        
        Write-Host "Opções de gerenciamento:" -ForegroundColor Yellow
        Write-Host "1. 📊 Ver status geral" -ForegroundColor White
        Write-Host "2. 🎯 Próximas execuções recomendadas" -ForegroundColor White
        Write-Host "3. 🔍 Análise de conflitos" -ForegroundColor White
        Write-Host "4. 🔄 Sincronizar status" -ForegroundColor White
        Write-Host "5. 🗑️ Reset de atividade específica" -ForegroundColor White
        
        $action = Read-Host "Escolha a ação (1-5)"
        
        switch ($action) {
            "1" { & $manageScript -Sprint $Sprint -Action status }
            "2" { & $manageScript -Sprint $Sprint -Action next }
            "3" { & $manageScript -Sprint $Sprint -Action conflicts }
            "4" { & $manageScript -Sprint $Sprint -Action sync }
            "5" {
                $activity = Read-Host "Nome da atividade para reset"
                if ($activity) {
                    Write-Host "⚠️ Isso irá resetar a atividade '$activity' para o estado inicial." -ForegroundColor Yellow
                    $confirm = Read-Host "Confirma? (s/N)"
                    if ($confirm -eq 's' -or $confirm -eq 'S') {
                        & $manageScript -Sprint $Sprint -Action reset -Activity $activity
                    } else {
                        Write-Host "Reset cancelado." -ForegroundColor Gray
                    }
                } else {
                    Write-Host "❌ Nome da atividade é obrigatório" -ForegroundColor Red
                }
            }
            default {
                Write-Host "❌ Opção inválida" -ForegroundColor Red
            }
        }
    }
    
    "4" {
        Write-Host ""
        Write-Host "🔄 MODO: Pipeline Escalonado Avançado" -ForegroundColor Cyan
        Write-Host ""
        
        Write-Host "Este modo cria um pipeline otimizado para máxima eficiência." -ForegroundColor Yellow
        Write-Host ""
        
        Write-Host "Digite as atividades separadas por vírgula:" -ForegroundColor Yellow
        Write-Host "Exemplo: login, relatorios, sap, dashboard, api" -ForegroundColor Gray
        $activitiesInput = Read-Host "Atividades"
        
        if ($activitiesInput) {
            $activities = $activitiesInput -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
            
            Write-Host ""
            Write-Host "Configurações do pipeline:" -ForegroundColor Yellow
            $sharedContext = Read-Host "Contexto do projeto (ex: Sistema ERP integrado)"
            
            Write-Host ""
            Write-Host "🚀 Criando pipeline completo..." -ForegroundColor Yellow
            
            $multiActivitiesScript = Join-Path $scriptDir "start-multi-activities.ps1"
            & $multiActivitiesScript -Sprint $Sprint -Activities $activities -SharedContext $sharedContext -ParallelSetup -CreatePipeline -AutoDetectDependencies
            
            Write-Host ""
            Write-Host "✅ Pipeline escalonado criado!" -ForegroundColor Green
            Write-Host ""
            Write-Host "📋 Documentos gerados:" -ForegroundColor Yellow
            Write-Host "- parallel-execution-guide.md" -ForegroundColor White
            Write-Host "- pipeline-schedule.md" -ForegroundColor White
            Write-Host "- dependency-matrix.md" -ForegroundColor White
            Write-Host ""
            Write-Host "🎯 Siga o cronograma em pipeline-schedule.md para execução otimizada!" -ForegroundColor Cyan
        } else {
            Write-Host "❌ Lista de atividades é obrigatória" -ForegroundColor Red
        }
    }
    
    "5" {
        Write-Host ""
        Write-Host "🎯 MODO: Mesa Redonda Específica" -ForegroundColor Cyan
        Write-Host ""
        
        Write-Host "Para decisões técnicas específicas ou debates entre especialistas." -ForegroundColor Yellow
        Write-Host ""
        
        $topic = Read-Host "Tópico da discussão (ex: escolha-arquitetura, decisao-tecnologia)"
        $focus = Read-Host "Foco específico (ex: performance, segurança, escalabilidade)"
        
        if ($topic) {
            Write-Host ""
            Write-Host "🏗️ Criando estrutura para Mesa Redonda..." -ForegroundColor Yellow
            
            $startManualScript = Join-Path $scriptDir "start-manual.ps1"
            & $startManualScript -Sprint $Sprint -Activity $topic -Context "Mesa Redonda: $focus"
            
            Write-Host ""
            Write-Host "✅ Estrutura criada!" -ForegroundColor Green
            Write-Host ""
            Write-Host "🎯 Execute a Mesa Redonda:" -ForegroundColor Yellow
            Write-Host "@agents/manual/roundtable-facilitator.agent.md" -ForegroundColor White
            Write-Host ""
            Write-Host "Contexto sugerido:" -ForegroundColor Gray
            Write-Host "\"$focus - Debater entre especialistas e chegar a consenso técnico\"" -ForegroundColor Gray
        } else {
            Write-Host "❌ Tópico da discussão é obrigatório" -ForegroundColor Red
        }
    }
    
    "6" {
        Write-Host ""
        Write-Host "❓ AJUDA E DOCUMENTAÇÃO" -ForegroundColor Cyan
        Write-Host ""
        
        Write-Host "📚 Documentação disponível:" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "📖 Guias principais:" -ForegroundColor White
        Write-Host "- docs/fluxo-completo.md (fluxo tradicional)" -ForegroundColor Gray
        Write-Host "- docs/guia-agentes-individuais.md (agentes separados)" -ForegroundColor Gray
        Write-Host "- README.md (visão geral do sistema)" -ForegroundColor Gray
        Write-Host ""
        
        Write-Host "⚡ Scripts de paralelização:" -ForegroundColor White
        Write-Host "- start-multi-activities.ps1 (criar múltiplas atividades)" -ForegroundColor Gray
        Write-Host "- manage-parallel-execution.ps1 (gerenciar execução)" -ForegroundColor Gray
        Write-Host "- quick-start.ps1 (este script)" -ForegroundColor Gray
        Write-Host ""
        
        Write-Host "🎯 Exemplos de uso:" -ForegroundColor White
        Write-Host ""
        Write-Host "# Atividade única:" -ForegroundColor Cyan
        Write-Host ".\powershell\start-manual.ps1 -Sprint 02 -Activity sistema-login" -ForegroundColor Gray
        Write-Host ""
        Write-Host "# Múltiplas atividades:" -ForegroundColor Cyan
        Write-Host ".\powershell\start-multi-activities.ps1 -Sprint 02 -Activities @(\"login\", \"relatorios\") -ParallelSetup" -ForegroundColor Gray
        Write-Host ""
        Write-Host "# Status das atividades:" -ForegroundColor Cyan
        Write-Host ".\powershell\manage-parallel-execution.ps1 -Sprint 02 -Action status" -ForegroundColor Gray
        Write-Host ""
        
        Write-Host "🚀 Para começar rapidamente:" -ForegroundColor Yellow
        Write-Host "1. Execute este script (quick-start.ps1) com sua escolha" -ForegroundColor White
        Write-Host "2. Siga as instruções na tela" -ForegroundColor White
        Write-Host "3. Use os guias gerados para execução otimizada" -ForegroundColor White
        Write-Host ""
        
        Write-Host "💡 Dica: Para projetos complexos, use sempre o modo 4 (Pipeline Escalonado)" -ForegroundColor Yellow
    }
    
    default {
        Write-Host ""
        Write-Host "❌ Opção inválida. Execute o script novamente." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "═══════════════════════════════" -ForegroundColor Green
Write-Host "🎉 AgileDevAgent - Execução concluída!" -ForegroundColor Green
Write-Host ""