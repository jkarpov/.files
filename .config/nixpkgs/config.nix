{ pkgs }:

let
  plugins = pkgs.callPackage ./plugins.nix {};
in
{
  allowUnfree = true;


  packageOverrides = pkgs: rec {

    #weechat = pkgs.weechat.override { extraBuildInputs = [ pkgs.python27Packages.websocket_client ]; };
    xpra = pkgs.xpra.override { };

    neovim = pkgs.neovim.override {
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

                # files
                "fzfWrapper"
                "fzf-vim"

                "vimproc"
                "vimproc-vim"

                "neoformat"
                "gundo"
                "UltiSnips"
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
                "gruvbox-haskell"

                "vim-trailing-whitespace"
                "deoplete-nvim"
                "ale"
                "LanguageClient-neovim"
                "nvim-completion-manager"
                "vim-nix"
                "vim2nix"

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
