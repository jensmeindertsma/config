default:
  just --list

stow system:
  stow {{system}} --target ~
