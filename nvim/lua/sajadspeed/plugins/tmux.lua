return {
	"aserowy/tmux.nvim",
	config = function()
		return require("tmux").setup({
			copy_sync = {
				enable = false,
			},
			navigation = {
				enable_default_keybindings = false,
				cycle_navigation = false,
			},
			resize = {
				enable_default_keybindings = false,
			},
			swap = {
				enable_default_keybindings = false,
			},
		})
	end,
}
