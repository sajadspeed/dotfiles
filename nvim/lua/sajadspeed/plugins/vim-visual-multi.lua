return {
	"mg979/vim-visual-multi",
	-- See https://github.com/mg979/vim-visual-multi/issues/241
	init = function()
		-- vim.g.VM_default_mappings = 0
		vim.g.VM_leader = "\\"
		vim.g.VM_mouse_mappings = 1
		vim.g.VM_maps = {
			["Select Cursor Down"] = "<C-M-j>",
			["Select Cursor Up"] = "<C-M-k>",
			["Select All"] = "\\a",
		}
		vim.g.VM_add_cursor_at_pos_no_mappings = 1
	end,
}
