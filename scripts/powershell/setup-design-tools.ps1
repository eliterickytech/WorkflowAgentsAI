param(
    [Parameter(Mandatory=$true)][string]$Sprint,
    [Parameter(Mandatory=$true)][string]$Activity,
    [switch]$InstallDesignTools = $false,
    [switch]$GenerateWireframes = $false,
    [switch]$ExportToFigma = $false
)

# Configuração
$baseDir = Join-Path (Join-Path $PSScriptRoot "..\out") ("sprint$Sprint\$Activity")
$wireframesDir = Join-Path $baseDir "04-wireframes"
$componentsDir = Join-Path $baseDir "04-components"

Write-Host "🎨 WorkFlowAI - Design Tools Integration" -ForegroundColor Magenta
Write-Host "Sprint: $Sprint | Activity: $Activity" -ForegroundColor Cyan
Write-Host ""

# Verificar se diretório existe
if (-not (Test-Path $baseDir)) {
    Write-Error "❌ Atividade não encontrada. Execute start-manual.ps1 primeiro."
    exit 1
}

# Instalar ferramentas de design se solicitado
if ($InstallDesignTools) {
    Write-Host "📦 Instalando ferramentas de design..." -ForegroundColor Yellow

    # VS Code Extensions para Design
    $extensions = @(
        "ms-vscode.vscode-react-native",
        "Angular.ng-template",
        "bradlc.vscode-tailwindcss",
        "figma.figma-vscode-extension",
        "bierner.markdown-mermaid",
        "yzhang.markdown-all-in-one",
        "ms-vscode.live-server"
    )

    foreach ($ext in $extensions) {
        Write-Host "  📌 Instalando: $ext" -ForegroundColor Gray
        code --install-extension $ext --force
    }

    # NPM packages para design tools
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        Write-Host "  📦 Instalando ferramentas NPM..." -ForegroundColor Gray
        npm install -g @mermaid-js/mermaid-cli
        npm install -g @storybook/cli
        npm install -g figma-export
        npm install -g ascii-art-cli
    }

    Write-Host "  ✅ Ferramentas de design instaladas!" -ForegroundColor Green
}

