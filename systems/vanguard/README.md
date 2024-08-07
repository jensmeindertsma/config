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

   You can from now on just run `just switch-vanguard` from anywhere within the repository to rebuild and apply the configuration.

   You can also change your login shell to the Nix-installed copy of Zsh:

   ```bash
   $ chsh -s /run/current-system/sw/bin/zsh
   ```

5. Install the required tools for Neovim to work:

   ```bash
   $ nvm install node
   $ rustup default stable
   ```
