{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
    dua
    gh
    just
  ];
}
