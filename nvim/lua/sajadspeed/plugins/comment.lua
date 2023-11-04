return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	-- config = true -- runs require("Comment").setup()
	config = function()
		require("Comment").setup({
			toggler = {
				line = '<leader>/',
				block = '<leader>cb'
			},
			opleader = {
				line = "<leader>/",
				block = "<leader>c"
			}
		})
	end
}
