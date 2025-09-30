# 🔍 Análise Automática de Projeto Existente (Multi-Tecnologia)

## 🎯 **Funcionalidade**

Durante a instalação, o sistema pode analisar projetos existentes (**✅ .NET, ✅ Node.js, ✅ Angular, ✅ React, ✅ Outros**) e gerar contexto automático para todos os agentes, garantindo que as propostas sejam **consistentes** com a arquitetura e stack tecnológica atual.

## 📋 **Como Usar**

### Durante a Instalação
```powershell
.\Install\setup-workflow.ps1
```

**Nova pergunta:**
```
Tipo de trabalho: (1) Projeto novo ou (2) Implementacao em projeto existente? 2
Caminho do projeto .NET existente para analise: C:\Projetos\MeuSistema
```

### O que Acontece
1. ✅ **Análise automática** da estrutura do projeto
2. ✅ **Geração do arquivo** `project-analysis.md`
3. ✅ **Contexto injetado** em todos os agentes

## 🔍 **O que é Analisado (Multi-Tecnologia)**

### 🏗️ **Estrutura do Projeto (Universal)**
- Pastas `/src`, `/test`, `/docs` - organização básica
- Detecção automática de padrões arquiteturais específicos
- Localização de testes e documentação

### 🎯 **Detecção Automática de Tipo**
- **🔷 .NET:** Detecta `.csproj`, `.sln`
- **🟢 Node.js:** Detecta `package.json`
- **🔴 Angular:** Detecta `angular.json`
- **⚛️ React:** Detecta `package.json` + dependência React
- **🐍 Python/☕ Java/🐘 PHP:** Por extensões de arquivo

### 🔧 **Tecnologias por Stack**

#### **.NET Projects**
- **ORM:** Entity Framework Core/6, TypeORM, Sequelize
- **Mapeamento:** AutoMapper
- **Validação:** FluentValidation
- **CQRS:** MediatR
- **Logging:** Serilog, NLog
- **API:** ASP.NET Core, Swagger/OpenAPI
- **Testes:** xUnit, NUnit, MSTest, FluentAssertions, Moq, Bogus

#### **Node.js Projects** 
- **Framework:** Express.js, Fastify, Koa, NestJS
- **ORM:** Sequelize, TypeORM, Prisma
- **Linguagem:** TypeScript vs JavaScript
- **Testes:** Jest, Mocha, Vitest
- **Build:** Webpack, Vite, Rollup

#### **Angular Projects**
- **Versão:** Angular CLI, Material Design
- **Estado:** NgRx (State Management)
- **Testes:** Jasmine, Karma, Protractor
- **Build:** Angular CLI

#### **React Projects**
- **Estado:** Redux, Redux Toolkit, Zustand, MobX
- **Routing:** React Router  
- **UI:** Material-UI, Ant Design, Bootstrap
- **Build:** Create React App, Vite, Webpack
- **Testes:** Jest, React Testing Library, Cypress

### 🗄️ **Banco de Dados (Universal)**
- PostgreSQL, SQL Server, MySQL, Oracle, MongoDB, SQLite
- ORMs específicos por tecnologia

### 📏 **Convenções de Código**
- **.NET:** Namespaces e estrutura C#
- **JS/TS:** Estrutura de módulos e imports
- **Estrutura de pastas** por tipo de projeto

## 📄 **Arquivo Gerado: project-analysis.md**

```markdown
# Análise Automática do Projeto Existente

**Projeto analisado:** `C:\Projetos\MeuSistema`

## 🏗️ Estrutura do Projeto
- Clean Architecture (/src)
- Pasta de Testes Dedicada

## 🎯 Padrões Arquiteturais Identificados  
- DDD (Domain folder)
- Infrastructure Layer
- Application Layer

## 🔧 Tecnologias em Uso
- Entity Framework Core
- AutoMapper
- FluentValidation
- MediatR (CQRS)
- Serilog (Logging)

## 🗄️ Banco de Dados
- PostgreSQL

## 🧪 Frameworks de Teste
- xUnit
- FluentAssertions
- Moq (Mocking)

## 📋 Instruções para os Agentes
[Instruções específicas para cada agente...]
```

## 🤖 **Impacto nos Agentes**

