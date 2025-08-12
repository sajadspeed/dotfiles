return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		{
			"tiagovla/scope.nvim",
			lazy = false,
			config = true,
		},
	},

	config = function()
		require("auto-session").setup({
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			auto_create = false,

			pre_save_cmds = {
				"ScopeSaveState",
			},
			post_restore_cmds = {
				"ScopeLoadState",
			},
		})
	end,
}
