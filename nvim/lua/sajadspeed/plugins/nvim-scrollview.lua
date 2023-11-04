return {
	"dstein64/nvim-scrollview",
	config = function()
		require("scrollview").setup({
			excluded_filetypes = { "NvimTree" },
			signs_on_startup = { "diagnostics", "marks", "spell" },
		})
	end,
}
