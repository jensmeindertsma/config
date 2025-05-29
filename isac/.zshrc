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

export PATH="/home/jens/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd --corepack-enabled --log-level quiet --shell zsh)"
eval "$(fnm completions --shell zsh)"
alias nvm="fnm"

export PATH="$HOME/.local/bin:$PATH"
export ELECTRON_OZONE_PLATFORM_HINT=wayland

# Map Ctrl+Left to backward-word
bindkey '^[[1;5D' backward-word

# Map Ctrl+Right to forward-word
bindkey '^[[1;5C' forward-word

alias ls="eza"
alias cat="bat"

eval $(keychain id_ed25519 --eval --ssh-allow-forwarded --quiet)

eval "$(starship init zsh)"
