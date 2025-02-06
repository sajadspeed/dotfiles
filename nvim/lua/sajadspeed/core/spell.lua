-- Doc for future
-- Make spell file:
-- Copy .dic and .aff file to nvim/spell/
-- Example: fa.dic, fa.aff
-- Run: mkspell! /home/sajadspeed/.config/nvim/spell/fa
-- Command make a file: fa.utf-8.spl
-- For text file same.
--
-- General settings
vim.opt.spell = true
vim.opt.spellcapcheck = "" -- If not applied here, move to `set_spell_settings` function.
local ignore_word_letters = 3 -- Words less than and equal to this number are ignored for spelling.

-- Cspell dicts port helloWord
local filetype_to_spelllang_map = {
	java = { "java", "java-additional-terms", "java-terms" },
	cs = { "csharp" },
	kt = { "kotlin" },
	lua = { "lua" },
	css = { "css" },
	html = { "html" },
	php = { "php", "php-allowed-terms", "php-functions", "html" },
	py = { "python", "python-common-packages", "python-extra", "python-lib" },
	js = { "typescript" },
	jsx = { "typescript" },
	ts = { "typescript" },
	tsx = { "typescript" },
}

local default_spelllangs = {
	"en",
	-- "fa",
	"aws",
	"computingAcronyms",
	"filetypes",
	"lorem",
	"networkingTerms",
	"softwareTerms",
	"webServices",
}

vim.opt.spelllang = default_spelllangs

local function dictionary_exists(lang)
	local dict_path = vim.fn.expand("~/.config/nvim/spell/" .. lang .. ".utf-8.spl")
	return vim.fn.filereadable(dict_path) == 1
end

local function add_spelllang_local(lang)
	if not vim.tbl_contains(vim.opt.spelllang:get(), lang) then
		vim.opt_local.spelllang:append(lang)
	end
end

local function set_spell_for_extension()
	local ext = vim.fn.expand("%:e")

	local langs = filetype_to_spelllang_map[ext]

	if not langs then
		-- vim.notify("No dictionary found for extension ." .. ext, vim.log.levels.INFO)
	end

	if langs then
		for _, lang in ipairs(langs) do
			if dictionary_exists(lang) then
				add_spelllang_local(lang)
			end
		end
	end
end

local function set_spell_settings()
	vim.opt_local.spelloptions = "camel"

	vim.cmd(string.format(
		[[
		syntax match myExShortWords /\<\w\{1,%s}\>/ contains=@NoSpell
    ]],
		ignore_word_letters
	))

	-- Alternative solution for when we didn't want to remove `noplainbuffer` and replace only `camel`.
	-- vim.cmd("syntax match noSpell /*./ contains=@NoSpell")
end

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- For first buffer load if exist.
		set_spell_settings()
		set_spell_for_extension()

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			pattern = "*",
			callback = function()
				-- if vim.bo.filetype ~= "NvimTree" then -- If you had problems with nvimtree.
				set_spell_settings()
				set_spell_for_extension()
			end,
		})

		vim.api.nvim_set_hl(0, "SpellBad", {
			fg = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }).fg,
			-- undercurl = true,
			-- italic = true,
			-- underdotted = true,
			standout = true,
		})
		-- DiagnosticInfo
		-- BufferLineModified
		-- lualine_b_normal
		-- lualine_b_diff_added_normal
		-- lualine_b_diff_modified_normal
		-- lualine_b_diagnostics_hint_normal
		-- GitSignsChangeInline
		-- lualine_a_inactive
		-- GitSignsDeletePreview
		-- BufferLineOffsetSeparator
		-- lualine_b_command
		local hi_color = vim.api.nvim_get_hl(0, { name = "lualine_b_command" })

		vim.api.nvim_set_hl(0, "SpellBad", { bg = hi_color.bg, italic = true, bold = true })
		vim.api.nvim_set_hl(0, "SpellCap", { fg = hi_color.fg })
		vim.api.nvim_set_hl(0, "SpellRare", { fg = hi_color.fg })
		vim.api.nvim_set_hl(0, "SpellLocal", { fg = hi_color.fg })
	end,
})
