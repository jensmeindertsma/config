{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
    };
  };

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
}
