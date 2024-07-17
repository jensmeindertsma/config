{source}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    neovim
    nil
    python3
    pkgs
    ["python3.12-pip"]
    ruff
  ];

  home.file.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${source}/modules/neovim";
    target = "${config.home.homeDirectory}/.config/nvim";
    recursive = true;
  };
}
