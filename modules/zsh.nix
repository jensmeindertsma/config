{aliases ? {}}: {
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [bat eza license-generator];

  programs.zsh = {
    enable = true;
    shellAliases =
      {
        cat = "bat";
        el = "eza -l";
        ela = "eza -la";
        mit = "license-generator mit --author 'Jens Meindertsma' --output LICENSE.md";
      }
      // aliases;
    initExtra = builtins.readFile ./zsh/.zshrc;
  };

  programs.starship = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    config = {
      warn_timeout = 0;
      hide_env_diff = true;
    };
  };
}
