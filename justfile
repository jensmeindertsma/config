default:
  just --list

link system:
  stow {{system}} --dir systems --target ~
