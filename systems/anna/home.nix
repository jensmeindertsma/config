{...}: {
  home = {
    stateVersion = "24.05";
    username = "keener";
    homeDirectory = "/home/keener";
  };

  nixpkgs.config.allowUnfree = true;

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      cabin = {
        hostname = "161.35.89.119";
        user = "jens";
      };

      devbox = {
        hostname = "192.168.122.8";
        user = "jens";
        forwardAgent = true;
      };
    };
  };
}
