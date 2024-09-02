homeModules: {
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.05";

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  imports = homeModules;

  programs.zsh.profileExtra = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  # programs.direnv.enable = lib.mkForce false;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      UseKeychain yes
    '';
    matchBlocks = {
      jupiter = {
        hostname = "192.168.64.11";
        user = "jens";
        forwardAgent = true;
      };
    };
  };
}
