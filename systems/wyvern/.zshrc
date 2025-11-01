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

zinit light zsh-users/zsh-autosuggestions

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

eval "$(fnm env --shell zsh --use-on-cd --log-level quiet)"

alias cdg='cd $(git rev-parse --show-toplevel)'
alias mit="license-generator mit --author 'Jens Meindertsma' --output LICENSE.md"
alias ls="eza"

bindkey '^[[1;5D' backward-word # Option + Left Arrow
bindkey '^[[1;5C' forward-word  # Option + Right Arrow

# Add a newline between commands
# https://github.com/starship/starship/issues/560
precmd() {
    precmd() {
        echo ""
    }
}

eval "$(starship init zsh)"
