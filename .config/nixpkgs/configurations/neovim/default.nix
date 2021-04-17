{ pkgs, ... }:

let
    plugins = pkgs.vimPlugins // pkgs.callPackage ./plugins.nix {};

    fzf = plugins.fzfWrapper.overrideAttrs (old: {
        postFixup = ''
        substituteInPlace $out/share/vim-plugins/fzf/plugin/fzf.vim \
            --replace "s:base_dir.'/bin/fzf'" "'${pkgs.fzf}/bin/fzf'"
        '';
    });
in
{

  #nixpkgs.overlays = [
  #    (self: super: {
  #      neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldattrs: {
  #        version = "0.5.0";
  #          src = pkgs.fetchFromGitHub {
  #          owner = "neovim";
  #          repo = "neovim";
  #          rev = "36762a00a8010c5e14ad4347ab8287d1e8e7e064";
  #          sha256 = "0n7i3mp3wpl8jkm5z0ifhaha6ljsskd32vcr2wksjznsmfgvm6p4";
  #        };
  #      });
  #    })
  #];

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython = true;
    withPython3 = true;

    configure = {
      customRC = ''source ~/.config/nvim/init.vim'';

      packages.myVimPackages = with plugins; {
        start = [
            fugitive
            vim-gitgutter
            vim-rhubarb

            fzfWrapper
            fzf-vim

            vimproc
            vimproc-vim
            direnv-vim

            neoformat
            gundo
            #vim-better-whitespace
            UltiSnips
            neosnippet-vim
            neosnippet-snippets
            sensible
            vim-unimpaired
            vim-ledger
            tmux-navigator
            vim-tmux-focus-events
            vim-tmux-clipboard

            goyo
            limelight-vim
            lightline-vim
            #eleline.vim
            seiya
            neo-solarized
            solarized8
            ayu
            molokai
            monodark
            mopkai
            github-colorscheme
            gruvbox-haskell

            haskell-vim

            coc-nvim
            coc-tsserver
            #ale
            vim-nix
            vim2nix
            fsharp-vim
            echodoc-vim
            vim-easy-align
            vim-commentary
            vim-obsession
            # file finding in neovim
            neovim-fuzzy
            # deal with trailing whitespace
            lessspace.vim
            #hlsl.vim
            vim-gist
            vim-gnupg
            vim-json
        ];
      };

    };
  };
}
