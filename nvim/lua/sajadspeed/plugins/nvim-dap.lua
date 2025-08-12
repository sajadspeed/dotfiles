return {
	"mfussenegger/nvim-dap",
	lazy = true,
	config = function()
		local dap = require("dap")

		--- PHP ---
		dap.adapters.php = {
			type = "executable",
			command = "/home/sajadspeed/.local/share/nvim/mason/packages/php-debug-adapter/php-debug-adapter",
			args = {},
		}

		dap.configurations.php = {
			{
				name = "Listen for Xdebug",
				type = "php",
				request = "launch",
				port = 9003,
				console = "internalConsole",
			},
			{
				name = "Run current script",
				type = "php",
				request = "launch",
				port = 9003,
				cwd = "${fileDirname}",
				program = "${file}",
				runtimeExecutable = "php",
			},
		}
		---
	end,
	keys = {
		{
			"<leader>dr",
			function()
				local dap = require("dap")
				local filetype = vim.bo.filetype

				if dap.configurations[filetype] then
					dap.run(dap.configurations[filetype][1])
				else
					print("No DAP configuration found for filetype: " .. filetype)
				end
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		-- {
		-- 	"<leader>dC",
		-- 	function()
		-- 		require("dap").reverse_continue()
		-- 	end,
		-- 	desc = "Continues execution reverse in time until last breakpoint.",
		-- },
		{
			"<leader>dn",
			function()
				require("dap").step_into()
			end,
			desc = "Requests the debugee to step into a function or method if possible.",
		},
		{
			"<leader>dN",
			function()
				require("dap").step_over()
			end,
			desc = "Requests the debugee to run again for [count] steps.",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Requests the debugee to step out of a function or method if possible.",
		},
		-- {
		-- 	"<leader>do",
		-- 	function()
		-- 		require("dap").step_back()
		-- 	end,
		-- 	desc = "Steps one step back. Debug adapter must support reverse debugging.",
		-- },
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Requests debug adapter to pause a thread.",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
	},
}
