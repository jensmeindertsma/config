import ../../modules/home.nix {
  imports = [
    ../../modules/sway.nix
    ../../modules/fontconfig.nix
    ({pkgs, ...}: {
      home.packages = with pkgs; [
        bluetuith
        bluez
        bluez-tools
        dmidecode
        htop
        networkmanagerapplet
        pavucontrol
        roboto
        spotify
        unzip
        virt-manager
        wev
        wget
        wl-clipboard
      ];

      xdg = {
        enable = true;
        # TODO: move .desktop files here.
        desktopEntries = {};
      };

      programs.firefox.enable = true;
    })
  ];
  username = "jens";
  homeDirectory = "/home/jens";
  aliases = {
    reflect = "sudo systemctl start reflector";
  };
  ssh = {
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhI5sNxApLWYWOKljGuaVzt/6rsAVlAlb2lKv0nPHyD jens@wyvern";
    hosts = {
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
