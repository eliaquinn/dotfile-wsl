# Neovim via bob (tem prioridade sobre apt/snap)
# export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
# .local/share/bob_bin/bob

# Remove o path do windows
export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v '/mnt/c/' | tr '\n' ':');

# export PATH=$HOME/.local/bin:$PATH
#export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
#export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="jonathan"
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Export nvim default editor 
export EDITOR=nvim

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# carrega o syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# carrega o zsh-autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

##### Alias
alias cls="clear"

# nvim aliases
alias vim=nvim
alias v=vim
alias vi=v
alias code=nvim

alias sb=supabase
alias connect="basti connect $AWS_PROFILE"

# bat settings, lauch from path
alias cat="~/.local/bin/bat"

# bob path
alias bob="~/.local/share/bob_bin/bob"

# History Search
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# VI Mode
autoload edit-command-line && zle -N edit-command-line
bindkey "^v" edit-command-line
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward


# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
# eval "$(zoxide init zsh)"
# alias cd="z"

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --zsh)"
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "batcat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/bin:/usr/local/bin:$PATH"

. "$HOME/.cargo/env"

. "/home/eliaquin-araujo/.deno/env"

# Created by `pipx` on 2026-03-04 16:30:07
export PATH="$PATH:/home/eliaquin-araujo/.local/bin"
export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"
export PATH="/home/linuxbrew/.linuxbrew/opt/php/bin:$PATH"

# opencode
export PATH=/home/eliaquin-araujo/.opencode/bin:$PATH
