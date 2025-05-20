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

export PATH="$HOME/.local/bin:$PATH"
export ELECTRON_OZONE_PLATFORM_HINT=wayland

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# I don't know how to make `keychain` add the
# key to the static SSH_AUTH_SOCK instead of
# prompting for the password even though the
# key has already been added only to spawn
# its own SSH agent.
#
eval $(keychain --eval id_ed25519 --quiet --ssh-agent-socket "$SSH_AUTH_SOCK" )

eval "$(starship init zsh)"
