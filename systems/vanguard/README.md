# Vanguard

My 2020 M1 MacBook Air

## Installation Steps

1. Clone this repository:

   ```bash
   git clone https://github.com/jensmeindertsma/config.git
   ```

2. Install Nix:

   ```bash
   $ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

3. Activate the Nix configuration defined in this repository:

   ```
   $ nix run nix-darwin -- switch --flake .#vanguard
   ```

4. Install Homebrew:

   ```bash
   $ /bin/bash -c$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

5. Install desired applications as Homebrew Casks:

   ```bash
   $ brew install \
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
