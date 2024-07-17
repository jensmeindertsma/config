{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
    dua
    fastfetch
    fd
    gh
    just
    vim
    wget
  ];
}
