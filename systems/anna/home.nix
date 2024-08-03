modules: {pkgs, ...}: {
  home = {
    stateVersion = "24.05";
    username = "jens";
    homeDirectory = "/home/jens";

    packages = with pkgs; [
      burpsuite
      efibootmgr
      firefox
      liquidctl
      networkmanagerapplet
    ];
  };

  nixpkgs.config.allowUnfree = true;

  imports = modules;

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {};
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
