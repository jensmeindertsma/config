{source}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    neovim
  ];

  home.file.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${source}/modules/neovim";
    target = "${config.home.homeDirectory}/.config/nvim";
    recursive = true;
  };
}
