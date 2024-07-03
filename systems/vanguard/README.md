# Vanguard

My 2020 M1 MacBook Air running macOS Sonoma, managed by nix-darwin and home-manager.

## Installation Steps

1. Clone this repository:

   ```bash
   git clone https://github.com/jensmeindertsma/config.git
   ```

2. Install Nix:

   ```bash
   $ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

3. Install Homebrew:

   ```bash
   $ /bin/bash -c $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. Activate the Nix configuration defined in this repository:

   ```
   $ nix run nix-darwin -- switch --flake .#vanguard
   ```

5. Install the `just` command runner and other required tools:

   ```bash
   $ brew install just
   $ nvm install node
   $ rustup default stable
   ```

   You can from now on just run `just switch-vanguard` from anywhere within the repository to rebuild and apply the configuration.

6. Install desired applications as Homebrew Casks:

   ```bash
   $ brew install --cask \
       aldente \
       bitwarden \
       discord \
       docker \
       firefox \
       google-chrome \
       hot \
       iterm2 \
       notion \
       microsoft-teams \
       monitorcontrol \
       protonvpn \
       proton-drive \
       protonmail-bridge \
       signal \
       spotify \
       utm \
       whatsapp
   ```

## Setting up Visual Studio Code

Currently, automatically installing extensions for Visual Studio Code does not work reliably with `home-manager`. Thus I do it manually, for now. Here is a list of the extensions that I use:

- `charliermarsh.ruff`
- `dbaeumer.vscode-eslint`
- `esbenp.prettier-vscode`
- `github.github-vscode-theme`
- `jnoortheen.nix-ide`
- `ms-azuretools.vscode-docker`
- `ms-python.python`
- `ms-vscode-remote.vscode-remote-extensionpack`
- `ms-vscode.remote-explorer`
- `rust-lang.rust-analyzer`
- `tamasfe.even-better-toml`
