homeModules: {pkgs, ...}: {
  home.stateVersion = "24.05";

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  imports = homeModules;

  programs.zsh.profileExtra = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      UseKeychain yes
    '';
    matchBlocks = {
      cruiser = {
        hostname = "192.168.64.8";
        user = "jens";
        forwardAgent = true;
      };

      athena = {
        hostname = "192.168.64.10";
        user = "jens";
        forwardAgent = true;
      };
    };
  };
}
