ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

zinit light zsh-users/zsh-autosuggestions

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export EDITOR=vim

alias ls="eza"
alias mit="license-generator mit --author 'Jens Meindertsma' --output LICENSE.md"

# Map Ctrl+Left to backward-word
bindkey '^[[1;5D' backward-word

# Map Ctrl+Right to forward-word
bindkey '^[[1;5C' forward-word

eval "$(starship init zsh)"
