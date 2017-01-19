set nocompatible              


" ---------------
" Dein
" ---------------
set runtimepath^=~/.nvim/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.nvim')) 
call dein#add('Shougo/dein.vim')

" interface
call dein#add('junegunn/fzf')
call dein#add('junegunn/fzf.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('ryanoasis/vim-devicons')
call dein#add('tpope/vim-unimpaired')
call dein#add('tomasr/molokai')
call dein#add('iCyMind/NeoSolarized')
call dein#add('morhetz/gruvbox')

" git
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-sensible')
call dein#add('tpope/vim-commentary')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

call dein#add('miyakogi/seiya.vim')


"call dein#add('Yggdroot/indentLine')
"call dein#add('Shougo/unite.vim')
"call dein#add('Shougo/vimfiler')


"util
call dein#add('cazador481/fakeclip.neovim')
call dein#add('airblade/vim-gitgutter')
"call dein#add('vim-syntastic/syntastic')

" lang
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('Shougo/deoplete.nvim')
call dein#add('neomake/neomake')
call dein#add('zchee/deoplete-clang')
call dein#add('arakashic/chromatica.nvim')

call dein#add('eagletmt/ghcmod-vim')
call dein#add('eagletmt/neco-ghc')
call dein#add('neovimhaskell/haskell-vim')
call dein#add('itchyny/vim-haskell-indent')
call dein#add('mpickering/hlint-refactor-vim')

call dein#add('euclio/vim-markdown-composer', {'on_ft':['md'], 'build': 'cargo build --release'})
call dein#add('lervag/vimtex')

call dein#add('idris-hackers/idris-vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('critiqjo/lldb.nvim')
call dein#add('raichoo/purescript-vim')
call dein#add('FrigoEU/psc-ide-vim')
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })


call dein#end()

syntax on
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
autocmd BufEnter * set cursorline
autocmd BufLeave * set nocursorline
set showmatch
set matchtime=2
set mousehide
set mouse=a
"set noerrorbells
"set novisualbell
set termguicolors

let g:neosolarized_bold = 1
let g:neosolarized_underline = 0
let g:neosolarized_italic = 1

let g:gruvbox_italic=1

set background=dark
"set background=light

colorscheme molokai
let g:airline_theme='molokai'

 "colorscheme gruvbox
 "let g:airline_theme='gruvbox'

"colorscheme NeoSolarized
"let g:airline_theme='solarized'


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
set inccommand=split

" ---------------
" Behavior
" ---------------
set splitbelow
set splitright
set hidden

set backup
set backupdir=~/.nvim/backup
"set directory=~/.vim/temp
set backspace=indent,eol,start

set shiftround
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

"let mapleader="\<Space>"
"let maplocalleader="\<Space>"

let mapleader=","
let maplocalleader=","

" ---------------
" deoplete
" ---------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.purescript = '[^. *\t]'
let g:deoplete#omni#input_patterns.haskell = '[^. *\t]'
let g:deoplete#omni#input_patterns.idris = '[^. *\t]'
"set completeopt=longest,menuone
"Amount of entries in completion popup
"set pumheight=10
let g:deoplete#max_menu_width = -1
autocmd FileType purescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()



" ---------------
" Haskell
" ---------------


let g:haddock_browser="chromium"
let g:haskellmode_completion_ghc = 0

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc


"let g:haskell_conceal_wide = 1
"let g:haskell_multiline_strings = 1
let g:necoghc_enable_detailed_browse = 1


au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>tt :GhcModType<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>tc :GhcModTypeClear<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>i :GhcModExpand<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>ta :GhcModTypeInsert<CR>

au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>a :GhcModSigCodegen<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>ip :GhcModInfoPreview<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>e :GhcModExpand<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>c :GhcModSplitFunCase<CR>



let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_indent_disable = 1


