{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
    dua
    fastfetch
    fd
    gh
    just
    unzip
    vim
    wget
  ];

  xdg.desktopEntries = {
    btop = {
      name = "btop";
      noDisplay = true;
    };
  };
}
