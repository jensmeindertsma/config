default:
  just --list

sync system:
  stow {{system}} --dir systems --target ~
