{
  aliases ? {},
  initExtra ? '''',
}: {
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
    initExtra = lib.strings.concatStrings [(builtins.readFile ./zsh/.zshrc) initExtra];
  };

  programs.starship = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    config = {
      warn_timeout = 0;
    };
  };
}