" ---------------
" Idris
" ---------------
au FileType idris nnoremap <buffer> <silent> <LocalLeader>r :call IdrisReload(0)<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>c :call IdrisCaseSplit()<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>d 0:call search(":")<ENTER>b:call IdrisAddClause(0)<ENTER>w
au FileType idris nnoremap <buffer> <silent> <LocalLeader>b 0:call IdrisAddClause(0)<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>m :call IdrisAddMissing()<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>md 0:call search(":")<ENTER>b:call IdrisAddClause(1)<ENTER>w
au FileType idris nnoremap <buffer> <silent> <LocalLeader>f :call IdrisRefine()<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>o :call IdrisProofSearch(0)<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>p :call IdrisProofSearch(1)<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>l :call IdrisMakeLemma()<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>e :call IdrisEval()<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>w 0:call IdrisMakeWith()<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>mc :call IdrisMakeCase()<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>i 0:call IdrisResponseWin()<ENTER>
au FileType idris nnoremap <buffer> <silent> <LocalLeader>h :call IdrisShowDoc()<ENTER>


" ---------------
" PureScript
" ---------------
au FileType purescript nmap <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestion<CR>
au FileType purescript nmap <leader>a :PSCIDEaddTypeAnnotation<CR>
au FileType purescript nmap <leader>i :PSCIDEimportIdentifier<CR>
au FileType purescript nmap <leader>r :PSCIDEload<CR>
au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
au FileType purescript nmap <leader>c :PSCIDEcaseSplit<CR>
au FileType purescript nmap <leader>qd :PSCIDEremoveImportQualifications<CR>
au FileType purescript nmap <leader>qa :PSCIDEaddImportQualifications<CR><Paste>
autocmd FileType purescript setlocal shiftwidth=2 tabstop=2 softtabstop=2


" ---------------
" C
" ---------------
autocmd FileType c setlocal tabstop=4 shiftwidth=4
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

let g:chromatica#libclang_path = '/usr/lib/'
let g:chromatica#highlight_feature_level = 1



" ---------------
" Quick spelling fix (first item in z= list)
" ---------------
function! QuickSpellingFix()
  if &spell
    normal 1z=
  else
    " Enable spelling mode and do the correction
    set spell
    normal 1z=
    set nospell
  endif
endfunction

command! QuickSpellingFix call QuickSpellingFix()
nmap <silent> <leader>z :QuickSpellingFix<CR>

" ---------------
" airline
" ---------------


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"let g:airline_symbols.space = "\ua0"

let g:airline_powerline_fonts = 1


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_linecolumn_prefix = '¶ '
let g:airline#extensions#branch#symbol = '⎇ '
let g:airline#extensions#paste#symbol = 'Þ'
let g:airline#extensions#whitespace#symbol = 'Ξ'

" ---------------
" Key Bindings
" ---------------
" window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" buffers
"nmap <leader>T :enew<cr>
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>




" ---------------
" LLVM Debugging
" ---------------
nmap <M-b> <Plug>LLBreakSwitch
vmap <F2> <Plug>LLStdInSelected
nnoremap <F4> :LLstdin<CR>
nnoremap <F5> :LLmode debug<CR>
nnoremap <S-F5> :LLmode code<CR>
nnoremap <F8> :LL continue<CR>
nnoremap <S-F8> :LL process interrupt<CR>
nnoremap <F9> :LL print <C-R>=expand('<cword>')<CR>
vnoremap <F9> :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>


" --------------
" Syntastic
" --------------

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_loc_list_height = 5
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
"let g:syntastic_javascript_checkers = ['eslint']
"
"let g:syntastic_error_symbol = '✖'
"let g:syntastic_style_error_symbol = '✖'
"let g:syntastic_warning_symbol = 'ℹ'
"let g:syntastic_style_warning_symbol = 'ℹ'
"
"highlight link SyntasticErrorSign SignColumn
"highlight link SyntasticWarningSign SignColumn
"highlight link SyntasticStyleErrorSign SignColumn
"highlight link SyntasticStyleWarningSign SignColumn
"

" ---------------
" Markdown
" ---------------
let g:markdown_composer_browser = "firefox"


" ---------------
" NERD Tree
" ---------------
let NERDTreeMapJumpFirstChild = ''
map <silent> - :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * silent NERDTree | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeMinimalUI = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''



" ---------------
" Neomake
" ---------------
"autocmd! BufWritePost * Neomake
autocmd InsertChange,TextChanged * update | Neomake


" ---------------
" Gitgutter
" ---------------
set updatetime=250

imap jj <Esc>

let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']


" ---------------
" FZF
" ---------------

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"


command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~40%',
  \ 'sink':    'Explore'})


