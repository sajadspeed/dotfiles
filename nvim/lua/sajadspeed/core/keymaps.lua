-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("i", "JJ", "<ESC>", { desc = "Exit insert mode with JJ" })

keymap.set({ "n", "i" }, "<C-s>", "<cmd> w <CR>", { desc = "Save file" })

-- ** BUFFERS **
--
keymap.set("n", "<leader>q", function()
	local buftype = vim.bo.buftype
	if buftype == "" or buftype == "nofile" then
		vim.cmd("BufDel")
	else
		vim.cmd("q")
	end
end, { desc = "Close buffer or window" })

keymap.set("n", "<leader>Q", "<cmd> BufDel! <CR>", { desc = "Close buffer force" })

keymap.set({ "n", "i" }, "<C-l>", "<cmd> BufferLineCycleNext <CR>", { desc = "Next buffer" })
keymap.set({ "n", "i" }, "<C-h>", "<cmd> BufferLineCyclePrev <CR>", { desc = "Prev buffer" })

-- <C-,>
keymap.set({ "n", "i" }, "\\u9F8D", "<cmd> BufferLineMovePrev <CR>", { desc = "BufferLine Move buffer prev" })
-- <C-.>
keymap.set({ "n", "i" }, "\\u99AC", "<cmd> BufferLineMoveNext <CR>", { desc = "BufferLine Move buffer next" })

keymap.set("n", "<leader>bp", "<cmd> BufferLinePick <CR>", { desc = "Prev buffer" })
keymap.set("n", "<leader>bi", "<cmd> BufferLineTogglePin <CR>", { desc = "Prev buffer" })

keymap.set("n", "<leader>bcl", "<cmd> BufferLineCloseRight <CR>", { desc = "BufferLineCloseRight" })
keymap.set("n", "<leader>bch", "<cmd> BufferLineCloseLeft <CR>", { desc = "BufferLineCloseLeft" })
keymap.set("n", "<leader>bco", "<cmd> BufferLineCloseOthers <CR>", { desc = "BufferLineCloseOthers" })
keymap.set("n", "<leader>bca", "<cmd> BufDelAll <CR>", { desc = "BufDelAll" })

-- ** TABS **
--
keymap.set("n", "<leader>tn", "<cmd> tabnew <CR>", { desc = "Tab New" })
keymap.set("n", "<leader>tc", "<cmd> tabclose <CR>", { desc = "Tab Close" })
keymap.set("n", "<leader>tf", "<cmd> tabfirst <CR>", { desc = "Tab First" })
keymap.set("n", "<leader>tl", "<cmd> tablast <CR>", { desc = "Tab Last" })

keymap.set("n", "<leader>tl", "<cmd> tabnext <CR>", { desc = "Next Tab" })
keymap.set("n", "<leader>th", "<cmd> tabprev <CR>", { desc = "Prev Tab" })

-- Map <leader>t1, <leader>t2, ..., <leader>t9 to switch to corresponding tab
for i = 1, 9 do
	keymap.set("n", "<leader>t" .. i, "<cmd>tabnext " .. i .. "<CR>", { desc = "Go to Tab " .. i })
end

-- CTRL + SHIFT + L
keymap.set({ "n", "i" }, "\\u65E5", "<cmd> tabnext <CR>", { desc = "Prev Tab" })

-- CTRL + SHIFT + H
keymap.set({ "n", "i" }, "\\u4E9C", "<cmd> tabprev <CR>", { desc = "Next Tab" })

keymap.set("n", "L", "$", { desc = "Go to end of line" })
-- It provides flexibility for moving around in the line more efficiently without selecting trailing spaces or newline characters.
-- Previously, using "$" would select the newline character and cause the next line to stick to the current one after deletion. This remap avoids that issue.
keymap.set("v", "L", "g_", { desc = "Go to last non-blank character in line" })

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

keymap.set("v", "p", '"_dP', { desc = "Paste without overwriting register" })
keymap.set("v", "P", '"_dp', { desc = "Paste(P) without overwriting register" })

-- Fixes cursor jumping to the start after yank in Visual mode
keymap.set("x", "y", "ygv<Esc>", { noremap = true, silent = true })

keymap.set({ "n" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard (yank)" })

keymap.set(
	{ "v" },
	"<leader>y",
	'"+ygv<Esc>',
	{ noremap = true, silent = true, desc = "Copy to system clipboard (yank)" }
)

keymap.set(
	{ "n", "v" },
	"<leader>Y",
	'"+y$',
	{ noremap = true, silent = true, desc = "Copy to system clipboard until end of line" }
)

keymap.set("n", "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard" })
keymap.set("n", "<leader>P", '"+P', { noremap = true, silent = true, desc = "Paste before from system clipboard" })
keymap.set(
	"v",
	"<leader>p",
	'"_d"+P',
	{ noremap = true, silent = true, desc = "Paste from system clipboard without overwriting register" }
)
keymap.set(
	"v",
	"<leader>P",
	'"_d"+p',
	{ noremap = true, silent = true, desc = "Paste before from system clipboard without overwriting register" }
)

keymap.set({ "i", "c" }, "<c-v>", '<c-r>"', { desc = "Paste from Neovim's clipboard" })

-- Window management and Tmux
keymap.set("n", "<leader>ss", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally

keymap.set("n", "<leader>sh", '<cmd>lua require("tmux").move_left()<CR>', { desc = "Go to left" })
keymap.set("n", "<leader>sl", '<cmd>lua require("tmux").move_right()<CR>', { desc = "Go to right" })
keymap.set("n", "<leader>sj", '<cmd>lua require("tmux").move_bottom()<CR>', { desc = "Go to bottom" })
keymap.set("n", "<leader>sk", '<cmd>lua require("tmux").move_top()<CR>', { desc = "Go to up" })
keymap.set("n", "<M-h>", '<cmd>lua require("tmux").move_left()<CR>', { desc = "Go to left" })
keymap.set("n", "<M-l>", '<cmd>lua require("tmux").move_right()<CR>', { desc = "Go to right" })
keymap.set("n", "<M-j>", '<cmd>lua require("tmux").move_bottom()<CR>', { desc = "Go to bottom" })
keymap.set("n", "<M-k>", '<cmd>lua require("tmux").move_top()<CR>', { desc = "Go to up" })

keymap.set("n", "<leader>st", function()
	if os.getenv("TMUX") then
		vim.fn.system("tmux select-pane -D")
	end
end, { desc = "Switch to bottom pane" })

keymap.set("n", "<leader>se", "<cmd>NvimTreeFocus<cr>", { desc = "NvimTreeFocus" })

keymap.set({ "n", "i" }, "<C-M-h>", '<cmd>lua require("tmux").resize_left(3)<CR>')
keymap.set({ "n", "i" }, "<C-M-l>", '<cmd>lua require("tmux").resize_right(3)<CR>')
keymap.set({ "n", "i" }, "<C-M-j>", '<cmd>lua require("tmux").resize_bottom()<CR>')
keymap.set({ "n", "i" }, "<C-M-k>", '<cmd>lua require("tmux").resize_top()<CR>')

keymap.set({ "n", "i" }, "<C-M-=>", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height

keymap.set("n", "<leader>H", function()
	vim.cmd("noh")
end, { desc = "Cancel Highlight search" })

keymap.set("n", "<leader>;", "A;<ESC>")

keymap.set({ "n", "v", "i" }, "<c-t>", "<cmd>Lspsaga term_toggle<CR>", { noremap = true, silent = true })
