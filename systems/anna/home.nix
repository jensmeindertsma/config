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
      athena = {
        hostname = "192.168.103.213";
        user = "jens";
        forwardAgent = true;
      };

      taurus = {
        hostname = "192.168.103.252";
        user = "jens";
        forwardAgent = true;
      };

      "i:ubuntu" = {
        hostname = "192.168.101.240";
        user = "jens";
      };
      "i:fedora" = {
        hostname = "192.168.101.199";
        user = "jens";
      };
      "l:ubuntu" = {
        hostname = "192.168.100.192";
        user = "jens";
      };
      "l:fedora" = {
        hostname = "192.168.100.217";
        user = "jens";
      };
      "l:opensuse" = {
        hostname = "192.168.100.226";
        user = "jens";
      };
      "l:rocky" = {
        hostname = "192.168.100.130";
        user = "jens";
      };
    };
  };
}
