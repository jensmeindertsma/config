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

. "$HOME/.cargo/env"

eval "$(fnm env --shell zsh --use-on-cd --log-level quiet)"

alias ls="eza"
alias mit="license-generator mit --author 'Jens Meindertsma' --output LICENSE.md"

bindkey '^[[1;3D' backward-word # Option + Left Arrow
bindkey '^[[1;3C' forward-word  # Option + Right Arrow

# Add a newline between commands
# https://github.com/starship/starship/issues/560
precmd() { 
    precmd() { 
        echo "" 
    } 
}

eval "$(starship init zsh)"
