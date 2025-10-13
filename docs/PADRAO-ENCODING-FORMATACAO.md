# Padrão de Encoding e Formatação · WorkflowAgentsAI

Este guia define, de forma objetiva, como trabalhamos com encoding, BOM, finais de linha e prevenção de mojibake em todo o ecossistema do WorkflowAgentsAI.

---

## 🎯 Padrão oficial do projeto

| Tipo de arquivo                           | Encoding | BOM         | Finais de linha |
|-------------------------------------------|----------|-------------|-----------------|
| `*.md` (Markdown)                         | UTF-8    | sem BOM     | CRLF            |
| `*.ps1`, `*.psm1` (PowerShell)            | UTF-8    | sem BOM     | CRLF            |
| `*.yaml`, `*.yml`, `*.feature`, `*.json`  | UTF-8    | sem BOM     | LF              |
| `*.ts`, `*.js`, `*.html`, `*.css`         | UTF-8    | sem BOM     | LF              |
| `*.cs` (C#)                               | UTF-8    | **com BOM** | CRLF            |

### ✅ Por que padronizamos em UTF-8 sem BOM?

- Compatível com Git/GitHub e evita deltas desnecessários.
- Funciona de forma idêntica em Linux, macOS e Windows.
- Evita caracteres “fantasma” introduzidos por shells ou pipelines.
- Reduz o tamanho dos arquivos em 3 bytes.
- É o padrão de mercado para praticamente todos os arquivos texto modernos.

### 📌 Quando o BOM é obrigatório?

- Arquivos C#, onde o Visual Studio ainda assume BOM por padrão.
- Configurações legadas do Windows (ex.: `.reg`, `.ini`) **quando exigido explicitamente**.

---

## ⚙️ Configuração recomendada do editor

### VS Code (`.vscode/settings.json`)

```json
{
  "files.encoding": "utf8",
  "files.autoGuessEncoding": false,
  "files.eol": "\r\n",
  "[yaml]": { "files.eol": "\n" },
  "[json]": { "files.eol": "\n" },
  "[typescript]": { "files.eol": "\n" },
  "[javascript]": { "files.eol": "\n" },
  "[html]": { "files.eol": "\n" }
}
```

### EditorConfig (trecho relevante)

```ini
[*]
charset = utf-8
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
end_of_line = crlf

[*.ps1]
end_of_line = crlf

[*.yaml]
end_of_line = lf

[*.cs]
charset = utf-8-bom
end_of_line = crlf
```

---

## 🔍 Diagnóstico de mojibake

| O que aparece          | Deveria ser | Causa provável                | Correção                     |
|-----------------------|-------------|--------------------------------|------------------------------|
| `Ã§`, `Ã£`, `Ã³`      | `ç`, `ã`, `ó`| Texto UTF-8 lido como Latin-1  | Reabrir arquivo como UTF-8   |
| `ï¿½`                  | Qualquer    | Caractere inválido/substituto | Revisar fonte original       |
| `â€™`, `â€œ`, `â€�`    | `’`, `“`, `”`| Word/Excel colado sem limpeza  | Colar sem formatação         |
| Emojis quebrados       | Emoji real  | Encode/double encode           | Copiar novamente da fonte    |

> 📌 **Alerta:** se o arquivo já está correto (acentos e emojis exibindo normalmente), **não** force regravação — isso evita regressões.

---

## 🛠️ Validação automatizada

Execute o script oficial sempre que fizer importações em massa ou antes do commit:

```powershell
cd C:\Projetos\WorkflowAgentsAI
.\scripts\powershell\validate-encoding.ps1 -Fix -RepairMojibake
```

Ele verifica e corrige, quando autorizado por `-Fix`, os seguintes pontos:

1. BOM presente/ausente conforme tabela.
2. Quebra de linha (CRLF ou LF) de acordo com o tipo de arquivo.
3. Sequências clássicas de mojibake (ex.: `Ã`, `â€™`, `ï¿½`), tentando reparo automático quando `-RepairMojibake` é informado.

---

## 🧭 Boas práticas diárias

1. Configure seu editor para salvar *sempre* em UTF-8.
2. Ao copiar conteúdos externos (Word, Excel, PDF), cole primeiro em um editor puro (ex.: Notepad++) para eliminar formatação problemática.
3. Revise diffs antes do commit e rejeite qualquer alteração que insira mojibake.
4. Para automações, force a biblioteca/API a escrever em UTF-8 (com ou sem BOM, conforme o artefato).
5. Se encontrar caracteres estranhos, pare, identifique a fonte correta e só então normalize — nunca “adivinhe” o texto original.

---

## 📎 Referências rápidas

- [Standard UTF-8](https://www.unicode.org/versions/Unicode15.0.0/ch03.pdf)
- [EditorConfig](https://editorconfig.org/)
- [Guia de Encoding no VS Code](https://code.visualstudio.com/docs/editor/codebasics#_file-encoding-support)
- [`validate-encoding.ps1`](../scripts/powershell/validate-encoding.ps1)
