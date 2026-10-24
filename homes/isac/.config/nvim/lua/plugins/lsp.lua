return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.diagnostic.config({
				virtual_text = true, -- Show messages inline
				signs = true, -- Show icons in the gutter
				underline = false,
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

			-- JSON and JSONC language server
			vim.lsp.config("jsonls", {
				settings = {
					json = {
						validate = { enable = true },
						format = { enable = true },
					},
				},
			})

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("rust_analyzer")
		end,
	},
}
