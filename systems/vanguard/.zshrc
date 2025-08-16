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

autoload -Uz compinit && compinit

### Fast Node Manager ###
eval "$(fnm env --use-on-cd --corepack-enabled --log-level quiet --shell zsh)"
eval "$(fnm completions --shell zsh)"

alias nvm="fnm"

### Docker ###
fpath=(/Users/Jens/.docker/completions $fpath)

### Homebrew ###
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

### SSH ###
eval $(keychain --eval id_ed25519 --quiet)

### Aliases ###
alias ls="eza"
alias mit="license-generator mit --author 'Jens Meindertsma' --output LICENSE.md"

### Other ###
export DYLD_LIBRARY_PATH=/usr/local/lib:$DYLD_LIBRARY_PATH

bindkey '^[[1;3D' backward-word # Option + Left Arrow
bindkey '^[[1;3C' forward-word  # Option + Right Arrow

# Add a newline between commands
# https://github.com/starship/starship/issues/560
precmd() { 
    precmd() { 
        echo "" 
    } 
}

### Prompt ###
eval "$(starship init zsh)"
