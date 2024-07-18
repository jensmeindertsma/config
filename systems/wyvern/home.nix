{...}: {
  home = {
    stateVersion = "24.05";
    username = "jens";
    homeDirectory = "/home/jens";
  };

  nixpkgs.config.allowUnfree = true;

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "i/fedora" = {
        hostname = "192.168.101.149";
        user = "jens";
      };
      "i/ubuntu" = {
        hostname = "192.168.101.154";
        user = "jens";
      };
      "l/fedora" = {
        hostname = "192.168.102.200";
        user = "jens";
      };
      "l/opensuse" = {
        hostname = "192.168.102.142";
        user = "jens";
      };
      "l/rocky" = {
        hostname = "192.168.102.181";
        user = "jens";
      };
      "l/ubuntu" = {
        hostname = "192.168.102.228";
        user = "jens";
      };
    };
  };
}
