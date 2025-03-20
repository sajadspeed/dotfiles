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
		"uga-rosa/cmp-dictionary",
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		-- require("luasnip.loaders.from_snipmate").lazy_load()

		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

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
					select = true,
				}),

				["<Tab>"] = cmp.mapping(function(fallback)
					-- if luasnip.expand_or_jumpable() and luasnip.jumpable() then -- If is not expandable
					-- 	luasnip.expand_or_jump()
					--
					if luasnip.jumpable() then -- If is not expandable
						luasnip.jump(1)
					elseif cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					elseif cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "dictionary", keyword_length = 3 },
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
			},
		})

		require("cmp_dictionary").setup({
			paths = { "/usr/share/dict/words" },
			exact_length = 2,
			first_case_insensitive = true,
			document = {
				enable = true,
				command = { "wn", "${label}", "-over" },
			},
		})

		-- If you want insert `(` after select function or method item
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		function leave_snippet()
			if
				((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
				and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
				and not require("luasnip").session.jump_active
			then
				require("luasnip").unlink_current()
			end
		end

		-- stop snippets when you leave to normal mode
		vim.api.nvim_command([[
			autocmd ModeChanged * lua leave_snippet()
		]])
	end,
}
