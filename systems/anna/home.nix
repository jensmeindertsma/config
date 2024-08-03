modules: {pkgs, ...}: {
  home = {
    stateVersion = "24.05";
    username = "jens";
    homeDirectory = "/home/jens";

    packages = with pkgs; [
      burpsuite
      efibootmgr
      firefox
      liquidctl
    ];
  };

  nixpkgs.config.allowUnfree = true;

  imports = modules;

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {};
  };

  programs.kitty.enable = true;

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=13";
        icons-enabled = "no";
        inner-pad = 8;
        lines = 10;
        vertical-pad = 16;
        width = 40;
      };
      colors = {
        background = "333333cc";
        match = "ff0000ff";
        selection = "ff0000cc";
        selection-match = "000000ff";
        selection-text = "ffffffff";
        text = "ffffffff";
      };
      border.width = 0;
    };
  };
}
