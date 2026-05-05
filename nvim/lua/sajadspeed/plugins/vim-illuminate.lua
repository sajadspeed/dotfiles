return {
	"RRethy/vim-illuminate",
	config = function()
		local function set_illuminate_hl()
			-- require("notify")("set_illuminate_hl")
			local groups = {
				"IlluminatedWordText",
				"IlluminatedWordRead",
				"IlluminatedWordWrite",
				"illuminatedCurWord",
			}

			for _, group in ipairs(groups) do
				vim.api.nvim_set_hl(0, group, {
					underline = true,
				})
			end
		end
		vim.api.nvim_create_autocmd("VimEnter", {
			once = true,
			callback = set_illuminate_hl,
		})
	end,
}
