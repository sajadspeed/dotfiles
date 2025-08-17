local function get_real_cursor_color()
	local hl = vim.api.nvim_get_hl(0, { name = "Cursor", link = false })
	return hl.bg and string.format("#%06x", hl.bg) or "#CCCCCC"
end

return {

	"sphamba/smear-cursor.nvim",
	opts = {
		cursor_color = get_real_cursor_color(),
		smear_between_neighbor_lines = false,
		hide_target_hack = true,
		never_draw_over_target = true,
	},
}
