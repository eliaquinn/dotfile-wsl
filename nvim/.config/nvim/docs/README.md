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
- `jsonls` - JSON
- `yamlls` - YAML
- `terraformls` - Terraform
- `sqlls` - SQL

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
