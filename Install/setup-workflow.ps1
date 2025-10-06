<#$
.SYNOPSIS
  Instala e configura os Agentes RickytechAgileAgent em um diretório especificado.
.DESCRIPTION
  - Checa e instala pre-requisitos (Python, Node.js, Git, .NET SDK)
  - Pergunta modo (Manual ou CrewAI), Sprint e Activity
  - Configura variaveis de ambiente para esta sessao
  - Copia agentes e estrutura de workflow para o local informado
  - (Opcional) Cria .venv-1 e instala requirements
  - (Opcional) Enriquece agentes com instrucoes personalizadas de uma pasta
.NOTES
  Execute no PowerShell: powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
#>
param(
  [string]$TargetProjectPath,
  [switch]$Quiet
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Warn($msg) { Write-Warning $msg }
function Write-Err($msg)  { Write-Host "[ERROR] $msg" -ForegroundColor Red }

function Ask($prompt, $default="") {
  if ($Quiet) { return $default }
  $v = Read-Host "$prompt"; if ([string]::IsNullOrWhiteSpace($v)) { return $default } else { return $v }
}

function Ensure-Dir($p) { if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p | Out-Null } }

function Get-SafeCount($obj) {
  if ($obj -eq $null) { return 0 }
  if ($obj -is [array]) { return $obj.Count }
  return 1
}

function Check-Command($cmdName) {
  return [bool](Get-Command $cmdName -ErrorAction SilentlyContinue)
}

function Install-With-Winget($id, $display) {
  try {
    Write-Info "Instalando $display via winget..."
    winget install --id $id -e --accept-source-agreements --accept-package-agreements | Out-Null
    Write-Info "$display instalado."
  } catch { Write-Warn "Falha ao instalar $display. Instale manualmente se necessário." }
}

function Ensure-Prereqs() {
  Write-Info "Checando pre-requisitos..."
  if (-not (Check-Command python)) { Install-With-Winget 'Python.Python.3.12' 'Python 3' }
  if (-not (Check-Command node))   { Install-With-Winget 'OpenJS.NodeJS.LTS' 'Node.js LTS' }
  if (-not (Check-Command git))    { Install-With-Winget 'Git.Git' 'Git' }
  if (-not (Check-Command dotnet)) { Install-With-Winget 'Microsoft.DotNet.SDK.8' '.NET SDK 8' }

  # Mermaid CLI (opcional, mas útil para diagramas)
  if (-not (Check-Command mmdc)) {
    try { Write-Info 'Instalando Mermaid CLI global...'; npm install -g @mermaid-js/mermaid-cli | Out-Null } catch { Write-Warn 'Nao foi possivel instalar Mermaid CLI automaticamente.' }
  }
}

function Choose-Mode() {
  Write-Host "Selecione o modo:" -ForegroundColor Yellow
  Write-Host "  1) Manual (recomendado para comecar)"
  Write-Host "  2) Automatico (CrewAI)"
  $c = Ask 'Digite 1 ou 2' '1'
  if ($c -eq '2') { return 'crewai' } else { return 'manual' }
}

function Configure-Env($mode, $sprint, $activity) {
  if ($mode -eq 'crewai') {
    $env:USE_CREWAI = '1'
  } else {
    $env:USE_CREWAI = '0'
  }
  $env:USE_AUTOGEN = '0'
  if ($sprint) { $env:SPRINT = $sprint }
  if ($activity) { $env:OUTPUT_ACTIVITY = $activity }
}

function Create-EnvFile($target, $mode, $sprint, $activity, $projectName) {
  $envExample = Join-Path $target '.env.example'
  $envFile = Join-Path $target '.env'

  if (-not (Test-Path $envExample)) {
    Write-Warn "Arquivo .env.example não encontrado em $envExample"
    return
  }

  Write-Info "Criando arquivo .env baseado no .env.example..."
  $content = Get-Content -Path $envExample -Raw

  # Configurar valores baseados no modo selecionado
  if ($mode -eq 'crewai') {
    $content = $content -replace '^USE_CREWAI=.*', 'USE_CREWAI=1'
  } else {
    $content = $content -replace '^USE_CREWAI=.*', 'USE_CREWAI=0'
  }

  # Configurar sprint e activity se fornecidos
  if ($sprint) {
    $content = $content -replace '^SPRINT=.*', "SPRINT=$sprint"
  }
  if ($activity) {
    $content = $content -replace '^OUTPUT_ACTIVITY=.*', "OUTPUT_ACTIVITY=$activity"
  }
  if ($projectName) {
    $content = $content -replace '^PROJECT_NAME=.*', "PROJECT_NAME=$projectName"
  }

  Set-Content -Path $envFile -Value $content -Encoding UTF8
  Write-Info "Arquivo .env criado com as configuracoes: Modo=$mode, Sprint=$sprint, Activity=$activity, Projeto=$projectName"
}

function Copy-Workflow($target) {
  # Detectar caminho do script de forma mais robusta
  try {
    $scriptPath = $PSCommandPath
    if (-not $scriptPath) { $scriptPath = $MyInvocation.MyCommand.Definition }
    if (-not $scriptPath) { $scriptPath = $MyInvocation.MyCommand.Source }
    if (-not $scriptPath) {
      # Fallback: assumir que estamos em Install/ dentro do repo
      $scriptPath = Join-Path $PWD "setup-workflow.ps1"
    }

    $root = Split-Path -Parent $scriptPath
    $repoRoot = Split-Path -Parent $root

    Write-Info "Script: $scriptPath"
    Write-Info "Install dir: $root"
    Write-Info "Repo root: $repoRoot"
    Write-Info "Copiando pastas do workflow para: $target"
  }
  catch {
    Write-Err "Erro ao detectar caminhos: $_"
    return
  }

  $mandatory = @('agents','Install/orchestrators','scripts/powershell','requirements.txt','.env.example')
  $optional  = @('prompts-manual','docs')
  $exclude   = @('prompts-manual/prompts/deprecated')

  foreach ($m in $mandatory) {
    $src = Join-Path $repoRoot $m
    $dst = Join-Path $target $m
    if (Test-Path $src) {
      Write-Info "Copiando $m ..."
      # Se for Install/orchestrators, copiar como orchestrators no destino
      if ($m -eq 'Install/orchestrators') {
        $dst = Join-Path $target 'orchestrators'
      }
      Copy-Item -Path $src -Destination $dst -Recurse -Force
    } else { Write-Warn "Item obrigatório não encontrado: $m" }
  }
  foreach ($o in $optional) {
    $src = Join-Path $repoRoot $o
    $dst = Join-Path $target $o
    if (Test-Path $src) {
      $ans = Ask "Copiar opcional '$o'? (s/n)" 's'
      if ($ans -match '^[sSyY]') {
        Write-Info "Copiando $o ..."
        Copy-Item -Path $src -Destination $dst -Recurse -Force

        # Remover pasta deprecated se existir
        $deprecatedPath = Join-Path $dst "prompts/deprecated"
        if (Test-Path $deprecatedPath) {
          Remove-Item -Path $deprecatedPath -Recurse -Force
          Write-Info "Removida pasta deprecated de $o"
        }
      }
    }
  }
}

function Setup-Python($target) {
  $venv = Join-Path $target '.venv-1'
  if (-not (Test-Path $venv)) {
    Write-Info 'Criando ambiente Python .venv-1...'
    python -m venv $venv | Out-Null
  }
  $activate = Join-Path $venv 'Scripts/Activate.ps1'
  if (Test-Path $activate) {
    Write-Info 'Instalando dependências Python no .venv-1...'
    & (Join-Path $venv 'Scripts/python.exe') -m pip install --upgrade pip
    & (Join-Path $venv 'Scripts/python.exe') -m pip install -r (Join-Path $target 'requirements.txt')
  } else { Write-Warn 'Não foi possível ativar a venv automaticamente.' }
}

