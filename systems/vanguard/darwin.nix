{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings.experimental-features = "nix-command flakes";

  security.pam.enableSudoTouchIdAuth = true;
  services.nix-daemon.enable = true;

  environment.shells = with pkgs; [zsh];

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;
}
