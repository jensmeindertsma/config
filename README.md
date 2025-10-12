# ⚙️ config

All my configuration for all my systems in one place!

## Stowing symlinks

This project makes heavy use of GNU Stow, a symlink farm manager. The dotfiles are symlinked from your local copy of this repository to their places in your home directory. You can apply them per-machine.

## Useful commands

To reload waybar and apply the latest configuration you can run:

```
$ kill -USR1 $(pidof waybar)
```
