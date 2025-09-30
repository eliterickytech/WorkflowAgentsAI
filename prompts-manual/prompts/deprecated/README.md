# 📁 Prompts Deprecated

Esta pasta contém prompts antigos que **NÃO são mais utilizados** no fluxo automatizado.

## ❌ **Arquivos Depreciados:**

- `requirements-analyst-prompt.md` - Prompt manual individual
- `systems-architect-prompt.md` - Prompt manual individual  
- `testing-specialist-prompt.md` - Prompt manual individual
- `simulacao-mesa-redonda-rn0002.md` - Exemplo específico antigo

## ✅ **Fluxo Atual (Automatizado):**

O sistema agora usa o **fluxo integrado e automatizado**:

```
Product Owner Agent → Template Mesa Redonda → Super-prompt Enriquecido
     ↓
Extrai prompts automaticamente de: agents/manual/*.agent.md
```

### **Vantagens do novo fluxo:**
- ✅ **Automatizado**: Product Owner preenche template automaticamente
- ✅ **Integrado**: Todos os agentes conectados em sequência
- ✅ **Consistente**: Prompts extraídos dos arquivos oficiais
- ✅ **Rastreável**: Histórico completo das decisões
- ✅ **Aprovação**: Workflow com gates de aprovação

## 🔧 **Arquivos Ativos:**

### **Configuração dos Agentes:**
- `agents/manual/product-owner.agent.md` - Product Owner oficial
- `agents/manual/requirements-analyst.agent.md` - Requirements Analyst oficial  
- `agents/manual/systems-architect.agent.md` - Systems Architect oficial
- `agents/manual/expert-developer.agent.md` - Expert Developer oficial
- `agents/manual/testing-specialist.agent.md` - Testing Specialist oficial

### **Templates Dinâmicos:**
- `prompts-manual/prompts/template-mesa-redonda-gpt5.md` - Template com placeholders para P.O.

### **Super-prompt Gerado:**
- Criado automaticamente pelo instalador
- Contém prompts enriquecidos de todos os agentes
- Personalizado para cada projeto/sprint/activity

### **Exemplos de Referência:**
- `prompts-manual/prompts/reference/` - Exemplos de alta qualidade para uso individual

## 📅 **Data da Depreciação:**
29 de setembro de 2025

## 🚀 **Para usar o novo fluxo:**
Execute o instalador: `.\Install\setup-workflow.ps1`