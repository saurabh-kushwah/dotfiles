" Key Mappings
let mapleader=','

" ui
set number
set ruler
set wildmenu
set showcmd
set showmatch
set term=xterm-256color
set lazyredraw nocursorline ttyfast
set wildmenu wildmode=longest:full,full wildcharm=<Tab>

hi Normal guibg=NONE ctermbg=NONE

" encoding/format
set encoding=utf-8
set fileformats=unix,dos,mac
set listchars=eol:¶,trail:•,tab:▸\  showbreak=¬\

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

" key timeout values
set esckeys
set ttimeoutlen=20
set timeoutlen=1000

" backup
set nobackup noswapfile nowritebackup
set undofile undodir=~/.vim/undo undolevels=99999

" allow syntax and filetype plugins
syntax enable
filetype plugin indent on

autocmd BufWritePre * silent! %s/\s\+$//e
autocmd FileType yaml setlocal nowrap softtabstop=2 tabstop=2 expandtab

" Better tabbing
vnoremap < <gv
vnoremap > >gv

inoremap jk <esc>

nnoremap <space> <nop>

" navigate + center
nnoremap <c-f> <c-f>zz
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz
nnoremap <c-b> <c-b>zz

" use extended regular search
nnoremap / /\v
vnoremap / /\v

"  Use black hole register "_ to dump text instead of system clipboard
nnoremap x  "_x

" qq to record, q to stop recording, Q to apply
nnoremap Q @q
vnoremap Q :normal @q<CR>

" Treat wrap lines as separate
nnoremap <UP> gk
nnoremap <DOWN> gj

" Go to the starting position after visual modes
vnoremap <ESC> o<ESC>

" move to beginning/end of the line
nnoremap H ^
nnoremap L $

vnoremap H ^
vnoremap L $

" use `u` to undo, use `U` to redo
nnoremap U <C-r>

" Y yank until the end of line
nnoremap Y y$

" go back to previous location or from definition
nnoremap dg <C-o>

" Move Buffers
nnoremap <TAB> :next<CR>
nnoremap <S-TAB> :prev<CR>

" Quit All Files and Exit may result in data loss
nnoremap <C-q> :qa!<CR>
inoremap <C-q> <Esc>:qa!<CR>

" close buffer
nnoremap <C-w>q :bdelete<CR>

" Move between buffers
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" New Tab create in insert and normal mode
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <ESC>:tabnew<CR>

" Move tabs
nnoremap <S-Left> :tabmove -1<CR>
nnoremap <S-Right> :tabmove +1<CR>

" Cycle Tabs
nnoremap <TAB> :tabnext<CR>
nnoremap <S-TAB> :tabprev<CR>

" Go To Tab By Number
nnoremap <leader>1 gt1
nnoremap <leader>2 gt2
nnoremap <leader>3 gt3
nnoremap <leader>4 gt4
nnoremap <leader>5 gt5
nnoremap <leader>6 gt6
nnoremap <leader>7 gt7
nnoremap <leader>8 gt8

" Write
nnoremap <leader>w :w<CR>
inoremap <leader>w <ESC>:w<CR>

" Turn Off Search Highlight
nnoremap <leader><space> :noh<CR>:redraw!<CR>

" Switch CWD To The Directory Of The Open Buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<cr>

" Rename Word Under Cursor
nnoremap <leader>s :silent %s/\<<C-r><C-w>\>/

" Auto-Capitalize First Character Of Words
nnoremap <leader>m V:%!sed -e 's/\b\(.\)/\u\1/g'<CR>
vnoremap <leader>m :%!sed -e 's/\b\(.\)/\u\1/g'<CR>

" close all buffers and open last edited file
nnoremap <leader>ca :silent bufdo bd<CR>

" navigate file changes using Alt+` & Alt+1
nnoremap <m-`> <c-o>zz
nnoremap <m-1> <c-i>zz
