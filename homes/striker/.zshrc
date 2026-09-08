ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light-mode for \
	zdharma-continuum/zinit-annex-as-monitor \
	zdharma-continuum/zinit-annex-bin-gem-node \
	zdharma-continuum/zinit-annex-patch-dl \
	zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-autosuggestions

HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
unsetopt share_history
unsetopt inc_append_history_time
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_ignore_space

# Alt + Left/Right
bindkey '^[[1;3D' beginning-of-line
bindkey '^[[1;3C' end-of-line

# Ctrl + Left/Right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

export PATH=$HOME/.cargo/bin:$PATH

export PATH=$HOME/.local/bin:$PATH

alias vim="nvim"

precmd() { precmd() { echo ""; }; }

eval "$(starship init zsh)"
