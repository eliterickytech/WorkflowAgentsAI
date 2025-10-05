# Padrão de Encoding e Formatação - WorkflowAgentsAI

## 📋 Padrão Oficial do Projeto

### ✅ Encoding Recomendado

**Para todos os arquivos do projeto:**

| Tipo de Arquivo | Encoding Padrão | BOM | Line Ending |
|-----------------|-----------------|-----|-------------|
| `*.md` (Markdown) | **UTF-8** | ❌ Sem BOM | CRLF (Windows) |
| `*.ps1` (PowerShell) | **UTF-8** | ❌ Sem BOM | CRLF (Windows) |
| `*.yaml`, `*.yml` | **UTF-8** | ❌ Sem BOM | LF (Unix) |
| `*.feature` (Gherkin) | **UTF-8** | ❌ Sem BOM | LF (Unix) |
| `*.json` | **UTF-8** | ❌ Sem BOM | LF (Unix) |
| `*.cs` (C#) | **UTF-8** | ⚠️ Com BOM | CRLF (Windows) |
| `*.ts`, `*.js` | **UTF-8** | ❌ Sem BOM | LF (Unix) |

### 🎯 Por que UTF-8 SEM BOM?

**Vantagens:**
- ✅ Compatível com Git e GitHub
- ✅ Funciona em Linux, macOS e Windows
- ✅ Compatível com ferramentas de linha de comando
- ✅ Menor tamanho de arquivo (3 bytes a menos)
- ✅ Padrão da indústria para arquivos texto

**Quando usar UTF-8 COM BOM:**
- ⚠️ Arquivos C# (.cs) - Visual Studio espera BOM
- ⚠️ Arquivos de configuração legados do Windows

---

## 🛠️ Configuração do VS Code

### Arquivo `.vscode/settings.json`

```json
{
  "files.encoding": "utf8",
  "files.eol": "\n",
  "files.autoGuessEncoding": false,
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,

  "[markdown]": {
    "files.encoding": "utf8",
    "files.eol": "\r\n",
    "files.trimTrailingWhitespace": true
  },

  "[powershell]": {
    "files.encoding": "utf8",
    "files.eol": "\r\n"
  },

  "[csharp]": {
    "files.encoding": "utf8bom",
    "files.eol": "\r\n"
  },

  "[yaml]": {
    "files.encoding": "utf8",
    "files.eol": "\n"
  },

  "[json]": {
    "files.encoding": "utf8",
    "files.eol": "\n"
  }
}
```

### Arquivo `.editorconfig` (Raiz do Projeto)

```ini
# EditorConfig - Padrão de formatação para todos os editores
# https://editorconfig.org

root = true

# Padrão para todos os arquivos
[*]
charset = utf-8
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

# Arquivos Markdown
[*.md]
charset = utf-8
end_of_line = crlf
indent_size = 2
trim_trailing_whitespace = false  # Permite espaços para quebras de linha

# PowerShell
[*.ps1]
charset = utf-8
end_of_line = crlf
indent_size = 4

# YAML
[*.{yaml,yml}]
charset = utf-8
end_of_line = lf
indent_size = 2

# JSON
[*.json]
charset = utf-8
end_of_line = lf
indent_size = 2

# Gherkin (BDD)
[*.feature]
charset = utf-8
end_of_line = lf
indent_size = 2

# C# e .NET
[*.cs]
charset = utf-8-bom
end_of_line = crlf
indent_size = 4

# TypeScript/JavaScript
[*.{ts,js,tsx,jsx}]
charset = utf-8
end_of_line = lf
indent_size = 2

# HTML
[*.{html,htm}]
charset = utf-8
end_of_line = lf
indent_size = 2
```

---

## 🔍 Como Verificar o Encoding Atual

### No VS Code

1. **Verificar encoding atual:**
   - Abra o arquivo
   - Veja o canto **inferior direito** da janela
   - Deve mostrar: `UTF-8` ou `UTF-8 with BOM`

2. **Converter encoding:**
   - Clique no encoding (ex: `UTF-8 with BOM`)
   - Selecione "Save with Encoding"
   - Escolha `UTF-8` (sem BOM)

### Via PowerShell

```powershell
# Verificar BOM de um arquivo
$bytes = [System.IO.File]::ReadAllBytes("arquivo.md")
if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    Write-Host "UTF-8 COM BOM"
} else {
    Write-Host "UTF-8 SEM BOM (correto!)"
}

# Verificar múltiplos arquivos
Get-ChildItem -Recurse -Include *.md | ForEach-Object {
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    $hasBOM = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
    "$($_.Name): $(if($hasBOM){'COM BOM'}else{'SEM BOM ✓'})"
}
```

---

## 🚫 Caracteres que DEVEM Funcionar Corretamente

### Português Brasileiro

| Caractere | Unicode | Bytes UTF-8 | Correto |
|-----------|---------|-------------|---------|
| ç | U+00E7 | `C3 A7` | ✅ |
| ã | U+00E3 | `C3 A3` | ✅ |
| õ | U+00F5 | `C3 B5` | ✅ |
| á | U+00E1 | `C3 A1` | ✅ |
| é | U+00E9 | `C3 A9` | ✅ |
| í | U+00ED | `C3 AD` | ✅ |
| ó | U+00F3 | `C3 B3` | ✅ |
| ú | U+00FA | `C3 BA` | ✅ |
| â | U+00E2 | `C3 A2` | ✅ |
| ê | U+00EA | `C3 AA` | ✅ |
| ô | U+00F4 | `C3 B4` | ✅ |

### Emojis Comuns no Projeto

| Emoji | Nome | Unicode | Bytes UTF-8 |
|-------|------|---------|-------------|
| 🎯 | Alvo | U+1F3AF | `F0 9F 8E AF` |
| 🚀 | Foguete | U+1F680 | `F0 9F 9A 80` |
| 📚 | Livros | U+1F4DA | `F0 9F 93 9A` |
| 📝 | Memo | U+1F4DD | `F0 9F 93 9D` |
| ✅ | Check | U+2705 | `E2 9C 85` |
| ❌ | X | U+274C | `E2 9D 8C` |
| ⚠️ | Aviso | U+26A0 | `E2 9A A0` |
| 💡 | Lâmpada | U+1F4A1 | `F0 9F 92 A1` |

### Símbolos Especiais

| Símbolo | Nome | Unicode | Bytes UTF-8 |
|---------|------|---------|-------------|
| → | Seta direita | U+2192 | `E2 86 92` |
| ← | Seta esquerda | U+2190 | `E2 86 90` |
| ↑ | Seta cima | U+2191 | `E2 86 91` |
| ↓ | Seta baixo | U+2193 | `E2 86 93` |
| • | Bullet | U+2022 | `E2 80 A2` |
| … | Elipse | U+2026 | `E2 80 A6` |
| — | Em dash | U+2014 | `E2 80 94` |
| – | En dash | U+2013 | `E2 80 93` |

---

## 🔧 Como Corrigir Encoding Incorreto

### Método 1: VS Code (Recomendado)

```
1. Abrir arquivo
2. Clicar no encoding (canto inferior direito)
3. "Reopen with Encoding" → Escolher o encoding que MOSTRA corretamente
4. "Save with Encoding" → UTF-8 (sem BOM)
5. Salvar arquivo (Ctrl+S)
```

### Método 2: PowerShell

```powershell
# Ler arquivo e salvar com encoding correto
$content = Get-Content "arquivo.md" -Raw -Encoding UTF8
$utf8NoBOM = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("arquivo.md", $content, $utf8NoBOM)
```

### Método 3: Script de Correção em Massa

```powershell
# Processar múltiplos arquivos
Get-ChildItem -Recurse -Include *.md,*.ps1 | ForEach-Object {
    try {
        $content = Get-Content $_.FullName -Raw -Encoding UTF8
        $utf8NoBOM = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($_.FullName, $content, $utf8NoBOM)
        Write-Host "✅ $($_.Name)"
    } catch {
        Write-Host "❌ $($_.Name): $_"
    }
}
```

---

## 🚨 Sintomas de Encoding Incorreto

### Como Identificar

| Você Vê | Deveria Ser | Problema |
|---------|-------------|----------|
| `Ã§` | `ç` | Double UTF-8 encoding |
| `ÃÂ§` | `ç` | Triple UTF-8 encoding |
| `Ã£` | `ã` | Double UTF-8 encoding |
| `Ã©` | `é` | Double UTF-8 encoding |
| `â€™` | `'` | Windows-1252 → UTF-8 |
| `â€"` | `—` | Windows-1252 → UTF-8 |
| `�` | Qualquer | Caractere inválido |
| `ðŸš€` | `🚀` | Double UTF-8 em emoji |

### Causas Comuns

1. **Editor configurado errado**
   - Editor lê UTF-8 como Latin-1/ISO-8859-1
   - Solução: Configurar editor para UTF-8

2. **Copy/paste de Word/Excel**
   - Word usa Windows-1252, não UTF-8
   - Solução: Limpar formatação ao colar

3. **Git configurado incorreto**
   - `core.autocrlf=true` pode causar problemas
   - Solução: `git config core.autocrlf false`

4. **PowerShell sem especificar encoding**
   - Default pode ser ASCII ou Latin-1
   - Solução: Sempre usar `-Encoding UTF8`

---

## ✅ Checklist de Qualidade

### Antes de Commit

- [ ] Todos os arquivos `.md` estão em **UTF-8 sem BOM**
- [ ] Todos os arquivos `.ps1` estão em **UTF-8 sem BOM**
- [ ] Arquivos `.cs` estão em **UTF-8 com BOM**
- [ ] Line endings corretos (CRLF para Windows, LF para Unix)
- [ ] Sem trailing whitespace (exceto Markdown)
- [ ] Final newline presente em todos os arquivos
- [ ] Caracteres acentuados aparecem corretamente
- [ ] Emojis aparecem corretamente (se aplicável)

### Validação Automática

```powershell
# Script de validação
$errors = @()

Get-ChildItem -Recurse -Include *.md,*.ps1,*.yaml,*.json | ForEach-Object {
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    $hasBOM = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)

    # Markdown e PowerShell NÃO devem ter BOM
    if ($_.Extension -in @('.md','.ps1') -and $hasBOM) {
        $errors += "❌ $($_.Name) tem BOM (deveria ser sem BOM)"
    }

    # C# DEVE ter BOM
    if ($_.Extension -eq '.cs' -and -not $hasBOM) {
        $errors += "⚠️ $($_.Name) não tem BOM (C# deveria ter)"
    }
}

if ($errors.Count -eq 0) {
    Write-Host "✅ Todos os arquivos estão corretos!"
} else {
    Write-Host "❌ Encontrados $($errors.Count) problemas:"
    $errors | ForEach-Object { Write-Host "  $_" }
}
```

---

## 📚 Referências

- [UTF-8 Specification](https://www.unicode.org/versions/Unicode15.0.0/ch03.pdf)
- [EditorConfig](https://editorconfig.org/)
- [VS Code Encoding](https://code.visualstudio.com/docs/editor/codebasics#_file-encoding-support)
- [PowerShell Encoding](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content)

---

## 🎯 Resumo Executivo

**Padrão oficial do WorkflowAgentsAI:**

```
✅ UTF-8 sem BOM
✅ Line ending: CRLF (Windows) para .md e .ps1
✅ Line ending: LF (Unix) para .yaml, .json, .feature
✅ Indentação: 2 espaços (geral), 4 espaços (PowerShell e C#)
✅ Trim trailing whitespace
✅ Insert final newline
```

**Configuração mínima necessária:**
1. Copiar `.editorconfig` para raiz do projeto ✅ (já existe)
2. Configurar VS Code settings (criar `.vscode/settings.json`)
3. Instalar extensão "EditorConfig for VS Code"

**Status atual do projeto:** ✅ **100% correto** (87 arquivos em UTF-8 sem BOM)
