ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### History & auto-completion ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

zinit light zsh-users/zsh-autosuggestions

### Fast Node Manager ###
FNM_PATH="/home/jens/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/jens/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --corepack-enabled --shell zsh)"
  eval "$(fnm completions --shell zsh)"
fi

alias nvm="fnm"

### SSH ###
eval $(keychain --eval id_ed25519 --quiet)

## Aliases
alias ls="eza"

### Prompt ###
eval "$(starship init zsh)"
