{
  source,
  destination,
}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [alejandra nixd];

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
      rust-lang.rust-analyzer
    ];
    userSettings = {
      nix.serverSettings = {
        nixd = {
          formatting = {
            command = ["alejandra"];
          };
        };
      };
    };
  };

  # home.file.vscode-settings = {
  #   source = config.lib.file.mkOutOfStoreSymlink "${source}/modules/vscode/settings.json";
  #   target = "${destination}/settings.json";
  # };

  xdg.desktopEntries = {
    code = {
      name = "Visual Studio Code";
      exec = "env ELECTRON_OZONE_PLATFORM_HINT=wayland code %F";
    };
  };
}
