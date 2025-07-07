# ⚙️ config

All my configuration for all my systems in one place!

## Stowing symlinks

This project makes heavy use of GNU Stow, a symlink farm manager. The dotfiles are symlinked from your local copy of this repository to their places in your home directory. You can apply them per-machine by following the instructions below.

## Systems

### ISAC

Arch Linux on my desktop

```
$ stow --target ~ isac
```

### Vanguard

macOS Sequoia on my Apple 2020 MacBook Air M1,

```
$ stow --target ~ vanguard
```

### Wyvern

Arch Linux on my ASUS Zenbook

```
$ stow --target ~ wyvern
```

### Kestrel

Windows 11 on my ASUS Zenbook.

Development is done inside WSL. This repository should be cloned inside its filesystem. A few symlinks are needed from the Windows side to WSL for configuration files I want to manage in this repository but are for Windows programs. This includes VSCode (runs as Windows program) and SSH (can't SSH from inside WSL to VirtualBox machines).

1. Inside WSL, make a `development` directory and clone this repository inside.
2. Install GNU stow with `sudo apt install stow`.
3. Inside the `config` repository, run `stow -t ~ kestrel/wsl`.
4. Inside Windows, install VSCode through the Microsoft Store.
5. Create the `.ssh` directory in your home folder.
6. Run each of these commands below in a PowerShell session (Run as Administrator), substituting my usernames for yours.

```powershell
$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\.ssh\config" -Target "\\wsl`$\Ubuntu\home\jens\development\config\kestrel\wsl\ssh\config"

$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\settings.json" -Target "\\wsl`$\Ubuntu\home\jens\development\config\kestrel\wsl\vscode\settings.json"

$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\keybindings.json" -Target "\\wsl`$\Ubuntu\home\jens\development\config\kestrel\wsl\ vscode\keybindings.json"
```
