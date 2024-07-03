{
  absolute_path_to_project,
  target_directory,
}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [alejandra nil ruff];

  home.file.vscode-settings = {
    source = config.lib.file.mkOutOfStoreSymlink "${absolute_path_to_project}/modules/vscode/settings.json";
    target = "${config.home.homeDirectory}/${target_directory}/settings.json";
  };
}
