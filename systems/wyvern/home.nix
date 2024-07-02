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
      
 services.ssh-agent.enable; 

      programs.firefox.enable = true;
    })
  ];
}
