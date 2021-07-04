{ config, pkgs, ... }:
let
  #lockCmd = "xlock -mode blank -erasedelay 0";
  #batch-explorer = pkgs.callPackage ./batch-explorer.nix { };
  #nuget = pkgs.callPackage ./nuget.nix { };
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
    #scrot
    zip unzip
    awscli2
    #alsaUtils
    #spotify
    ranger
    #slack
    #albert # menu

    #xlockmore
    #xclip
    #copyq

    gnupg
    #inotify-tools
    fzy
    ripgrep
    #batch-explorer
    #discord
    #postman
    nodePackages.node2nix


    #vlc
    mitmproxy
    tmux-mine
    tmuxinator
    #haskellPackages.arbtt
    #google-chrome

    #cortex-cli

    #sqlpackage
    #fsharp10
    #msbuild
    #zoom-us
    #libreoffice
  ];


  programs = {
    neovim.enable = true;
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    #obs-studio.enable = true;
    #firefox.enable = true;
    #qutebrowser.enable = true;
    #feh.enable = true;
    direnv.enable = true;
    direnv.enableZshIntegration = true;
    fzf.enable = true;
    jq.enable = true;
    #alacritty.enable = true;
    #zathura.enable = true;
    htop.enable = true;

    gpg.enable = true;
    password-store = {
      enable = true;
      settings = {
          PASSWORD_STORE_DIR = "/home/ditadi/.password-store";
      };
    };

    #tmux = {
    #  enable = true;
    #  tmuxinator.enable = true;
    #};

    irssi = {
      enable = true;
      networks = {
        freenode = {
          nick = "ditadi";
          server = {
            address = "chat.freenode.net";
            port = 6697;
            autoConnect = true;
            ssl = {
              enable = true;
              verify = true;
            };
          };
          channels = {
            nixos.autoJoin = true;
            haskell.autoJoin = true;
            hledger.autoJoin = true;
          };
        };
      };
      extraConfig = ''
        ignores = ({
          level = "JOINS PARTS QUITS NICKS";
          channels = ("#nixos", "#haskell", "#hledger");
        });
      '';
    };

    #browserpass = {
    #  enable = true;
    #  browsers = [ "firefox" ];
    #};

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
    #bash = {
    #  enable = true;
    #  enableAutojump = true;
    #  historyControl = [ "ignoredups" "erasedups" ];
    #  historyIgnore = [ "ls" "cd" "exit" ];
    #  profileExtra = "if [ -f ~/.bashrc ]; then\n . ~/.bashrc\n fi";
    #  shellAliases = {
    #    ".." = "cd ..";
    #    "ll" = "ls -l";
    #    "mux" = "tmuxinator";
    #    "dot" = "git --git-dir=$HOME/.files/ --work-tree=$HOME";
    #    "r" = "ranger";
    #    # diff two files in a terminal
    #    "d" = "kitty +kitten diff";
    #    # do git diff in a termial
    #    "gd" = "git difftool --no-symlinks --dir-diff";
    #  };
    #  initExtra = builtins.readFile ../bash/bashrc;
    #};

    git = {
      enable = true;
      userName = "Dmitriy Tadyshev";
      userEmail = "dmitriy@tadyshev.com";
      signing.key = "3762F98A01D3E704C1CCCF5F2605552C1DF82E49";
      signing.signByDefault = true;
      ignores = [ "shell.nix" ".envrc" "local.appsettings.json" ];
    };
  };

  #xsession = {
  #    enable = false;
  #    preferStatusNotifierItems = true;
  #    windowManager.xmonad = {
  #      enable = true;
  #      enableContribAndExtras = true;
  #      extraPackages = haskellPackages: [
  #        haskellPackages.xmonad-contrib
  #        haskellPackages.xmobar
  #      ];
  #      config = pkgs.runCommand "xmonad.hs" {
  #        lockCmd = lockCmd;
  #        xmobar = "${pkgs.haskellPackages.xmobar}/bin/xmobar";
  #        albert = "${pkgs.albert}/bin/albert";
  #        } ''
  #          substituteAll ${~/.config/xmonad/xmonad.hs} $out
  #        '';
  #    };
  #    pointerCursor = {
  #      package = pkgs.paper-icon-theme;
  #      name = "Paper";
  #      size = 24;
  #    };
  #    initExtra = ''
  #      autorandr -c
  #    '';
  #};

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
      #pinentryFlavor = "qt";
      #extraConfig = ''
      #  pinentry-program ${pkgs.pinentry.qt}/bin/pinentry
      #'';
    };

    #screen-locker = {
    #  enable = true;
    #  lockCmd = lockCmd;
    #};

    #compton = {
    #  enable = false;
    #  fade = false;
    #  shadow = false;
    #  fadeDelta = 4;
    #};

    #redshift = {
    #  enable = true;
    #  latitude = "29.8";
    #  longitude = "-95.4";
    #};
  };

  xdg.configFile."direnv/direnvrc".text = ''
    use_nix () {
        eval "$(lorri direnv)"
    }
  '';

  #xdg.mimeApps = {
  #  enable = true;
  #  defaultApplications = {
  #    "application/pdf" = "org.pwmt.zathura.desktop";
  #    "application/x-pdf" = "org.pwmt.zathura.desktop";

  #    "text/csv" = "calc.desktop";
  #    "text/x-csv" = "calc.desktop";
  #    "text/plain" = "nvim.desktop";
  #    "text/x-script.python" = "nvim.desktop";
  #    "text/x-script.sh" = "nvim.desktop";
  #    "text/html" = "nvim.desktop";
  #    "text/css" = "nvim.desktop";
  #    "text/xml" = "nvim.desktop";

  #    "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
  #    "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
  #    "x-scheme-handler/chrome" = "org.qutebrowser.qutebrowser.desktop";

  #    "x-scheme-handler/postman" = "org.qutebrowser.qutebrowser.desktop";
  #    "x-scheme-handler/zoommtg" = "us.zoom.Zoom.desktop";
  #  };
  #  #associations.added = {
  #  #  "text/x-emacs-lisp" = "emacs.desktop";
  #  #  "text/plain" = "emacs.desktop";
  #  #  "text/html" = "org.gnome.gedit.desktop";
  #  #};
  #};

  home.file = {
    ".tmux.conf".source = ../tmux/tmux.conf;
    ".tmuxinator".source = ../tmuxinator;
  };
}
