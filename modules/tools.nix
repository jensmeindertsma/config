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
}
