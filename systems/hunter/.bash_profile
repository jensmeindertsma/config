eval `keychain --quiet --noask --eval hunter`

. "$HOME/.cargo/env"

eval "$(fnm env --use-on-cd --shell bash)"

eval "$(starship init bash)"
