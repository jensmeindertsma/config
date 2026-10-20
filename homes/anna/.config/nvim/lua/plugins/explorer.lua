-- lazy.nvim
return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		explorer = {
			replace_netrw = true, -- Replace netrw with the snacks explorer
			trash = true, -- Use the system trash when deleting files
			-- your explorer configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		picker = {
			files = {
				hidden = true,
				ignored = true,
			},
			sources = {
				explorer = {
					-- your explorer picker configuration comes here
					-- or leave it empty to use the default settings
				},
			},
		},
	},
}