# Criar estrutura de wireframes
if ($GenerateWireframes) {
    Write-Host "🖼️ Gerando estrutura de wireframes..." -ForegroundColor Yellow

    # Criar diretórios
    $null = New-Item -ItemType Directory -Force -Path $wireframesDir
    $null = New-Item -ItemType Directory -Force -Path $componentsDir
    $null = New-Item -ItemType Directory -Force -Path (Join-Path $wireframesDir "ascii")
    $null = New-Item -ItemType Directory -Force -Path (Join-Path $wireframesDir "mermaid")
    $null = New-Item -ItemType Directory -Force -Path (Join-Path $wireframesDir "html-preview")

    # Template de wireframe ASCII
    $asciiWireframe = @"
# Wireframe ASCII - $Activity

## Layout Principal
```
┌─────────────────────────────────────────────────────────────┐
│  🏢 LOGO              [🔍 Search]         👤 Profile ⚙️    │ Header (64px)
├─────────────────────────────────────────────────────────────┤
│ 📱│                                                       │
│ 📊│  📈 Dashboard Principal                               │ Main Content
│ 📋│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐      │ (Cards Grid)
│ ⚙️│  │  KPI 1  │ │  KPI 2  │ │  KPI 3  │ │  KPI 4  │      │
│   │  │  \$1.2M  │ │  +15%   │ │  847    │ │  99.9%  │      │
│   │  └─────────┘ └─────────┘ └─────────┘ └─────────┘      │
│   │                                                       │
│   │  📊 [Chart Area - Interactive Visualization]         │ Chart Section
│   │  ████████████████████████▲                            │
│   │                                                       │
├───┴───────────────────────────────────────────────────────┤
│  © 2025 Company  │  📧 Support  │  🔗 Links  │  📱 Mobile  │ Footer (48px)
└─────────────────────────────────────────────────────────────┘
```

## Responsive Breakpoints
- Mobile (320px): Stack cards vertically, hamburger menu
- Tablet (768px): 2x2 card grid, sidebar collapsible
- Desktop (1024px+): Full layout as shown above

## Interactive Elements
- 🔍 Search: Real-time filtering with autocomplete
- 📊 KPI Cards: Hover animations, click for drill-down
- 📈 Charts: Touch-friendly, zoom/pan capabilities
- 📱 Sidebar: Collapsible with smooth animations
"@

    $asciiWireframe | Out-File -FilePath (Join-Path $wireframesDir "ascii\layout-principal.md") -Encoding utf8

    # Template Mermaid para User Flow
    $mermaidUserFlow = @"
# User Flow - $Activity

## Fluxo Principal do Usuário
``````mermaid
graph TD
    A[🏠 Landing Page] --> B{👤 Usuário Logado?}
    B -->|Sim| C[📊 Dashboard]
    B -->|Não| D[🔐 Login]
    D --> E{📧 Credenciais OK?}
    E -->|Sim| C
    E -->|Não| F[❌ Erro de Login]
    F --> D
    C --> G[📈 Visualizar KPIs]
    G --> H[🔍 Filtrar Dados]
    H --> I[📋 Exportar Relatório]
    C --> J[⚙️ Configurações]
    J --> K[👤 Perfil do Usuário]

    style A fill:#e1f5fe
    style C fill:#f3e5f5
    style G fill:#e8f5e8
``````

## Sitemap da Aplicação
``````mermaid
graph LR
    Home[🏠 Home] --> Auth[🔐 Auth]
    Home --> Dashboard[📊 Dashboard]
    Dashboard --> Reports[📈 Relatórios]
    Dashboard --> Analytics[📊 Analytics]
    Dashboard --> Settings[⚙️ Configurações]
    Reports --> Export[📤 Exportar]
    Analytics --> Filters[🔍 Filtros]
    Settings --> Profile[👤 Perfil]
    Settings --> Admin[🔧 Admin]
``````
"@

    $mermaidUserFlow | Out-File -FilePath (Join-Path $wireframesDir "mermaid\user-flow.md") -Encoding utf8

    # Template HTML Preview
    $htmlPreview = @"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wireframe Preview - $Activity</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }

        .wireframe {
            max-width: 1200px; margin: 20px auto; padding: 20px;
            border: 2px dashed #ccc; background: #f9f9f9;
        }

        .header {
            height: 64px; background: #e3f2fd; border: 1px solid #1976d2;
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 24px; margin-bottom: 16px;
        }

        .main-layout { display: grid; grid-template-columns: 240px 1fr; gap: 16px; }
        .sidebar { background: #f5f5f5; border: 1px solid #ddd; padding: 16px; }
        .content { background: #fff; border: 1px solid #ddd; padding: 24px; }

        .kpi-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px;
            margin-bottom: 24px;
        }

        .kpi-card {
            background: #ffffff; border: 1px solid #e0e0e0;
            padding: 24px; text-align: center; border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .chart-area {
            background: #fafafa; border: 2px dashed #ccc;
            height: 300px; display: flex; align-items: center; justify-content: center;
            font-size: 18px; color: #666;
        }

        .footer {
            height: 48px; background: #f5f5f5; border: 1px solid #ddd;
            display: flex; align-items: center; justify-content: center;
            margin-top: 16px; font-size: 14px; color: #666;
        }

        @media (max-width: 768px) {
            .main-layout { grid-template-columns: 1fr; }
            .kpi-grid { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 480px) {
            .kpi-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="wireframe">
        <header class="header">
            <div>🏢 <strong>LOGO</strong></div>
            <div>🔍 <input placeholder="Search..." style="padding: 8px;"> 👤 Profile ⚙️</div>
        </header>

        <main class="main-layout">
            <aside class="sidebar">
                <div>📊 <strong>Dashboard</strong></div>
                <div>📈 Relatórios</div>
                <div>📋 Tarefas</div>
                <div>⚙️ Configurações</div>
            </aside>

            <section class="content">
                <div class="kpi-grid">
                    <div class="kpi-card">
                        <div style="font-size: 24px; font-weight: bold; color: #1976d2;">\$1.2M</div>
                        <div>Revenue</div>
                    </div>
                    <div class="kpi-card">
                        <div style="font-size: 24px; font-weight: bold; color: #388e3c;">+15%</div>
                        <div>Growth</div>
                    </div>
                    <div class="kpi-card">
                        <div style="font-size: 24px; font-weight: bold; color: #f57c00;">847</div>
                        <div>Customers</div>
                    </div>
                    <div class="kpi-card">
                        <div style="font-size: 24px; font-weight: bold; color: #7b1fa2;">99.9%</div>
                        <div>Uptime</div>
                    </div>
                </div>

                <div class="chart-area">
                    📊 Interactive Chart Area - Click to Expand
                </div>
            </section>
        </main>

        <footer class="footer">
            © 2025 Company | 📧 Support | 🔗 Links | 📱 Mobile App
        </footer>
    </div>
</body>
</html>
"@

    $htmlPreview | Out-File -FilePath (Join-Path $wireframesDir "html-preview\wireframe-preview.html") -Encoding utf8

    Write-Host "  ✅ Wireframes gerados em: $wireframesDir" -ForegroundColor Green
}

# Gerar Design System template
$designSystemPath = Join-Path $baseDir "04-design-system.md"
if (-not (Test-Path $designSystemPath)) {
    $designSystem = @"
# Design System - $Activity

## 🎨 Design Tokens

### Colors
``````json
{
  "color": {
    "primary": {
      "50": "#e3f2fd", "100": "#bbdefb", "200": "#90caf9",
      "300": "#64b5f6", "400": "#42a5f5", "500": "#2196f3",
      "600": "#1e88e5", "700": "#1976d2", "800": "#1565c0", "900": "#0d47a1"
    },
    "secondary": {
      "50": "#fce4ec", "500": "#e91e63", "900": "#880e4f"
    },
    "neutral": {
      "50": "#fafafa", "100": "#f5f5f5", "200": "#eeeeee",
      "500": "#9e9e9e", "700": "#616161", "900": "#212121"
    }
  }
}
``````

### Typography
``````json
{
  "typography": {
    "fontFamily": {
      "primary": "Inter, system-ui, sans-serif",
      "secondary": "Roboto Mono, monospace"
    },
    "fontSize": {
      "xs": "0.75rem", "sm": "0.875rem", "base": "1rem",
      "lg": "1.125rem", "xl": "1.25rem", "2xl": "1.5rem"
    },
    "fontWeight": {
      "normal": "400", "medium": "500", "semibold": "600", "bold": "700"
    }
  }
}
``````

### Spacing
``````json
{
  "spacing": {
    "0": "0px", "1": "4px", "2": "8px", "3": "12px", "4": "16px",
    "5": "20px", "6": "24px", "8": "32px", "10": "40px", "12": "48px"
  }
}
``````

## 🧩 Component Library

### Button Component
``````css
.btn {
  padding: var(--spacing-3) var(--spacing-4);
  border-radius: 6px;
  font-weight: var(--font-weight-medium);
  transition: all 0.2s ease;
  cursor: pointer;
}

.btn-primary {
  background: var(--color-primary-500);
  color: white;
  border: none;
}

.btn-primary:hover {
  background: var(--color-primary-600);
  transform: translateY(-1px);
}
``````

### Card Component
``````css
.card {
  background: white;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  padding: var(--spacing-6);
  border: 1px solid var(--color-neutral-200);
}

.card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}
``````

## 📱 Responsive Grid System
``````css
.container { max-width: 1200px; margin: 0 auto; padding: 0 var(--spacing-4); }

.grid { display: grid; gap: var(--spacing-4); }
.grid-cols-1 { grid-template-columns: 1fr; }
.grid-cols-2 { grid-template-columns: repeat(2, 1fr); }
.grid-cols-3 { grid-template-columns: repeat(3, 1fr); }
.grid-cols-4 { grid-template-columns: repeat(4, 1fr); }

@media (max-width: 768px) {
  .grid-cols-2, .grid-cols-3, .grid-cols-4 {
    grid-template-columns: 1fr;
  }
}
``````

## ♿ Accessibility Guidelines

### WCAG 2.1 AA Compliance
- **Color Contrast**: Minimum 4.5:1 for normal text, 3:1 for large text
- **Focus Indicators**: Visible focus states for all interactive elements
- **Keyboard Navigation**: Full keyboard accessibility
- **Screen Readers**: Semantic HTML + ARIA labels
- **Motion**: Respect prefers-reduced-motion preferences

### Implementation Checklist
- [ ] Color contrast validated with WebAIM tool
- [ ] Focus states defined for all interactive elements
- [ ] Semantic HTML structure implemented
- [ ] ARIA labels added where necessary
- [ ] Keyboard navigation tested
- [ ] Screen reader compatibility verified
"@

    $designSystem | Out-File -FilePath $designSystemPath -Encoding utf8
    Write-Host "✅ Design System criado: $designSystemPath" -ForegroundColor Green
}

# Exportar para Figma (se ferramenta disponível)
if ($ExportToFigma) {
    Write-Host "🎨 Exportando wireframes para Figma..." -ForegroundColor Yellow

    if (Get-Command figma-export -ErrorAction SilentlyContinue) {
        # Converter wireframes para formato Figma-compatível
        $figmaExport = @{
            "name" = "$Activity Wireframes"
            "wireframes" = @(
                @{
                    "name" = "Desktop Layout"
                    "width" = 1200
                    "height" = 800
                    "elements" = @(
                        @{ "type" = "header"; "height" = 64 }
                        @{ "type" = "sidebar"; "width" = 240 }
                        @{ "type" = "main"; "grid" = "4-column" }
                    )
                }
            )
        }

        $figmaExport | ConvertTo-Json -Depth 3 | Out-File (Join-Path $wireframesDir "figma-export.json")
        Write-Host "  📤 Arquivo de exportação Figma criado" -ForegroundColor Green
        Write-Host "  💡 Use a Figma API ou plugin para importar os wireframes" -ForegroundColor Gray
    } else {
        Write-Host "  ⚠️ figma-export não encontrado. Instale com: npm install -g figma-export" -ForegroundColor Yellow
    }
}

# Gerar comandos úteis
Write-Host ""
Write-Host "🛠️ Ferramentas disponíveis:" -ForegroundColor Cyan
Write-Host ""
Write-Host "📊 Visualizar Mermaid diagrams:" -ForegroundColor White
Write-Host "  mmdc -i wireframes/mermaid/user-flow.md -o wireframes/user-flow.png" -ForegroundColor Gray
Write-Host ""
Write-Host "🌐 Preview HTML:" -ForegroundColor White
Write-Host "  code --install-extension ms-vscode.live-server" -ForegroundColor Gray
Write-Host "  # Depois: Right-click no HTML > 'Open with Live Server'" -ForegroundColor Gray
Write-Host ""
Write-Host "🎨 Abrir no VS Code:" -ForegroundColor White
Write-Host "  code $wireframesDir" -ForegroundColor Gray
Write-Host ""
Write-Host "✅ Setup de design concluído!" -ForegroundColor Green
Write-Host "📁 Estrutura criada em: $baseDir" -ForegroundColor Cyan
