set nocompatible


" ---------------
" Dein
" ---------------

" interface
"call dein#add('ryanoasis/vim-devicons')
"call dein#add('tpope/vim-unimpaired')
"call dein#add('iCyMind/NeoSolarized')
"call dein#add('ayu-theme/ayu-vim')
"call dein#add('jacoborus/tender.vim')

" git
"call dein#add('tpope/vim-sensible')
"call dein#add('tpope/vim-commentary')

"call dein#add('miyakogi/seiya.vim')


"call dein#add('Shougo/denite.nvim')
"call dein#add('Shougo/vimfiler')


"util
"call dein#add('airblade/vim-gitgutter')
"call dein#add('diepm/vim-rest-console')


" lang
"
"call dein#add('w0rp/ale')
"call dein#add('itchyny/vim-haskell-indent')
""call dein#add('mpickering/hlint-refactor-vim')
"
"call dein#add('jez/vim-better-sml')
"
""call dein#add('lervag/vimtex')
"
"
"call dein#add('idris-hackers/idris-vim')
"call dein#add('raichoo/purescript-vim')
"call dein#add('FrigoEU/psc-ide-vim')


syntax on
filetype plugin indent on


" ---------------
" Interface
" ---------------
set ruler
set number
set nowrap
set laststatus=2
set cmdheight=1
autocmd BufEnter * set nocursorline
autocmd BufLeave * set nocursorline
set showmatch
set matchtime=2
set mousehide
set mouse=a
"set noerrorbells
"set novisualbell
"set termguicolors

set background=dark

colorscheme molokai
hi Normal guibg=NONE ctermbg=NONE
highlight clear LineNr
highlight clear SignColumn
highlight LineNr ctermfg=DarkGrey
"let g:airline_theme='monochrome'

"colorscheme gruvbox
"let g:airline_theme='gruvbox'
"let g:gruvbox_italic=1

"colorscheme NeoSolarized
"let g:airline_theme='solarized'
"let g:neosolarized_bold = 1
"let g:neosolarized_underline = 0
"let g:neosolarized_italic = 1

"colorscheme ayu
"let ayucolor="mirage"
"let ayucolor="dark"
"let ayucolor="light"
"let g:airline_theme='solarized'

"colorscheme ratazii

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
set linespace=0
"set inccommand=split

" ---------------
" Behavior
" ---------------
set splitbelow
set splitright
set hidden

set backup
set backupdir=~/.nvim/backup
set directory=~/.nvim/temp
set backspace=indent,eol,start

set shiftround
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set relativenumber

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

set completeopt=longest,menuone
"Amount of entries in completion popup
"set pumheight=10
"
let g:deoplete#max_menu_width = -1
"autocmd FileType purescript setlocal shiftwidth=2 tabstop=2 softtabstop=2

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
"imap <expr><TAB>
"	 \ neosnippet#expandable_or_jumpable() ?
"	 \    "\<Plug>(neosnippet_expand_or_jump)" :
"         \ 	  pumvisible() ? "\<C-n>" : "\<TAB>"
"
" deoplete tab-complete
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


"ultisnips
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"




" ---------------
" Haskell
" ---------------

"let g:haddock_browser="chromium"
let g:haskellmode_completion_ghc = 0

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc


"let g:haskell_conceal_wide = 1
"let g:haskell_multiline_strings = 1
let g:necoghc_enable_detailed_browse = 1


au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>ti :GhcModInfoPreview<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>te :GhcModExpand<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>tt :GhcModType<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>tc :GhcModTypeClear<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>ta :GhcModTypeInsert<CR>

au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>sg :GhcModSigCodegen<CR>
au FileType haskell,lhaskell nnoremap <buffer> <silent> <LocalLeader>s :GhcModSplitFunCase<CR>



let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords



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
"autocmd FileType c setlocal tabstop=4 shiftwidth=4
"let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
"let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
"
"let g:chromatica#libclang_path = '/usr/lib/'
"let g:chromatica#highlight_feature_level = 1



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
" Key Bindings
" ---------------
" window movement

let g:tmux_navigator_no_mappings = 0
" The following mappings work when nvim is NOT inside tmux
nnoremap <S-Up>    :TmuxNavigateUp<CR>
nnoremap <S-Down>  :TmuxNavigateDown<CR>
nnoremap <S-Left>  :TmuxNavigateLeft<CR>
nnoremap <S-Right> :TmuxNavigateRight<CR>
" These mappings are used when nvim IS inside tmux
nnoremap <C-W>k    :TmuxNavigateUp<CR>
nnoremap <C-W>j    :TmuxNavigateDown<CR>
nnoremap <C-W>h    :TmuxNavigateLeft<CR>
nnoremap <C-W>l    :TmuxNavigateRight<CR>


"nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" buffers
"nmap <leader>T :enew<cr>
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

nmap <leader>ep <Plug>(ale_previous_wrap)
nmap <leader>en <Plug>(ale_next_wrap)



" ---------------
" Markdown
" ---------------
"let g:markdown_composer_browser = "chromium"


" ---------------
" Gitgutter
" ---------------
set updatetime=250

imap jj <Esc>


" ---------------
" Git
" ---------------
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gD :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gL :exe ':!cd ' . expand('%:p:h') . '; git la'<CR>
nnoremap <Leader>gl :exe ':!cd ' . expand('%:p:h') . '; git las'<CR>
nnoremap <Leader>gh :silent Glog<CR>:set nofoldenable<CR>
nnoremap <Leader>gH :silent Glog<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>g- :silent Git stash<CR>:e<CR>
nnoremap <Leader>g+ :silent Git stash pop<CR>:e<CR>o

" ---------------
" FZF
" ---------------
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

" ---------------
" Goyo - distraction free editing
" ---------------
let g:goyo_height = 88
let g:goyo_width = 100

" Leader shortcut for enabling Goyo
nnoremap <Leader>f :Goyo<CR>

" Ensure :q quits when Goyo is active
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  Limelight
  set noshowmode
  set noshowcmd
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
  Limelight!
  set showmode
  set showcmd
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

let g:ledger_bin="hledger"
autocmd BufEnter,BufNew *.hledger* set filetype=ledger


"----
" Ale
""-----
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_column_always = 1


set hidden

let g:LanguageClient_serverCommands = {
      \ 'haskell': ['hie', '--lsp'], 
      \ }


set guicursor=
set termguicolors