function Get-AgentPrompt($agentType, $sprint, $activity, $projectName) {
  switch ($agentType) {
    'product_owner' {
  return @"
Voce e o Product Owner Agent (otimizado para GPT-4o).

CONTEXTO:
- Solicitacao do cliente: data/in/sprint$sprint/$activity/business_request/
- Sprint: $sprint
- Activity: $activity
- Projeto: $projectName

RESPONSABILIDADES:
- Entender solicitacoes do cliente e requisitos de negocio
- Definir visao do produto e objetivos estrategicos
- Priorizar funcionalidades por valor de negocio
- Comunicar requisitos claramente para a equipe tecnica
- Validar entregas com stakeholders
- Gerenciar expectativas e alinhamento de escopo

HABILIDADES FUNDAMENTAIS:
- Comunicacao clara com todos os stakeholders e equipe
- Tomada de decisao rapida, baseada em dados e visao estrategica
- Capacidade de priorizacao do backlog, focando no valor para o cliente
- Boa relacao com a equipe de desenvolvimento, promovendo colaboracao
- Visao orientada para o negocio e para o produto
- Agilidade para adaptar-se a mudancas e entendimento do mercado

INSTRUCOES:
1. Analise a solicitacao do cliente identificando objetivos de negocio
2. Defina a visao do produto e metas estrategicas
3. Identifique stakeholders principais e suas necessidades
4. Priorize funcionalidades por valor de negocio e impacto
5. Elabore briefing claro para a equipe tecnica
6. Defina criterios de aceitacao e metricas de sucesso
7. Estabeleca cronograma e marcos importantes

CRITERIOS DE QUALIDADE:
- Visao de produto clara e alinhada com objetivos de negocio
- Priorizacao baseada em valor para o cliente
- Comunicacao transparente e objetiva
- Criterios de aceitacao bem definidos
- Alinhamento entre expectativas do cliente e capacidade tecnica
- Gestao proativa de riscos e dependencias

COMPORTAMENTOS A EVITAR:
- Micromanagement ou controle excessivo da equipe tecnica
- Superlotacao do backlog sem priorizacao real
- Negligencia no engajamento dos stakeholders
- Perda do proposito e visao do produto
- Falta de transparencia ou comunicacao inadequada

SAIDAS:
- Requirements Brief (visao geral, objetivos, stakeholders)
- Business Context (contexto de negocio, justificativas, metricas)
- User Stories priorizadas
- Criterios de aceitacao definidos
- Roadmap de entregas
- Template Mesa Redonda preenchido automaticamente
- Solicitacao de aprovacao para iniciar mesa redonda

FLUXO DE TRABALHO PO:
1. ANALISE COMPLETA: Processe documentos em business_request/
2. PREENCHIMENTO TEMPLATE: Substitua placeholders [PO_FILL_*] no template-mesa-redonda-gpt5.md
3. VALIDACAO INTERNA: Verifique preenchimento adequado
4. SOLICITACAO APROVACAO: Apresente documento e aguarde confirmacao
5. AGUARDE RESPOSTA: [SIM/NAO/REVISAR] antes de prosseguir

FORMATO SOLICITACAO APROVACAO:
'Mesa Redonda Preparada - Aguardando Aprovacao
Resumo: [regra], [complexidade], [impactos], [especialistas]
Status: Pronto para Execucao
Posso prosseguir? [SIM/NAO/REVISAR]'
"@
    }
    'requirements' {
  return @"
Voce e o Requirements Analyst Agent (otimizado para Gemini 2.5).

CONTEXTO:
- Documento fonte: data/in/sprint$sprint/$activity/attachments/
- Sprint: $sprint
- Activity: $activity
- Projeto: $projectName

RESPONSABILIDADES:
- Extrair regras de negocio e formulas dos documentos
- Produzir BDD e casos de teste abrangentes
- Mapear dependencias entre regras
- Validar consistencia com terminologia padrao
- Derivar cenarios de teste completos

INSTRUCOES:
1. Leia os documentos e extraia entidades de dominio, atores, regras de negocio
2. Construa Glossario (ID, termo, definicao, fonte)
3. Especifique FR no formato: FR-<ID> - [Nome] com descricao, fluxos, pre/pos-condicoes
4. Especifique NFR no formato: NFR-<ID> - [Atributo] com metricas verificaveis
5. Gere Casos de Teste BDD: Feature -> Scenarios (Given/When/Then)
6. Monte Matriz de Rastreabilidade (FR/NFR <-> Testes <-> Fontes)

CRITERIOS DE QUALIDADE:
- Precisao na extracao de formulas e dados
- Terminologia padronizada (RBA, RBAA, RBT12, SINAC)
- sinacCode sempre com 3 digitos
- Casos de teste abrangentes e alinhados ao dominio
- Clareza e testabilidade: use verbos DEVE/DEVERA
- Rastreabilidade ponta-a-ponta

SAIDAS:
- SRS.md completo e estruturado
- NFR_Catalog.md
- TestSuite_BDD.md com scenarios Given/When/Then
- Glossary.md
- Traceability.csv
"@
    }
    'architect' {
      return @"
Voce e o Systems Architect Agent (otimizado para GPT-5).

CONTEXTO:
- Analise de requisitos disponivel da etapa anterior
- Sprint: $sprint
- Activity: $activity
- Projeto: $projectName

RESPONSABILIDADES:
- Definir componentes e contratos
- Documentar decisoes arquiteturais (ADR)
- Projetar diagramas de solucao
- Planejar roadmap de implementacao
- Definir metricas de qualidade arquitetural

INSTRUCOES:
1. Analise os requisitos e identifique impactos arquiteturais
2. Projete bounded contexts com escalabilidade
3. Defina entidades, value objects e servicos necessarios
4. Especifique contratos e dependencias
5. Estabeleca estrategia de testes por camada
6. Documente decisoes em ADRs com justificativas

PADROES APLICAVEIS:
- DDD (Aggregates, Entities, Value Objects)
- SOLID e Clean Architecture
- CQRS quando aplicavel
- Padroes de performance e seguranca

CRITERIOS DE QUALIDADE:
- Bounded contexts bem definidos
- Separacao clara de responsabilidades
- Abstracoes reutilizaveis
- Consideracoes de performance e seguranca
- Roadmap faseado com riscos identificados

SAIDAS:
- Arquitetura.md com estrutura completa
- ADRs em adrs/ com decisoes justificadas
- Diagramas Mermaid em diagrams/
- Roadmap de implementacao
"@
    }
    'developer' {
      return @"
Voce e o Expert Developer Agent (otimizado para Claude 4).

CONTEXTO:
- Especificacao arquitetural da etapa anterior
- Sprint: $sprint
- Activity: $activity
- Projeto: $projectName

RESPONSABILIDADES:
- Implementar classes e validacoes conforme arquitetura
- Configurar DI, logs e documentacao tecnica
- Garantir tratamento robusto de erros
- Assegurar testabilidade maxima
- Aplicar padroes de codigo enterprise

PADROES TECNICOS:
- .NET Framework 4.8/5/8+ conforme projeto
- DDD, SOLID, Clean Architecture
- FluentValidation para validacoes
- Serilog para logging estruturado
- Async/await otimizado

INSTRUCOES:
1. Implemente classes conforme especificacao arquitetural
2. Aplique padroes SOLID rigorosamente
3. Configure validacoes com FluentValidation
4. Implemente logs estruturados informativos
5. Configure injecao de dependencia
6. Documente com XML comments completos
7. Garanta compilacao sem warnings

CRITERIOS DE QUALIDADE:
- Zero warnings de compilacao
- 100% XML docs em membros publicos
- SRP estrito e DDD com precisao
- Abstracoes elegantes e performance
- Thread-safety quando necessario
- Pontos claros para injecao/mocking
- Separacao adequada de infraestrutura

SAIDAS:
- Classes implementadas e documentadas
- Validadores configurados
- Logs estruturados implementados
- Configuracao de DI atualizada
- Codigo compilando sem warnings
"@
    }
    'testing' {
      return @"
Voce e o Testing Specialist Agent.

CONTEXTO:
- Codigo implementado da etapa anterior
- Sprint: $sprint
- Activity: $activity
- Projeto: $projectName
- Meta de cobertura: 90%+

RESPONSABILIDADES:
- Analisar componentes e identificar cenarios de teste
- Implementar testes unitarios abrangentes
- Criar testes de integracao quando necessario
- Executar testes e coletar metricas de cobertura
- Documentar cenarios criticos e edge cases

ESTRATEGIAS DE TESTE:
- Testes unitarios com xUnit/NUnit
- Fixtures com Bogus para dados de teste
- Mocking com Moq/NSubstitute
- Testes de integracao com TestHost
- Cobertura de casos extremos e validacoes

INSTRUCOES:
1. Analise o codigo implementado identificando pontos criticos
2. Implemente testes unitarios para cada componente
3. Crie fixtures e mocks apropriados
4. Cubra casos de sucesso, erro e edge cases
5. Execute testes e colete metricas de cobertura
6. Documente cenarios de teste criticos
7. Valide que a cobertura atinge 90%+

CRITERIOS DE QUALIDADE:
- Cobertura >= 90% do codigo critico
- Testes independentes e deterministicos
- Nomes de teste descritivos e claros
- Arrange/Act/Assert bem estruturado
- Mocks apropriados sem over-mocking
- Performance adequada da suite de testes

SAIDAS:
- Plano de testes detalhado
- Testes unitarios implementados
- Testes de integracao quando aplicavel
- Relatorio de cobertura
- Documentacao de cenarios criticos
"@
    }
  }
}

