{
  lib,
  pkgs,
  ...
}: let
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
        wrapped_bin=$out/bin/$(basename $bin)
        echo "exec ${lib.getExe pkgs.nixgl.nixGLMesa} $bin \$@" > $wrapped_bin
        chmod +x $wrapped_bin
      done
    '';
in {
  programs.kitty = {
    enable = true;
    package = nixGLWrap pkgs.kitty;
    font = {
      size = 14;
      name = "monospace";
    };
    settings = {
      enable_audio_bell = "no";
    };
    extraConfig = ''
      include theme.conf
    '';
  };

  programs.zsh.shellAliases = {
    s = "kitten ssh";
    ssh = "kitten ssh";
  };
}
