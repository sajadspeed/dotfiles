return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			start_in_insert = true,
			mappings = {
				n = {
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
					["q"] = "Close", -- Added by me
				},
				i = {
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
					["<Up>"] = "HistoryPrev",
					["<Down>"] = "HistoryNext",
				},
			},
		},
	},
}