function Configure-SuperPrompt($target, $sprint, $activity, $projectName) {
  $superPromptPath = Join-Path $target 'prompts-manual/prompts/super-prompt.md'
  if (-not (Test-Path $superPromptPath)) {
    Write-Warn "Super-prompt não encontrado em $superPromptPath"
    return
  }

  Write-Info "Configurando super-prompt com contexto enriquecido dos agentes..."

  # Obter prompts otimizados para cada agente
  $productOwnerPrompt = Get-AgentPrompt 'product_owner' $sprint $activity $projectName
  $requirementsPrompt = Get-AgentPrompt 'requirements' $sprint $activity $projectName
  $architectPrompt = Get-AgentPrompt 'architect' $sprint $activity $projectName
  $developerPrompt = Get-AgentPrompt 'developer' $sprint $activity $projectName
  $testingPrompt = Get-AgentPrompt 'testing' $sprint $activity $projectName

  # Criar super-prompt enriquecido com codificação limpa
  $enrichedSuperPrompt = "# Super Prompt - Implementacao Completa (Enriquecido)`n`n"
  $enrichedSuperPrompt += "Voce coordenara a implementacao COMPLETA da [REGRA-ALVO] usando a cadeia de agentes especializados.`n`n"

  $enrichedSuperPrompt += "CONTEXTO GERAL:`n"
  $enrichedSuperPrompt += "- Regra: [RN-00xx] - [Descricao da regra]`n"
  $enrichedSuperPrompt += "- Documento fonte: data/in/sprint$sprint/$activity/attachments/`n"
  $enrichedSuperPrompt += "- Projeto: $projectName`n"
  $enrichedSuperPrompt += "- Meta: Implementacao end-to-end com 90%+ cobertura de testes`n`n"

  $enrichedSuperPrompt += "PARAMETROS DE EXECUCAO:`n"
  $enrichedSuperPrompt += "- Sprint: $sprint`n"
  $enrichedSuperPrompt += "- Activity: $activity`n"
  $enrichedSuperPrompt += "- Convencao de saida: out/sprint$sprint/$activity/`n`n"

  $enrichedSuperPrompt += "POLITICA DE EXECUCAO:`n"
  $enrichedSuperPrompt += "- Nao faca perguntas. Se faltar informacao, adote ate 3 suposicoes razoaveis, liste-as no inicio e prossiga.`n"
  $enrichedSuperPrompt += "- Salve cada etapa exatamente nos caminhos abaixo.`n`n"

  $enrichedSuperPrompt += "MAPEAMENTO DE SAIDAS:`n"
  $enrichedSuperPrompt += "- 00-requirements-brief.md -> out/sprint$sprint/$activity/00-requirements-brief.md`n"
  $enrichedSuperPrompt += "- 01-ata-mesa-redonda.md -> out/sprint$sprint/$activity/01-ata-mesa-redonda.md`n"
  $enrichedSuperPrompt += "- 02-requisitos-bdd.md (+ arquivos .feature) -> out/sprint$sprint/$activity/02-requisitos-bdd.md e out/sprint$sprint/$activity/features/`n"
  $enrichedSuperPrompt += "- 03-arquitetura.md (+ ADRs e diagramas) -> out/sprint$sprint/$activity/03-arquitetura.md; ADRs em out/sprint$sprint/$activity/adrs/; diagramas em out/sprint$sprint/$activity/diagrams/`n"
  $enrichedSuperPrompt += "- 04-desenvolvimento.md -> out/sprint$sprint/$activity/04-desenvolvimento.md`n"
  $enrichedSuperPrompt += "- 05-qa-plano.md -> out/sprint$sprint/$activity/05-qa-plano.md`n`n"

  $enrichedSuperPrompt += "CADEIA DE EXECUCAO:`n`n"
  $enrichedSuperPrompt += "=" * 80 + "`n"
  $enrichedSuperPrompt += "ETAPA 0 - PRODUCT OWNER AGENT:`n`n"
  $enrichedSuperPrompt += $productOwnerPrompt + "`n`n"
  $enrichedSuperPrompt += "TAREFA ESPECIFICA:`n"
  $enrichedSuperPrompt += "1. Analise solicitacao do cliente em: data/in/sprint$sprint/$activity/business_request/`n"
  $enrichedSuperPrompt += "2. Produza: out/sprint$sprint/$activity/00-requirements-brief.md`n"
  $enrichedSuperPrompt += "3. Defina contexto de negocio em: out/sprint$sprint/$activity/00-business-context.md`n"
  $enrichedSuperPrompt += "4. Preencha template-mesa-redonda-gpt5.md substituindo TODOS os placeholders [PO_FILL_*]`n"
  $enrichedSuperPrompt += "5. Solicite aprovacao para execucao da mesa redonda: [SIM/NAO/REVISAR]`n`n"
  $enrichedSuperPrompt += "AO FINALIZAR: Aguarde aprovacao antes de prosseguir para proxima etapa.`n`n"

  $enrichedSuperPrompt += "=" * 80 + "`n"
  $enrichedSuperPrompt += "ETAPA 1 - REQUIREMENTS ANALYST AGENT:`n`n"
  $enrichedSuperPrompt += $requirementsPrompt + "`n`n"
  $enrichedSuperPrompt += "TAREFA ESPECIFICA:`n"
  $enrichedSuperPrompt += "1. Analise documentos em: data/in/sprint$sprint/$activity/attachments/`n"
  $enrichedSuperPrompt += "2. Produza: out/sprint$sprint/$activity/02-requisitos-bdd.md`n"
  $enrichedSuperPrompt += "3. Crie features em: out/sprint$sprint/$activity/features/`n`n"
  $enrichedSuperPrompt += "AO FINALIZAR: Passe os resultados para o Systems Architect Agent.`n`n"

  $enrichedSuperPrompt += "=" * 80 + "`n"
  $enrichedSuperPrompt += "ETAPA 2 - SYSTEMS ARCHITECT AGENT:`n`n"
  $enrichedSuperPrompt += $architectPrompt + "`n`n"
  $enrichedSuperPrompt += "TAREFA ESPECIFICA:`n"
  $enrichedSuperPrompt += "1. Use resultados da analise anterior`n"
  $enrichedSuperPrompt += "2. Produza: out/sprint$sprint/$activity/03-arquitetura.md`n"
  $enrichedSuperPrompt += "3. Crie ADRs em: out/sprint$sprint/$activity/adrs/`n"
  $enrichedSuperPrompt += "4. Gere diagramas em: out/sprint$sprint/$activity/diagrams/`n`n"
  $enrichedSuperPrompt += "AO FINALIZAR: Passe as especificacoes para o Expert Developer Agent.`n`n"

  $enrichedSuperPrompt += "=" * 80 + "`n"
  $enrichedSuperPrompt += "ETAPA 3 - EXPERT DEVELOPER AGENT:`n`n"
  $enrichedSuperPrompt += $developerPrompt + "`n`n"
  $enrichedSuperPrompt += "TAREFA ESPECIFICA:`n"
  $enrichedSuperPrompt += "1. Use especificacao arquitetural anterior`n"
  $enrichedSuperPrompt += "2. Produza: out/sprint$sprint/$activity/04-desenvolvimento.md`n"
  $enrichedSuperPrompt += "3. Implemente codigo seguindo padroes do projeto $projectName`n`n"
  $enrichedSuperPrompt += "AO FINALIZAR: Passe o codigo implementado para o Testing Specialist Agent.`n`n"

  $enrichedSuperPrompt += "=" * 80 + "`n"
  $enrichedSuperPrompt += "ETAPA 4 - TESTING SPECIALIST AGENT:`n`n"
  $enrichedSuperPrompt += $testingPrompt + "`n`n"
  $enrichedSuperPrompt += "TAREFA ESPECIFICA:`n"
  $enrichedSuperPrompt += "1. Use codigo da etapa anterior`n"
  $enrichedSuperPrompt += "2. Produza: out/sprint$sprint/$activity/05-qa-plano.md`n`n"

  $enrichedSuperPrompt += "=" * 80 + "`n"
  $enrichedSuperPrompt += "ENTREGAVEIS FINAIS:`n"
  $enrichedSuperPrompt += "1. Requirements Brief e contexto de negocio (00-requirements-brief.md + 00-business-context.md)`n"
  $enrichedSuperPrompt += "2. Ata de mesa redonda (01-ata-mesa-redonda.md)`n"
  $enrichedSuperPrompt += "3. Analise de requisitos completa (02-requisitos-bdd.md + features/)`n"
  $enrichedSuperPrompt += "4. Arquitetura documentada (03-arquitetura.md + ADRs + diagramas)`n"
  $enrichedSuperPrompt += "5. Codigo implementado (04-desenvolvimento.md)`n"
  $enrichedSuperPrompt += "6. Plano de testes (05-qa-plano.md)`n"
  $enrichedSuperPrompt += "7. Documentacao tecnica completa`n`n"
  $enrichedSuperPrompt += "EXECUTE TODA A CADEIA SEQUENCIALMENTE e me entregue todos os artefatos organizados.`n`n"

  $enrichedSuperPrompt += "## Estrutura de Pastas Criada:`n"
  $enrichedSuperPrompt += "- data/in/sprint$sprint/$activity/business_request/ (solicitacoes do cliente)`n"
  $enrichedSuperPrompt += "- data/in/sprint$sprint/$activity/attachments/ (documentos fonte tecnicos)`n"
  $enrichedSuperPrompt += "- out/sprint$sprint/$activity/ (saidas principais)`n"
  $enrichedSuperPrompt += "  - features/ (arquivos .feature BDD)`n"
  $enrichedSuperPrompt += "  - adrs/ (Architecture Decision Records)`n"
  $enrichedSuperPrompt += "  - diagrams/ (diagramas Mermaid)`n`n"

  $enrichedSuperPrompt += "## Como Usar:`n"
  $enrichedSuperPrompt += "1. Coloque solicitacao do cliente em: data/in/sprint$sprint/$activity/business_request/`n"
  $enrichedSuperPrompt += "2. Coloque documentos tecnicos em: data/in/sprint$sprint/$activity/attachments/`n"
  $enrichedSuperPrompt += "3. Execute este prompt no seu LLM`n"
  $enrichedSuperPrompt += "4. Colete os artefatos em: out/sprint$sprint/$activity/`n"

  # Criar pastas de entrada
  $inputPath = Join-Path $target "data/in/sprint$sprint/$activity/attachments"
  $businessRequestPath = Join-Path $target "data/in/sprint$sprint/$activity/business_request"
  Ensure-Dir $inputPath
  Ensure-Dir $businessRequestPath

  # Criar pastas de saída
  $outputPath = Join-Path $target "out/sprint$sprint/$activity"
  Ensure-Dir $outputPath
  Ensure-Dir (Join-Path $outputPath "features")
  Ensure-Dir (Join-Path $outputPath "adrs")
  Ensure-Dir (Join-Path $outputPath "diagrams")

  # Salvar com codificação UTF-8 sem BOM para evitar problemas de caracteres especiais
  [System.IO.File]::WriteAllText($superPromptPath, $enrichedSuperPrompt, [System.Text.UTF8Encoding]::new($false))
  Write-Info "Super-prompt enriquecido configurado com contexto completo dos agentes!"
  Write-Info "Entrada: $inputPath"
  Write-Info "Saida: $outputPath"
}

