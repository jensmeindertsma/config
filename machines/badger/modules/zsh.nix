{...}: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      mit = "license-generator mit --author 'Jens Meindertsma' --output LICENSE.md";
      switch = "darwin-rebuild switch --flake ~/Development/config";
    };
  };

  programs.starship.enable = true;
}
