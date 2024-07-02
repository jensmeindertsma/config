{
  username = "jens";
  homeDirectory = "/home/jens";
  modules = [
    ({pkgs, ...}: {
      home.packages = with pkgs; [
        bluetuith
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

      programs.firefox.enable = true;
    })
  ];
}
