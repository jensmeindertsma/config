# ANNA (Windows)

```powershell
$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\.ssh\config" -Target "\\wsl`$\Ubuntu\home\jens\dev\config\systems\anna\windows\ssh\config"
```


```powershell
$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\settings.json" -Target "\\wsl`$\Ubuntu\home\jens\dev\config\systems\anna\windows\vscode\settings.json"

$ New-Item -ItemType SymbolicLink -Path "C:\Users\Jens\AppData\Roaming\Code\User\keybindings.json" -Target "\\wsl`$\Ubuntu\home\jens\dev\config\systems\anna\windows\vscode\keybindings.json"
```