return {
	"https://github.com/neovim/nvim-lspconfig",
	config = function()
		vim.diagnostic.config({
			virtual_text = true, -- Show messages inline
			signs = true, -- Show icons in the gutter
			underline = true, -- Underline problematic code
			severity_sort = true,
			update_in_insert = false,
		})

		vim.lsp.config("lua_ls", {
			cmd = { "lua-language-server" },
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
						},
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		vim.lsp.enable("lua_ls")
	end,
}
