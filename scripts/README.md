# scripts

Diretório de compatibilidade. O local canônico dos scripts Windows neste repositório é:
- scripts/powershell/ — execução diária (start-manual, quick-start, render-diagrams, use-venv, ...)

Observações:
- Install/ contém apenas setup e orquestradores (Install/orchestrators) — não replique scripts aqui.
- scripts/setup está vazio e será removido futuramente; não colocar arquivos novos nele.

Para uso em projetos clientes, os scripts são copiados para uma pasta powershell/ no projeto alvo pelo Install/setup-workflow.ps1.
