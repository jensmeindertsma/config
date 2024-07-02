({pkgs, ...}: {
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  security.pam.enableSudoTouchIdAuth = true;

  users.users.jens = {
    home = "/Users/Jens";
  };

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
    ];
  };

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    casks = [
      "aldente"
      "bitwarden"
      "discord"
      "docker"
      "firefox"
      "google-chrome"
      "hot"
      "iterm2"
      "notion"
      "microsoft-teams"
      "monitorcontrol"
      "protonvpn"
      "proton-drive"
      "protonmail-bridge"
      "signal"
      "spotify"
      "utm"
      "whatsapp"
    ];

    masApps = {
      "QuickShade" = 931571202;
    };
  };
})
