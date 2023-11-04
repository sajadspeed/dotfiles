return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		-- require("luasnip.loaders.from_snipmate").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
					-- luasnip.filetype_extend("lua", { "lua" })
					-- luasnip.filetype_extend("c_sharp", { "csharp" })
					-- luasnip.filetype_extend("javascript", { "javascript" })
					-- luasnip.filetype_extend("typescript", { "javascript" })
					-- luasnip.filetype_extend("php", { "php" })
					-- luasnip.filetype_extend("python", { "python" })
					-- luasnip.filetype_extend("html", { "html" })
					-- luasnip.filetype_extend("css", { "css" })
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					selet = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					elseif require("luasnip").jumpable(-1) then
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = function(entry, vim_item)
					-- fancy icons and a name of kind
					vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
					local source = entry.source.name -- nvim_lsp, luasnip, buffer...
					vim_item.menu = " [" .. source .. "]"

					return vim_item
				end,
				-- format = lspkind.cmp_format({
				-- 	maxwidth = 50,
				-- 	ellipsis_char = "...",
				-- 	format = function(entry, vim_item)
				-- 		local source = entry.source.name -- nvim_lsp, luasnip, buffer...
				-- 		vim_item.menu = " [" .. source .. "]"
				--
				-- 		return vim_item
				-- 	end,
				-- }),
			},
		})

		-- If you want insert `(` after select function or method item
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
