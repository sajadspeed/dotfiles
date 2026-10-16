return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		-- local configs = require("nvim-surround.config")
		-- configs.keymaps.visual = "s"
		-- configs.keymaps.visual_line = "gs"

		vim.g.nvim_surround_no_mappings = true

		vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)", {
			desc = "Add a surrounding pair around a visual selection",
		})
		vim.keymap.set("x", "gs", "<Plug>(nvim-surround-visual-line)", {
			desc = "Add a surrounding pair around a visual selection, on new lines",
		})
	end,
}
