# Exemplo de Instruções Personalizadas para Agentes

Este documento mostra como criar instruções personalizadas para cada agente do workflow. Durante a instalação, você pode optar por enriquecer os agentes com instruções específicas para seu projeto/empresa.

## Como Funciona

1. **Durante a instalação**, quando perguntado: `Deseja enriquecer os agentes com instruções personalizadas? (s/n)`
2. **Responda `s`** e informe uma pasta contendo arquivos `*.instructions.md` ou `*.instructions.txt`
3. **Os arquivos serão automaticamente aplicados** aos agentes correspondentes

## Agentes Disponíveis

### Product Owner
**Arquivo:** `product-owner.instructions.md`

Exemplo de conteúdo personalizado:
```markdown
## Instruções Específicas da Empresa

### Contexto Organizacional
- Nossa empresa é uma software house focada em soluções .NET para o mercado brasileiro
- Trabalhamos principalmente com sistemas web usando ASP.NET Core, Entity Framework e PostgreSQL
- Nossos clientes são principalmente PMEs do setor financeiro e de saúde

### Metodologia de Trabalho
- Sprints de 2 semanas
- Reuniões de planning às segundas-feiras
- Review e retrospectiva às sextas-feiras
- Standup diário às 9h

### Critérios de Aceitação Padrão
- Todo desenvolvimento deve incluir testes unitários (xUnit)
- Cobertura mínima de 80%
- Code review obrigatório
- Documentação técnica atualizada
- Compliance com LGPD sempre que houver dados pessoais

### Stakeholders Típicos
- **Cliente final:** Usuários do sistema (funcionários das empresas)
- **Sponsor:** Diretor de TI da empresa cliente
- **Compliance:** Time jurídico (para validar LGPD)
- **Infraestrutura:** Time DevOps interno
```

### Requirements Analyst
**Arquivo:** `requirements-analyst.instructions.md`

### Systems Architect  
**Arquivo:** `systems-architect.instructions.md`

### Expert Developer
**Arquivo:** `expert-developer.instructions.md`

### Testing Specialist
**Arquivo:** `testing-specialist.instructions.md`

### Roundtable Facilitator
**Arquivo:** `roundtable-facilitator.instructions.md`

## Exemplo de Estrutura de Pasta

```
C:\MinhaEmpresa\Instrucoes\
├── product-owner.instructions.md
├── requirements-analyst.instructions.md
├── systems-architect.instructions.md
├── expert-developer.instructions.md
├── testing-specialist.instructions.md
└── roundtable-facilitator.instructions.md
```

## Aplicação das Instruções

Durante a instalação, informe o caminho:
```
Informe a pasta com arquivos *.instructions.md|txt (ex.: C:\temp\newInstruction): C:\MinhaEmpresa\Instrucoes
```

As instruções serão **anexadas** ao final de cada arquivo de agente, sob o cabeçalho:
```markdown
---
### Custom Instructions (instalador)
[seu conteúdo personalizado aqui]
```

## Modo Idempotente

- Se você executar o instalador novamente com a mesma pasta, as instruções personalizadas serão **substituídas**
- Isso permite atualizar as instruções sem duplicar conteúdo
- As instruções originais dos agentes são preservadas

## Dicas

1. **Seja específico:** Inclua contexto da sua empresa, tecnologias, metodologias
2. **Defina padrões:** Estabeleça critérios de qualidade, processos obrigatórios  
3. **Identifique stakeholders:** Liste os papéis e responsabilidades específicos
4. **Exemplifique:** Use casos concretos do seu domínio de negócio
5. **Atualize regularmente:** Mantenha as instruções evoluindo com a empresa