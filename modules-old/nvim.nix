{config, ...}: {
  home.file.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink /home/jens/dev/config/modules/nvim;
    target = "/home/jens/.config/nvim";
    recursive = true;
  };
}
