{ config, pkgs, ... }:
let
  lockCmd = "xlock -mode blank -erasedelay 0";
  #batch-explorer = pkgs.callPackage ./batch-explorer.nix { };
  #nuget = pkgs.callPackage ./nuget.nix { };
  #pkgsUnstable = import <nixpkgs-unstable> {};

in rec {

  imports = with builtins;
    map (name: ./configurations + "/${name}") (attrNames (readDir ./configurations));

  nixpkgs.config.allowUnfree = true;


  home.username = "ditadi";
  home.homeDirectory = "/home/ditadi";

  home.packages = with pkgs; [
    hledger hledger-ui hledger-web
    scrot
    zip unzip
    alsaUtils
    spotify
    ranger
    slack
    albert # menu

    xlockmore
    xclip
    copyq

    gnupg
    inotify-tools
    fzy
    ripgrep
    #batch-explorer
    discord
    postman

    vlc
    mitmproxy
    tmux-mine
    tmuxinator
    #haskellPackages.arbtt
    google-chrome

    #cortex-cli

    #sqlpackage
    #fsharp10
    #msbuild
    zoom-us
    libreoffice
  ];


  programs = {
    neovim.enable = true;
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    obs-studio.enable = true;
    firefox.enable = true;
    qutebrowser.enable = true;
    feh.enable = true;
    direnv.enable = true;
    direnv.enableZshIntegration = true;
    fzf.enable = true;
    jq.enable = true;
    alacritty.enable = true;
    zathura.enable = true;
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

    browserpass = {
      enable = true;
      browsers = [ "firefox" ];
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      #defaultKeymap = "vicmd";
      #dotDir = ".config/zsh";
      history.share = false;
      history.expireDuplicatesFirst = true;
      history.ignoreDups = true;
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

    autorandr = {
     enable = true;
     profiles = {
       "laptop" = {
         fingerprint = {
           eDP1 = "00ffffffffffff0028892a4200000000001b0104a51d147803de50a3544c99260f505400000001010101010101010101010101010101b798b8a0b0d03e700820080c25c41000001ab798b8a0b0d041720820080c25c41000001a000000fe004a444920202020202020202020000000fe004c504d3133394d3432324120200039";
         };
         config = {
           eDP1 = {
             enable = true;
             mode = "3000x2000";
             rate = "60";
           };
         };
       };

       "work" = {
         fingerprint = {
           DP1 = "00ffffffffffff0010acbea0424544300f1c0104a5351e783ae245a8554da3260b5054a54b00714f8180a9c0a940d1c0e100d10001014dd000a0f0703e803e3035000f282100001a000000ff0035394a4a34383442304445420a000000fc0044454c4c205032343135510a20000000fd001d4c1e8c36000a202020202020012902031df150101f200514041312110302161507060123091f0783010000565e00a0a0a02950302035000f282100001a023a801871382d40582c25000f282100001e011d007251d01e206e2855000f282100001ea36600a0f0701f80302035000f282100001a0000000000000000000000000000000000000000000000000000eb";
           eDP1 = "00ffffffffffff0028892a4200000000001b0104a51d147803de50a3544c99260f505400000001010101010101010101010101010101b798b8a0b0d03e700820080c25c41000001ab798b8a0b0d041720820080c25c41000001a000000fe004a444920202020202020202020000000fe004c504d3133394d3432324120200039";
         };
         config = {
           eDP1 = {
             enable = false;
           };
           DP1 = {
             mode = "3840x2160";
             rate = "60";
           };
         };
       };

       "5k2k" = {
         fingerprint = {
            #DP-0 = "00ffffffffffff001e6d2077a53c0200021d0104b55021789e09c1ae5044af260e50542108007140818081c0a9c0d1c0810001010101e77c70a0d0a0295030203a00204a3100001a9d6770a0d0a0225030203a00204a3100001a000000fd00303d1e874c000a202020202020000000fc004c472048445220354b0a20202002e50203197144900403012309070783010000e305c000e30605014dd000a0f0703e803020650c204a3100001a286800a0f0703e800890650c204a3100001a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e37012790300030028701d0186ff136801188060006f083d002f000800b88e0086ff136801188060006f083d002f000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ab90";
            DP-2 = "00ffffffffffff001e6d2077a53c0200021d0104b55021789e09c1ae5044af260e50542108007140818081c0a9c0d1c0810001010101e77c70a0d0a0295030203a00204a3100001a9d6770a0d0a0225030203a00204a3100001a000000fd00303d1e874c000a202020202020000000fc004c472048445220354b0a20202002e50203197144900403012309070783010000e305c000e30605014dd000a0f0703e803020650c204a3100001a286800a0f0703e800890650c204a3100001a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e37012790300030028701d0186ff136801188060006f083d002f000800b88e0086ff136801188060006f083d002f000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ab90";
         };
         config = {
           DP-2 = {
             enable = true;
             mode = "5120x2160";
             rate = "60.00";
           };
         };
       };

       "4k" = {
         fingerprint = {
            DP-2 = "00ffffffffffff0028892a4200000000001b0104a51d147803de50a3544c99260f505400000001010101010101010101010101010101b798b8a0b0d03e700820080c25c41000001ab798b8a0b0d041720820080c25c41000001a000000fe004a444920202020202020202020000000fe004c504d3133394d3432324120200039";
         };
         config = {
           DP-2 = {
             enable = true;
             mode = "3840x2160";
             rate = "60";
           };
         };
       };
     };
     hooks.postswitch = {
       "restart-xmonad" = "xmonad --restart";
       "kill-albert" = "pkill albert";
       "change-background" = "${pkgs.feh}/bin/feh --bg-fill -z ~/photo/wallpaper";
       "change-dpi" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            laptop)
              DPI=170
              ;;
            4k)
              DPI=135
              ;;
            5k2k)
              DPI=133
              ;;
            work)
              DPI=135
              ;;
            *)
              echo "Unknown profle: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac

          echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        '';
      };
    };
    git = {
      enable = true;
      userName = "Dmitriy Tadyshev";
      userEmail = "dmitriy@tadyshev.com";
      signing.key = "3762F98A01D3E704C1CCCF5F2605552C1DF82E49";
      signing.signByDefault = true;
      ignores = [ "shell.nix" ".envrc" "local.appsettings.json" ];
    };
  };

  xsession = {
      enable = true;
      preferStatusNotifierItems = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmobar
        ];
        config = pkgs.runCommand "xmonad.hs" {
          lockCmd = lockCmd;
          xmobar = "${pkgs.haskellPackages.xmobar}/bin/xmobar";
          albert = "${pkgs.albert}/bin/albert";
          } ''
            substituteAll ${~/.config/xmonad/xmonad.hs} $out
          '';
      };
      pointerCursor = {
        package = pkgs.paper-icon-theme;
        name = "Paper";
        size = 24;
      };
      initExtra = ''
        autorandr -c
      '';
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
      #pinentryFlavor = "qt";
      #extraConfig = ''
      #  pinentry-program ${pkgs.pinentry.qt}/bin/pinentry
      #'';
    };

    screen-locker = {
      enable = true;
      lockCmd = lockCmd;
    };

    #compton = {
    #  enable = false;
    #  fade = false;
    #  shadow = false;
    #  fadeDelta = 4;
    #};

    redshift = {
      enable = true;
      latitude = "29.8";
      longitude = "-95.4";
    };
  };

  xdg.configFile."direnv/direnvrc".text = ''
    use_nix () {
        eval "$(lorri direnv)"
    }
  '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/x-pdf" = "org.pwmt.zathura.desktop";

      "text/csv" = "calc.desktop";
      "text/x-csv" = "calc.desktop";
      "text/plain" = "nvim.desktop";
      "text/x-script.python" = "nvim.desktop";
      "text/x-script.sh" = "nvim.desktop";
      "text/html" = "nvim.desktop";
      "text/css" = "nvim.desktop";
      "text/xml" = "nvim.desktop";

      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/chrome" = "org.qutebrowser.qutebrowser.desktop";

      "x-scheme-handler/postman" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/zoommtg" = "us.zoom.Zoom.desktop";
    };
    #associations.added = {
    #  "text/x-emacs-lisp" = "emacs.desktop";
    #  "text/plain" = "emacs.desktop";
    #  "text/html" = "org.gnome.gedit.desktop";
    #};
  };

  home.file = {
    ".tmux.conf".source = ../tmux/tmux.conf;
    ".tmuxinator".source = ../tmuxinator;
  };
}
