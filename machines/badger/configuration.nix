{ pkgs, config, home-manager, ... }: {
  system.stateVersion = 4;

  services.nix-daemon.enable = true;

  nix.settings.experimental-features = "nix-command flakes";
  
  users.users.jens = {
        name = "jens";
        home = "/Users/jens";
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [ git ];

  environment.shells = with pkgs; [ zsh ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.jens = { config, pkgs, ... }: {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.11";

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
      starship
      stow
      tmux
    ];
  };
}
