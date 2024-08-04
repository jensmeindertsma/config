{hideDesktopEntries ? true}: {pkgs, ...}: {
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

  xdg.desktopEntries =
    if hideDesktopEntries == true
    then {
      btop = {
        name = "btop";
        noDisplay = true;
      };
    }
    else {};
}
