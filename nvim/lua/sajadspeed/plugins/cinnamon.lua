return {
	"declancm/cinnamon.nvim",
	config = function()
		require("cinnamon").setup({
			default_delay = 7,
		})
	end,
}
