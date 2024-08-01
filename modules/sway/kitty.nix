{ install ? true, }: {pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = if install == true then pkgs.kitty else pkgs.runCommandNoCC "empty" {} "mkdir -p $out";
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
}
