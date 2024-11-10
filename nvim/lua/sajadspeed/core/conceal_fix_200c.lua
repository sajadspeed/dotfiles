local function set_conceal_normal()
	vim.api.nvim_command("call matchadd('Conceal', '‌', 10, -1, {'conceal':'‌'})")
	vim.api.nvim_command("set conceallevel=2 concealcursor=nv")
end

local function set_conceal_insert()
	vim.api.nvim_command("call matchadd('Conceal', '‌', 10, -1, {'conceal':' '})")
	vim.api.nvim_command("set concealcursor=i")
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		set_conceal_normal()
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	callback = function()
		set_conceal_insert()
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		set_conceal_normal()
	end,
})
