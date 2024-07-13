{pkgs, ...}: {
  home.packages = with pkgs; [pkg-config openssl rustup];
}
