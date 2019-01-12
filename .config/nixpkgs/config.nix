{ pkgs }:

let
  plugins = pkgs.callPackage ./plugins.nix {};
in
{
  allowUnfree = true;

  packageOverrides = pkgs: rec {

    #weechat = pkgs.weechat.override { extraBuildInputs = [ pkgs.python27Packages.websocket_client ]; };
    #xpra = pkgs.xpra.override { };

    neovim = pkgs.neovim.override {
      vimAlias = true;
      withPython = true;
      withPython3 = true;
      configure = {
        #customRC = ''source ~/.config/nvim/init.vim'';
        customRC = ''
          " vimrc
          if &compatible
            set nocompatible
          endif
          set hidden


          syntax on
          syntax enable
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
          set noerrorbells
          set novisualbell
          set guicursor=
          set termguicolors
          set background=dark
          "set background=light

          let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
          let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

          "colorscheme molokai

          let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

          let g:seiya_auto_enable=0
          "colorscheme monodark

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

          "let ayucolor="mirage"
          let ayucolor="dark"
          "let ayucolor="light"
          "let g:airline_theme='solarized'
          colorscheme ayu


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
          set noswapfile
          set nobackup
          set noshowmode

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

          let g:LanguageClient_serverCommands = {
              \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
              \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
              \ 'c': ['cquery', '--log-file=/tmp/cquery.log'],
              \ 'cpp': ['cquery', '--log-file=/tmp/cquery.log'],
              \ 'haskell': ['hie', '--lsp'],
              \ 'python': ['pyls'],
              \ 'fsharp': ['dotnet', '/home/ditadi/github/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp2.0/FSharpLanguageServer.dll']
              \ }
          " Automatically start language servers.
          let g:LanguageClient_autoStart = 1
          " Autoformat key map
          nmap <Leader>f :Autoformat<CR>
          nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
          nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
          nnoremap <silent> gr :call LanguageClient_textDocument_rename()<CR>
          " Enable omni completion.
          autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS shiftwidth=2 tabstop=2
          autocmd FileType html,markdown,liquid setlocal omnifunc=htmlcomplete#CompleteTags shiftwidth=2 tabstop=2
          autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS shiftwidth=2 tabstop=2
          autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
          autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags shiftwidth=2 tabstop=2
          autocmd FileType pug setlocal shiftwidth=2 tabstop=2
          " deoplete
          let g:deoplete#sources#go#gocode_binary = "/home/savage/.go/bin/gocode"
          
          let g:deoplete#enable_at_startup = 1
          if !exists('g:deoplete#omni#input_patterns')
            let g:deoplete#omni#input_patterns = {}
          endif
          " let g:deoplete#disable_auto_complete = 1
          autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
          "
          " latex stuff
          let g:livepreview_engine = 'xelatex' . ' '
          " path to clang lib file

          au FileType c,cpp,objc,objcpp setl omnifunc=clang_complete#ClangComplete

          " deoplete tab-complete
          inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
          let python_highlight_all=1
          syntax on
          if has('autocmd')
              filetype plugin indent on
          endif
          if has('syntax')
              syntax enable
          endif
          set autoindent
          set backspace=indent,eol,start
          set complete-=i
          set smarttab
          set nrformats-=octal
          set ttimeout
          set ttimeoutlen=100
          set incsearch
          set tabstop=4
          set shiftwidth=4
          set expandtab
          nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
          set laststatus=2
          set ruler
          set showcmd
          set wildmenu
          set display+=lastline
          set encoding=utf-8


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

"imap jj <Esc>


" ---------------
" Git
" ---------------
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
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
nnoremap <Leader>ss :silent Git stash<CR>:e<CR>
nnoremap <Leader>sa :silent Git stash apply<CR>:e<CR>o
nnoremap <Leader>sp :silent Git stash pop<CR>:e<CR>o
nnoremap <Leader>sl :Git stash list<CR>:e<CR>o

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" ---------------
" FZF
" ---------------
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : "").":FZF\<cr>"


" ---------------
" UltiSnips
" ---------------
" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" ---------------
" LangaugeClient
" ---------------
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" ---------------
" DEBUG
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

        '';
        #customRC = ''
        #  syntax on
        #'';
        vam = {
          knownPlugins = pkgs.vimPlugins // plugins;
          pluginDictionaries = [
            # git
            { names = [
                # git
                "fugitive"
                "vim-gitgutter"

                # files
                "fzfWrapper"
                "fzf-vim"

                "vimproc"
                "vimproc-vim"

                "neoformat"
                "gundo"
                "UltiSnips"
                "vim-snippets"
                "sensible"
                "vim-unimpaired"
                "vim-ledger"
                "tmux-navigator"

                #themes
                "goyo"
                "limelight-vim"
                "seiya"
                "neo-solarized"
                "solarized8"
                "ayu"
                "molokai"
                "monodark"
                "mopkai"
                "github-colorscheme"
                "gruvbox-haskell"

                "vim-trailing-whitespace"
                "deoplete-nvim"
                "ale"
                "LanguageClient-neovim"
                "nvim-completion-manager"
                "vim-nix"
                "vim2nix"
                "lldb"

                "fsharp-vim"
                "vim-pandoc"
                "vim-pandoc-syntax"
                "latex-live-preview"
                "csv"
                "echodoc-vim"

                #{ name = "vim-airline"; }
                #{ name = "vim-auto-save"; }
                #{ name = "vim-airline-themes"; }
              ];
            }

            # Haskell
            { ft_regex = "^haskell\$";
              names = [
                "haskell-vim"
                "Hoogle"
                "ghcmod"
                "neco-ghc"
                "vim-stylish-haskell"
                "hlint-refactor"
                "Tagbar"
                #"vim-textobj-haskell"
              #{ name = "lushtags"; }
              ];
            }


            { tag = "lazy";
              names = [
                 "vim-rhubarb"
              ];
            }

          ];


        };
      };
    };
  };
}
