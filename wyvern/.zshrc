### ZINIT ###
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

autoload -Uz compinit && compinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### ZINIT END ###

### NVM ###
export NVM_COMPLETION=true

zinit wait lucid light-mode for lukechilds/zsh-nvm
### NVM END ###

### SSH ###
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

eval $(keychain --eval id_ed25519 -q --inherit any)
### SSH END ###

bindkey '^[[1;3D' backward-word  # Alt + Left Arrow
bindkey '^[[1;3C' forward-word   # Alt + Right Arrow

alias mit="license-generator --author 'Jens Meindertsma' mit --output LICENSE.md"
alias ssh="kitten ssh"

# For the `toggle_theme` script
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"