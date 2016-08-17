"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
set runtimepath^=/home/dima/.vim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/home/dima/.vim')) 

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

" window management
call dein#add('scrooloose/nerdtree')
call dein#add('roman/golden-ratio')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

call dein#add('godlygeek/csapprox')
call dein#add('flazz/vim-colorschemes')

call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

" ---------------
"  Languages
" ---------------
call dein#add('tpope/vim-fugitive')
call dein#add('scrooloose/syntastic')
call dein#add('fsharp/vim-fsharp')
call dein#add('Shougo/deoplete.nvim')
call dein#add('raichoo/purescript-vim')
call dein#add('FrigoEU/psc-ide-vim')
"call dein#add('eagletmt/ghcmod-vim')
"call dein#add('eagletmt/neco-ghc')
"call dein#add('Valloric/YouCompleteMe')

"call dein#add('albfan/AutoComplPop')
"call dein#add('Shougo/neocomplete')
"call dein#add('Konfekt/FastFold')

let g:syntastic_ocaml_checkers = ['merlin']




" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------



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


" source: https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
" http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
 
" KEYS REMAPPING 
" leader mapping
let mapleader=","

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

"colorscheme 256-jungle
colorscheme wombat256mod
syntax enable
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete


" Use deoplete.
let g:deoplete#enable_at_startup = 1

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

set t_Co=256

set splitbelow
set splitright
set hidden
set nocompatible
set nobackup
set noswapfile
set nowrap
set tabstop=4 shiftwidth=4 expandtab
set backspace=indent,eol,start

set autoindent
set copyindent
set number
set shiftwidth=4
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set laststatus=2

" deoplete tab-complete
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
" ,<Tab> for regular tab
inoremap <Leader><Tab> <Space><Space>


" ---------------
" Key Bindings
" ---------------

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



