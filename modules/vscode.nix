{
  source,
  destination,
  install ? false,
}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [alejandra nil]
    ++ (
      if install == true
      then [pkgs.vscode]
      else []
    );

  home.file.vscode-settings = {
    source = config.lib.file.mkOutOfStoreSymlink "${source}/modules/vscode/settings.json";
    target = "${destination}/settings.json";
  };

  xdg.desktopEntries = {
    code = {
      name = "Visual Studio Code";
      exec = "env ELECTRON_OZONE_PLATFORM_HINT=wayland code %F";
    };
  };
}
