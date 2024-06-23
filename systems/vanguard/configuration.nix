{
  config,
  pkgs,
  ...
}: {
  
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  security.pam.enableSudoTouchIdAuth = true;

  users.users.jens = {
    home = "/Users/Jens";
  };

  environment.systemPackages = with pkgs; [
    git
  ];

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

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.jens = {pkgs, ...}: {
    home.stateVersion = "24.05";

    # Let `home-manager` install and manage itself.
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      bat
      btop
      cowsay
      dive
      doctl
      dua
      eza
      gh
      just
      neofetch
      neovim
      tmux
    ];

    programs.vscode.enable = true;

    imports = [
      ./home/git.nix
      ./home/shell.nix
      ./home/ssh.nix
      ./home/vscode.nix
    ];
  };
}
