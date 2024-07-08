return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local custom_codedark = require("lualine.themes.codedark")
		local colors = { -- copy from lualine.themes.codedark
			gray = "#3C3C3C",
			lightred = "#D16969",
			blue = "#569CD6",
			pink = "#C586C0",
			black = "#262626",
			white = "#D4D4D4",
			green = "#608B4E",
		}
		custom_codedark.command = {
			b = { fg = colors.lightred, bg = colors.black },
			a = { fg = colors.black, bg = colors.lightred, gui = "bold" },
		}
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = custom_codedark,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
