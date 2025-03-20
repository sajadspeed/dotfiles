return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		triggers = {},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ keys = "<leader>", global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
