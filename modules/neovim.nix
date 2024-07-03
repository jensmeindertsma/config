{absolute_path_to_project}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    neovim
  ];

  home.file.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${absolute_path_to_project}/modules/neovim";
    target = "${config.home.homeDirectory}/.config/nvim";
    recursive = true;
  };
}
