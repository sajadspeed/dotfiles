return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				-- path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
			},
		})

		-- telescope.load_extension("fzf")

		-- Undo extention
		telescope.load_extension("undo")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		-- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		-- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

		local builtin = require("telescope.builtin")

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set(
			"n",
			"<leader>fa",
			"<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
			{ desc = "Find all" }
		)
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fuzzy live grep" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find oldfiles" })
		keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Find in current buffer" })
		keymap.set("n", "<leader>fy", "<cmd>Telescope yank_history<CR>", { desc = "Yank History" }) -- Yanky
		keymap.set("n", "<leader>fu", "<cmd>Telescope undo<CR>", { desc = "Telescope undo" }) -- Yanky
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help pages" })
		-- Before.nvim set keymap on before.lua
	end,
}
