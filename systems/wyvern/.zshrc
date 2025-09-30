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

autoload -Uz compinit && compinit

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/fnm:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

### NODE.JS ###
eval "$(fnm env --use-on-cd --corepack-enabled --shell zsh)"
eval "$(fnm completions --shell zsh)"

### CONTROLS ###
# Map Ctrl+Left to backward-word
bindkey '^[[1;5D' backward-word

# Map Ctrl+Right to forward-word
bindkey '^[[1;5C' forward-word

### BINDS ###
alias cat="bat"
alias ls="eza"
alias nvm="fnm"

alias mit="license-generator mit --author 'Jens Meindertsma' --output LICENSE.md"

### SSH ###
eval $(keychain id_ed25519 --eval --ssh-allow-forwarded --quiet)

### PROMPT ###
# Add a newline between commands
# https://github.com/starship/starship/issues/560
precmd() { precmd() { echo "" } }
alias clear="precmd() { precmd() { echo } } && clear"

eval "$(starship init zsh)"

