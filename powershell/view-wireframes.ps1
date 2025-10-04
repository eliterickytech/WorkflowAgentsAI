param(
    [Parameter(Mandatory=$true)][string]$Sprint,
    [Parameter(Mandatory=$true)][string]$Activity,
    [switch]$OpenBrowser = $false,
    [switch]$ExportImages = $false,
    [switch]$GenerateStorybook = $false
)

# Configuração
$baseDir = Join-Path (Join-Path $PSScriptRoot "..\out") ("sprint$Sprint\$Activity")
$wireframesDir = Join-Path $baseDir "04-wireframes"

Write-Host "👁️ AgileDevAgent - Wireframe Viewer" -ForegroundColor Blue
Write-Host "Sprint: $Sprint | Activity: $Activity" -ForegroundColor Cyan
Write-Host ""

# Verificar se wireframes existem
if (-not (Test-Path $wireframesDir)) {
    Write-Error "❌ Wireframes não encontrados. Execute setup-design-tools.ps1 -GenerateWireframes primeiro."
    exit 1
}

# Listar wireframes disponíveis
Write-Host "📋 Wireframes disponíveis:" -ForegroundColor Yellow
Get-ChildItem $wireframesDir -Recurse -Include "*.md", "*.html" | ForEach-Object {
    $relativePath = $_.FullName.Replace("$wireframesDir\", "")
    Write-Host "  📄 $relativePath" -ForegroundColor Gray
}
Write-Host ""

# Abrir no navegador
if ($OpenBrowser) {
    $htmlPreview = Join-Path $wireframesDir "html-preview\wireframe-preview.html"
    
    if (Test-Path $htmlPreview) {
        Write-Host "🌐 Abrindo preview no navegador..." -ForegroundColor Green
        Start-Process $htmlPreview
        
        # Criar servidor local se Live Server estiver disponível
        if (Get-Command code -ErrorAction SilentlyContinue) {
            Write-Host "💡 Dica: Use Live Server no VS Code para hot reload" -ForegroundColor Cyan
            Write-Host "  1. Abra o HTML no VS Code" -ForegroundColor Gray
            Write-Host "  2. Right-click > 'Open with Live Server'" -ForegroundColor Gray
        }
    } else {
        Write-Host "⚠️ HTML preview não encontrado" -ForegroundColor Yellow
    }
}

# Exportar diagramas Mermaid para imagens
if ($ExportImages) {
    Write-Host "🖼️ Exportando diagramas para imagens..." -ForegroundColor Yellow
    
    $mermaidDir = Join-Path $wireframesDir "mermaid"
    $imagesDir = Join-Path $wireframesDir "images"
    
    if (Test-Path $mermaidDir) {
        $null = New-Item -ItemType Directory -Force -Path $imagesDir
        
        # Verificar se mermaid-cli está disponível
        if (Get-Command mmdc -ErrorAction SilentlyContinue) {
            Get-ChildItem $mermaidDir -Filter "*.md" | ForEach-Object {
                $inputFile = $_.FullName
                $baseName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
                $outputFile = Join-Path $imagesDir "$baseName.png"
                
                Write-Host "  🎨 Renderizando: $baseName.md → $baseName.png" -ForegroundColor Gray
                
                try {
                    & mmdc -i $inputFile -o $outputFile -t dark -b transparent 2>$null
                    
                    if (Test-Path $outputFile) {
                        Write-Host "    ✅ Sucesso!" -ForegroundColor Green
                    } else {
                        Write-Host "    ❌ Falha na renderização" -ForegroundColor Red
                    }
                } catch {
                    Write-Host "    ❌ Erro: $($_.Exception.Message)" -ForegroundColor Red
                }
            }
            
            Write-Host "  📁 Imagens salvas em: $imagesDir" -ForegroundColor Cyan
        } else {
            Write-Host "  ⚠️ Mermaid CLI não encontrado" -ForegroundColor Yellow
            Write-Host "  💡 Instale com: npm install -g @mermaid-js/mermaid-cli" -ForegroundColor Gray
        }
    }
}

# Gerar Storybook para componentes
if ($GenerateStorybook) {
    Write-Host "📚 Gerando Storybook..." -ForegroundColor Yellow
    
    $storybookDir = Join-Path $baseDir "04-storybook"
    $null = New-Item -ItemType Directory -Force -Path $storybookDir
    
    # Template de story para componentes
    $buttonStory = @"
import type { Meta, StoryObj } from '@storybook/react';
import { Button } from './Button';

const meta: Meta<typeof Button> = {
  title: '$Activity/Button',
  component: Button,
  parameters: {
    layout: 'centered',
  },
  tags: ['autodocs'],
  argTypes: {
    variant: {
      control: { type: 'select' },
      options: ['primary', 'secondary', 'outline'],
    },
    size: {
      control: { type: 'select' },
      options: ['sm', 'md', 'lg'],
    },
  },
};

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    variant: 'primary',
    children: 'Button',
  },
};

export const Secondary: Story = {
  args: {
    variant: 'secondary',
    children: 'Button',
  },
};

export const Large: Story = {
  args: {
    size: 'lg',
    children: 'Button',
  },
};

