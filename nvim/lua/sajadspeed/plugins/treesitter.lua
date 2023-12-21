return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vimdoc",
				"bash",
				"c_sharp",
				"cpp",
				"javascript",
				"typescript",
				"php",
				"python",
				"sql",
				"html",
				"css",
				"csv",
				"git_config",
				"java",
				"json",
				"xml",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = false,
			},
			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["ar"] = "@return.outer",
						["ir"] = "@return.inner",
						-- -- You can optionally set descriptions to the mappings (used in the desc parameter of
						-- -- nvim_buf_set_keymap) which plugins like which-key display
						-- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						-- -- You can also use captures from other query groups like `locals.scm`
						-- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
						["@conditional.outer"] = "V", -- linewise
						["@loop.outer"] = "V", -- linewise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true of false
					include_surrounding_whitespace = false,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = "@function.outer",
						["]i"] = "@conditional.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]I"] = "@conditional.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[i"] = "@conditional.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[I"] = "@conditional.outer",
					},
					-- Below will go to either the start or the end, whichever is closer.
					-- Use if you want more granular movements
					-- Make it even more gradual by adding multiple queries and regex.
					-- goto_next = {
					-- 	["]i"] = "@conditional.outer",
					-- 	["]f"] = "@function.outer",
					-- },
					-- goto_previous = {
					-- 	["[i"] = "@conditional.outer",
					-- 	["[f"] = "@function.outer",
					-- },
				},
			},
		})
	end,
}
