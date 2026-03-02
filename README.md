---

# 🛠️ Ambiente de Desenvolvimento

## Zsh · Neovim · Tmux (Linux / Ubuntu)

Este documento descreve o processo de **instalação e configuração** do ambiente de desenvolvimento utilizando **Zsh**, **Neovim** e **Tmux**, além de ferramentas auxiliares como `fzf`, `eza`, `bat`, LSPs e linters.

---

## 📦 Pré-requisitos

- Sistema Linux baseado em Debian/Ubuntu
- Acesso `sudo`
- `curl`, `git` instalados

```bash
sudo apt update
sudo apt install -y curl git
```

---

## 🐚 Configuração do Zsh

### Instalar Zsh

```bash
sudo apt install -y zsh
```

### Instalar Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

> Durante a instalação, aceite definir o **Zsh como shell padrão**.

---

### Instalar Stow (gerenciamento de dotfiles)

```bash
sudo apt install -y stow
```

---

### Instalar Homebrew (Linux)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Após a instalação, siga as instruções exibidas no terminal para adicionar o `brew` ao `PATH`.

---

### Plugins do Zsh

#### zsh-autosuggestions

```bash
brew install zsh-autosuggestions
```

Caso o plugin **não carregue automaticamente**:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
$ZSH_CUSTOM/plugins/zsh-autosuggestions
```

#### zsh-syntax-highlighting

```bash
brew install zsh-syntax-highlighting
```

Caso o plugin **não carregue automaticamente**:

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
$ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

👉 Lembre-se de adicionar os plugins no `.zshrc`:

```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

---

## 📁 Instalar Eza (substituto moderno do `ls`)

```bash
sudo mkdir -p /etc/apt/keyrings

wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
| sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg

echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
| sudo tee /etc/apt/sources.list.d/gierens.list

sudo chmod 644 /etc/apt/keyrings/gierens.gpg \
/etc/apt/sources.list.d/gierens.list

sudo apt update
sudo apt install -y eza
```

---

## 🔍 Instalar FZF (fuzzy finder)

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

---

## 🦀 Instalar Rust (necessário para alguns linters)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

---

## 📝 Neovim

### Instalar Bob (gerenciador de versões do Neovim)

```bash
sudo apt install -y unzip
curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash
```

### Instalar versão do Neovim

```bash
bob install v0.11.6
```

---

### Dependências de build

```bash
sudo apt install -y make build-essential
```

---

### Bat (substituto do `cat`)

```bash
sudo apt install -y bat
```

---

### Observação sobre plugins do Neovim

Caso algum plugin **não seja instalado corretamente**:

```bash
rm -rf ~/.local/share/nvim/lazy
```

Depois, reabra o Neovim e aguarde a reinstalação dos plugins.
⚠️ Certifique-se de que **todas as dependências do projeto** estejam instaladas.

---

## 🧩 LSPs e Formatters

> É necessário instalar as linguagens que serão utilizadas.

### Python

```bash
sudo apt install -y python3 python3-pip python3-venv
```

> Para Node.js, recomenda-se o uso do **nvm**.

---

## 🧪 Linters

### Selene (Lua)

```bash
cargo install selene
```

### ESLint (JavaScript / TypeScript)

```bash
npm install -g eslint_d
```

⚠️ **Aviso**
Linters são rigorosos e exibem _warnings_ sobre boas práticas.
Recomenda-se utilizá-los apenas se você já tiver **bom domínio da linguagem**.

---

## 🧱 Tmux

### Instalar TPM (Tmux Plugin Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Recarregar configuração

```bash
tmux source ~/.tmux.conf
```

Dentro do tmux, instale os plugins com:

```
Prefix + I
```

---

## ✅ Finalização

Após concluir todos os passos:

- Reinicie o terminal
- Verifique:
  - `zsh` como shell padrão
  - Plugins do Zsh funcionando
  - Neovim abrindo sem erros
  - Tmux com plugins ativos

---
