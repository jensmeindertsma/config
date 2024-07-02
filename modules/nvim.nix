{config, ...}: {
  home.file.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink ./nvim;
    target = ".config/nvim";
    recursive = true;
  };
}