function Start-ManualWorkflow($target, $sprint, $activity) {
  $startScript = Join-Path $target 'powershell/start-manual.ps1'
  if (-not (Test-Path $startScript)) {
    Write-Warn "Script start-manual.ps1 nao encontrado em $startScript"
    return
  }

  Write-Info "Executando o fluxo manual automaticamente..."
  try {
    Set-Location $target
    $params = @()
    if ($sprint) { $params += "-Sprint"; $params += $sprint }
    if ($activity) { $params += "-Activity"; $params += $activity }

    & powershell -NoProfile -ExecutionPolicy Bypass -File $startScript @params
    Write-Info "Fluxo manual iniciado com sucesso!"
  }
  catch {
    Write-Warn "Erro ao executar o fluxo manual: $_"
    Write-Info "Você pode executar manualmente com o comando:"
    Write-Host "powershell -NoProfile -ExecutionPolicy Bypass -File .\\powershell\\start-manual.ps1 -Sprint $sprint -Activity $activity" -ForegroundColor Gray
  }
}

function Enrich-Agents($target, $instructionsPath) {
  if (-not (Test-Path $instructionsPath)) { Write-Warn "Pasta de instrucoes nao encontrada: $instructionsPath"; return }
  $agentsPath = Join-Path $target 'agents/manual'
  if (-not (Test-Path $agentsPath)) { Write-Warn "Pasta de agentes manuais nao encontrada em $agentsPath"; return }

  Write-Info "Enriquecendo agentes com instrucoes em: $instructionsPath"
  $map = @{
    'product-owner'        = 'product-owner.agent.md'
    'expert-developer'     = 'expert-developer.agent.md'
    'systems-architect'    = 'systems-architect.agent.md'
    'requirements-analyst' = 'requirements-analyst.agent.md'
    'testing-specialist'   = 'testing-specialist.agent.md'
    'roundtable-facilitator' = 'roundtable-facilitator.agent.md'
  }

  foreach ($role in $map.Keys) {
    $fileBase = Get-ChildItem -Path $instructionsPath -Filter "$role.instructions.*" -File -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($null -ne $fileBase) {
      $content = Get-Content -Path $fileBase.FullName -Raw
      $agentFile = Join-Path $agentsPath $map[$role]
      if (Test-Path $agentFile) {
        Write-Info "Atualizando agente $role com novas instrucoes (modo idempotente)..."
        $header = "### Custom Instructions (instalador)"
        $agentText = Get-Content -Path $agentFile -Raw
        if ($agentText.IndexOf($header) -ge 0) {
          # Substitui o bloco existente a partir do header ate o fim do arquivo
          $idx = $agentText.IndexOf($header)
          $prefix = $agentText.Substring(0, $idx).TrimEnd("`r","`n")
          $newBlock = "`n`n---`n### Custom Instructions (instalador)`n$content"
          $newText = $prefix + $newBlock
          Set-Content -Path $agentFile -Value $newText -Encoding UTF8
        } else {
          # Acrescenta o bloco ao final
          Add-Content -Path $agentFile -Value "`n`n---`n### Custom Instructions (instalador)`n$content"
        }
      } else { Write-Warn "Arquivo do agente nao encontrado: $agentFile" }
    } else {
      Write-Info "Nenhuma instrucao personalizada encontrada para $role (esperado: $($role).instructions.md|txt)"
    }
  }
}

function Analyze-ExistingProject($projectPath, $target) {
  Write-Info "Analisando projeto existente em: $projectPath"

  $analysis = @{
    ProjectPath = $projectPath
    ProjectType = ""
    ProjectStructure = @()
    Technologies = @()
    Patterns = @()
    Dependencies = @()
    Conventions = @()
    DatabaseContext = @()
    TestFrameworks = @()
    BuildTools = @()
    Scripts = @()
    CopilotInstructions = ""
    HasCopilotInstructions = $false
    IsMultiProject = $false
    MainProject = $null
    OtherProjects = @()
    MultiProjectCopilot = @()
  }

  # Detectar se é workspace multi-projeto
  $detectedProjects = Detect-MultiProjectWorkspace -workspacePath $projectPath

  # Garantir que $detectedProjects seja um array e obter contagem segura
  if (-not $detectedProjects) { $detectedProjects = @() }
  if ($detectedProjects -isnot [array]) { $detectedProjects = @($detectedProjects) }
  $projectCount = if ($detectedProjects -is [array]) { $detectedProjects.Count } else { if ($detectedProjects) { 1 } else { 0 } }

  if ($projectCount -gt 1) {
    $analysis.IsMultiProject = $true
    $projectSelection = Choose-ProjectsForAnalysis -projects $detectedProjects

    $analysis.MainProject = $projectSelection.MainProject
    $analysis.OtherProjects = $projectSelection.OtherProjects

    # Analisar projeto principal em detalhes
    $projectType = $projectSelection.MainProject.Type
    $analysis.ProjectType = $projectType
    $analysis.ProjectPath = $projectSelection.MainProject.Path

    Write-Info "Workspace multi-projeto detectado!"
    Write-Info "Projeto principal: $($projectSelection.MainProject.Name) (tipo: $projectType)"
    $otherProjectsCount = if ($projectSelection.OtherProjects -is [array]) { $projectSelection.OtherProjects.Count } else { if ($projectSelection.OtherProjects) { 1 } else { 0 } }
    Write-Info "Projetos adicionais: $otherProjectsCount"
  } else {
    # Projeto único - usar fluxo original
    $projectType = Detect-ProjectType -projectPath $projectPath
    $analysis.ProjectType = $projectType
    Write-Info "Projeto unico detectado: $projectType"
  }

  # Analisar estrutura básica (comum a todos os tipos)
  if (Test-Path "$projectPath\src") { $analysis.ProjectStructure += "Código fonte organizado (/src)" }
  if ((Test-Path "$projectPath\test") -or (Test-Path "$projectPath\tests") -or (Test-Path "$projectPath\Tests")) {
    $analysis.ProjectStructure += "Pasta de testes dedicada"
  }
  if ((Test-Path "$projectPath\docs") -or (Test-Path "$projectPath\doc")) {
    $analysis.ProjectStructure += "Documentação organizada"
  }

  # Determinar caminho para análise (projeto principal ou único)
  $analysisPath = if ($analysis.IsMultiProject) { $analysis.MainProject.Path } else { $projectPath }

  # Detectar GitHub Copilot instructions
  if ($analysis.IsMultiProject) {
    Analyze-MultiProjectCopilot -analysis $analysis
  } else {
    Analyze-CopilotInstructions -projectPath $analysisPath -analysis $analysis
  }

  # Análise específica por tipo de projeto (focada no projeto principal)
  switch ($projectType) {
    "dotnet" { Analyze-DotNetProject -projectPath $analysisPath -analysis $analysis }
    "nodejs" { Analyze-NodeJsProject -projectPath $analysisPath -analysis $analysis }
    "angular" { Analyze-AngularProject -projectPath $analysisPath -analysis $analysis }
    "react" { Analyze-ReactProject -projectPath $analysisPath -analysis $analysis }
    default { Analyze-GenericProject -projectPath $analysisPath -analysis $analysis }
  }

  # Analisar convenções de código (específico por linguagem)
  if ($projectType -eq "dotnet") {
    $csFiles = Get-ChildItem "$projectPath" -Recurse -Filter "*.cs" -ErrorAction SilentlyContinue | Select-Object -First 5
    foreach ($file in $csFiles) {
      try {
        $content = Get-Content $file.FullName -ErrorAction SilentlyContinue | Select-Object -First 10
        $namespaceLines = $content | Where-Object { $_ -match "^namespace\s+" }
        if ($namespaceLines) {
          $analysis.Conventions += $namespaceLines[0].Trim()
          break
        }
      } catch { }
    }
  }

  # Remover duplicatas
  $analysis.Technologies = $analysis.Technologies | Sort-Object | Get-Unique
  $analysis.Patterns = $analysis.Patterns | Sort-Object | Get-Unique
  $analysis.DatabaseContext = $analysis.DatabaseContext | Sort-Object | Get-Unique
  $analysis.TestFrameworks = $analysis.TestFrameworks | Sort-Object | Get-Unique

  # Gerar arquivo de contexto
  Generate-ProjectContext -analysis $analysis -target $target

  Write-Info "Analise do projeto concluida!"
  return $analysis
}

