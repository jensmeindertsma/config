# config

All my configuration for all my systems in one place!

## Stowing symlinks

This project makes heavy use of GNU Stow, a symlink farm manager. The dotfiles are symlinked from your local copy of this repository to their places in your home directory. You can apply them per-machine by following the instructions below.

## Systems

### Vanguard

Vanguard is my 2020 MacBook Air running macOS Sequoia.

```
$ stow --target ~ vanguard
```

### Wyvern

My ASUS Zenbook laptop has a dualboot setup with Arch Linux and Windows, where the Linux installation is named Wyvern. All of the systems in here are named after people or names from Tom Clancy's The Division by Ubisoft, one of my favorite game with cool names :D

```
$ stow --target ~ wyvern
```

### Jupiter

The Windows installation on my ASUS Zenbook, still a work in progress.

### ISAC

ISAC is my desktop Arch Linux installation.

```
$ stow --target ~ isac
```

### ANNA

`ANNA` is the Windows 11 Pro installed on the same desktop with a WSL Ubuntu distribution set up for development. VSCode is installed on Windows and has the necessary extensions installed to be used to develop on the WSL distribution and over SSH on the virtual machines.

The WSL dotfiles can be symlinked with GNU Stow like this:

```
$ stow --target ~ --dir anna wsl
```

#### Windows symbolic links

To set up the symbolic links from the configuration files in WSL to the correct paths in Windows, you can use the following PowerShell commands. Be sure to modify the paths for your own username, directory and WSL installation.

```powershell
$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\.ssh\config" -Target "\\wsl`$\Ubuntu\home\jens\development\config\anna\windows\ssh\config"

$ New-Item -ItemType SymbolicLink -Path wyvern

$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\keybindings.json" -Target "\\wsl`$\Ubuntu\home\jens\development\config\anna\windows\vscode\keybindings.json"
```
