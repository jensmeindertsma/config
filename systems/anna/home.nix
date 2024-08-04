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
      spotify
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

    desktopEntries = {
      nixos-manual = {
        name = "NixOS Manual";
        noDisplay = true;
      };

      nm-connection-editor = {
        name = "Network Configuration";
        exec = "nm-connection-editor %U";
      };
      burpsuite = {
        name = "Burp Suite";
        exec = "burpsuite %U";
      };
      spotify = {
        name = "Spotify";
        exec = "spotify --uri=%U --enable-features=UseOzonePlatform --ozone-platform=wayland";
      };

      virt-manager = {
        name = "Virtual Machines";
        exec = "virt-manager %U";
      };
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
