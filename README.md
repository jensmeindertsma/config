# ⚙️ config

All my configuration for all my systems in one place!

## Stowing symlinks

This project makes heavy use of GNU Stow, a symlink farm manager. The dotfiles are symlinked from your local copy of this repository to their places in your home directory. You can apply them per-machine by following the instructions below.

## Systems

### ISAC

> Arch Linux on my desktop

```
$ cd systems
$ stow --target ~ isac
```

### Vanguard

> macOS Sequoia on my Apple 2020 MacBook Air M1

```
$ cd systems
$ stow --target ~ vanguard
```

### Wyvern

> My ASUS Zenbook booting Arch Linux

```
$ cd systems
$ stow --target ~ wyvern
```

## Useful commands

To reload waybar and apply the latest configuration you can run:

```
$ kill -USR1 $(pidof waybar)
```
