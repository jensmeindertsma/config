{ ... }: {
  home.stateVersion = "24.05";
  home.username = "jens";
  home.homeDirectory = "/home/jens";
  home.packages = with pkgs; [git neovim];

  programs.bash.enable = true;
  programs.zsh.enable = true;

  programs.direnv.enable = true;
  programs.starship.enable = true;
}
