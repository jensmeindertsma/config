{nix-vscode-extensions, ...}: {
  config,
  pkgs,
  ...
}: {
  system.stateVersion = 4;
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
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];
  };

  programs.zsh.enable = true;

  imports = [
    ./system/apps.nix
  ];

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

    imports = [
      ./home/git.nix
      ./home/shell.nix
      ./home/ssh.nix
      (import ./home/vscode.nix nix-vscode-extensions)
    ];
  };
}
