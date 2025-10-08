# 🎯📋 Fluxo Completo: Do Zero à Mesa Redonda

## 🎯👁️‍🗨️ **Visão Geral do Processo**

```mermaid
graph TD
    A[1\. Instalação] --> B[2\. Adicionar Documentos]
    B --> C[3\. Executar Product Owner]
    C --> D[4\. Mesa Redonda GPT-5]
    D --> E[5\. Fluxo dos Demais Agentes - TDD]
```

## 🎯📦🛠️ **PASSO 1: Instalação**

### Executar o Instalador
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Install\setup-workflow.ps1
```

**O que acontece:**
- ☑️ Estrutura de pastas criada
- ☑️ Ambiente configurado
- ☑️ Templates copiados
- ☑️ **NOVO:** Análise automática de projeto existente (se selecionado)
- ⚠️ **Documentos ainda NÃO processados**

### **Nova Pergunta Durante Instalação:**
```
Tipo de trabalho: (1) Projeto novo ou (2) Implementacao em projeto existente? 2
Caminho do projeto .NET existente para analise: C:\Projetos\MeuSistema
```

**Se opção 2:** Sistema analisa automaticamente estrutura, tecnologias e padrões do projeto existente, gerando `project-analysis.md` com contexto completo para os agentes.

## 🎯📂 **PASSO 2: Adicionar Seus Documentos**

### Estrutura Final (APÓS instalação):
```
C:\Projetos\MeuSistema\ia\
├── in\sprint01\01\
│   ├── attachments\                    ⬅️ VOCÊ ADICIONA AQUI
│   │   ├── pedido-cliente.docx         ⬅️ Documento do cliente
│   │   ├── tela-mockup-1.html          ⬅️ Mockups HTML
│   │   ├── tela-mockup-2.html
│   │   └── tela-mockup-3.html
│   └── business_request\               ⬅️ VOCÊ CRIA AQUI
│       └── analise-tecnica.md          ⬅️ Sua análise técnica
```

### Exemplo: `business_request/analise-tecnica.md`
```markdown
# Análise Técnica - Sistema de Notificação

## Contexto do Cliente
- **Objetivo:** Sistema de notificação desktop
- **Insumos:** 1 Word + 3 mockups HTML

