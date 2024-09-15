# config

All my configuration for all my systems in one place!

# Setting up

Simply run `just link {system}` to set up all the necessary symlinks.
Supported systems:

- `vanguard` (macOS)
- `wyvern-wsl` (Windows Subsystem for Linux)
- `wyvern-linux` (Arch Linux) **(TODO!)**

When I set up a NixOS virtual machine I would also like to add its configuration here.

## VSCode

To set up shared VSCode configuration, please run one of the following commands based on your platform. **NOTE: replace adjust file paths for your system!**

- Windows (run in Command Prompt with administrator privileges): `mklink "C:\Users\Jens\AppData\Roaming\Code\User\settings.json" "C:\Users\Jens\Projects\jensmeindertsma\config\tools\vscode\settings.json"`

- Windows with Subsystem for Linux (run in Command Prompt with administrator privileges): `mklink "C:\Users\Jens\AppData\Roaming\Code\User\settings.json" "\\wsl$\Ubuntu\home\jens\dev\jensmeindertsma\config\tools\vscode\settings.json"`

- macOS: `ln -sf ~/Projects/jensmeindertsma/config/tools/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json`

- Linux: `ln -sf ~/Projects/jensmeindertsma/config/tools/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json`