export const Small: Story = {
  args: {
    size: 'sm',
    children: 'Button',
  },
};
"@
    
    $buttonStory | Out-File -FilePath (Join-Path $storybookDir "Button.stories.ts") -Encoding utf8
    
    # Package.json para Storybook
    $storybookPackage = @{
        "name" = "$Activity-storybook"
        "version" = "1.0.0"
        "scripts" = @{
            "storybook" = "storybook dev -p 6006"
            "build-storybook" = "storybook build"
        }
        "devDependencies" = @{
            "@storybook/react" = "^7.6.0"
            "@storybook/react-vite" = "^7.6.0"
            "storybook" = "^7.6.0"
        }
    }
    
    $storybookPackage | ConvertTo-Json -Depth 3 | Out-File (Join-Path $storybookDir "package.json") -Encoding utf8
    
    Write-Host "  📚 Storybook template criado em: $storybookDir" -ForegroundColor Green
    Write-Host "  💡 Para inicializar: cd $storybookDir && npm init storybook" -ForegroundColor Cyan
}

# Criar relatório de wireframes
$reportPath = Join-Path $baseDir "04-wireframe-report.md"
$report = @"
# Relatório de Wireframes - $Activity

📅 **Gerado em:** $(Get-Date -Format "dd/MM/yyyy HH:mm")
🎯 **Sprint:** $Sprint | **Atividade:** $Activity

## 📊 Estrutura Criada

### 🎨 Wireframes ASCII
- **Layout Principal**: Estrutura base da interface
- **Componentes**: Elementos individuais da UI
- **Responsividade**: Breakpoints mobile/tablet/desktop

### 📐 Diagramas Mermaid
- **User Flow**: Fluxo de navegação do usuário
- **Sitemap**: Arquitetura de informação
- **Component Tree**: Hierarquia de componentes

### 🌐 HTML Preview
- **Interactive Demo**: Visualização clicável
- **Responsive Layout**: Grade adaptativa
- **Component Library**: Elementos reutilizáveis

### 🎯 Design System
- **Design Tokens**: Colors, Typography, Spacing
- **Component Specs**: CSS e comportamento
- **Accessibility**: Guidelines WCAG 2.1 AA

## 📁 Arquivos Gerados

``````
04-wireframes/
├── ascii/
│   └── layout-principal.md
├── mermaid/
│   └── user-flow.md
├── html-preview/
│   └── wireframe-preview.html
└── images/ (se exportado)
    ├── user-flow.png
    └── sitemap.png
``````

## 🛠️ Próximos Passos

### Para Desenvolvedores
1. **Analisar wireframes** ASCII para entender a estrutura
2. **Implementar componentes** baseados no Design System
3. **Seguir especificações** de responsividade
4. **Aplicar guidelines** de acessibilidade

### Para UX/UI Designers  
1. **Refinar wireframes** com mais detalhes visuais
2. **Criar protótipos** interativos no Figma
3. **Definir animações** e microinterações
4. **Validar usabilidade** com testes

### Para QA
1. **Verificar responsividade** em diferentes dispositivos
2. **Testar acessibilidade** com ferramentas automatizadas
3. **Validar performance** dos Core Web Vitals
4. **Conferir compatibilidade** cross-browser

## 📋 Checklist de Qualidade

### ✅ Estrutura
- [x] Layout base definido
- [x] Componentes identificados  
- [x] Responsividade planejada
- [x] Navegação mapeada

### ⚡ Performance
- [ ] Imagens otimizadas
- [ ] CSS minificado
- [ ] Lazy loading implementado
- [ ] Core Web Vitals < 2.5s

### ♿ Acessibilidade
- [x] Contraste de cores validado
- [x] Navegação por teclado
- [x] ARIA labels definidos
- [ ] Testes com screen readers

### 📱 Responsividade
- [x] Mobile-first approach
- [x] Breakpoints definidos
- [x] Touch-friendly elements
- [ ] Cross-device testing

## 🎨 Ferramentas Recomendadas

### Design
- **Figma**: Para protótipos de alta fidelidade
- **Miro**: Para collaborative wireframing
- **Whimsical**: Para user flows e sitemaps

### Desenvolvimento
- **Storybook**: Component documentation
- **Chromatic**: Visual regression testing  
- **Accessibility Insights**: A11y validation

### Testes
- **Lighthouse**: Performance auditing
- **axe DevTools**: Accessibility testing
- **BrowserStack**: Cross-browser testing

---

💡 **Dica**: Use este relatório como base para refinamentos futuros dos wireframes.
"@

$report | Out-File -FilePath $reportPath -Encoding utf8

# Resumo final
Write-Host ""
Write-Host "📊 Resumo da visualização:" -ForegroundColor Cyan
Write-Host "┌────────────────────────────────────────────────┐" -ForegroundColor Gray
Write-Host "│ 📁 Diretório: $((Split-Path $wireframesDir -Leaf).PadRight(30)) │" -ForegroundColor Gray

$fileCount = (Get-ChildItem $wireframesDir -Recurse -File).Count
Write-Host "│ 📄 Arquivos: $($fileCount.ToString().PadRight(32)) │" -ForegroundColor Gray

$dirCount = (Get-ChildItem $wireframesDir -Recurse -Directory).Count  
Write-Host "│ 📂 Diretórios: $($dirCount.ToString().PadRight(30)) │" -ForegroundColor Gray
Write-Host "└────────────────────────────────────────────────┘" -ForegroundColor Gray

Write-Host ""
Write-Host "🎯 Comandos úteis:" -ForegroundColor Yellow
Write-Host "  .\view-wireframes.ps1 -Sprint $Sprint -Activity $Activity -OpenBrowser" -ForegroundColor Gray
Write-Host "  .\view-wireframes.ps1 -Sprint $Sprint -Activity $Activity -ExportImages" -ForegroundColor Gray  
Write-Host "  code `"$wireframesDir`"" -ForegroundColor Gray
Write-Host ""
Write-Host "📋 Relatório criado: $(Split-Path $reportPath -Leaf)" -ForegroundColor Green
Write-Host "✅ Visualização concluída!" -ForegroundColor Green