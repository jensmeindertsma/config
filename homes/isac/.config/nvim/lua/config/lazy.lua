-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Configure vim.opt settings
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true -- Use spaces instead of literal tab characters
vim.opt.tabstop = 2 -- A literal tab character displays as 4 spaces
vim.opt.shiftwidth = 2 -- Indent by 4 spaces with Tab/>>/<<
vim.opt.softtabstop = 4 -- Tab and Backspace use 4 spaces
vim.opt.autoindent = true -- Copy indentation from the previous line
vim.opt.smartindent = true -- Basic automatic indentation for code

-- Load plugin manager
require("lazy").setup({
	spec = {
		-- Load every file in the plugins directory
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "gruvbox" } },
	checker = { enabled = true },
})
