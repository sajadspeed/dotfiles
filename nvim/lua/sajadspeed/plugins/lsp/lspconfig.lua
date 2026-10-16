return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"ray-x/lsp_signature.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
		"Decodetalkers/csharpls-extended-lsp.nvim",
	},
	config = function()
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

				keymap.set("n", "<leader>rs", ":lsp restart<CR>", opts) -- mapping to restart lsp if necessary

				-- Toggle virtual_text
				keymap.set("n", "<leader>rv", function()
					if vim.g.diagnostic_virtual_text_enabled == nil then
						vim.g.diagnostic_virtual_text_enabled = 1
					end
					vim.g.diagnostic_virtual_text_enabled = not vim.g.diagnostic_virtual_text_enabled
					vim.diagnostic.config({ virtual_text = vim.g.diagnostic_virtual_text_enabled })
				end, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>dD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Copy line diagnostics in system clipboard"
				keymap.set("n", "<leader>dy", function()
					local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })

					if #diagnostics == 0 then
						return
					end

					local messages = {}
					for _, diagnostic in ipairs(diagnostics) do
						table.insert(messages, diagnostic.message)
					end

					vim.fn.setreg("+", table.concat(messages, "\n"))
				end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

				opts.desc = "Show all methods/classes... in current buffer"
				keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", opts) -- show documentation for what is under cursor

				opts.desc = "Show all methods/classes... in workspace"
				keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts) -- show documentation for what is under cursor
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.INFO] = signs.Info,
					[vim.diagnostic.severity.HINT] = signs.Hint,
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})
		-- END

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
		vim.lsp.config("lua_ls", {
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

		vim.lsp.config("vtsls", {
			capabilities = capabilities,
		})

		vim.lsp.config("phpactor", {
			capabilities = capabilities,
		})

		vim.lsp.config("pyright", {
			capabilities = capabilities,
		})
		-- SS: For enable again just remove this line.
		vim.lsp.enable("ruff", false)

		vim.lsp.config("html", {
			capabilities = capabilities,
		})

		-- configure css server
		vim.lsp.config("cssls", {
			capabilities = capabilities,
		})

		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
		})

		vim.lsp.config("dockerls", {
			capabilities = capabilities,
		})

		-- C#
		-- local util = require("lspconfig.util")
		--
		-- local function omnisharp_root()
		-- 	local cwd = vim.fn.getcwd()
		-- 	return util.root_pattern("*.slnx", "*.sln", "*.csproj")(cwd) or cwd
		-- end
		--
		-- vim.lsp.config("omnisharp", {
		-- 	-- SS: Find the solution/project root from Neovim's cwd so OmniSharp starts from the correct project directory. Fix Unity Assets directory cwd.
		-- 	-- cmd_cwd = omnisharp_root(),
		-- 	capabilities = capabilities,
		-- 	handlers = {
		-- 		["textDocument/definition"] = require("omnisharp_extended").handler,
		-- 	},
		-- 	settings = {
		-- 		MsBuild = {
		-- 			LoadProjectsOnDemand = false,
		-- 		},
		-- 	},
		-- })

		-- vim.lsp.config("roslyn", {
		-- 	capabilities = capabilities,
		-- })

		vim.lsp.config("csharp_ls", {
			capabilities = capabilities,
			handlers = {
				["textDocument/definition"] = require("csharpls_extended").handler,
				["textDocument/typeDefinition"] = require("csharpls_extended").handler,
			},
		})

		vim.lsp.enable("csharp_ls")
		require("telescope").load_extension("csharpls_definition")

		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "visual" })
	end,
}
