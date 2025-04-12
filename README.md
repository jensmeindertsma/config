# config

All my configuration for all my systems in one place!

## Stowing symlinks

This project makes heavy use of GNU Stow, a symlink farm manager. The dotfiles are symlink to your local copy of this repository. You can apply them per-machine, as below:

```
$ stow --target ~ wyvern
```
