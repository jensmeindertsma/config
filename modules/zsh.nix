{
  install ? true,
  aliases ? {},
}: {
  config,
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

    enableCompletion = false;
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    shellAliases =
      {
        cat = "bat";
        el = "eza -l";
        ela = "eza -la";
        mit = "license-generator mit --author 'Jens Meindertsma' --output LICENSE.md";
      }
      // aliases;
    initExtra = ''
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
      [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      source "''${ZINIT_HOME}/zinit.zsh"

      zinit load "zsh-users/zsh-autosuggestions"

      # Filter history search to what has already been typed at the prompt.
      bindkey '^[[A' history-beginning-search-backward
      bindkey '^[[B' history-beginning-search-forward
      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N history-beginning-search-backward up-line-or-beginning-search
      zle -N history-beginning-search-forward down-line-or-beginning-search
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 50000;
    };
  };

  programs.direnv = {
    enable = true;
    config = {
      warn_timeout = 0;
      hide_env_diff = true;
    };
  };
}