### **Requirements Analyst**
- ✅ Considera limitações das tecnologias existentes
- ✅ Propõe soluções compatíveis com a stack atual

### **Systems Architect**  
- ✅ Mantém consistência arquitetural
- ✅ Usa mesmos padrões (DDD, Clean Architecture)
- ✅ Integra com tecnologias estabelecidas

### **Expert Developer**
- ✅ Segue convenções de namespace existentes
- ✅ Usa bibliotecas já configuradas
- ✅ Mantém estilo de código consistente

### **Testing Specialist**
- ✅ Usa frameworks de teste já configurados
- ✅ Aproveita infraestrutura de teste existente
- ✅ Mantém padrões estabelecidos

## 🚀 **Fluxos Atualizados**

### **Manual (start-manual.ps1)**
```markdown
## 🏗️ CONTEXTO DO PROJETO EXISTENTE

**ANÁLISE AUTOMÁTICA DISPONÍVEL:** `project-analysis.md`

### ⚠️ INSTRUÇÃO CRÍTICA PARA TODOS OS AGENTES:
1. LEIA PRIMEIRO o arquivo project-analysis.md
2. MANTENHA CONSISTÊNCIA com arquitetura existente  
3. INTEGRE suas propostas (não substitua)
4. USE mesmas bibliotecas e convenções
```

### **Automático (start-orchestration.ps1)**
```powershell
$env:PROJECT_ANALYSIS_PATH = "project-analysis.md"
# Orquestradores podem acessar via variável de ambiente
```

## 💡 **Exemplos de Uso Multi-Tecnologia**

### **Cenário 1: Sistema de Notificação (.NET)**
```
Projeto existente: Sistema ERP com Clean Architecture + EF Core + PostgreSQL
Nova funcionalidade: Sistema de notificações

Resultado: Agentes propõem:
- Usar mesmo padrão de Domain Services
- Integrar com contexto EF existente  
- Seguir convenções de namespace do projeto
- Usar PostgreSQL para persistência de notificações
```

### **Cenário 2: Dashboard Analytics (React)**
```  
Projeto existente: App React + Redux + Material-UI + Jest
Nova funcionalidade: Dashboard de analytics

Resultado: Agentes propõem:
- Store Redux para estado do dashboard
- Componentes Material-UI consistentes
- Testes Jest + React Testing Library
- Hooks personalizados seguindo padrões existentes
```

### **Cenário 3: API Gateway (Node.js)**
```
Projeto existente: Backend Express + TypeScript + Prisma + PostgreSQL  
Nova funcionalidade: Sistema de autenticação JWT

Resultado: Agentes propõem:
- Middleware Express para auth
- Prisma schemas para usuários
- TypeScript interfaces consistentes
- Testes Jest seguindo padrão atual
```

### **Cenário 4: Módulo Admin (Angular)**
```
Projeto existente: App Angular + NgRx + Angular Material + Jasmine
Nova funcionalidade: Painel administrativo

Resultado: Agentes propõem:
- Actions/Reducers NgRx para admin state
- Components Angular Material consistentes  
- Services seguindo arquitetura existente
- Testes Jasmine + TestBed patterns
```

## 🎯 **Benefícios**

1. **🎯 Consistência:** Propostas alinhadas com projeto atual
2. **⚡ Produtividade:** Não precisa reexplicar arquitetura para cada agente  
3. **🔧 Integração:** Soluções que se encaixam naturalmente
4. **📚 Reutilização:** Aproveita infraestrutura existente
5. **🚀 Qualidade:** Evita conflitos arquiteturais

## ⚠️ **Limitações**

- Análise é **sintática** (estrutura de arquivos e dependências)
- Não analisa **lógica de negócio** específica
- Projetos muito **customizados** podem ter padrões não detectados
- **Sempre revisar** as propostas dos agentes

## 📋 **Próximos Passos**

1. ✅ Implementação básica concluída
2. 🔄 **Futuro:** Análise mais profunda (interfaces, contratos)
3. 🔄 **Futuro:** Templates específicos por tipo de projeto detectado
4. 🔄 **Futuro:** Sugestões de modernização da stack

---

**Resultado:** Sistema de agentes **contextualmente inteligente** que entende e respeita a arquitetura do seu projeto! 🎉