return {
	{
		"luukvbaal/statuscol.nvim",
		branch = "0.10",
		-- enabled = false,
		config = function()
			require("statuscol").setup({
				-- setopt = true,
				relculright = true,
			})
		end,
	},
}
