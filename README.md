# config

All my configuration for all my systems in one place!

# Setting up

Simply run `just link {system}` to set up all the necessary symlinks.
Supported systems:

- `vanguard` (macOS)
- `wyvern-wsl` (Windows Subsystem for Linux)
- `wyvern-linux` (Arch Linux) **\*TODO!\***

For setting up Git on Wyvern (Windows), once you have your SSH keys in place, run the following command to set up the link:

```sh
$ mklink "C:\Users\Jens\.gitconfig" "C:\Users\Jens\Projects\jensmeindertsma\config\systems\wyvern-windows\.gitconfig"
```

When I set up a NixOS virtual machine I would also like to add its configuration here.

## VSCode

To set up shared VSCode configuration, please run one of the following commands based on your platform.

**NOTE: replace adjust file paths for your system!**

#### Windows

Run the following command in Command Prompt with administrator privileges:

```sh
$ mklink "C:\Users\Jens\AppData\Roaming\Code\User\settings.json" "C:\Users\Jens\Projects\jensmeindertsma\config\tools\vscode\settings.json"
```

#### Windows Subsystem for Linux

Run the following command in Command Prompt with administrator privileges:

```sh
$ mklink "C:\Users\Jens\AppData\Roaming\Code\User\settings.json" "\\wsl$\Ubuntu\home\jens\dev\jensmeindertsma\config\tools\vscode\settings.json"
```

#### macOS

```sh
$ ln -sf ~/Projects/jensmeindertsma/config/tools/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

#### Linux

```sh
ln -sf ~/Projects/jensmeindertsma/config/tools/vscode/settings.json ~/.config/Code/User/settings.json
```
