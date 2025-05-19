HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

export PATH="$HOME/.local/bin:$PATH"

eval $(keychain --eval id_ed25519 --quiet)

eval "$(starship init zsh)"
