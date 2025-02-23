set mouse=r

set nowrap
set number
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
vnoremap L $
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

map <leader>a ggVG

" set spell
" set spelloptions=camel
