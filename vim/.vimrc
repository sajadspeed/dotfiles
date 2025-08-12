set mouse=r

set nowrap
set relativenumber
syntax on

set tabstop=4

" Ignore case when searchingCase
set ignorecase

" When searching try to be smart about cases 
set smartcase

let mapleader = " "

imap jj <Esc>
imap JJ <Esc>
map L $
map H ^

"" It provides flexibility for moving around in the line more efficiently without selecting trailing spaces or newline characters.
"" Previously, using '$' would select the newline character and cause the next line to stick to the current one after deletion. This remap avoids that issue.
vnoremap L g_

vnoremap H ^

map J <C-d>
map K <C-u>
vnoremap J <C-d>
vnoremap K <C-u>

map <CR> o<ESC>
" map <S-CR> O<ESC>
map <C-A> ggVG

map <C-j> :m .+1<CR>==
map <C-k> :m .-2<CR>==

imap <C-j> <Esc>:m .+1<CR>==gi
imap <C-k> <Esc>:m .-2<CR>==gi

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Fixes cursor jumping to the start after yank in Visual mode
xnoremap y ygv<Esc>

" Paste from Neovim's clipboard
imap <C-v> <C-r>"

map <leader>a ggVG

nnoremap <leader>n :set number!<CR>

" set spell
" set spelloptions=camel
