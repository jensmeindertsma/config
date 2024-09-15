# This script needs to be run in a PowerShell session with administrator rights!

$source = "C:\Users\Jens\AppData\Roaming\Code\User\settings.json"
$target = "\\wsl$\Ubuntu\home\jens\dev\jensmeindertsma\config\tools\vscode\settings.json"

New-Item -ItemType SymbolicLink -Path $source -Target $target

Write-Host "Symbolic link created from $source to $target"
