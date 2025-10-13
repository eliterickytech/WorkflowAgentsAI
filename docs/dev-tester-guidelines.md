# Diretrizes para Desenvolvedores e Testers

1. **Inventarie o projeto antes de alterar qualquer coisa.** Abra a solution/workspace real do cliente, identifique os módulos e páginas impactados e registre quais arquivos precisam ser atualizados. Evite criar novas pastas/soluções sem checar se já existe implementação correspondente.
   - Se o projeto já existe, abra a solution completa, localize exatamente em qual módulo/projeto a alteração precisa entrar e valide dependências antes de tocar no código.
   - Em cenários com múltiplos projetos, só avance depois de mapear qual pasta é a principal e quais componentes compartilham a responsabilidade. Alterações precisam acontecer no lugar certo, de acordo com o que você acabou de identificar.
2. **Trabalhe sempre na estrutura oficial.** Utilize os mesmos namespaces, camadas (`src/`, `tests/`, `docs/`, etc.) e convenções do projeto. Se precisar de novos componentes, crie-os dentro do domínio correto.
3. **Mantenha rastreabilidade.** Toda alteração deve apontar para sprint e activity (`data/out/sprintXX/<activity>/`). No final da entrega, liste os arquivos modificados para facilitar revisão e QA.
4. **Teste na mesma camada em que o código vive.** Garantir que os testes automatizados residam em `engineering/tests` ou no diretório oficial do projeto (se o código for integrado diretamente).
5. **Sinalize desvios imediatamente.** Se perceber artefatos gerados fora dos diretórios esperados, ajuste o caminho (`WORKFLOW_OUTPUT_ROOT`) ou peça correção antes da aprovação final.