function Generate-ProjectContext($analysis, $target) {
  $contextFile = Join-Path $target "project-analysis.md"

  $content = @"
# Análise Automática do Projeto Existente

**Projeto analisado:** ``$($analysis.ProjectPath)``
**Tipo de projeto:** ``$($analysis.ProjectType.ToUpper())``
**Workspace:** $( if ($analysis.IsMultiProject) { "Multi-projeto ($((Get-SafeCount $analysis.OtherProjects) + 1) projetos)" } else { "Projeto unico" } )
**Data da analise:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

## Resumo Executivo
$( if ($analysis.IsMultiProject) {
    "Este e um **workspace multi-projeto** com foco no projeto **$($analysis.MainProject.Name)** (tipo: $($analysis.ProjectType))."
  } else {
    "Este e um projeto **$($analysis.ProjectType)**"
  } ) com as seguintes caracteristicas principais:
$( if ((Get-SafeCount $analysis.Technologies) -gt 3) {
    "- Stack principal: " + (($analysis.Technologies | Select-Object -First 3) -join ", ")
  } else {
    "- Tecnologias: " + ($analysis.Technologies -join ", ")
  } )
$( if ($analysis.HasCopilotInstructions) {
    "`n- **GitHub Copilot integrado** - Instrucoes existentes foram importadas automaticamente"
  } else {
    ""
  } )

## Estrutura do Projeto
$( if ((Get-SafeCount $analysis.ProjectStructure) -gt 0) {
    ($analysis.ProjectStructure | ForEach-Object { "- $_" }) -join "`n"
  } else {
    "- Estrutura padrao detectada"
  } )

## Padroes Arquiteturais Identificados
$( if ((Get-SafeCount $analysis.Patterns) -gt 0) {
    ($analysis.Patterns | ForEach-Object { "- $_" }) -join "`n"
  } else {
    "- Nenhum padrao arquitetural especifico detectado"
  } )

## Stack Tecnologico Completo
$( if ((Get-SafeCount $analysis.Technologies) -gt 0) {
    ($analysis.Technologies | ForEach-Object { "- $_" }) -join "`n"
  } else {
    "- Stack padrao para $($analysis.ProjectType)"
  } )

## Persistencia de Dados
$( if ((Get-SafeCount $analysis.DatabaseContext) -gt 0) {
    ($analysis.DatabaseContext | ForEach-Object { "- $_" }) -join "`n"
  } else {
    "- Nao identificado ou nao configurado"
  } )

## Estrategia de Testes
$( if ((Get-SafeCount $analysis.TestFrameworks) -gt 0) {
    ($analysis.TestFrameworks | ForEach-Object { "- $_" }) -join "`n"
  } else {
    "- Nenhum framework de teste identificado"
  } )

## Ferramentas de Build e Deploy
$( if ((Get-SafeCount $analysis.BuildTools) -gt 0) {
    ($analysis.BuildTools | ForEach-Object { "- $_" }) -join "`n"
  } else {
    "- Build tools padrao para $($analysis.ProjectType)"
  } )

$( if ((Get-SafeCount $analysis.Scripts) -gt 0) {
    "## Scripts Disponiveis`n" + ($analysis.Scripts | ForEach-Object { "- ``$_``" }) -join "`n" + "`n"
  } else {
    ""
  } )

## Convencoes de Codigo
$( if ((Get-SafeCount $analysis.Conventions) -gt 0) {
    ($analysis.Conventions | ForEach-Object { "- ``$_``" }) -join "`n"
  } else {
    "- Convencoes padrao para $($analysis.ProjectType)"
  } )

$( if ($analysis.IsMultiProject) {
    "## Workspace Multi-Projeto`n`n" +
    "### Projeto Principal (Analise Detalhada)`n" +
    "- **Nome:** $($analysis.MainProject.Name)`n" +
    "- **Tipo:** $($analysis.MainProject.Type)`n" +
    "- **Caminho:** ``$($analysis.MainProject.Path)```n" +
    "- **Copilot:** $(if ($analysis.MainProject.HasCopilot) { 'Configurado' } else { 'Nao configurado' })`n`n" +
    "### Outros Projetos (Contexto)`n" +
    ($analysis.OtherProjects | ForEach-Object {
      "- **$($_.Name)** ($($_.Type)) - Copilot: $(if ($_.HasCopilot) { 'sim' } else { 'nao' })"
    }) -join "`n" + "`n`n" +
    "### Estrategia de Integracao`n" +
    "- **Foco:** Implementacao no projeto principal ($($analysis.MainProject.Name))`n" +
    "- **Contexto:** Outros projetos informados para decisoes de integracao`n" +
    "- **Copilot:** Instrucoes de todos os projetos consideradas`n`n"
  } else {
    ""
  } )

$( if ($analysis.HasCopilotInstructions -or (Get-SafeCount $analysis.MultiProjectCopilot) -gt 0) {
    "## GitHub Copilot Integration`n`n" +
    "### Status: DETECTADO E INTEGRADO $(if ($analysis.IsMultiProject) { '(MULTI-PROJETO)' } else { '' })`n`n" +
    $(if ($analysis.HasCopilotInstructions) {
      "### Projeto Principal ($($analysis.MainProject.Name))`n" +
      "- **Arquivo:** ``.github/copilot-instructions.md```n" +
      "- **Status:** Instrucoes principais integradas`n`n" +
      "#### Instrucoes Copilot do Projeto Principal:`n" +
      "````markdown`n" + $analysis.CopilotInstructions + "`n````n`n"
    } else { "" }) +
    $(if ((Get-SafeCount $analysis.MultiProjectCopilot) -gt 0) {
      "### Outros Projetos com Copilot`n" +
      ($analysis.MultiProjectCopilot | ForEach-Object {
        "#### $($_.ProjectName) ($($_.ProjectType))`n" +
        "- **Caminho:** ``$($_.ProjectPath)```n" +
        "- **Copilot:** Incluido no contexto para consistencia cross-project`n`n" +
        "````markdown`n" + $_.Instructions + "`n````n`n"
      }) -join ""
    } else { "" }) +
    "### Beneficio Multi-Projeto`n" +
    "- **Contexto unificado** entre todos os projetos do workspace`n" +
    "- **Consistencia** de padroes entre diferentes stacks`n" +
    "- **Integracao** consciente das dependencias entre projetos`n"
  } else {
    "## GitHub Copilot Integration`n`n" +
    "### Status: NAO DETECTADO`n" +
    "- Nenhum arquivo copilot-instructions.md encontrado em nenhum projeto`n" +
    "- **Sugestao:** Considere criar .github/copilot-instructions.md em cada projeto"
  } )

---

## Instrucoes Especificas para os Agentes

### **PRINCIPIO FUNDAMENTAL: INTEGRACAO HARMONIOSA**

**Todos os agentes devem INTEGRAR suas propostas com o projeto existente, mantendo consistencia total com a stack e padroes ja estabelecidos.**

$(if ($analysis.HasCopilotInstructions -or (Get-SafeCount $analysis.MultiProjectCopilot) -gt 0) {
    "### **INTEGRACAO GITHUB COPILOT DETECTADA" + $(if ($analysis.IsMultiProject) { " (MULTI-PROJETO)" } else { "" }) + "**`n`n" +
    "**CRITICO:** " + $(if ($analysis.IsMultiProject) { "Este workspace possui multiplos projetos com instrucoes Copilot." } else { "Este projeto possui instrucoes GitHub Copilot configuradas." }) + " Os agentes devem:`n" +
    "- **SEGUIR** as diretrizes do projeto principal ($($analysis.MainProject.Name))`n" +
    "- **CONSIDERAR** padroes dos outros projetos para integracao`n" +
    "- **MANTER** consistencia cross-project quando aplicavel`n" +
    "- **COMPLEMENTAR** (nao contradizer) instrucoes existentes`n`n" +
    $(if ($analysis.IsMultiProject) {
      "**Contexto Multi-Projeto:**`n" +
      "- **Projeto Principal:** Foco da implementacao ($($analysis.MainProject.Name))`n" +
      "- **Projetos Relacionados:** " + ($analysis.OtherProjects.Name -join ", ") + "`n" +
      "- **Integracao:** Considere APIs, contratos e dependencias entre projetos`n`n"
    } else { "" }) +
    "**Todas as instrucoes Copilot estao incluidas acima e devem ser respeitadas integralmente.**`n"
  } else {
    ""
  })

### **Diretrizes por Agente:**

#### 1. **Requirements Analyst**
- ✅ **Considere as limitações** da stack tecnológica atual ($($analysis.ProjectType))
- ✅ **Proponha soluções** compatíveis com os frameworks já em uso
- ✅ **Adapte requisitos** às capacidades das tecnologias existentes
- ✅ **Valide viabilidade** técnica com base no que já está implementado

#### 2. **Systems Architect**
- ✅ **PRESERVE** a estrutura arquitetural identificada
- ✅ **REUTILIZE** padrões já estabelecidos no projeto
- ✅ **INTEGRE** com tecnologias e frameworks existentes
- ✅ **MANTENHA** convenções de organização de pastas e módulos
- ✅ **CONSIDERE** as ferramentas de build já configuradas

#### 3. **Expert Developer**
- ✅ **SIGA** as convenções de código identificadas
- ✅ **USE** bibliotecas e frameworks já presentes no projeto
- ✅ **MANTENHA** consistência com padrões de nomenclatura existentes
- ✅ **APROVEITE** configurações e infraestrutura já implementada
- ✅ **INTEGRE** com sistemas de build e deploy atuais
$(if ($analysis.HasCopilotInstructions) {
    "- 🤖 **COPILOT:** Respeite integralmente as instrucoes GitHub Copilot do projeto`n"
  } else {
    ""
  })

#### 4. **Testing Specialist**
- ✅ **UTILIZE** frameworks de teste já configurados
- ✅ **SIGA** padrões de teste estabelecidos no projeto
- ✅ **APROVEITE** infraestrutura e helpers de teste existentes
$(if ($analysis.HasCopilotInstructions) {
    "- 🤖 **COPILOT:** Considere padroes de teste mencionados nas instrucoes Copilot`n"
  } else {
    ""
  })
- ✅ **MANTENHA** estratégia de cobertura e qualidade atual
- ✅ **INTEGRE** com pipeline de testes existente (se houver)

### 🚀 **Resultado Esperado:**
A nova funcionalidade deve parecer que **sempre fez parte do projeto**, seguindo naturalmente todos os padrões, convenções e tecnologias já estabelecidos.

### **Lema da Implementacao:**
> *"Não reinvente, INTEGRE. Não substitua, COMPLEMENTE. Não quebre, HARMONIZE."*
"@

  Set-Content -Path $contextFile -Value $content -Encoding UTF8
  Write-Info "Contexto do projeto salvo em: $contextFile"
}

function Detect-ProjectType($projectPath) {
  # Angular - detectar primeiro pois também tem package.json
  if (Test-Path "$projectPath\angular.json") { return "angular" }

  # React - verificar package.json com dependências React
  $packageJson = Join-Path $projectPath "package.json"
  if (Test-Path $packageJson) {
    try {
      $packageContent = Get-Content $packageJson -Raw | ConvertFrom-Json
      if (($packageContent.dependencies.react) -or ($packageContent.devDependencies.react)) {
        return "react"
      }
      # Se não é React mas tem package.json, é Node.js
      return "nodejs"
    } catch {
      # Se não conseguir ler package.json, assume Node.js
      return "nodejs"
    }
  }

  # .NET - verificar arquivos .csproj ou .sln
  $csprojFiles = Get-ChildItem "$projectPath" -Recurse -Filter "*.csproj" -ErrorAction SilentlyContinue
  $slnFiles = Get-ChildItem "$projectPath" -Filter "*.sln" -ErrorAction SilentlyContinue
  if (($csprojFiles) -or ($slnFiles)) { return "dotnet" }

  # Default para projetos não identificados
  return "generic"
}

