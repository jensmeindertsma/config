{pkgs, ...}: {
  home.packages = with pkgs; [license-generator starship];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      mit = "license-generator mit --author 'Jens Meindertsma' --output LICENSE.md";
    };
  };

  programs.direnv.enable = true;

  programs.starship.enable = true;
}
