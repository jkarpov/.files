{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.username = "ditadi";
  home.homeDirectory = "/home/ditadi";

  home.packages = with pkgs; [
    hledger
    hledger-ui
    hledger-web
    zip
    unzip
    ranger
    gnupg
    fzy
    ripgrep
    nodePackages.node2nix
    mitmproxy
    tmux
    tmuxinator
  ];

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;

      extraConfig = ''
set nocompatible


syntax on
syntax enable
filetype plugin indent on


" --------------- 
"  Interface
" ---------------
set ruler
set nonumber
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
"set termguicolors
set colorcolumn=80
set noshowmode
set background=dark
"set background=light
set shell=/bin/sh

if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

"colorscheme molokai
let g:seiya_auto_enable=1
if &diff
  let g:seiya_auto_enable=0
  colorscheme github
endif
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
"colorscheme molokai

"let ayucolor="mirage"
"let ayucolor="dark"
"let ayucolor="light"
"let g:airline_theme='solarized'
colorscheme ayu
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
set tabstop=2
set backspace=2
set shiftwidth=2
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

set completeopt=menuone,noinsert,noselect


let mapleader=","
let maplocalleader=","



lua << EOF
local nvim_lsp = require('lspconfig')
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) 
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Haskell Language Server
nvim_lsp.hls.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = { 'haskell-language-server-wrapper', '--lsp' },
    settings = {
        haskell = {
            formattingProvider = 'brittany'
        }
    },
    capabilities = capabilities,
}

-- Nix
nvim_lsp.hls.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = { 'haskell-language-server-wrapper', '--lsp' },
    settings = {
        haskell = {
            formattingProvider = 'brittany'
        }
    },
    capabilities = capabilities,
}

nvim_lsp.rnix.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF


" ---------------
" treesitter
" ---------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {},
  },
}
EOF



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


let g:ledger_bin="hledger"
autocmd BufEnter,BufNew *.hledger* set filetype=ledger


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



noremap y "+y
noremap p "+p
noremap Y "*y
noremap P "*p

set clipboard+=unnamedplus


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
'';

      extraPackages = with pkgs; [
        gcc
        tree-sitter

        # Needed by Telescope
        bat
        fd
        ripgrep

        # Various language servers
        #rust-analyzer
        #nodePackages.bash-language-server
        #nodePackages.svelte-language-server
        #clang-tools
        #nodePackages.vscode-css-languageserver-bin
        #nodePackages.dockerfile-language-server-nodejs
        #gopls
        #nodePackages.vscode-html-languageserver-bin
        #nodePackages.pyright
        rnix-lsp
        haskellPackages.tree-sitter-haskell
        #terraform-ls
        #nodePackages.typescript
        #nodePackages.typescript-language-server
        deno
      ];

      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        (nvim-treesitter.withPlugins (
          p:
          [
            p.tree-sitter-bash
            p.tree-sitter-c
            p.tree-sitter-css
            p.tree-sitter-html
            p.tree-sitter-java
            p.tree-sitter-javascript
            p.tree-sitter-jsdoc
            p.tree-sitter-json
            p.tree-sitter-lua
            p.tree-sitter-markdown
            p.tree-sitter-nix
            p.tree-sitter-python
            p.tree-sitter-regex
            p.tree-sitter-ruby
            p.tree-sitter-rust
            p.tree-sitter-typescript
            p.tree-sitter-yaml
            p.tree-sitter-haskell
          ]
        )
        )
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        nvim-cmp

        cmp-vsnip
        vim-vsnip
        lsp_signature-nvim
        telescope-nvim
        fugitive
        vim-gitgutter
        vim-rhubarb
        fzfWrapper
        fzf-vim
        direnv-vim
        gundo
        tmux-navigator
        lightline-vim
        vim-nix
        vim2nix
        #vim-easy-align
        #vim-commentary
        #vim-obsession
        neovim-ayu
        molokai
        NeoSolarized
      ];
    };


    home-manager.enable = true;
    direnv.enable = true;
    direnv.enableZshIntegration = true;
    fzf.enable = true;
    jq.enable = true;
    htop.enable = true;

    gpg.enable = true;
    password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "/home/ditadi/.password-store";
      };
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      history = {
        share = false;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        extended = true;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "colorize" "colored-man-pages" ];
        theme = "bira";
      };

      sessionVariables = {
        EDITOR = "nvim";
        SSH_AUTH_SOCK = "$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)";
        LEDGER_FILE = "/home/ditadi/notes/current.journal";
        DISABLE_AUTO_TITLE = true;
        #PASSWORD_STORE_DIR = "$($HOME/.password-store)";
      };

      shellAliases = {
        ".." = "cd ..";
        "ll" = "ls -l";
        "mux" = "tmuxinator";
        "dot" = "git --git-dir=$HOME/.files/ --work-tree=$HOME";
        "r" = "ranger";
        "gd" = "git difftool --no-symlinks --dir-diff";
      };
      #initExtra = builtins.readFile ../zsh/zshrc;
    };

    git = {
      enable = true;
      userName = "Dmitriy Tadyshev";
      userEmail = "dmitriy@tadyshev.com";
      signing.key = "3762F98A01D3E704C1CCCF5F2605552C1DF82E49";
      signing.signByDefault = false;
    };
  };

  services = {
    password-store-sync.enable = true;
    lorri.enable = true;

    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 900;
      maxCacheTtl = 7200;
      defaultCacheTtlSsh = 3600;
      maxCacheTtlSsh = 86400;
      enableExtraSocket = true;
      sshKeys = [
        "9C6B531D7F8F5B250E863FD52990013F0E0B92FB"
      ];
    };
  };
}
