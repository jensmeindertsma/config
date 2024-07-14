{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.runCommandNoCC "empty" {} "mkdir -p $out";
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
