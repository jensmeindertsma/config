### HOMEBREW ###
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export HOMEBREW_NO_ENV_HINTS=true

### CARGO ###
. "$HOME/.cargo/env"
