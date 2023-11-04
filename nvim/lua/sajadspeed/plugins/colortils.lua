return {
	"max397574/colortils.nvim",
	config = function()
		require("colortils").setup({
			background = "#21242b",
			mappings = {
				-- save the current color in the register specified above with the format specified above
				set_register_default_format = "<m-cr>",
				-- save the current color in the register specified above with a format you can choose
				set_register_cjoose_format = "g<m-cr>",
				-- replace the color under the cursor with the current color in the format specified above
				replace_default_format = "<cr>",
				-- replace the color under the cursor with the current color in a format you can choose
				replace_choose_format = "g<cr>",
				-- export the current color to a different tool
				export = "e",
				-- set the value to a certain number (done by just entering numbers)
				set_value = "c",
				-- toggle transparency
				transparency = "t",
				-- choose the background (for transparent colors)
				choose_background = "b",
			},
		})
		vim.keymap.set("n", "<leader>cp", "<cmd>Colortils picker<CR>")
	end,
}
