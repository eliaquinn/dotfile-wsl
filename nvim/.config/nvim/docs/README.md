# Documentação Neovim Config

## Índice

1. [Treesitter Prisma](./TREESITTER_PRISMA.md) - Configuração do parser e highlight para arquivos Prisma

---

## Visão Geral

Esta configuração do Neovim usa:
- **Plugin Manager:** lazy.nvim
- **LSP:** nvim-lspconfig + mason.nvim
- **Treesitter:** nvim-treesitter
- **Tema:** tokyonight

## Estrutura

```
nvim/.config/nvim/
├── init.lua              # Entry point
├── lazy.lua              # Configuração do lazy.nvim
├── lua/eliaquinn/
│   ├── core/             # Configurações core (keymaps, options, api)
│   ├── plugins/           # Plugins individuais
│   │   ├── treesitter.lua
│   │   ├── rust.lua       # Setup do toolchain Rust (PATH e atalhos)
│   │   ├── rust/
│   │   │   └── keymaps.lua
│   │   └── lsp/
│   │       ├── lspconfig.lua
│   │       ├── mason-lspconfig.lua
│   │       ├── mason.lua
│   │       ├── lint.lua
│   │       └── conform.lua
│   └── config/
└── docs/                 # Documentação
```

## Configurações Especiais

### Prisma

O parser do Prisma requer configuração especial. Veja [TREESITTER_PRISMA.md](./TREESITTER_PRISMA.md) para detalhes.

### LSPs Configurados

- `ts_ls` - TypeScript/JavaScript
- `eslint` - ESLint
- `pyright` - Python
- `lua_ls` - Lua
- `vue_ls` - Vue
- `intelephense` - PHP
- `prismals` - Prisma
- `rust_analyzer` - Rust
- `jsonls` - JSON
- `yamlls` - YAML
- `terraformls` - Terraform
- `sqlls` - SQL

## Rust

O suporte ao Rust é dividido entre LSP, formatação, lint e atalhos:

- **LSP**: `rust_analyzer` (instalado pelo Mason), com `cargo check` para erros
  de compilação e o `clippy` executado pelo `nvim-lint` para os lints do clippy.
- **Formatter**: `rustfmt` (via `conform.nvim`) e `taplo` para arquivos TOML.
- **Linter**: `clippy` (`cargo clippy`), executado ao salvar o arquivo.
- **Atalhos** (buffer local, em arquivos Rust):

| Atalho | Ação |
| --- | --- |
| `<leader>rt` | Executa o teste sob o cursor (`experimental/runnables` do rust-analyzer) |
| `<leader>rm` | Expande a macro sob o cursor (`rust-analyzer/expandMacro`) |

> O `rustup` guarda os binários em `~/.cargo/bin`, que não está no PATH do
> Neovim quando ele é iniciado fora de um shell interativo. O plugin
> `plugins/rust.lua` adiciona esse diretório ao PATH durante a inicialização.

## Comandos Úteis

```bash
# Verificar health geral
:checkhealth

# Verificar treesitter
:checkhealth treesitter

# Atualizar parsers
:TSUpdate

# Instalar parser específico
:TSInstall prisma

# Ver LSPs ativos
:LspInfo

# Mason - gerenciar LSPs
:Mason
```
