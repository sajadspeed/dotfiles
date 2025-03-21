-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("i", "JJ", "<ESC>", { desc = "Exit insert mode with JJ" })

keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
keymap.set("i", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })

keymap.set("n", "<leader>q", "<cmd> bp<bar>sp<bar>bn<bar>bd <CR>", { desc = "Close buffer" })
keymap.set("n", "<leader>tl", "<cmd> bn <CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>th", "<cmd> bp <CR>", { desc = "Prev buffer" })
keymap.set({ "n", "i" }, "<C-l>", "<cmd> bn <CR>", { desc = "Next buffer" })
keymap.set({ "n", "i" }, "<C-h>", "<cmd> bp <CR>", { desc = "Prev buffer" })

keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })
keymap.set({ "n", "v" }, "H", "^", { desc = "Go to first of line" })

keymap.set({ "n", "x" }, "J", function()
	require("cinnamon").scroll("<C-d>")
end, { desc = "Half page down" })
keymap.set({ "n", "x" }, "K", function()
	require("cinnamon").scroll("<C-u>")
end, { desc = "Half page up" })

keymap.set("n", "<leader>j", "J<CR>", { desc = "Join" })

keymap.set("n", "<C-j>", ":m .+1<CR>==")
keymap.set("n", "<C-k>", ":m .-2<CR>==")
keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- keymap.set("n", "<CR>", "o <ESC>", { desc = "New blank line in normal mode" })
-- keymap.set("n", "<S-CR>", "i<CR><ESC>", { desc = "New blank line in normal mode" })
keymap.set("n", "<CR>", function()
	if vim.bo.modifiable then
		return "o <ESC>"
	else
		return "<CR>"
	end
end, { expr = true, desc = "New blank line in normal mode if modifiable" })

keymap.set("n", "<S-CR>", function()
	if vim.bo.modifiable then
		return "i<CR><ESC>"
	else
		return "<CR>"
	end
end, { expr = true, desc = "New blank line in normal mode if modifiable" })

keymap.set("n", "<leader>a", "ggVG", { desc = "Select all" })
keymap.set("n", "x", '"_x')
keymap.set("n", "X", '"_X')

keymap.set(
	{ "n", "v" },
	"<leader>y",
	'"+y',
	{ noremap = true, silent = true, desc = "Copy to system clipboard (yank)" }
)
keymap.set(
	{ "n", "v" },
	"<leader>Y",
	'"+y$',
	{ noremap = true, silent = true, desc = "Copy to system clipboard until end of line" }
)

keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard" })
keymap.set(
	{ "n", "v" },
	"<leader>P",
	'"+P',
	{ noremap = true, silent = true, desc = "Paste before from system clipboard" }
)

keymap.set({ "i", "c" }, "<c-v>", '<c-r>"', { desc = "Paste from Neovim's clipboard" })

-- window management
keymap.set("n", "<leader>ss", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Go to left" })
keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Go to bottom" })
keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Go to up" })
keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Go to right" })
keymap.set("n", "<leader>se", "<cmd>NvimTreeFocus<cr>", { desc = "NvimTreeFocus" })

keymap.set("n", "<M-l>", "<cmd>vertical resize +3<CR>")
keymap.set("n", "<M-h>", "<cmd>vertical resize -3<CR>")
keymap.set("n", "<M-k>", "<cmd>res +1<CR>")
keymap.set("n", "<M-j>", "<cmd>res -1<CR>")
keymap.set("n", "<M-=>", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height

keymap.set("n", "<leader>H", function()
	vim.cmd("noh")
end, { desc = "Cancel Highlight search" })

keymap.set("n", "<leader>;", "A;<ESC>")

keymap.set({ "n", "v", "i" }, "<c-t>", "<cmd>Lspsaga term_toggle<CR>", { noremap = true, silent = true })
