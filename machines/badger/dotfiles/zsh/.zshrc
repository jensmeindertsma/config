alias mit="license-generator mit --author 'Jens Meindertsma' --output LICENSE.md"


# pnpm
export PNPM_HOME="/Users/jens/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(starship init zsh)"

