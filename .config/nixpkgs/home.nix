{ config, pkgs, ... }:
let
  #pkgsUnstable = import <nixpkgs-unstable> {};
  easy-hls-src = pkgs.fetchFromGitHub {
    owner  = "jkachmar";
    repo   = "easy-hls-nix";
    rev    = "0cc4e5893a3e1de3456e3c91bc8dfdebad249dc1";
    sha256 = "nu3HCXSie7yfMhj2h7wCtsEYTrzrBiVE7kdFg0SsV8o=";
  };
  easy-hls = pkgs.callPackage easy-hls-src {};

in rec {

  imports = with builtins;
    map (name: ./configurations + "/${name}") (attrNames (readDir ./configurations));

  nixpkgs.config.allowUnfree = true;

  home.username = "ditadi";
  home.homeDirectory = "/home/ditadi";

  home.packages = with pkgs; [
    hledger hledger-ui hledger-web
    zip unzip
    #awscli2
    ranger
    gnupg
    fzy
    ripgrep
    nodePackages.node2nix
    mitmproxy
    #tmux-mine
    tmux
    tmuxinator
    #haskellPackages.arbtt
  ];


  programs = {
    neovim.enable = true;
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
      #defaultKeymap = "vicmd";
      #dotDir = ".config/zsh";
      #editor = "vi";
      history.share = false;
      history.expireDuplicatesFirst = true;
      history.ignoreDups = true;
      history.extended = true;
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [ "git" "sudo" "colorize" "colored-man-pages" ];
      oh-my-zsh.theme = "bira";

      sessionVariables = {
        EDITOR = "nvim";
        SSH_AUTH_SOCK = "$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)";
        LEDGER_FILE = "/home/ditadi/notes/current.journal";
        DISABLE_AUTO_TITLE = true;
        #HISTCONTROL = "ignoreboth:erasedups";
        #PASSWORD_STORE_DIR = "$($HOME/.password-store)";
      };

      shellAliases = {
        ".." = "cd ..";
        "ll" = "ls -l";
        "mux" = "tmuxinator";
        "dot" = "git --git-dir=$HOME/.files/ --work-tree=$HOME";
        "r" = "ranger";
        # diff two files in a terminal
        "d" = "kitty +kitten diff";
        # do git diff in a termial
        "gd" = "git difftool --no-symlinks --dir-diff";
        "home-update" = "home-manager -I nixpkgs=/nix/var/nix/profiles/per-user/$USER/channels/nixpkgs-unstable switch";
      };
      initExtra = builtins.readFile ../zsh/zshrc;
    };

    git = {
      enable = true;
      userName = "Dmitriy Tadyshev";
      userEmail = "dmitriy@tadyshev.com";
      signing.key = "3762F98A01D3E704C1CCCF5F2605552C1DF82E49";
      signing.signByDefault = false;
      ignores = [ "shell.nix" ".envrc" "local.appsettings.json" ];
    };
  };

  services = {
    #openssh = {
    #  enable = true;
    #  permitRootLogin = "no";
    #  passwordAuthentication = false;
    #  ports = [ 22 2222 ];
    #};
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

  xdg.configFile."direnv/direnvrc".text = ''
    use_nix () {
        eval "$(lorri direnv)"
    }
  '';

  home.file = {
    ".tmux.conf".source = ../tmux/tmux.conf;
    ".tmuxinator".source = ../tmuxinator;
  };
}
