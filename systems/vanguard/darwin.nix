{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings.experimental-features = "nix-command flakes";

  services.nix-daemon.enable = true;

  environment.shells = with pkgs; [zsh];

  users.users.jens = {
    home = "/Users/Jens";
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    brews = ["nvm"];
    casks = [
      "aldente"
      "iterm2"
      "protonvpn"
      "bitwarden"
      "microsoft-auto-update"
      "signal"
      "discord"
      "microsoft-teams"
      "spotify"
      "docker"
      "monitorcontrol"
      "utm"
      "firefox"
      "notion"
      "visual-studio-code"
      "google-chrome"
      "proton-drive"
      "whatsapp"
      "hot"
      "protonmail-bridge"
    ];
  };
}
