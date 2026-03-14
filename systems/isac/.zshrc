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

export PATH="$HOME/.local/share/shd/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

alias cat=bat
alias ls=eza

bindkey -e

# ---- Ctrl + Arrow for word movement ----
# Ctrl + Left Arrow → move backward one word
bindkey '^[[1;5D' backward-word

# Ctrl + Right Arrow → move forward one word
bindkey '^[[1;5C' forward-word

# Add a newline between commands
# https://github.com/starship/starship/issues/560
precmd() { precmd() { echo "" } }
alias clear="precmd() { precmd() { echo } } && clear"

eval "$(fnm env --use-on-cd --log-level quiet --shell zsh)"
eval "$(starship init zsh)"
