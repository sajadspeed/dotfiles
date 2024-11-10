local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.autoindent = true -- copy indent from current line when starting new one
opt.expandtab = false
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- For fix <200c> half-space in farsi
-- require("sajadspeed.core.conceal_fix_200c")

require("sajadspeed.core.spell")

-- General Langs: en,fa,aws,computingAcronyms,filetypes,lorem,networkingTerms,softwareTerms,webServices,
