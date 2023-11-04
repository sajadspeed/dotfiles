return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")
		-- util.add_formatter_args("prettier", { "--use-tabs", "--single-attribute-per-line true", "--print-width 9999" })

		-- local php_cs_fixer = vim.deepcopy(require("conform.formatters.php_cs_fixer"))
		-- php_cs_fixer.command = "php-cs-fixer"
		-- util.add_formatter_args(php_cs_fixer, {
		-- 	'--rules=\'{"braces_position": {"classes_opening_brace": "same_line", "functions_opening_brace": "same_line"}}\'',
		-- })

		conform.setup({
			formatters = {
				prettier = {
					command = "prettier",
					prepend_args = {
						"--use-tabs",
						-- "--single-attribute-per-line",
						"--print-width 9999",
					},
				},
				php_cs_fixer = {
					command = "php-cs-fixer",
					prepend_args = {
						"--config=/home/sajadspeed/.config/nvim/lua/sajadspeed/plugins/lsp/php_cs_config.php",
					},
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				c_sharp = { "clang_format" },
				cpp = { "clang_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				php = { "php_cs_fixer" },
				python = { "black", "isort" },
				html = { "prettier" },
				css = { "prettier" },
				markdown = { "prettier" },
				java = { "google-java-format" },
				json = { "prettier" },
				xml = { "prettier" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		})

		-- vim.keymap.set({ "n", "v" }, "<leader>mp", function()
		-- 	conform.format({
		-- 		lsp_fallback = true,
		-- 		async = false,
		-- 		timeout_ms = 500,
		-- 	})
		-- end, { desc = "Format file or range (in visual mode)" })
	end,
}
