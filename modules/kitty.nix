{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      size = 14;
      name = "monospace";
    };
    settings = {
      enable_audio_bell = "no";
      background_opacity = "0.7";
    };
    extraConfig = ''
      include theme.conf
    '';
  };

  xdg.desktopEntries = {
    kitty = {
      name = "Kitty";
      exec = "kitty %U";
    };
  };
}
