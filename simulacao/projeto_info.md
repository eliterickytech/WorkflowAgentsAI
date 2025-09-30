# Documentação Técnica - Sistema SistemaVendas

## Arquitetura Atual
- **Framework**: ASP.NET Core 8.0
- **Frontend**: React 18 com TypeScript
- **Styling**: Styled Components + CSS Modules
- **Banco de dados**: PostgreSQL
- **ORM**: Entity Framework Core

## Estrutura do Projeto
```
SistemaVendas/
├── src/
│   ├── SistemaVendas.API/           # Backend API
│   ├── SistemaVendas.Web/           # Frontend React
│   ├── SistemaVendas.Domain/        # Camada de domínio
│   ├── SistemaVendas.Infrastructure/ # Infraestrutura
│   └── SistemaVendas.Application/   # Lógica de aplicação
├── tests/                           # Testes automatizados
└── docs/                           # Documentação

```

## Componentes de UI Relevantes

### Cores Atuais do Sistema
```css
:root {
  --color-success: #28a745;     /* Verde atual */
  --color-error: #dc3545;       /* Vermelho */
  --color-warning: #ffc107;     /* Amarelo */
  --color-info: #17a2b8;        /* Azul */
  --color-primary: #6f42c1;     /* Roxo - cor da marca */
}
```

### Componentes que usam cor de sucesso
1. **Alert/Notification components**
   - `src/SistemaVendas.Web/components/Alert.tsx`
   - `src/SistemaVendas.Web/components/Toast.tsx`

2. **Buttons**
   - `src/SistemaVendas.Web/components/Button.tsx`
   - Classe: `.btn-success`

3. **Status indicators**
   - `src/SistemaVendas.Web/components/StatusBadge.tsx`
   - Estados de pedidos aprovados

4. **Form validations**
   - `src/SistemaVendas.Web/styles/forms.css`
   - `.field-valid`, `.success-message`

## Tecnologias de Styling
- **CSS Variables** para cores do tema
- **Styled Components** para componentes React  
- **CSS Modules** para estilos específicos
- **SASS** para pré-processamento

## Guidelines de Acessibilidade
- Contraste mínimo: 4.5:1 (WCAG AA)
- Suporte a modo escuro
- Compatibilidade com leitores de tela

## Browsers Suportados
- Chrome 90+
- Firefox 88+  
- Safari 14+
- Edge 90+

---
**Última atualização**: 30/09/2025
**Versão do sistema**: 2.1.4
**Ambiente**: Produção