return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"ray-x/lsp_signature.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
		-- "VidocqH/lsp-lens.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")

		-- import lspconfig plugin

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"[d",
			"<cmd>Lspsaga diagnostic_jump_prev<CR>",
			{ noremap = true, silent = true, desc = "Go to previous diagnostic" }
		)

		keymap.set(
			"n",
			"]d",
			"<cmd>Lspsaga diagnostic_jump_next<CR>",
			{ noremap = true, silent = true, desc = "Go to next diagnostic" }
		)

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				-- Toggle virtual_text
				keymap.set("n", "<leader>rv", function()
					if vim.g.diagnostic_virtual_text_enabled == nil then
						vim.g.diagnostic_virtual_text_enabled = 1
					end
					vim.g.diagnostic_virtual_text_enabled = not vim.g.diagnostic_virtual_text_enabled
					vim.diagnostic.config({ virtual_text = vim.g.diagnostic_virtual_text_enabled })
				end, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>dD", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

				opts.desc = "Show all methods/classes... in current buffer"
				keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", opts) -- show documentation for what is under cursor

				opts.desc = "Show all methods/classes... in workspace"
				keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts) -- show documentation for what is under cursor
			end,
		})

		-- local SymbolKind = vim.lsp.protocol.SymbolKind

		-- require("lsp-lens").setup({
		-- 	enable = true,
		-- 	include_declaration = false, -- Reference include declaration
		-- 	sections = { -- Enable / Disable specific request, formatter example looks 'Format Requests'
		-- 		definition = false,
		-- 		references = true,
		-- 		implements = true,
		-- 		git_authors = true,
		-- 	},
		-- 	ignore_filetype = {
		-- 		"prisma",
		-- 	},
		-- 	-- Target Symbol Kinds to show lens information
		-- 	target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
		-- 	-- Symbol Kinds that may have target symbol kinds as children
		-- 	wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
		-- })

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.cmd([[
		  highlight DiagnosticHint guifg=#af87d7
		]])
		vim.cmd([[
		  highlight DiagnosticSignHint guifg=#af87d7
		]])
		vim.cmd([[
		  highlight DiagnosticVirtualTextHint guifg=#af87d7
		]])
		vim.cmd([[
		  highlight DiagnosticUnderlineHint guifg=#af87d7
		]])

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,

			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
		})

		-- local tsserverCapabilities = cmp_nvim_lsp.default_capabilities()
		-- tsserverCapabilities.textDocument.completion.completionItem.snippetSupport = false

		-- configure typescript server with plugin
		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
		})

		-- lspconfig["intelephense"].setup({
		-- 	capabilities = capabilities,
		-- 	init_options = {
		-- 		globalStoragePath = "/home/sajadspeed/.config/intelephense",
		-- 	},
		--
		-- })

		lspconfig["phpactor"].setup({
			capabilities = capabilities,
		})

		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
		})

		lspconfig["sqlls"].setup({
			capabilities = capabilities,
		})

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,

			filetypes = { "html", "php" },
		})

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			filetypes = { "html", "css", "sass", "scss", "less", "svelte" },
		})

		lspconfig["dockerls"].setup({
			capabilities = capabilities,
		})

		lspconfig["docker_compose_language_service"].setup({
			capabilities = capabilities,
		})

		-- C#
		-- lspconfig["omnisharp"].setup({
		-- 	capabilities = capabilities,
		-- 	cmd = { "dotnet", "/home/sajadspeed/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
		-- 	handlers = {
		-- 		["textDocument/definition"] = require("omnisharp_extended").handler,
		-- 	},
		-- 	-- Enables support for reading code style, naming convention and analyzer
		-- 	-- settings from .editorconfig.
		-- 	enable_editorconfig_support = true,
		--
		-- 	-- If true, MSBuild project system will only load projects for files that
		-- 	-- were opened in the editor. This setting is useful for big C# codebases
		-- 	-- and allows for faster initialization of code navigation features only
		-- 	-- for projects that are relevant to code that is being edited. With this
		-- 	-- setting enabled OmniSharp may load fewer projects and may thus display
		-- 	-- incomplete reference lists for symbols.
		-- 	enable_ms_build_load_projects_on_demand = false,
		--
		-- 	-- Enables support for roslyn analyzers, code fixes and rulesets.
		-- 	enable_roslyn_analyzers = false,
		--
		-- 	-- Specifies whether 'using' directives should be grouped and sorted during
		-- 	-- document formatting.
		-- 	organize_imports_on_format = false,
		--
		-- 	-- Enables support for showing unimported types and unimported extension
		-- 	-- methods in completion lists. When committed, the appropriate using
		-- 	-- directive will be added at the top of the current file. This option can
		-- 	-- have a negative impact on initial completion responsiveness,
		-- 	-- particularly for the first few completion sessions after opening a
		-- 	-- solution.
		-- 	enable_import_completion = true,
		--
		-- 	-- Specifies whether to include preview versions of the .NET SDK when
		-- 	-- determining which version to use for project loading.
		-- 	sdk_include_prereleases = true,
		--
		-- 	-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
		-- 	-- true
		-- 	analyze_open_documents_only = false,
		--
		-- 	-- SS: My omnisharp.json in ~/.omnisharp/omnisharp.json
		-- })

		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "visual" })
	end,
}
