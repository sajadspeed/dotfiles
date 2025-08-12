return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = {
				enabled = false,
			},
			char = {
				enabled = false,
			},
		},
	},
	keys = {
		{
			"<leader>ws",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"<leader>wt",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"<leader>wr",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"<leader>wR",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		-- {
		-- 	"<c-b>",
		-- 	mode = { "c" },
		-- 	function()
		-- 		require("flash").toggle()
		-- 	end,
		-- 	desc = "Toggle Flash Search",
		-- },
	},
}
