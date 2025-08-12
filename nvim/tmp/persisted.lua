return {
	"olimorris/persisted.nvim",
	-- event = "VimEnter", -- Ensure the plugin loads only when a buffer has been loaded
	opts = {
		autoload = true,
		-- Your config goes here ...
	},
	config = function()
		require("telescope").load_extension("persisted")
	end,
}
