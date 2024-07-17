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
      magnus = {
        hostname = "192.168.103.150";
        user = "jens";
        forwardAgent = true;
      };

      robin = {
        hostname = "192.168.103.223";
        user = "jens";
        forwardAgent = true;
      };
    };
  };
}