function Detect-MultiProjectWorkspace($workspacePath) {
  Write-Info "Verificando workspace multi-projeto em: $workspacePath"

  $projects = @()

  # Verificar se o caminho existe
  if (-not (Test-Path $workspacePath)) {
    Write-Warn "Caminho não encontrado: $workspacePath"
    return @()
  }

  $childDirectories = Get-ChildItem $workspacePath -Directory -ErrorAction SilentlyContinue

  # Se não há diretórios filhos, retorna array vazio
  if (-not $childDirectories) {
    Write-Info "Nenhum diretório encontrado em $workspacePath"
    return @()
  }

  foreach ($dir in $childDirectories) {
    # Pular pastas comuns que não são projetos
    $skipFolders = @(".git", ".vs", ".vscode", "node_modules", "bin", "obj", "packages", ".nuget", "ia")
    if ($skipFolders -contains $dir.Name) { continue }

    $projectType = Detect-ProjectType $dir.FullName
    if ($projectType -ne "generic") {
      # Verificar se tem copilot-instructions.md
      $copilotFile = Join-Path $dir.FullName ".github\copilot-instructions.md"
      $hasCopilot = Test-Path $copilotFile

      $project = New-Object PSObject -Property @{
        Name = $dir.Name
        Path = $dir.FullName
        Type = $projectType
        HasCopilot = $hasCopilot
        CopilotPath = if ($hasCopilot) { $copilotFile } else { "" }
      }
      $projects += $project

      Write-Info "Projeto detectado: $($dir.Name) (tipo: $projectType, copilot: $(if ($hasCopilot) { 'sim' } else { 'nao' }))"
    }
  }

  # Garantir que sempre retorna um array, mesmo vazio
  if ($projects.Count -eq 0) {
    Write-Info "Nenhum projeto válido detectado no workspace"
    return @()
  }

  return [array]$projects
}

function Choose-ProjectsForAnalysis($projects) {
  # Garantir que $projects seja um array e tratar casos nulos/vazios
  if (-not $projects) { $projects = @() }
  if ($projects -isnot [array]) { $projects = @($projects) }

  if ($projects.Count -eq 0) {
    Write-Warn "Nenhum projeto detectado no workspace"
    return @{ MainProject = $null; OtherProjects = @() }
  }

  if ($projects.Count -eq 1) {
    Write-Info "Apenas um projeto detectado, usando como principal"
    return @{ MainProject = $projects[0]; OtherProjects = @() }
  }

  Write-Host "`nWorkspace multi-projeto detectado!" -ForegroundColor Yellow
  Write-Host "Projetos encontrados:" -ForegroundColor Yellow

  for ($i = 0; $i -lt $projects.Count; $i++) {
    $project = $projects[$i]
    # Verificar se a propriedade HasCopilot existe
    $hasCopilot = if ($project.PSObject.Properties['HasCopilot']) { $project.HasCopilot } else { $false }
    $copilotInfo = if ($hasCopilot) { " [Copilot: sim]" } else { " [Copilot: nao]" }
    Write-Host "  $($i + 1)) $($project.Name) ($($project.Type))$copilotInfo" -ForegroundColor Cyan
  }

  $mainChoice = Ask "Selecione projeto PRINCIPAL para analise detalhada (1-$($projects.Count))" "1"
  $mainIndex = [int]$mainChoice - 1

  if (($mainIndex -lt 0) -or ($mainIndex -ge $projects.Count)) {
    Write-Warn "Selecao invalida, usando primeiro projeto"
    $mainIndex = 0
  }

  $includeOthers = Ask "Incluir analise superficial dos outros projetos no contexto? (s/n)" "s"

  $result = @{
    MainProject = $projects[$mainIndex]
    OtherProjects = @()
  }

  if ($includeOthers -match '^[sSyY]') {
    $result.OtherProjects = $projects | Where-Object { $_.Name -ne $result.MainProject.Name }
    Write-Info "Projeto principal: $($result.MainProject.Name)"
    Write-Info "Projetos contextuais: $($result.OtherProjects.Name -join ', ')"
  } else {
    Write-Info "Analise focada apenas no projeto: $($result.MainProject.Name)"
  }

  return $result
}

function Analyze-DotNetProject($projectPath, $analysis) {
  # Analisar estrutura interna de /src para detectar padrões DDD/Clean Architecture
  $srcPath = Join-Path $projectPath "src"
  if (Test-Path $srcPath) {
    if ((Test-Path "$srcPath\Domain") -or (Get-ChildItem $srcPath -Directory -Filter "*Domain*")) {
      $analysis.Patterns += "DDD (Domain-Driven Design)"
    }
    if ((Test-Path "$srcPath\Infrastructure") -or (Get-ChildItem $srcPath -Directory -Filter "*Infrastructure*")) {
      $analysis.Patterns += "Infrastructure Layer"
    }
    if ((Test-Path "$srcPath\Application") -or (Get-ChildItem $srcPath -Directory -Filter "*Application*")) {
      $analysis.Patterns += "Application Layer (Clean Architecture)"
    }
    if ((Get-ChildItem $srcPath -Directory -Filter "*API*") -or (Get-ChildItem $srcPath -Directory -Filter "*Web*")) {
      $analysis.Patterns += "API/Web Layer"
    }
  }

  # Analisar arquivos .csproj para dependências
  $csprojFiles = Get-ChildItem "$projectPath" -Recurse -Filter "*.csproj" -ErrorAction SilentlyContinue | Select-Object -First 10
  foreach ($file in $csprojFiles) {
    try {
      $content = Get-Content $file.FullName -ErrorAction SilentlyContinue
      # Entity Framework
      if ($content -match "EntityFrameworkCore") { $analysis.Technologies += "Entity Framework Core" }
      if ($content -match "EntityFramework\.") { $analysis.Technologies += "Entity Framework 6" }

      # Mapeamento e Validação
      if ($content -match "AutoMapper") { $analysis.Technologies += "AutoMapper" }
      if ($content -match "FluentValidation") { $analysis.Technologies += "FluentValidation" }

      # Arquitetural
      if ($content -match "MediatR") { $analysis.Technologies += "MediatR (CQRS/Mediator)" }

      # Logging
      if ($content -match "Serilog") { $analysis.Technologies += "Serilog (Structured Logging)" }
      if ($content -match "NLog") { $analysis.Technologies += "NLog" }

      # API e Web
      if ($content -match "Swashbuckle") { $analysis.Technologies += "Swagger/OpenAPI" }
      if ($content -match "Microsoft.AspNetCore") { $analysis.Technologies += "ASP.NET Core" }

      # Testes
      if ($content -match "xunit") { $analysis.TestFrameworks += "xUnit" }
      if ($content -match "nunit") { $analysis.TestFrameworks += "NUnit" }
      if ($content -match "MSTest") { $analysis.TestFrameworks += "MSTest" }
      if ($content -match "FluentAssertions") { $analysis.TestFrameworks += "FluentAssertions" }
      if ($content -match "Moq") { $analysis.TestFrameworks += "Moq (Mocking)" }
      if ($content -match "Bogus") { $analysis.TestFrameworks += "Bogus (Test Data Generation)" }

      # Banco de Dados
      if ($content -match "PostgreSQL|Npgsql") { $analysis.DatabaseContext += "PostgreSQL" }
      if ($content -match "SqlServer") { $analysis.DatabaseContext += "SQL Server" }
      if ($content -match "Oracle") { $analysis.DatabaseContext += "Oracle Database" }
      if ($content -match "MySql") { $analysis.DatabaseContext += "MySQL" }

      # Cache e Mensageria
      if ($content -match "Redis") { $analysis.Technologies += "Redis (Cache/Session)" }
      if ($content -match "RabbitMQ") { $analysis.Technologies += "RabbitMQ (Messaging)" }
    } catch {
      # Ignora erros de leitura
    }
  }

  # Analisar appsettings.json
  $appSettings = Get-ChildItem "$projectPath" -Recurse -Filter "appsettings*.json" -ErrorAction SilentlyContinue | Select-Object -First 3
  foreach ($file in $appSettings) {
    try {
      $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
      if ($content -match "DefaultConnection|ConnectionStrings") { $analysis.DatabaseContext += "Connection Strings configuradas" }
    } catch { }
  }

  # Detectar versão do .NET
  $globalJson = Join-Path $projectPath "global.json"
  if (Test-Path $globalJson) {
    try {
      $globalContent = Get-Content $globalJson -Raw | ConvertFrom-Json
      if ($globalContent.sdk.version) {
        $analysis.Technologies += ".NET SDK $($globalContent.sdk.version)"
      }
    } catch { }
  }
}

