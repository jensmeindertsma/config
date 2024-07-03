homeModules: {pkgs, ...}: {
  home.stateVersion = "24.05";

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  imports = homeModules ++ [
    ./modules/homebrew.nix
    ./modules/vscode.nix
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      UseKeychain yes
    '';
    matchBlocks = {
      devbox = {
        hostname = "127.0.0.1";
        port = 2001;
        user = "jens";
        forwardAgent = true;
      };
    };
  };
}
