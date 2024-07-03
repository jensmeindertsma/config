{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [alejandra nil ruff];

  home.file.vscode-settings = {
    source = config.lib.file.mkOutOfStoreSymlink "/Users/Jens/Development/config/systems/vanguard/modules/vscode/settings.json";
    target = "${config.home.homeDirectory}/Library/Application Support/Code/User/settings.json";
  };
}
