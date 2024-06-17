{pkgs, ...}: {
  home.packages = with pkgs; [starship license-generator];

  programs.zsh = {
    enable = true;
    shellAliases = {
      mit = "license-generator mit --author 'Jens Meindertsma' --output LICENSE.md";
    };
  };

  programs.starship.enable = true;
}
