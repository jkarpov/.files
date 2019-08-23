set nocompatible


syntax on
syntax enable
filetype plugin indent on


" --------------- Interface
" ---------------
set ruler
set number
set nowrap
set laststatus=2
autocmd BufEnter * set nocursorline
autocmd BufLeave * set nocursorline
set showmatch
set matchtime=2
set signcolumn=yes
set mousehide
set mouse=a
set noerrorbells
set novisualbell
set nonumber
set guicursor=
set termguicolors
set colorcolumn=80
set noshowmode
set background=dark
set shell=/bin/sh
"set background=light

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"colorscheme molokai
let g:seiya_auto_enable=0
if &diff
  let g:seiya_auto_enable=0
  colorscheme github
endif
colorscheme monodark

"let g:gruvbox_italic=1
"colorscheme gruvbox


"let g:neosolarized_bold = 1
"let g:neosolarized_underline = 1
"let g:neosolarized_italic = 1
"let g:neosolarized_contrast = "medium"
"let g:solarized_visibility = "medium"
"let g:solarized_extra_hi_groups=1
"let g:airline_theme='solarized'
"colorscheme NeoSolarized
"let g:solarized_use16 = 1
"colorscheme solarized8
"
"colorscheme mopkai
"colorscheme molokai

"let ayucolor="mirage"
"let ayucolor="dark"
"let ayucolor="light"
"let g:airline_theme='solarized'
"colorscheme ayu
"
"highlight clear LineNr
"highlight clear SignColumn
"highlight LineNr ctermfg=DarkGrey
"

" ---------------
" Text format
" ---------------
set encoding=utf-8
set cindent
set autoindent
set smarttab
set expandtab
set tabstop=4
set backspace=2
set shiftwidth=4
set linespace=0
"set inccommand=split

" ---------------
" Behavior
" ---------------
set splitbelow
set splitright
set hidden
set noswapfile
set nobackup

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

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

let mapleader=","
let maplocalleader=","

" ---------------
" coc
" ---------------

set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ }
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" ---------------
" deoplete
" ---------------
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#file#enable_buffer_path = 1
"let g:deoplete#enable_ignore_case = 'ignorecase'
"let g:deoplete#enable_smart_case = 'infercase'
"let g:deoplete#data_directory = '~/.cache/deoplete/'
"
"  " Don't squash types
"call deoplete#custom#source('_', 'converters', [])
"call deoplete#custom#source('LanguageClient', 'min_pattern_length', 1)

" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"    return deoplete#mappings#smart_close_popup() . "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
"set completeopt=longest,menuone
"set completeopt+=noinsert
"set completeopt+=noselect


"Amount of entries in completion popup
"set pumheight=10
let g:deoplete#max_menu_width = -1



" ---------------
" NeoSnippet
" ---------------
"
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
	 \ neosnippet#expandable_or_jumpable() ?
	 \    "\<Plug>(neosnippet_expand_or_jump)" :
     \ 	  pumvisible() ? "\<C-n>" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


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
let g:markdown_composer_browser = "firefox"


" ---------------
" Gitgutter
" ---------------
set updatetime=250



" ---------------
" Git
" ---------------
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
"nnoremap <Leader>gd :Gdiff<CR>
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
nnoremap <Leader>ss :silent Git stash<CR>:e<CR>
nnoremap <Leader>sa :silent Git stash apply<CR>:e<CR>o
nnoremap <Leader>sp :silent Git stash pop<CR>:e<CR>o
nnoremap <Leader>sl :Git stash list<CR>:e<CR>o

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" ---------------
" FZF
" ---------------
"nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FuzzyOpen\<cr>"
nnoremap <Leader><Leader> :FuzzyOpen<CR>
"nnoremap <Leader>e :FuzzyGrep<CR>
"nnoremap <silent> <expr> <Leader><Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FuzzyGrep\<cr>"

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
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign
let g:ale_sign_column_always = 1


