# data/

Repositório de dados auxiliares e agora também o local oficial de saída:
- `in/` → insumos (arquivos de entrada dos agentes)
- `logs/` → logs e telemetria
- `out/` → SAÍDAS OFICIAIS dos agentes (novo padrão)

Padrão oficial de I/O (atualizado):
- Inputs: `data/in/sprint<sprint>/<activity>/` ou `in/sprint<sprint>/<activity>/` (ambos aceitos)
- Outputs: `data/out/sprint<sprint>/<activity>/` (canônico)

Notas importantes:
- O diretório `./out` na raiz está DEPRECADO e servirá apenas como compatibilidade temporária.
- Scripts e documentação estão sendo atualizados para usar `data/out/` como destino padrão.
- Se você ainda tem automações apontando para `./out`, ajuste para `data/out` assim que possível.
- Quer manter `data/out` fora do projeto? Configure `WORKFLOW_OUTPUT_ROOT` no `.env` (ou variável de ambiente) para o diretório desejado; `setup-workflow.ps1` já exporta o caminho padrão e aceita `-OutputRoot` para customização.
