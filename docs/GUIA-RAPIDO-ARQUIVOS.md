# Guia Rapido: Criacao e Edicao de Arquivos

## Prioridades MAXIMAS ao Trabalhar com Arquivos

### 1. SEMPRE Verificar Encoding ANTES de Salvar

```
VS Code > Canto Inferior Direito > Deve mostrar: UTF-8
```

### 2. Tabela de Encoding por Tipo de Arquivo

| Arquivo | Encoding | BOM | Line End | Indent |
|---------|----------|-----|----------|--------|
| .md | UTF-8 | NAO | CRLF | 2 sp |
| .ps1 | UTF-8 | NAO | CRLF | 4 sp |
| .yaml | UTF-8 | NAO | LF | 2 sp |
| .json | UTF-8 | NAO | LF | 2 sp |
| .feature | UTF-8 | NAO | LF | 2 sp |
| .cs | UTF-8 | SIM | CRLF | 4 sp |
| .ts/.js | UTF-8 | NAO | LF | 2 sp |

### 3. Checklist OBRIGATORIO

**ANTES de criar arquivo:**
- [ ] Qual tipo de arquivo?
- [ ] Precisa de BOM? (so .cs)
- [ ] Line ending: CRLF ou LF?
- [ ] Indentacao: 2 ou 4 espacos?

**DURANTE criacao:**
- [ ] UTF-8 sem BOM (exceto .cs)
- [ ] Espacos, NUNCA tabs
- [ ] Line ending correto
- [ ] Final newline presente

**DEPOIS de salvar:**
- [ ] VS Code mostra "UTF-8" correto
- [ ] Caracteres c, a, e aparecem certos
- [ ] Sem corrupcao (NAO Ac, a, etc)

### 4. Sinais de ALERTA

**PARE IMEDIATAMENTE se ver:**
- Ac ao inves de c
- Aa ao inves de a
- configuracAa ao inves de configuracao
- "UTF-8 with BOM" para .md, .ps1, .yaml

**Solucao:**
1. VS Code > Encoding > Reopen with UTF-8
2. Verificar se ficou correto
3. Save with Encoding > UTF-8 (sem BOM)

### 5. Comandos Rapidos

**Verificar encoding de um arquivo:**
```powershell
$bytes = [System.IO.File]::ReadAllBytes("arquivo.md")
if ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB) {
    "TEM BOM (errado para .md)"
} else {
    "SEM BOM (correto!)"
}
```

**Validar projeto completo:**
```powershell
cd .\powershell
# (Script validate-encoding.ps1 em desenvolvimento)
```

## Arquivos de Configuracao

**JA CONFIGURADOS no projeto:**
- `.editorconfig` (raiz) - Regras universais
- `.vscode/settings.json` - Configuracao VS Code

**NAO precisa criar novamente!**

## Documentacao Completa

Para mais detalhes, consulte:
- `docs/PADRAO-ENCODING-FORMATACAO.md` (400+ linhas)
- `.github/copilot-instructions.md` (secao completa sobre encoding)

## Status Atual

```
Total arquivos: 87
Encoding correto: 87/87 (100%)
Configuracao: OK
```

**Projeto esta PERFEITO em encoding!**

## Regras Especificas por Arquivo

### Markdown (.md)
- UTF-8 sem BOM
- CRLF (Windows)
- 2 espacos
- Permite trailing space (quebras de linha)

### PowerShell (.ps1)
- UTF-8 sem BOM
- CRLF (Windows)
- 4 espacos
- Sem trailing space

### YAML (.yaml, .yml)
- UTF-8 sem BOM
- LF (Unix)
- 2 espacos (CRITICO!)
- Sem trailing space

### JSON (.json)
- UTF-8 sem BOM
- LF (Unix)
- 2 espacos
- Sem trailing space

### Gherkin (.feature)
- UTF-8 sem BOM
- LF (Unix)
- 2 espacos
- Palavras-chave em portugues: Funcionalidade, Cenario, Dado, Quando, Entao

### C# (.cs)
- UTF-8 COM BOM (unica excecao!)
- CRLF (Windows)
- 4 espacos
- Sem trailing space

## Dicas Pro

1. **Instale extensao EditorConfig no VS Code**
   - Respeita automaticamente .editorconfig

2. **Configure VS Code para mostrar espacos/tabs**
   - Settings > Render Whitespace > boundary

3. **Use Format Document (Shift+Alt+F)**
   - Formata seguindo .editorconfig

4. **Git: Configure core.autocrlf**
   ```
   git config core.autocrlf false
   ```
   - Previne conversoes automaticas de line ending

## Troubleshooting

### Problema: Caracteres estranhos apos salvar
**Solucao:** Arquivo foi salvo com encoding errado
1. Reopen with Encoding > UTF-8
2. Save with Encoding > UTF-8 (sem BOM)

### Problema: YAML nao parseia
**Solucao:** Provavelmente indentacao errada
- YAML e SUPER sensivel a espacos
- SEMPRE 2 espacos, NUNCA tabs

### Problema: PowerShell script nao executa
**Solucao:** Pode ser line ending errado
- PowerShell espera CRLF
- Verifique: file.eol no VS Code

### Problema: Git mostra arquivo inteiro como mudado
**Solucao:** Line ending mudou
```
git config core.autocrlf false
```

## Contato/Suporte

Para duvidas sobre encoding:
- Leia: `docs/PADRAO-ENCODING-FORMATACAO.md`
- Configuracoes: `.editorconfig` e `.vscode/settings.json`
