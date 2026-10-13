# Neovim Treesitter - Parser Prisma

## Problema

O nvim-treesitter não instala automaticamente o parser do Prisma porque:

1. O `tree-sitter-cli` (dependência para compilar parsers) pode não estar no PATH do Neovim
2. O parser precisa ser compilado a partir do repositório `tree-sitter-prisma`
3. As queries de highlight precisam ser copiadas

## Solução Automática

A configuração em `lua/eliaquinn/plugins/treesitter.lua` já inclui:

- Detecção automática do `tree-sitter-cli` em vários caminhos comuns
- Compilação e instalação automática do parser na primeira execução
- Autocmd para ativar highlight para arquivos `.prisma`

## Instalação Manual (se a automática falhar)

Se o highlight não funcionar, siga estes passos:

### 1. Instalar dependências

```bash
# Instalar tree-sitter-cli (se ainda não tiver)
npm install -g tree-sitter-cli

# Verificar instalação
tree-sitter --version
```

### 2. Compilar e instalar o parser manualmente

```bash
# Clonar o repositório do parser
cd /tmp
rm -rf tree-sitter-prisma
git clone --depth 1 https://github.com/victorhqc/tree-sitter-prisma.git
cd tree-sitter-prisma

# Gerar arquivos e compilar
tree-sitter generate
tree-sitter build -o /tmp/prisma_parser.so

# Criar diretórios se necessário
mkdir -p ~/.local/share/nvim/site/parser
mkdir -p ~/.local/share/nvim/site/queries/prisma

# Copiar parser compilado
cp /tmp/prisma_parser.so ~/.local/share/nvim/site/parser/prisma.so

# Copiar queries de highlight
cp queries/*.scm ~/.local/share/nvim/site/queries/prisma/
```

### 3. Verificar instalação

```bash
# No Neovim
:checkhealth treesitter
```

Deve aparecer:
```
✅ OK Parser: prisma  ABI: 15, path: ~/.local/share/nvim/site/parser/prisma.so
```

### 4. Reiniciar o Neovim

```bash
nvim schema.prisma
```

O highlight deve funcionar.

## Caminhos comums do tree-sitter-cli

O script detecta automaticamente nos seguintes caminhos:

| Plataforma | Caminho |
|------------|---------|
| Linuxbrew | `/home/linuxbrew/.linuxbrew/bin` |
| npm global | `~/.npm-global/bin` |
| Homebrew | `/usr/local/bin` |
| Sistema | `/usr/bin` |

## Verificar status

```bash
# Verificar parsers instalados
:checkhealth treesitter

# Ver filetype
:echo &filetype

# Verificar se treesitter está ativo
:lua print(vim.inspect(vim.treesitter.get_parser()))
```

## Troubleshooting

### Parser não aparece no checkhealth

1. Verifique se o arquivo existe: `ls -la ~/.local/share/nvim/site/parser/`
2. Verifique se o ABI é compatível: `ls -la ~/.local/share/nvim/site/parser/prisma.so`

### Highlight não funciona mesmo com parser instalado

1. Verifique se o filetype está correto: `:echo &filetype` (deve ser `prisma`)
2. Tente forçar o start: `:lua vim.treesitter.start()`
3. Verifique se há erros: `:messages`

### tree-sitter-cli não encontrado

1. Verifique se está instalado: `which tree-sitter`
2. Adicione ao PATH do sistema ou reinicie o Neovim após instalar