function Analyze-NodeJsProject($projectPath, $analysis) {
  $packageJson = Join-Path $projectPath "package.json"
  if (-not (Test-Path $packageJson)) { return }

  try {
    $packageContent = Get-Content $packageJson -Raw | ConvertFrom-Json

    # Detectar tipo de aplicação Node.js
    $analysis.Technologies += "Node.js"

    # Framework web
    if ($packageContent.dependencies.express) { $analysis.Technologies += "Express.js" }
    if ($packageContent.dependencies.fastify) { $analysis.Technologies += "Fastify" }
    if ($packageContent.dependencies.koa) { $analysis.Technologies += "Koa.js" }
    if ($packageContent.dependencies.nestjs) { $analysis.Technologies += "NestJS" }

    # Banco de dados
    if ($packageContent.dependencies.mongoose) { $analysis.DatabaseContext += "MongoDB (Mongoose)" }
    if ($packageContent.dependencies.pg) { $analysis.DatabaseContext += "PostgreSQL" }
    if (($packageContent.dependencies.mysql2) -or ($packageContent.dependencies.mysql)) { $analysis.DatabaseContext += "MySQL" }
    if ($packageContent.dependencies.sqlite3) { $analysis.DatabaseContext += "SQLite" }

    # ORMs
    if ($packageContent.dependencies.sequelize) { $analysis.Technologies += "Sequelize ORM" }
    if ($packageContent.dependencies.typeorm) { $analysis.Technologies += "TypeORM" }
    if ($packageContent.dependencies.prisma) { $analysis.Technologies += "Prisma ORM" }

    # Linguagem
    if (($packageContent.dependencies.typescript) -or ($packageContent.devDependencies.typescript)) {
      $analysis.Technologies += "TypeScript"
    } else {
      $analysis.Technologies += "JavaScript"
    }

    # Testes
    if ($packageContent.devDependencies.jest) { $analysis.TestFrameworks += "Jest" }
    if ($packageContent.devDependencies.mocha) { $analysis.TestFrameworks += "Mocha" }
    if ($packageContent.devDependencies.vitest) { $analysis.TestFrameworks += "Vitest" }

    # Build tools
    if ($packageContent.devDependencies.webpack) { $analysis.BuildTools += "Webpack" }
    if ($packageContent.devDependencies.vite) { $analysis.BuildTools += "Vite" }
    if ($packageContent.devDependencies.rollup) { $analysis.BuildTools += "Rollup" }

    # Scripts disponíveis
    if ($packageContent.scripts) {
      $analysis.Scripts = @($packageContent.scripts.PSObject.Properties.Name)
    }

  } catch {
    Write-Warn "Erro ao analisar package.json: $_"
  }
}

function Analyze-AngularProject($projectPath, $analysis) {
  $analysis.Technologies += "Angular"

  # Analisar package.json para versão e dependências
  $packageJson = Join-Path $projectPath "package.json"
  if (Test-Path $packageJson) {
    try {
      $packageContent = Get-Content $packageJson -Raw | ConvertFrom-Json

      # Versão do Angular
      if ($packageContent.dependencies.'@angular/core') {
        $angularVersion = $packageContent.dependencies.'@angular/core' -replace '[^\d\.]', ''
        $analysis.Technologies += "Angular $angularVersion"
      }

      # Material Design
      if ($packageContent.dependencies.'@angular/material') { $analysis.Technologies += "Angular Material" }

      # State Management
      if ($packageContent.dependencies.'@ngrx/store') { $analysis.Technologies += "NgRx (State Management)" }

      # HTTP Client
      if ($packageContent.dependencies.'@angular/common') { $analysis.Technologies += "Angular HTTP Client" }

      # TypeScript
      $analysis.Technologies += "TypeScript"

      # Testes
      if ($packageContent.devDependencies.jasmine) { $analysis.TestFrameworks += "Jasmine" }
      if ($packageContent.devDependencies.karma) { $analysis.TestFrameworks += "Karma" }
      if ($packageContent.devDependencies.protractor) { $analysis.TestFrameworks += "Protractor (E2E)" }
      if ($packageContent.devDependencies.'@angular/cli') { $analysis.BuildTools += "Angular CLI" }

    } catch { }
  }

  # Analisar angular.json para configurações
  $angularJson = Join-Path $projectPath "angular.json"
  if (Test-Path $angularJson) {
    try {
      $angularConfig = Get-Content $angularJson -Raw | ConvertFrom-Json
      if ($angularConfig.projects) {
        $projectNames = @($angularConfig.projects.PSObject.Properties.Name)
        $analysis.ProjectStructure += "Projetos Angular: $($projectNames -join ', ')"
      }
    } catch { }
  }
}

function Analyze-ReactProject($projectPath, $analysis) {
  $analysis.Technologies += "React"

  $packageJson = Join-Path $projectPath "package.json"
  if (Test-Path $packageJson) {
    try {
      $packageContent = Get-Content $packageJson -Raw | ConvertFrom-Json

      # Versão do React
      if ($packageContent.dependencies.react) {
        $reactVersion = $packageContent.dependencies.react -replace '[^\d\.]', ''
        $analysis.Technologies += "React $reactVersion"
      }

      # Linguagem
      if (($packageContent.dependencies.typescript) -or ($packageContent.devDependencies.typescript)) {
        $analysis.Technologies += "TypeScript"
      } else {
        $analysis.Technologies += "JavaScript"
      }

      # State Management
      if ($packageContent.dependencies.redux) { $analysis.Technologies += "Redux" }
      if ($packageContent.dependencies.'@reduxjs/toolkit') { $analysis.Technologies += "Redux Toolkit" }
      if ($packageContent.dependencies.zustand) { $analysis.Technologies += "Zustand" }
      if ($packageContent.dependencies.mobx) { $analysis.Technologies += "MobX" }

      # Routing
      if ($packageContent.dependencies.'react-router-dom') { $analysis.Technologies += "React Router" }

      # UI Libraries
      if ($packageContent.dependencies.'@mui/material') { $analysis.Technologies += "Material-UI (MUI)" }
      if ($packageContent.dependencies.antd) { $analysis.Technologies += "Ant Design" }
      if ($packageContent.dependencies.'react-bootstrap') { $analysis.Technologies += "React Bootstrap" }

      # Build Tools
      if ($packageContent.dependencies.'react-scripts') { $analysis.BuildTools += "Create React App" }
      if ($packageContent.devDependencies.vite) { $analysis.BuildTools += "Vite" }
      if ($packageContent.devDependencies.webpack) { $analysis.BuildTools += "Webpack" }

      # Testes
      if ($packageContent.devDependencies.jest) { $analysis.TestFrameworks += "Jest" }
      if ($packageContent.devDependencies.'@testing-library/react') { $analysis.TestFrameworks += "React Testing Library" }
      if ($packageContent.devDependencies.cypress) { $analysis.TestFrameworks += "Cypress (E2E)" }

    } catch { }
  }
}

function Analyze-GenericProject($projectPath, $analysis) {
  # Análise genérica para projetos não identificados
  $analysis.Technologies += "Projeto genérico"

  # Verificar linguagens comuns por extensões de arquivo
  $pythonFiles = Get-ChildItem "$projectPath" -Recurse -Filter "*.py" -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($pythonFiles) { $analysis.Technologies += "Python" }

  $javaFiles = Get-ChildItem "$projectPath" -Recurse -Filter "*.java" -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($javaFiles) { $analysis.Technologies += "Java" }

  $phpFiles = Get-ChildItem "$projectPath" -Recurse -Filter "*.php" -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($phpFiles) { $analysis.Technologies += "PHP" }

  # Verificar se tem Dockerfile
  if (Test-Path "$projectPath\Dockerfile") { $analysis.BuildTools += "Docker" }
  if (Test-Path "$projectPath\docker-compose.yml") { $analysis.BuildTools += "Docker Compose" }
}

function Analyze-CopilotInstructions($projectPath, $analysis) {
  # Verificar se existe arquivo copilot-instructions.md na pasta .github
  $copilotFile = Join-Path $projectPath ".github\copilot-instructions.md"

  if (Test-Path $copilotFile) {
    try {
      $copilotContent = Get-Content $copilotFile -Raw -ErrorAction SilentlyContinue
      if (-not [string]::IsNullOrWhiteSpace($copilotContent)) {
        $analysis.HasCopilotInstructions = $true
        $analysis.CopilotInstructions = $copilotContent.Trim()
        Write-Info "GitHub Copilot instructions encontradas e integradas"

        # Adicionar à lista de tecnologias para visibilidade
        $analysis.Technologies += "GitHub Copilot (configurado)"
      }
    } catch {
      Write-Warn "Erro ao ler copilot-instructions.md: $_"
    }
  }

  # Também verificar outros locais comuns para instruções Copilot
  $alternatePaths = @(
    ".github\copilot-instructions.txt",
    "docs\copilot-instructions.md",
    ".copilot\instructions.md"
  )

  foreach ($altPath in $alternatePaths) {
    $fullPath = Join-Path $projectPath $altPath
    if ((Test-Path $fullPath) -and (-not $analysis.HasCopilotInstructions)) {
      try {
        $copilotContent = Get-Content $fullPath -Raw -ErrorAction SilentlyContinue
        if (-not [string]::IsNullOrWhiteSpace($copilotContent)) {
          $analysis.HasCopilotInstructions = $true
          $analysis.CopilotInstructions = $copilotContent.Trim()
          Write-Info "GitHub Copilot instructions encontradas em: $altPath"
          $analysis.Technologies += "GitHub Copilot (configurado em $altPath)"
          break
        }
      } catch {
        # Ignora erros em caminhos alternativos
      }
    }
  }
}

