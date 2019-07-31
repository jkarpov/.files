{ pkgs, ... }:

let
  plugins = pkgs.callPackage ./plugins.nix {};
in
{
  allowUnfree = true;
  allowBroken = true;


  nixpkgs.overlays = [
      (self: super: {
        neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldattrs: {
          version = "0.4.0";
        src = pkgs.fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            rev = "36762a00a8010c5e14ad4347ab8287d1e8e7e064";
            sha256 = "0n7i3mp3wpl8jkm5z0ifhaha6ljsskd32vcr2wksjznsmfgvm6p4";
          };
        });
      })
  ];


  programs.neovim = {
    vimAlias = true;
    withPython = true;
    withPython3 = true;
    configure = {
      customRC = ''source ~/.config/nvim/init.vim'';

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
              "vim-rhubarb"

              # files
              "fzfWrapper"
              "fzf-vim"

              "vimproc"
              "vimproc-vim"
              "direnv-vim"

              "neoformat"
              "gundo"
              "vim-better-whitespace"
              "UltiSnips"
              "neosnippet-vim"
              "neosnippet-snippets"
              "sensible"
              "vim-unimpaired"
              "vim-ledger"
              "tmux-navigator"
              "vim-tmux-focus-events"
              "vim-tmux-clipboard"

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

              "coc-nvim"
              "deoplete-nvim"
              "ale"
              "LanguageClient-neovim"
              "vim-nix"
              "vim2nix"
              "fsharp-vim"
              "echodoc-vim"
              #"vim-markdown"
              #"vim-pandoc"
              #"vim-pandoc-syntax"
              "latex-live-preview"
              "csv"
              "vim-easy-align"
              "vim-commentary"
              "vim-obsession"
              "neovim-fuzzy"
              "lessspace.vim"
              "hlsl.vim"
              "gist-vim"
              "vim-gnupg"
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



  #$packageOverrides = pkgs: rec {

  #$  #ml = pkgs.python35.withPackages (ps: with ps; [ scikitlearn numpy pandas matplotlib ]);

  #$  #weechat = pkgs.weechat.override { extraBuildInputs = [ pkgs.python27Packages.websocket_client ]; };
  #$  #xpra = pkgs.xpra.override { };
  #$  fake-cli = pkgs.stdenv.mkDerivation {
  #$    name = "dotnet-fake-cli";
  #$    buildInputs = [
  #$      pkgs.dotnet-sdk
  #$    ];
  #$    src = null;
  #$    shellHook = ''
  #$      dotnet --version
  #$    '';
  #$  };



  #$  haskellPackages = pkgs.haskellPackages.override {
  #$    overrides = self: super:
  #$    {
  #$      pandoc-citeproc = pkgs.haskell.lib.dontCheck super.pandoc-citeproc;
  #$    };
  #$  };

  #$};
}
