{
  source,
  hideDesktopEntry ? true,
}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    gcc
    neovim
    nil
    nixd
    prettierd
    python3
    ruff
    rustup
    stylua
  ];

  home.file.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${source}/modules/neovim";
    target = "${config.home.homeDirectory}/.config/nvim";
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.desktopEntries =
    if hideDesktopEntry == true
    then {
      nvim = {
        name = "Neovim";
        noDisplay = true;
      };
    }
    else {};
}
