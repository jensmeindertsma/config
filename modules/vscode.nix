{
  source,
  destination,
}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [alejandra nil ruff];

  home.file.vscode-settings = {
    source = config.lib.file.mkOutOfStoreSymlink "${source}/modules/vscode/settings.json";
    target = "${destination}/settings.json";
  };
}
