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

  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  programs.zsh.enable = true;

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
      ./modules/git.nix
      ./modules/ssh.nix
      (import ./modules/vscode.nix nix-vscode-extensions)
      ./modules/zsh.nix
    ];
  };
}
