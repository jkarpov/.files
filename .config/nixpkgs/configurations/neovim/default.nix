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

    plugins = with plugins; [
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
      #neovim-ayu
      molokai
      NeoSolarized
    ];

  };
}
