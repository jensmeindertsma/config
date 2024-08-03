{pkgs, ...}: {
  programs.kitty = {
    enable = true;
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
