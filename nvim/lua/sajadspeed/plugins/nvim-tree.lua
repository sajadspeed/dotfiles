return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvimtree = require("nvim-tree")
		-- local api = require("nvim-tree.api")
		--
		-- local function open_without_focus(node)
		-- 	api.
		-- 	api.node.open.edit(node, { close_tree = true })
		-- 	api.tree.close()
		-- end

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- change color for arrows in tree to light blue
		-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			local function open_no_focus()
				api.node.open.edit()
				api.tree.focus()
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
			-- vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
			vim.keymap.set("n", "<Tab>", open_no_focus, opts("Open: No Focus"))
			vim.keymap.set("n", "<S-Tab>", api.node.open.preview, opts("Preview"))

			vim.keymap.set("n", "r", api.fs.rename_basename, opts("Rename basename"))
			vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
		end

		-- configure nvim-tree
		nvimtree.setup({
			view = {
				width = 30,
				relativenumber = true,
			},
			actions = {
				open_file = {
					resize_window = false,
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
			on_attach = my_on_attach,
			-- sync_root_with_cwd = true
		})

		-- Open on startup
		-- require("nvim-tree.api").tree.open()

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Open file explorer on current file" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
		vim.api.nvim_create_autocmd("User", {
			pattern = "NvimTreeSetup",
			callback = function()
				local events = require("nvim-tree.api").events
				events.subscribe(events.Event.NodeRenamed, function(data)
					if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
						data = data
						Snacks.rename.on_rename_file(data.old_name, data.new_name)
					end
				end)
			end,
		})
	end,
}
