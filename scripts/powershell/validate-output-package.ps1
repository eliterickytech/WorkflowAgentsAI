# Validates that client-facing evidence and report documents are fully populated.
[CmdletBinding()]
param(
    [string]$OutRoot = (Join-Path $PSScriptRoot "..\..\data\out")
)

class ValidationFinding {
    [string]$Path
    [string]$Message
    ValidationFinding([string]$path, [string]$message) {
        $this.Path = $path
        $this.Message = $message
    }
    [string]ToString() {
        return "$($this.Path): $($this.Message)"
    }
}

function Get-FileContent {
    param([string]$Path)
    return Get-Content -Path $Path -Encoding UTF8
}

function Test-RequiredLines {
    param(
        [string]$Path,
        [string[]]$Patterns,
        [string]$Description = ""
    )

    $findings = @()
    $lines = Get-FileContent -Path $Path

    foreach ($pattern in $Patterns) {
        $matchedLines = $lines | Where-Object { $_ -match $pattern }
        if ($null -eq $matchedLines -or $matchedLines.Count -eq 0) {
            $label = $Description
            if (-not $label) { $label = $pattern }
            $findings += [ValidationFinding]::new($Path, "Linha obrigatória ausente: $label")
            continue
        }

        foreach ($line in $matchedLines) {
            if ($line -match ":\s*$") {
                $findings += [ValidationFinding]::new($Path, "Valor ausente após '$line'")
            }
        }
    }

    return $findings
}

function Test-Placeholders {
    param(
        [string]$Path,
        [string[]]$Placeholders
    )

    $findings = @()
    $content = (Get-Content -Path $Path -Encoding UTF8 -Raw)

    foreach ($placeholder in $Placeholders) {
        if ($content -match $placeholder) {
            $findings += [ValidationFinding]::new($Path, "Substituir placeholder correspondente a expressão '$placeholder'")
        }
    }

    return $findings
}

function Test-StatusMarkers {
    param([string]$Path)
    $findings = @()
    $lines = Get-FileContent -Path $Path
    foreach ($line in $lines) {
        if ($line -match 'Status:\s*\?') {
            $findings += [ValidationFinding]::new($Path, "Status não preenchido corretamente: '$line'")
        }
    }
    return $findings
}

function Test-TableGaps {
    param(
        [string]$Path,
        [string[]]$Markers
    )

    $findings = @()
    $content = (Get-Content -Path $Path -Encoding UTF8 -Raw)
    foreach ($marker in $Markers) {
        if ($content -match $marker) {
            $findings += [ValidationFinding]::new($Path, "Tabela contém células vazias que precisam ser preenchidas.")
            break
        }
    }
    return $findings
}

function Assert-FileExists {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        throw "Arquivo obrigatório não encontrado: $Path"
    }
}

$outRootResolved = Resolve-Path -Path $OutRoot
$evidenceRoot = Join-Path $outRootResolved "evidence"
$reportRoot = Join-Path $outRootResolved "report"

if (-not (Test-Path $evidenceRoot)) {
    throw "Diretório de evidências não encontrado: $evidenceRoot"
}
if (-not (Test-Path $reportRoot)) {
    throw "Diretório de relatórios não encontrado: $reportRoot"
}

$findings = @()
$placeholderRegex = @(
    '\[A ser preenchido',
    '<AREA>',
    '<id>',
    '<squad>',
    '<sprint>',
    '<activity>',
    '\[Aguardando',
    '\[Responsável',
    'TODO'
)

$evidenceFiles = Get-ChildItem -Path $evidenceRoot -Recurse -Filter *.md
foreach ($file in $evidenceFiles) {
    $findings += Test-Placeholders -Path $file.FullName -Placeholders $placeholderRegex
    $findings += Test-StatusMarkers -Path $file.FullName
}

$tableGapMarkers = @(
    '\|\s*\|',
    '\|\s{2,}\|'
)

$techReport = Join-Path $reportRoot "area-atividade-Evidencias-Tecnicas.md"
Assert-FileExists -Path $techReport
$findings += Test-Placeholders -Path $techReport -Placeholders $placeholderRegex
$findings += Test-StatusMarkers -Path $techReport
$findings += Test-TableGaps -Path $techReport -Markers $tableGapMarkers
$findings += Test-RequiredLines -Path $techReport -Patterns @(
    '1\.\s*Projeto:',
    '-\s*Hash:',
    '-\s*Descrição:',
    'Total tests:',
    'Total time:',
    '-\s*Cenário:',
    '-\s*Dado que:',
    '-\s*Quando:',
    '-\s*Então:',
    '-\s*Endpoint / fluxo validado:',
    '-\s*Evidência \(screenshot/log\):',
    '-\s*Pendências técnicas:',
    '-\s*Itens para acompanhamento:',
    'Comando:\s*dotnet build',
    'Resultado:',
    '\*\*Gerado por:\*\*',
    '\*\*Data/Horário:\*\*'
) -Description "Campos obrigatórios no relatório técnico"

$execReport = Join-Path $reportRoot "area-atividade-Relatorio.md"
Assert-FileExists -Path $execReport
$findings += Test-Placeholders -Path $execReport -Placeholders $placeholderRegex
$findings += Test-StatusMarkers -Path $execReport
$findings += Test-TableGaps -Path $execReport -Markers $tableGapMarkers
$findings += Test-RequiredLines -Path $execReport -Patterns @(
    '-\s*Objetivo do projeto:',
    '-\s*Contexto e motivadores:',
    '-\s*Principais entregas desta entrega:',
    '-\s*Percentual concluído:',
    '-\s*Marcos atingidos / pendentes:',
    '-\s*Aderência a orçamento/horas:',
    '-\s*KPIs principais:',
    '1\.\s+\S',
    '-\s*Em andamento \(responsável / prazo\):',
    '-\s*Próximos passos planejados:',
    '-\s*Risco/Problema:',
    'Severidade / impacto:',
    'Ação de mitigação:',
    '-\s*Horas investidas nesta etapa:',
    '-\s*Estimativa humana equivalente:',
    '-\s*Consumo orçamentário',
    '-\s*Suites executadas \(build/test\):',
    '-\s*Resultados e cobertura:',
    '-\s*Bugs críticos em aberto:',
    '-\s*Cliente/usuário:',
    '-\s*Squad interna:',
    '-\s*Outras áreas:',
    '-\s*Resumo da entrega:',
    '-\s*Recomendações para o próximo ciclo:',
    '\|\s*Projeto\s*\|\s*Execução',
    '\*\*Dados de Controle\*\*',
    '-\s*Issue:',
    '-\s*Responsável:',
    '-\s*Data do relatório:'
) -Description "Campos obrigatórios no relatório executivo"

if ($findings.Count -gt 0) {
    Write-Host "Falhas de validação encontradas:`n" -ForegroundColor Yellow
    $findings | Sort-Object Path, Message | ForEach-Object {
        Write-Host (" - {0}" -f $_.ToString())
    }
    throw "Validação de evidências e relatórios falhou. Preencha os campos pendentes antes da entrega ao cliente."
}
else {
    Write-Host "✅ Evidências e relatórios verificados: estrutura preservada e campos preenchidos." -ForegroundColor Green
}
