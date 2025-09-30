# 📋 Simulação: Implementação RN-0015 - Alteração Cor de Sucesso

## 🎯 Atividade
**Trocar cor de sucesso de verde para roxo** no sistema SistemaVendas

## 📁 Estrutura de Entrada Criada
```
simulacao/in/sprint03/rn0015/
├── business_request/
│   └── business_request.md     # Solicitação do negócio
└── attachments/
    └── projeto_info.md         # Documentação técnica atual
```

## 🤖 Como Executar com os Agentes

### **Opção 1: Processo Manual (GitHub Copilot)**
1. **Copie a estrutura para seu workspace dos agentes**:
   ```bash
   # Se você já executou o setup-workflow.ps1
   cp -r simulacao/in/sprint03/rn0015/ [SEU_WORKSPACE]/in/sprint03/
   ```

2. **Execute os agentes sequencialmente**:
   ```bash
   # No seu workspace dos agentes
   cd [SEU_WORKSPACE]
   powershell -NoProfile -ExecutionPolicy Bypass -File .\powershell\start-manual.ps1 -Sprint 03 -Activity rn0015
   ```

### **Opção 2: GitHub Copilot Chat Individual**
Use cada agente individualmente:

#### **1. Product Owner Agent**
```
@workspace Use arquivo business_request.md para:
- Analisar solicitação RN-0015 (mudança cor sucesso verde→roxo)
- Gerar requirements brief
- Validar critérios de aceitação
```

#### **2. Requirements Analyst Agent** 
```
@workspace Baseado na solicitação RN-0015:
- Extrair requisitos funcionais/não-funcionais
- Gerar cenários BDD para testes de cores
- Mapear componentes afetados
```

#### **3. Systems Architect Agent**
```
@workspace Para RN-0015 (alteração cor sucesso):
- Analisar impacto arquitetural
- Identificar pontos de mudança (CSS vars, components)
- Propor estratégia de implementação
```

#### **4. Expert Developer Agent**
```
@workspace Implementar RN-0015:
- Alterar variáveis CSS de --color-success
- Atualizar componentes React afetados  
- Manter acessibilidade e consistência
```

#### **5. Testing Specialist Agent**
```
@workspace Criar testes para RN-0015:
- Testes visuais de cor
- Testes de acessibilidade (contraste)
- Validação cross-browser
```

## 📊 Resultado Esperado

### **Artifacts Gerados**:
```
out/sprint03/rn0015/
├── 00-business-context.md       # Contexto e justificativa
├── 00-requirements-brief.md     # Resumo de requisitos
├── 01-ata-mesa-redonda.md       # Discussão técnica
├── 02-requisitos-bdd.md         # Cenários de teste
├── 03-arquitetura.md            # Decisões arquiteturais
├── 04-desenvolvimento.md        # Código implementado
├── 05-qa-plano.md              # Estratégia de testes
├── features/                    # Arquivos .feature BDD
│   └── cor-sucesso.feature
├── adrs/                        # Architecture Decision Records
│   └── adr-001-mudanca-cor.md
└── diagrams/                    # Diagramas técnicos
    └── componentes-afetados.mmd
```

### **Implementação Esperada**:
```css
/* Antes */
:root {
  --color-success: #28a745;  /* Verde */
}

/* Depois */  
:root {
  --color-success: #6f42c1;  /* Roxo */
}
```

```tsx
// Componentes atualizados
// Alert.tsx, Button.tsx, StatusBadge.tsx, etc.
```

## ⏱️ Tempo Estimado
- **Setup**: 5 min
- **Execução agentes**: 15-30 min
- **Revisão/ajustes**: 10-15 min
- **Total**: ~30-50 min

## 🎯 Benefícios desta Simulação
✅ **Processo completo** de ponta-a-ponta  
✅ **Documentação automática** gerada  
✅ **BDD scenarios** prontos para QA  
✅ **Decisões arquiteturais** registradas  
✅ **Código implementado** seguindo padrões  
✅ **Rastreabilidade** total da mudança  

---
**Esta é uma atividade perfeita para testar o workflow dos agentes com uma tarefa simples e real!** 🚀