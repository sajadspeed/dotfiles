return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
				sign = false,
			},
		})
		-- vim.diagnostic.config({
		-- 	severity_sort = true,
		-- })
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
