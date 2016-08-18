set nocompatible              

" ---------------
" Dein
" ---------------
set runtimepath^=/home/dima/.vim/repos/github.com/Shougo/dein.vim
call dein#begin(expand('/home/dima/.vim')) 
call dein#add('Shougo/dein.vim')
" interface
call dein#add('scrooloose/nerdtree')
call dein#add('junegunn/fzf')
call dein#add('roman/golden-ratio')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('altercation/vim-colors-solarized')
" lang
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('tpope/vim-fugitive')
call dein#add('neomake/neomake')
call dein#add('fsharp/vim-fsharp')
call dein#add('Shougo/deoplete.nvim')
call dein#add('raichoo/purescript-vim')
call dein#add('FrigoEU/psc-ide-vim')
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
call dein#end()

filetype plugin indent on
if dein#check_install()
  call dein#install()
endif


" ---------------
" Interface
" ---------------
set ruler
set number
set nowrap
set laststatus=2
set cmdheight=1
set cursorcolumn
set showmatch
set matchtime=2
set mousehide
set mouse=a
set noerrorbells
set novisualbell
set t_Co=256
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
let g:solarized_termtrans=0
let g:solarized_visibility='low'
syntax enable


" ---------------
" Text format
" ---------------
set encoding=utf-8
set cindent
set autoindent
set smarttab
set expandtab
set tabstop=2
set backspace=2
set shiftwidth=2
set backspace=2


" ---------------
" Behavior
" ---------------
set splitbelow
set splitright
set hidden

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/temp
set backspace=indent,eol,start

set shiftround
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

let mapleader=","

" ---------------
" deoplete
" ---------------
let g:deoplete#enable_at_startup = 1
let g:necoghc_enable_detailed_browse = 1
let g:deoplete#file#enable_buffer_path = 1

" deoplete tab-complete
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType purescript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ---------------
" neomake
" ---------------
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_open_list = 2

let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

" ---------------
" airline
" ---------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '¶ '
let g:airline#extensions#branch#symbol = '⎇ '
let g:airline#extensions#paste#symbol = 'Þ'
let g:airline#extensions#whitespace#symbol = 'Ξ'
let g:airline_theme='ubaryd'

" ---------------
" Key Bindings
" ---------------
" window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" buffers
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>
" purescript 
au FileType purescript nmap <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestion<CR>
au FileType purescript nmap <leader>a :PSCIDEaddTypeAnnotation<CR>
au FileType purescript nmap <leader>i :PSCIDEimportIdentifier<CR>
au FileType purescript nmap <leader>r :PSCIDEload<CR>
au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
au FileType purescript nmap <leader>c :PSCIDEcaseSplit<CR>
au FileType purescript nmap <leader>qd :PSCIDEremoveImportQualifications<CR>
au FileType purescript nmap <leader>qa :PSCIDEaddImportQualifications<CR><Paste>


