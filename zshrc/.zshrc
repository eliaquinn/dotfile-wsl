# Neovim via bob (tem prioridade sobre apt/snap)
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

#remove o path do windows
export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v '/mnt/c/' | tr '\n' ':')

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="jonathan"

plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim

# Set up alias here
alias cls="clear"
alias vim=nvim
alias v=vim
alias vi=v

alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias tree="eza --tree --icons"

# basti connection to aws sasi
alias connect="basti connect $AWS_PROFILE"

HISTFILE=$HOME/.zshistory
SAVEHIST=1000
HISTSIZE=999

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.cargo/bin:$PATH"

# Created by `pipx` on 2025-12-31 16:29:43
# export PATH="$PATH:/home/eliaquinn/.local/bin"
export PATH="/usr/bin:/usr/local/bin:$PATH"
