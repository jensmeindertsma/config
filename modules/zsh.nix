{
  install ? true,
  aliases ? {},
}: {
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [bat eza license-generator];

  programs.zsh = {
    enable = true;
    package =
      if install == true
      then pkgs.zsh
      else pkgs.runCommandNoCC "empty" {} "mkdir -p $out";
    shellAliases =
      {
        cat = "bat";
        el = "eza -l";
        ela = "eza -la";
        mit = "license-generator mit --author 'Jens Meindertsma' --output LICENSE.md";
      }
      // aliases;
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
