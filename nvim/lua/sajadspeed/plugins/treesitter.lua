return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",

	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
		},
	},

	config = function()
		-- =========================================================================
		-- nvim-treesitter
		-- =========================================================================

		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local parsers = {
			"lua",
			"vimdoc",
			"bash",
			"c_sharp",
			"cpp",
			"javascript",
			"typescript",
			"jsx",
			"tsx",
			"php",
			"python",
			"sql",
			"html",
			"css",
			"csv",
			"java",
			"json",
			"xml",
		}

		require("nvim-treesitter").install(parsers)

		-- =========================================================================
		-- Treesitter highlighting
		-- =========================================================================

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"cs",
				"cpp",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"php",
				"python",
				"sql",
				"html",
				"css",
				"csv",
				"java",
				"json",
				"xml",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})

		-- =========================================================================
		-- Treesitter indentation
		-- =========================================================================

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua",
				"bash",
				"cs",
				"cpp",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"jsx",
				"tsx",
				"php",
				"python",
				"sql",
				"html",
				"css",
				"java",
				"json",
				"xml",
			},
			callback = function()
				-- Indention handle with treesitter. It's to bugy for C# files.
				-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				vim.treesitter.start()
			end,
		})

		-- =========================================================================
		-- Textobjects
		-- =========================================================================

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,

				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "<c-v>",
					["@conditional.outer"] = "V",
					["@loop.outer"] = "V",
				},

				include_surrounding_whitespace = false,
			},

			move = {
				set_jumps = true,
			},
		})

		-- Select textobjects
		local select = require("nvim-treesitter-textobjects.select")

		vim.keymap.set({ "x", "o" }, "af", function()
			select.select_textobject("@function.outer", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "if", function()
			select.select_textobject("@function.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ac", function()
			select.select_textobject("@class.outer", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ic", function()
			select.select_textobject("@class.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "aa", function()
			select.select_textobject("@parameter.outer", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ia", function()
			select.select_textobject("@parameter.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ai", function()
			select.select_textobject("@conditional.outer", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ii", function()
			select.select_textobject("@conditional.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "al", function()
			select.select_textobject("@loop.outer", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "il", function()
			select.select_textobject("@loop.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ab", function()
			select.select_textobject("@block.outer", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ib", function()
			select.select_textobject("@block.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ar", function()
			select.select_textobject("@return.outer", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ir", function()
			select.select_textobject("@return.inner", "textobjects")
		end)

		-- =========================================================================
		-- Textobjects movement
		-- =========================================================================

		local move = require("nvim-treesitter-textobjects.move")

		vim.keymap.set("n", "]f", function()
			move.goto_next_start("@function.outer", "textobjects")
		end)

		vim.keymap.set("n", "]F", function()
			move.goto_next_end("@function.outer", "textobjects")
		end)

		vim.keymap.set("n", "]i", function()
			move.goto_next_start("@conditional.outer", "textobjects")
		end)

		vim.keymap.set("n", "]I", function()
			move.goto_next_end("@conditional.outer", "textobjects")
		end)

		vim.keymap.set("n", "]a", function()
			move.goto_next_start("@parameter.outer", "textobjects")
		end)

		vim.keymap.set("n", "]A", function()
			move.goto_next_end("@parameter.outer", "textobjects")
		end)

		vim.keymap.set("n", "[f", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end)

		vim.keymap.set("n", "[F", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end)

		vim.keymap.set("n", "[i", function()
			move.goto_previous_start("@conditional.outer", "textobjects")
		end)

		vim.keymap.set("n", "[I", function()
			move.goto_previous_end("@conditional.outer", "textobjects")
		end)

		vim.keymap.set("n", "[a", function()
			move.goto_previous_start("@parameter.outer", "textobjects")
		end)

		vim.keymap.set("n", "[A", function()
			move.goto_previous_end("@parameter.outer", "textobjects")
		end)
	end,
}
