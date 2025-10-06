# Workflow Agents Architecture

Esta pasta implementa uma estrutura de Clean Architecture para orquestrar os agentes manuais e automatizados.

## Camadas Principais
- `core/`: tipos base, resultados padronizados e excecoes comuns.
- `domain/`: entidades imutaveis, objetos de valor e servicos de regra de negocio.
- `application/`: casos de uso, DTOs e servicos de orquestracao entre camadas.
- `infrastructure/`: adaptadores de persistencia e serializacao para arquivos de manifesto.
- `interfaces/`: integracoes direcionadas, como a camada de CLI.
- `cli/`: ponto de entrada para executar comandos via linha de comando.
- `orchestration/`: pipeline de execucao e runtime para gerar blueprints a partir dos agentes.
- `config/`: carregamento de configuracoes e manifestos.
- `shared/`: utilitarios genericos compartilhados entre as camadas.
- `assets/`: artefatos estaticos e indicacoes para referencias externas.

## Fluxo de Alto Nivel
1. `config/settings.py` resolve caminhos e padrao de encoding.
2. `infrastructure/repositories/file_system_agent_repository.py` carrega e persiste manifestos em JSON.
3. `application/use_cases/register_agent.py` valida e registra agentes via `domain/services.py`.
4. `orchestration/pipeline.py` monta um blueprint com base nos agentes cadastrados.
5. `cli/main.py` expõe comandos para registrar agentes e gerar artefatos.

## Convenções
- Arquivos Python usam `LF`, indentação com 4 espaços e UTF-8 sem BOM.
- Documentação Markdown usa `CRLF` conforme `.editorconfig`.
- Referências de prompts agora residem em `src/workflow_agents/assets/references/`.
