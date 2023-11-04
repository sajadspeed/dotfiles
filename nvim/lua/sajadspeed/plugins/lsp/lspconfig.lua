return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		-- import lspconfig plugin

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness
		-- local on_attach = function(bufnr)
		-- 	opts.buffer = bufnr
		--

		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		--
		-- vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
		keymap.set(
			"n",
			"[d",
			vim.diagnostic.goto_prev,
			{ noremap = true, silent = true, desc = "Go to previous diagnostic" }
		) -- jump to previous diagnostic in buffer

		keymap.set(
			"n",
			"]d",
			vim.diagnostic.goto_next,
			{ noremap = true, silent = true, desc = "Go to next diagnostic" }
		) -- jump to next diagnostic in buffer

		-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
		-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
		-- vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist)

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
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				-- opts.desc = "Restart LSP"
				-- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
				-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
				-- vim.keymap.set('n', '<space>wl', function()
				-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, opts)
				-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
				-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
				-- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
				-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				-- vim.keymap.set('n', '<space>f', function()
				-- 	vim.lsp.buf.format { async = true }
				-- end, opts)
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			-- on_attach = on_attach,
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
			-- on_attach = on_attach,
		})

		-- local tsserverCapabilities = cmp_nvim_lsp.default_capabilities()
		-- tsserverCapabilities.textDocument.completion.completionItem.snippetSupport = false

		-- configure typescript server with plugin
		lspconfig["tsserver"].setup({
			capabilities = capabilities,
			-- on_attach = on_attach,
		})
		lspconfig["intelephense"].setup({
			capabilities = capabilities,
			-- on_attach = on_attach,
		})
		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			-- on_attach = on_attach,
		})

		lspconfig["sqlls"].setup({
			capabilities = capabilities,
			-- on_attach = on_attach,
		})

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			-- on_attach = on_attach,
			filetypes = { "html", "php" },
		})

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			-- on_attach = on_attach,
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			-- on_attach = on_attach,
			filetypes = { "html", "css", "sass", "scss", "less", "svelte" },
		})
	end,
}
