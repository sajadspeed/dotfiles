return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		-- local configs = require("nvim-surround.config")
		-- configs.keymaps.visual = "s"
		-- configs.keymaps.visual_line = "gs"
		require("nvim-surround").setup({
			keymaps = {
				visual = "s",
				visual_line = "gs",
			},
		})
	end,
}
