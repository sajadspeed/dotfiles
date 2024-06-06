return {
	"davidmh/cspell.nvim",
	dependencies = {
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local cspell = require("cspell")

		local config = {
			--- A way to define your own logic to find the CSpell configuration file.
			---@params cwd The same current working directory defined in the source,
			--             defaulting to vim.loop.cwd()
			---@return string|nil The path of the json file
			find_json = function(cwd)
				return "/home/sajadspeed/.config/cspell.nvim.json" -- For global directory
			end,
		}

		require("null-ls").setup({
			sources = {
				cspell.diagnostics.with({
					diagnostics_postprocess = function(diagnostic)
						diagnostic.severity = vim.diagnostic.severity["INFO"]
						-- diagnostic.message = "WrongSpell"
					end,
					config = config,
				}),
				cspell.code_actions.with({
					config = config,
				}),
			},
		})
	end,
}
