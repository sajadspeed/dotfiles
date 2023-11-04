return {
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedarkpro").setup({
			options = {
				cursorline = true,
				terminal_colors = true,
			},
		})
		-- onedark
		-- onelight
		-- onedark_vivid
		-- onedark_dark
		vim.cmd([[colorscheme onedark]])
	end,
}
-- return {
-- 	"marko-cerovac/material.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.material_style = "darker"
-- 		vim.cmd("colorscheme material")
-- 	end,
-- }
-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }
-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		vim.cmd("colorscheme tokyonight-night")
-- 	end,
-- }
-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		vim.cmd("colorscheme kanagawa-wave")
-- 	end,
-- }
-- return {
-- 	"stevedylandev/flexoki-nvim",
-- 	name = "flexoki",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		vim.cmd("colorscheme flexoki")
-- 	end,
-- }
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		vim.o.background = "dark" -- or "light" for light mode
-- 		vim.cmd([[colorscheme gruvbox]])
-- 	end,
-- }
-- return { -- good
-- 	"navarasu/onedark.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("onedark").setup({
-- 			style = "darker",
-- 		})
-- 		require("onedark").load()
-- 	end,
-- }
-- return { -- good
-- 	"Everblush/nvim",
-- 	name = "everblush",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd("colorscheme everblush")
-- 	end,
-- }
