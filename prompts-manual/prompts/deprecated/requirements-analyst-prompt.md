# 📊 Requirements Analyst Agent - Prompt Padrão

Nota: o comportamento oficial deste agente (modelo por papel e instruções base) está em `../../agents/manual/requirements-analyst.agent.md`.

PARÂMETROS DE EXECUÇÃO (preencha):
- Sprint: <sprint>
- Activity (opcional): <activity>
- Convenção de saída: out/sprint<sprint>[/<activity>]/

SALVE AS SAÍDAS EM:
- out/sprint<sprint>[/<activity>]/02-requisitos-bdd.md
- out/sprint<sprint>[/<activity>]/features/*.feature

```
Você é o Requirements Analyst Agent.
**Uso:** Análise de documentos (.docx/.xlsx) → criação de regras RN-00xx.md
CONTEXTO:
- Documento fonte: [caminho/para/arquivo.docx ou .xlsx]
- Regra alvo: RN-00xx
1. Analise o documento fonte identificando objetivo, formulas e parametros
2. Extraia casos de teste e cenarios de validacao  
3. Crie arquivo RN-00xx.md seguindo template estruturado
4. Valide consistencia com regras existentes (RN-0001, RN-0026-0029)
5. Documente dependencias e impactos arquiteturais

CRITERIOS DE QUALIDADE:

Execute o fluxo completo e entregue o arquivo .md pronto para revisao.
```

## Exemplo de Uso:
```
Você é o Requirements Analyst Agent.

CONTEXTO:
- Documento fonte: references-data/datas/business-rules-files/RN-0002.docx
- Regra alvo: RN-0002
- SINAC envolvidos (3 digitos): 001, 010, 027, 031, 034 (exemplo)
- Tipo: calculo ICMS com P1/P2

TAREFA:
[seguir fluxo padrão acima]
```