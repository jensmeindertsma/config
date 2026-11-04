return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.diagnostic.config({
				virtual_text = true, -- Show messages inline
				severity_sort = true,
				update_in_insert = true,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			vim.lsp.enable("lua_ls")
		end,
	},
}
