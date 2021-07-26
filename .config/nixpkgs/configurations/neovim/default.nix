{ pkgs, ... }:

let
    plugins = pkgs.vimPlugins;

    fzf = plugins.fzfWrapper.overrideAttrs (old: {
        postFixup = ''
        substituteInPlace $out/share/vim-plugins/fzf/plugin/fzf.vim \
            --replace "s:base_dir.'/bin/fzf'" "'${pkgs.fzf}/bin/fzf'"
        '';
    });
in
{

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;

    extraConfig = ''source ~/.config/nvim/myinit.vim'';

    extraPackages = with pkgs; [
        gcc
        tree-sitter

        # Needed by Telescope
        bat
        fd
        ripgrep

        # For nvim-dap
        #lldb

        # Various language servers
        #rust-analyzer
        nodePackages.bash-language-server
        nodePackages.svelte-language-server
        #clang-tools
        nodePackages.vscode-css-languageserver-bin
        nodePackages.dockerfile-language-server-nodejs
        #gopls
        nodePackages.vscode-html-languageserver-bin
        nodePackages.pyright
        rnix-lsp
        haskellPackages.tree-sitter-haskell
        #terraform-ls
        #nodePackages.typescript
        #nodePackages.typescript-language-server
      ];

    plugins = with plugins; [
      # 0.5
      #nvim-lspconfig
      nvim-lspconfig
            (
              nvim-treesitter.withPlugins (
                grammars:
                  [
                    # TODO: package tree-sitter-comment
                    grammars.tree-sitter-bash
                    grammars.tree-sitter-c
                    grammars.tree-sitter-cpp
                    grammars.tree-sitter-css
                    grammars.tree-sitter-go
                    grammars.tree-sitter-html
                    grammars.tree-sitter-java
                    grammars.tree-sitter-javascript
                    grammars.tree-sitter-jsdoc
                    grammars.tree-sitter-json
                    grammars.tree-sitter-lua
                    grammars.tree-sitter-markdown
                    grammars.tree-sitter-nix
                    grammars.tree-sitter-php
                    grammars.tree-sitter-python
                    grammars.tree-sitter-regex
                    grammars.tree-sitter-ruby
                    grammars.tree-sitter-rust
                    grammars.tree-sitter-tsx
                    grammars.tree-sitter-typescript
                    grammars.tree-sitter-yaml
                    grammars.tree-sitter-haskell
                  ]
              )
            )

      nvim-compe
      lspsaga-nvim

      #nvim-treesitter

      # below .5
      #fugitive
      #vim-gitgutter
      #vim-rhubarb

      fzfWrapper
      fzf-vim

      #vimproc
      #vimproc-vim
      direnv-vim

      #neoformat
      gundo
      #UltiSnips
      #neosnippet-vim
      #neosnippet-snippets
      #sensible
      #vim-unimpaired
      tmux-navigator
      #vim-tmux-focus-events
      #vim-tmux-clipboard

      #goyo
      #limelight-vim
      lightline-vim
      #eleline.vim
      #solarized8
      #ayu
      molokai

      #haskell-vim

      #coc-nvim
      #coc-tsserver
      #ale
      vim-nix
      vim2nix
      #echodoc-vim
      #vim-easy-align
      #vim-commentary
      #vim-obsession
      # file finding in neovim
      #neovim-fuzzy
      # deal with trailing whitespace
      #hlsl.vim
      #vim-json
    ];

  };
}
