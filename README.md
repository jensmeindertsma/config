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

> My ASUS Zenbook dual boot Windows and Arch Linux

#### Linux

```
$ cd systems/wyvern
$ stow --target ~ linux
```

#### WSL

```
$ cd systems/wyvern
$ stow --target ~ wsl
```

#### Windows

```powershell
$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\.ssh\config" -Target "\\wsl`$\Ubuntu\home\jens\development\config\systems\wyvern\windows\ssh\config"

$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\settings.json" -Target "\\wsl`$\Ubuntu\home\jens\development\config\systems\wyvern\windows\vscode\settings.json"

$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\keybindings.json" -Target "\\wsl`$\Ubuntu\home\jens\development\config\systems\wyvern\windows\vscode\keybindings.json"
```

#### WSL setup

1. `sudo apt install starship stow`
2. `cd kestrel`
3. `stow -t ~ wsl`