"\ 'haskell': ['hie', '--lsp'],
let g:LanguageClient_serverCommands = {
      \ 'fsharp': ['dotnet', '/home/ditadi/code/fsprojects/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp2.0/FSharpLanguageServer.dll'],
      \ 'python': ['pyls'],
      \ }

let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

"highlight Type gui=bold
"highlight operator gui=bold
"highlight Operator gui=bold
"highlight Structure gui=bold
"highlight Keyword gui=bold


"set foldmethod=indent
"set foldlevel=5
"set foldclose=all

let g:livepreview_previewer = 'zathura'

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,fsharp,python call SetLSPShortcuts()
augroup END
autocmd FileType haskell,cpp,c,fsharp,python call SetLSPShortcuts()

"let g:echodoc#enable_at_startup = 1
"
:imap jj <Esc>

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p


"set noshowmode
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'


" Don't highlight whitespace
let g:better_whitespace_enabled=0
let g:strip_whitespace_on_save=1

set shortmess+=c

autocmd BufWrite *.md silent execute "! touch /tmp/bufwrite"
set autoread

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"fu! SaveSess()
"    execute 'mksession! ' . getcwd() . '/.session.vim'
"endfunction
"
"fu! RestoreSess()
"if filereadable(getcwd() . '/.session.vim')
"    execute 'so ' . getcwd() . '/.session.vim'
"    if bufexists(1)
"        for l in range(1, bufnr('$'))
"            if bufwinnr(l) == -1
"                exec 'sbuffer ' . l
"            endif
"        endfor
"    endif
"endif
"endfunction
"
"autocmd BufEnter,VimLeavePre * call SaveSess()
"autocmd VimEnter * nested call RestoreSess()

"noremap y "+y
"noremap p "+p
"noremap Y "*y
"noremap P "*p
"
set clipboard+=unnamedplus

"function! ClipboardYank()
"  call system('kitty +kitten clipboard', @@)
"endfunction
"function! ClipboardPaste()
"  let @@ = system('kitty +kitten clipboard --get-clipboard')
"endfunction
"
"vnoremap <silent> y y:call ClipboardYank()<cr>
"vnoremap <silent> d d:call ClipboardYank()<cr>
"nnoremap <silent> p :call ClipboardPaste()<cr>p
"
" nnoremap <Leader> :GundoToggle<CR>

if has('NVIM')
    let s:editor_root=expand("~/.config/nvim")
else
    let s:editor_root=expand("~/.vim")
endif

" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory(s:editor_root . '/backup') == 0
  call mkdir(s:editor_root . '/backup', 'p')
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
execute "set backupdir^=" . s:editor_root . '/backup//'
set backupdir^=./.vim-backup//
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory(s:editor_root . '/swap') == 0
  call mkdir(s:editor_root . '/swap', 'p')
endif
set directory=./.vim-swap//
execute "set directory+=" . s:editor_root . '/swap//'
set directory+=~/tmp//
set directory+=.

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory(s:editor_root . '/undo') == 0
    call mkdir(s:editor_root . '/undo', 'p')
  endif
  set undodir=./.vim-undo//
  execute "set undodir+=" . s:editor_root . '/undo//'
  set undofile
endif

set hidden

set tabpagemax=1000

set ffs=unix,dos

if has('nvim')
  set inccommand=nosplit
endif

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" viminfo / shada
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tell vim to remember certain things when we exit
"  '100  :  marks will be remembered for up to 10 previously edited files
"  "1000 :  will save up to 100 lines for each register
"  :200  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='1000,\"1000,:200,%,n~/.viminfo

if has('nvim')
  set shada='1000,/1000,:1000,@1000
endif

function! ResCur()
  if line("'\"") <= line("$")
    normal! g'"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

let g:pandoc#syntax#codeblocks#embeds#langs = ["ruby","fsharp", "bash=sh"]


hi link ALEError Error
hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
hi link ALEWarning Warning
hi link ALEInfo SpellCap


let g:vim_json_syntax_conceal = 0
