ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice wait "2"
zinit load "lukechilds/zsh-nvm"
zinit load "zsh-users/zsh-autosuggestions"

# Filter history search to what has already been typed at the prompt.
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N history-beginning-search-backward up-line-or-beginning-search
zle -N history-beginning-search-forward down-line-or-beginning-search
