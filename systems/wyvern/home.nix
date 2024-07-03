{...}: {
  home = {
    stateVersion = "24.05";
    username = "jens";
    homeDirectory = "/home/jens";
  };

  nixpkgs.config.allowUnfree = true;

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      devbox = {
        hostname = "192.168.122.66";
        user = "jens";
        forwardAgent = true;
      };

      "iv/ubuntu" = {
        hostname = "192.168.100.211";
        user = "jens";
      };

      "iv/fedora" = {
        hostname = "192.168.100.133";
        user = "jens";
      };

      "l+/ubuntu" = {
        hostname = "192.168.101.167";
        user = "jens";
      };

      "l+/fedora" = {
        hostname = "192.168.101.240";
        user = "jens";
      };

      "l+/suse" = {
        hostname = "192.168.101.152";
        user = "jens";
      };

      "l+/rocky" = {
        hostname = "192.168.101.215";
        user = "jens";
      };
    };
  };
}
