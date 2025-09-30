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
export PATH="$HOME/.cargo/bin:$PATH"

. "$HOME/.cargo/env"

export EDITOR=vim

# Map Ctrl+Left to backward-word
bindkey '^[[1;5D' backward-word

# Map Ctrl+Right to forward-word
bindkey '^[[1;5C' forward-word

precmd() { 
    # Split PWD by /, ignoring the first empty element
    dir_parts=("${(@s:/:)PWD}") 
    # Remove empty elements
    dir_parts=(${dir_parts:#""})
    len=${#dir_parts[@]}

    if (( len <= 2 )); then
        title="$PWD"
    else
        title="../${dir_parts[len-1]}/${dir_parts[len]}"
    fi

    # Set Kitty window title: shell name + path
    kitty @ set-window-title "${SHELL##*/} - $title"
}

eval $(keychain id_ed25519 --eval --ssh-allow-forwarded --quiet)

eval "$(starship init zsh)"
