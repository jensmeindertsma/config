# config

All my configuration for all my systems in one place!

## Stowing symlinks

This project makes heavy use of GNU Stow, a symlink farm manager. The dotfiles are symlink to your local copy of this repository. You can apply them per-machine, as below:

```
$ stow --target ~ wyvern
```

## Systems

### ANNA

`ANNA` is a Windows system with a WSL Ubuntu distribution set up for development. VSCode is installed on Windows and has the necessary extensions installed to be used to develop on the WSL distribution and over SSH on the virtual machines.

The WSL dotfiles can be symlinked with Stow like this:

```
$ stow --target ~ --dir anna wsl
```

#### Windows symbolic links

To set up the symbolic links from the configuration files in WSL to the correct paths in Windows, you can use the following PowerShell commands. Be sure to modify the paths for your own username, directory and WSL installation.

```powershell
$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\.ssh\config" -Target "\\wsl`$\Ubuntu\home\jens\development\config\anna\windows\ssh\config"

$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\settings.json" -Target "\\wsl`$\Ubuntu\home\jens\development\config\anna\windows\vscode\settings.json"

$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\keybindings.json" -Target "\\wsl`$\Ubuntu\home\jens\development\config\anna\windows\vscode\keybindings.json"
```

### Vanguard

Vanguard is my 2020 MacBook Air running macOS Sequoia.

```
$ stow --target ~ vanguard
```
