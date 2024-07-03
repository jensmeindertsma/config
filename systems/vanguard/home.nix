homeModules: {pkgs, ...}: {
  home.stateVersion = "24.05";

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  imports = homeModules;

  home.packages = with pkgs; [
    btop
    cowsay
    dive
    doctl
    dua
    fastfetch
    gh
    just
    ripgrep
    tmux
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      UseKeychain yes
    '';
    matchBlocks = {
      ubuntu = {
        hostname = "127.0.0.1";
        port = 2001;
        user = "jens";
        forwardAgent = true;
      };
    };
  };
}