## Decisões Técnicas Preliminares
- **Framework:** WPF (Windows Presentation Foundation)
- **Stack:** .NET 8, Material Design, SQLite
- **Deploy:** MSI installer
- **Justificativa:** Cliente quer "interface bonita estilo web"
```

## 🎯👤📝 **PASSO 3: Executar Product Owner**

### **Opção A: Manual (Recomendado para começar)**
1. **Abrir ChatGPT/Claude**
2. **Copiar prompt completo** de: `agents/manual/product-owner.agent.md`
3. **Informar contexto:**
   ```
   Sprint: 01
   Activity: 01
   Documentos em: business_request/ e attachments/
   ```
4. **Anexar todos os arquivos** (Word, HTMLs, analise-tecnica.md)

### **Opção B: Via Script (Futuro - ainda não implementado)**
```powershell
# WISHLIST - não existe ainda
.\powershell\run-agent.ps1 -Agent ProductOwner -Sprint 01 -Activity 01
```

### **O que o Product Owner produz:**
- ☑️ `00-requirements-brief.md`
- ☑️ `00-business-context.md`
- ☑️ `mesa-redonda-01-preparada.md` ⬅️ **TEMPLATE PREENCHIDO**

## 🎯🗣️ **PASSO 4: Mesa Redonda GPT-5**

### Executar a Mesa Redonda
1. **Abrir GPT-5**
2. **Copiar e colar** o conteúdo completo de `mesa-redonda-01-preparada.md`
3. **Executar** - GPT-5 facilitará discussão entre especialistas
4. **Salvar resultado** como `01-ata-mesa-redonda.md`

## 🎯⚙️ **PASSO 5: Demais Agentes (Sequencial - TDD)**

### 🆕 **FLUXO TDD (Test-Driven Development):**
⭐ **Testing Specialist** cria o plano de QA **ANTES** da implementação
⭐ **Expert Developer** implementa seguindo os testes já definidos
⭐ **Testing Validator** valida se a implementação atende ao plano original

### 5.1 Requirements Analyst (Gemini 2.5 Pro)
- **Input:** Ata da mesa redonda + documentos originais
- **Output:** `02-requisitos-bdd.md` + `features/*.feature`

### 5.2 Systems Architect (GPT-5)
- **Input:** Requisitos + contexto técnico
- **Output:** `03-arquitetura.md` + `adrs/` + `diagrams/`

### 5.3 Testing Specialist (Claude 4) ⭐ **TDD - ANTES DO CÓDIGO**
- **Input:** Arquitetura + requisitos + mockups
- **Output:** `05-qa-plano.md` (Plano TDD completo)
- **Papel:** Define TODOS os testes antes da implementação

### 5.4 Expert Developer (Claude 4) ⭐ **TDD - DEPOIS DO PLANO**
- **Input:** Arquitetura + plano TDD + wireframes
- **Output:** `04-desenvolvimento.md` + código implementado
- **Papel:** Implementa seguindo os testes já definidos

### 5.5 UX/UI Specialist (GPT-4o) 🎯✓ - OPCIONAL
- **Input:** Arquitetura + requisitos + mockups existentes
- **Output:** `05-ux-wireframes.md` + estrutura de wireframes
- **Ferramentas:** `setup-design-tools.ps1` + `view-wireframes.ps1`

### 5.6 Frontend Specialist (GPT-4o) 🎯✓ - OPCIONAL
- **Input:** Arquitetura + requisitos + especificações de UX/UI
- **Output:** `04-frontend-implementation.md` + `04-components/` + `04-ui-guidelines.md`
- **Papel:** Implementa interface seguindo o design system e os wireframes

### 5.7 Testing Validator (GPT-4o) 🎯✓
- **Input:** Plano TDD + implementação + critérios aceite
- **Output:** `05.1-testing-validation.md` (Validação independente)
- **Papel:** Valida se implementação atende ao plano original

### 5.8 Code Reviewer (Claude 4) - OPCIONAL
- **Input:** Código implementado + padrões projeto
- **Output:** `04.1-code-review.md` (Auditoria qualidade)

### 5.9 Product Owner Final (GPT-5)
- **Input:** Todos artefatos + critérios aceite originais
- **Output:** `99-checklist-final.md` (Aprovação/rejeição entrega)

## 🎯📁 **Resultado Final**

### Estrutura de Saída:
```
out\sprint01\01\
├── 00-requirements-brief.md      ⬅️ Product Owner
├── 00-business-context.md        ⬅️ Product Owner
├── 01-ata-mesa-redonda.md        ⬅️ Mesa Redonda GPT-5
├── 02-requisitos-bdd.md          ⬅️ Requirements Analyst
├── 03-arquitetura.md             ⬅️ Systems Architect
├── 05-qa-plano.md                ⬅️ Testing Specialist (TDD - ANTES)
├── 04-desenvolvimento.md         ⬅️ Expert Developer (TDD - DEPOIS)
├── 05.1-testing-validation.md    ⬅️ Testing Validator
├── 04-frontend-implementation.md ⬅️ Frontend Specialist (opcional)
├── 04-components\                ⬅️ Estrutura de componentes frontend
├── 04-ui-guidelines.md           ⬅️ Guidelines de UI/UX
├── features\                     ⬅️ Arquivos .feature (BDD)
├── adrs\                         ⬅️ Architecture Decision Records
└── diagrams\                     ⬅️ Diagramas Mermaid
```

## ☑️ **Scripts de Apoio**

### Renderizar Diagramas
```powershell
.\powershell\render-diagrams.ps1
```

### Criar Estrutura Manual (alternativa)
```powershell
.\powershell\start-manual.ps1 -Sprint 01 -Activity 01
```

## 🎯🗣️ **Pontos Críticos**

### ⚠️ **Confusões Comuns:**
- **Instalação ≠ Execução:** Instalador só prepara ambiente
- **Documentos:** Devem ser adicionados APÓS instalação
- **Product Owner:** Não executa automaticamente durante instalação

### ☑️ **Sequência Correta:**
1. **Instalar** (preparar ambiente)
2. **Documentar** (adicionar arquivos do cliente + análise)
3. **Executar PO** (preencher mesa redonda)
4. **Mesa redonda** (facilitar discussão)
5. **Demais agentes TDD** (Testing Specialist → Developer → Validator)

## 🎯📚 **Documentação de Apoio**

- **[Processo Manual Detalhado](./manual-process.md)**
- **[Agentes Individuais](../agents/manual/)**
- **[Exemplo Fluxo TDD Completo](./exemplo-fluxo-tdd-completo.md)**
- **[Personalização de Agentes](./exemplo-instrucoes-personalizada.md)**

---

**🎯💡 DICA:** Na primeira vez, use a **Opção A (Manual)** para entender o fluxo. Depois, você pode automatizar partes específicas conforme sua necessidade.

**🆕 IMPORTANTE:** O fluxo TDD garante que todos os testes sejam definidos ANTES do código ser escrito, resultando em melhor qualidade e menor retrabalho!
