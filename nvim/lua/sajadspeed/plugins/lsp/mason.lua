return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				-- "csharp_ls",
				"clangd",
				"tsserver",
				"intelephense",
				"pyright",
				"sqlls",
				"html",
				"cssls",
				"emmet_ls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"clang-format", -- c... formatter
				"php-cs-fixer",
				"black", -- Python formatter
				"isort", -- Python sort imports formatter
				"google-java-format", -- java formatter
				"eslint", -- js linter
				"stylelint", -- css linter
				"pylint", -- python linter
				"cspell",
			},
		})
	end,
}