function Analyze-MultiProjectCopilot($analysis) {
  Write-Info "Analisando instrucoes Copilot multi-projeto..."

  # Analisar Copilot do projeto principal
  $mainHasCopilot = if ($analysis.MainProject.PSObject.Properties['HasCopilot']) { $analysis.MainProject.HasCopilot } else { $false }
  if ($mainHasCopilot) {
    try {
      $mainCopilotContent = Get-Content $analysis.MainProject.CopilotPath -Raw -ErrorAction SilentlyContinue
      if (-not [string]::IsNullOrWhiteSpace($mainCopilotContent)) {
        $analysis.HasCopilotInstructions = $true
        $analysis.CopilotInstructions = $mainCopilotContent.Trim()
        $analysis.Technologies += "GitHub Copilot (projeto principal)"
        Write-Info "Copilot instructions do projeto principal ($($analysis.MainProject.Name)) integradas"
      }
    } catch {
      Write-Warn "Erro ao ler copilot-instructions.md do projeto principal: $_"
    }
  }

  # Analisar Copilot dos outros projetos
  foreach ($project in $analysis.OtherProjects) {
    $projectHasCopilot = if ($project.PSObject.Properties['HasCopilot']) { $project.HasCopilot } else { $false }
    if ($projectHasCopilot) {
      try {
        $projectCopilotContent = Get-Content $project.CopilotPath -Raw -ErrorAction SilentlyContinue
        if (-not [string]::IsNullOrWhiteSpace($projectCopilotContent)) {
          $copilotInfo = @{
            ProjectName = $project.Name
            ProjectType = $project.Type
            ProjectPath = $project.Path
            Instructions = $projectCopilotContent.Trim()
          }
          $analysis.MultiProjectCopilot += $copilotInfo
          $analysis.Technologies += "GitHub Copilot ($($project.Name) - $($project.Type))"
          Write-Info "Copilot instructions do projeto $($project.Name) incluidas no contexto"
        }
      } catch {
        Write-Warn "Erro ao ler copilot-instructions.md do projeto $($project.Name): $_"
      }
    }
  }

  Write-Info "Total de projetos com Copilot: $(1 + (Get-SafeCount $analysis.MultiProjectCopilot))"
}

function Create-DotNetProject($projectPath, $projectName) {
  Write-Info "Criando projeto .NET em: $projectPath"
  try {
    Set-Location $projectPath
    & dotnet new sln -n $projectName
    & dotnet new webapi -n "$projectName.API" -o "src"
    & dotnet sln add "src/$projectName.API.csproj"
    New-Item -ItemType Directory -Path "docs" -Force | Out-Null
    Write-Info "Projeto .NET '$projectName' criado com sucesso!"
  } catch {
    Write-Warn "Erro ao criar projeto .NET: $_"
  }
}

function Create-NodeJsProject($projectPath, $projectName) {
  Write-Info "Criando projeto Node.js em: $projectPath"
  try {
    Ensure-Dir $projectPath
    Set-Location $projectPath
    & npm init -y
    & npm install express
    New-Item -ItemType Directory -Path "src" -Force | Out-Null
    "console.log('Projeto $projectName iniciado!');" | Out-File -FilePath "src/index.js" -Encoding UTF8
    Write-Info "Projeto Node.js '$projectName' criado com sucesso!"
  } catch {
    Write-Warn "Erro ao criar projeto Node.js: $_"
  }
}

function Create-AngularProject($projectPath, $projectName) {
  Write-Info "Criando projeto Angular em: $projectPath"
  try {
    $parentPath = Split-Path $projectPath
    Set-Location $parentPath
    $folderName = Split-Path $projectPath -Leaf
    & ng new $folderName --routing --style=scss --skip-git
    Write-Info "Projeto Angular '$projectName' criado com sucesso!"
  } catch {
    Write-Warn "Erro ao criar projeto Angular: $_. Certifique-se de ter Angular CLI instalado."
  }
}

function Create-ReactProject($projectPath, $projectName) {
  Write-Info "Criando projeto React em: $projectPath"
  try {
    $parentPath = Split-Path $projectPath
    Set-Location $parentPath
    $folderName = Split-Path $projectPath -Leaf
    & npx create-react-app $folderName --template typescript
    Write-Info "Projeto React '$projectName' criado com sucesso!"
  } catch {
    Write-Warn "Erro ao criar projeto React: $_"
  }
}

function Create-GenericProject($projectPath, $projectName) {
  Write-Info "Criando projeto generico em: $projectPath"
  try {
    Ensure-Dir $projectPath
    New-Item -ItemType Directory -Path "$projectPath/src" -Force | Out-Null
    New-Item -ItemType Directory -Path "$projectPath/docs" -Force | Out-Null
    "# $projectName`n`nProjeto criado via RickytechAgileAgent" | Out-File -FilePath "$projectPath/README.md" -Encoding UTF8
    Write-Info "Projeto generico '$projectName' criado com sucesso!"
  } catch {
    Write-Warn "Erro ao criar projeto generico: $_"
  }
}

try {
  if (-not $TargetProjectPath) {
    $TargetProjectPath = Ask 'Onde quer que gere os Agentes? (ex: C:\Projetos\MeuProjeto)'
  }
  if ([string]::IsNullOrWhiteSpace($TargetProjectPath)) { throw 'Caminho para gerar os agentes nao informado.' }
  Ensure-Dir $TargetProjectPath

  Ensure-Prereqs

  $mode = Choose-Mode
  $sprint = Ask 'Qual o numero da sprint? (ex.: 01)' '01'
  $activity = Ask 'Qual a activity? (ex.: rn0001)' 'rn0001'
  $projectName = Ask 'Qual o nome do projeto? (ex.: CalculationEngine, SistemaVendas)' 'MeuProjeto'

  # Perguntar sobre tipo de projeto e caminhos específicos
  $projectType = Ask 'Tipo de trabalho: (1) Projeto novo ou (2) Implementacao em projeto existente?' '1'
  $projectPath = ""
  $existingProjectPath = ""

  if ($projectType -eq '1') {
    # Projeto novo - perguntar onde CRIAR o projeto
    $projectPath = Ask 'Onde CRIAR o novo projeto? (ex: C:\Projetos\MeuNovoSistema)'
    if ([string]::IsNullOrWhiteSpace($projectPath)) {
      Write-Warn "Caminho para criar projeto nao informado. Usando apenas agentes sem criacao de projeto."
      $projectPath = ""
    } else {
      Write-Info "Novo projeto sera criado em: $projectPath"
    }
  } else {
    # Projeto existente - perguntar onde ESTA o projeto
    $existingProjectPath = Ask 'Onde ESTA o projeto existente? (ex: C:\Projetos\MeuSistema)'
    if (-not [string]::IsNullOrWhiteSpace($existingProjectPath) -and (Test-Path $existingProjectPath)) {
      Write-Info "Projeto existente encontrado em: $existingProjectPath"
    } else {
      Write-Warn "Caminho do projeto existente nao encontrado. Continuando apenas com agentes."
      $existingProjectPath = ""
    }
  }

  Configure-Env -mode $mode -sprint $sprint -activity $activity

  Copy-Workflow -target $TargetProjectPath

  # Criar arquivo .env com as configuracoes
  Create-EnvFile -target $TargetProjectPath -mode $mode -sprint $sprint -activity $activity -projectName $projectName

  # Configurar super-prompt com dados do projeto
  Configure-SuperPrompt -target $TargetProjectPath -sprint $sprint -activity $activity -projectName $projectName

  # Criar estrutura do projeto novo se solicitado
  if ($projectType -eq '1' -and (-not [string]::IsNullOrWhiteSpace($projectPath))) {
    $createProject = Ask 'Criar estrutura basica do projeto agora? (s/n)' 's'
    if ($createProject -match '^[sSyY]') {
      Write-Info "Criando estrutura basica do projeto em: $projectPath"
      Ensure-Dir $projectPath

      # Determinar tipo de projeto a criar
      $newProjectType = Ask 'Tipo de projeto: (1) .NET, (2) Node.js, (3) Angular, (4) React, (5) Generico' '1'
      switch ($newProjectType) {
        '2' { Create-NodeJsProject -projectPath $projectPath -projectName $projectName }
        '3' { Create-AngularProject -projectPath $projectPath -projectName $projectName }
        '4' { Create-ReactProject -projectPath $projectPath -projectName $projectName }
        '5' { Create-GenericProject -projectPath $projectPath -projectName $projectName }
        default { Create-DotNetProject -projectPath $projectPath -projectName $projectName }
      }
    }
  }

  # Analisar projeto existente se informado
  if (-not [string]::IsNullOrWhiteSpace($existingProjectPath)) {
    Analyze-ExistingProject -projectPath $existingProjectPath -target $TargetProjectPath
  }

  $doVenv = Ask 'Criar .venv-1 e instalar requirements agora? (s/n)' 's'
  if ($doVenv -match '^[sSyY]') { Setup-Python -target $TargetProjectPath }

  $doEnrich = Ask 'Deseja enriquecer os agentes com instrucoes personalizadas? (s/n)' 'n'
  if ($doEnrich -match '^[sSyY]') {
    $instr = Ask 'Informe a pasta com arquivos *.instructions.md|txt (ex.: C:\\temp\\newInstruction)'
    if (-not [string]::IsNullOrWhiteSpace($instr)) { Enrich-Agents -target $TargetProjectPath -instructionsPath $instr }
  }

  Write-Host "\nTudo pronto!" -ForegroundColor Green

  if ($mode -eq 'manual') {
    $autoRun = Ask 'Executar o fluxo manual automaticamente agora? (s/n)' 's'
    if ($autoRun -match '^[sSyY]') {
      Start-ManualWorkflow -target $TargetProjectPath -sprint $sprint -activity $activity
    } else {
      Write-Host "Dica: rode o fluxo manual:" -ForegroundColor Yellow
      Write-Host "powershell -NoProfile -ExecutionPolicy Bypass -File .\\powershell\\start-manual.ps1 -Sprint $sprint -Activity $activity" -ForegroundColor Gray
    }
  } else {
    Write-Host "Dica: rode o fluxo CrewAI:" -ForegroundColor Yellow
    Write-Host "python .\\orchestrators\\crewai_runner.py $([int]$sprint)" -ForegroundColor Gray
  }
}
catch {
  Write-Err $_
  exit 1
}
