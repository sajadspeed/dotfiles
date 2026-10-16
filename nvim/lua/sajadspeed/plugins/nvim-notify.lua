return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup()

		vim.notify = require("notify")

		-- SS: Only just for ignore `No information available` for hover_document in lspsaga
		-- DELETE This when fix the bug in lspsaga
		--
		local notify = vim.notify
		vim.notify = function(msg, level, opts)
			if type(msg) == "string" and msg == "No information available" then
				return
			end

			notify(msg, level, opts)
		end
		---
		---
	end,
}
