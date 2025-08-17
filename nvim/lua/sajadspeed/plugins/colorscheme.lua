return {
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedarkpro").setup({
			options = {
				cursorline = true,
				terminal_colors = true,
			},
		})
		-- onedark
		-- onelight
		-- onedark_vivid
		-- onedark_dark
		vim.cmd([[colorscheme onedark]])
	end,
}
