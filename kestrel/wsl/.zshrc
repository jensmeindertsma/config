ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

autoload -Uz compinit && compinit

zinit light zsh-users/zsh-autosuggestions

FNM_PATH="/home/jens/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/jens/.local/share/fnm:$PATH"
  eval "`fnm env --use-on-cd --corepack-enabled`"
fi

# Map Ctrl+Left to backward-word
bindkey '^[[1;5D' backward-word

# Map Ctrl+Right to forward-word
bindkey '^[[1;5C' forward-word

eval $(keychain id_ed25519 --eval --inherit any --quiet)

eval "$(starship init zsh)"
