require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.expandtab = true -- Use spaces instead of literal tab characters
vim.opt.tabstop = 2 -- A literal tab character displays as 4 spaces
vim.opt.shiftwidth = 2 -- Indent by 2 spaces with Tab/>>/<<
vim.opt.softtabstop = 4 -- Tab and Backspace use 4 spaces
vim.opt.autoindent = true -- Copy indentation from the previous line
vim.opt.smartindent = true -- Basic automatic indentation for code

vim.opt.showmode = false

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
