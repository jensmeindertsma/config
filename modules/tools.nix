{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
    dua
    fd
    gh
    just
    vim
  ];
}
