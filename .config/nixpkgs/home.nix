{ config, pkgs, ... }:
let
  lockCmd = "xlock -erasedelay 0";
in
{

  home.username = "ditadi";
  home.homeDirectory = "/home/ditadi";
  #home.keyboard.options = [ "compose:rctrl" "caps:none" ];

  home.packages = [
    pkgs.htop
    pkgs.kitty # terminal emulator
    pkgs.xclip
    pkgs.hledger # cli accounting
    pkgs.pass # cli accounting
    pkgs.scrot # screenshots
    pkgs.zip
    pkgs.unzip
    pkgs.alsaUtils
    pkgs.spotify
    pkgs.ranger # cli file manager
    pkgs.slack
    pkgs.zathura # pdf viewer
    pkgs.signal-desktop
    pkgs.albert # menu
    pkgs.xlockmore
    pkgs.copyq
  ];


  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    firefox.enable = true;
    feh.enable = true;
    autorandr = {
     enable = true;
     profiles = {
       "default" = {
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
            eDP1 = "00ffffffffffff0028892a4200000000001b0104a51d147803de50a3544c99260f505400000001010101010101010101010101010101b798b8a0b0d03e700820080c25c41000001ab798b8a0b0d041720820080c25c41000001a000000fe004a444920202020202020202020000000fe004c504d3133394d3432324120200039";
            DP1 = "00ffffffffffff0010acbea0424544300f1c0104a5351e783ae245a8554da3260b5054a54b00714f8180a9c0a940d1c0e100d10001014dd000a0f0703e803e3035000f282100001a000000ff0035394a4a34383442304445420a000000fc0044454c4c205032343135510a20000000fd001d4c1e8c36000a202020202020012902031df150101f200514041312110302161507060123091f0783010000565e00a0a0a02950302035000f282100001a023a801871382d40582c25000f282100001e011d007251d01e206e2855000f282100001ea36600a0f0701f80302035000f282100001a0000000000000000000000000000000000000000000000000000eb";
         };
         config = {
           eDP1 = {
             enable = false;
           };
           DP1 = {
             enable = true;
             mode = "3840x2160";
             rate = "60";
           };
         };
       };
     };
     hooks.postswitch = {
       "change-background" = "${pkgs.feh}/bin/feh --bg-fill -z ~/photo/wallpaper";
       "change-dpi" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            default)
              DPI=170
              ;;
            home)
              DPI=170
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
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
    git = {
      enable = true;
      userName = "Dmitriy Tadyshev";
      userEmail = "dmitriy@tadyshev.com";
      signing.key = "3762F98A01D3E704C1CCCF5F2605552C1DF82E49";
      signing.signByDefault = true;
      extraConfig.diff.tool = "kitty";
      extraConfig.diff.guitool = "kitty.gui";
      extraConfig.difftool.prompt = false;
      extraConfig.difftool.trustExitCode = true;
    };
    tmux = {
      enable = true;
      tmuxinator.enable = true;
    };
    browserpass = {
      enable = true;
      browsers = [ "firefox" ];
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
          } ''
            substituteAll ${~/.config/xmonad/xmonad.hs} $out
          '';
      };
      pointerCursor = {
        package = pkgs.paper-icon-theme;
        name = "Paper";
        size = 16;
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

    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };

    screen-locker = {
      enable = true;
      lockCmd = lockCmd;
    };

    compton = {
      enable = true;
      fade = false;
      shadow = true;
      fadeDelta = 4;
      extraOptions = ''
        no-dock-shadow = true;
      '';
    };

    redshift = {
      enable = true;
      latitude = "29.8";
      longitude = "-95.4";
    };
    #xserver = {
    #  enable = true;
    #  layout = "us";
    #  exportConfiguration = true;
    #  windowManager = {
    #    default = "xmonad";
    #    xmonad.enable = true;
    #    xmonad.enableContribAndExtras = true;
    #  };
    #  displayManager.slim = {
    #    enable = true;
    #    theme = pkgs.fetchurl {
    #      url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
    #      sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
    #    };
    #  }; 
    #};
  };


  home.file = {
  ".tmux.conf" = {
  text = ''
# See: https://github.com/christoomey/vim-tmux-navigator

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
| grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

is_fzf="ps -o state= -o comm= -t '#{pane_tty}' \
| grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"

bind -n C-h run "($is_vim && tmux send-keys C-h) || \
               tmux select-pane -L"

bind -n C-j run "($is_vim && tmux send-keys C-j)  || \
               ($is_fzf && tmux send-keys C-j) || \
               tmux select-pane -D"

bind -n C-k run "($is_vim && tmux send-keys C-k) || \
               ($is_fzf && tmux send-keys C-k)  || \
               tmux select-pane -U"

bind -n C-l run "($is_vim && tmux send-keys C-l) || \
               tmux select-pane -R"

# kill current session
bind X confirm-before kill-session

# change the prefix binding to CTRL+A
set -g prefix C-a
unbind C-b


# remove the small delay that tmux introduces
set -sg escape-time 1

# set the window/pane numbering to be base 1 instead of 0
set -g base-index 1
set -g pane-base-index 1

# reload mux 3configuration
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# window numbering always ordered
set-option -g renumber-windows on

# split windows and use same directory
bind \ split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
# kill current pane (and unbind default keybinding for this action)

# resize panes
bind H resize-pane -L 20
bind J resize-pane -D 20
bind K resize-pane -U 20
bind L resize-pane -R 20


# restore clear screen
#bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "send-keys C-l"
#bind-key b send-keys -R \; clear-history
#bind u send-keys C-l \; run-shell "sleep .3s" \; clear-history
#bind-key -n C-l send-keys C-l \; send-keys -R \; clear-history

# mouse
#setw -g mode-mouse on
#set -g mouse-select-pane on
#set -g mouse-resize-pane on
#set -g mouse-select-window on
#@set -g mouse on
#bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e; send-keys -M'"
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X copy-selection
bind-key -T copy-mode-vi y send -X copy-pipe "xclip -selection clipboard -i" \; send -X clear-selection
bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe "xclip -selection clipboard -i" \; send -X clear-selection
bind-key -T copy-mode-vi r send-keys -X rectangle-toggle


set -g mouse on


## color - status bar
#set -g status-fg white
#set -g status-bg default
#
# color - pane split

set -g pane-border-style fg=colour8
set -g pane-active-border-style fg=default
#set -g pane-active-border-style bg=default

# border colours
setw -g monitor-activity on
set -g visual-activity on


set-option -g set-titles on
set-option -g set-titles-string '#S'

set -g status-bg "colour0"
set -g message-command-fg "colour253"
set -g status-justify "left"
set -g status-left-length "100"
set -g status "on"
set -g message-bg "colour16"
set -g status-right-length "100"
set -g status-right-attr "none"
set -g message-fg "colour253"
set -g message-command-bg "colour16"
set -g status-attr "none"
set -g status-left-attr "none"
setw -g window-status-fg "colour253"
setw -g window-status-attr "none"
setw -g window-status-activity-bg "colour0"
setw -g window-status-activity-attr "none"
setw -g window-status-activity-fg "colour144"
setw -g window-status-separator ""
#setw -g window-status-bg "bce"


#set -g default-terminal "screen-256color"

set -g terminal-overrides "xterm*:XT:smcup@:rmcup@"
set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'

set -g  default-terminal "tmux-256color"
set -ga terminal-overrides ",xterm-*:Tc"


# indicate whether Prefix has been captured + time in the right-status area
set -g status-left "#[fg=colour8,bg=colour0] #S"
set -g status-left "#[fg=bce,bg=bce] #S"
#set -g status-right '#[fg=colour144,bg=colour0,nobold,nounderscore,noitalics]#[fg=colour232,bg=colour144]#{?client_prefix,🚀 🚀 🚀,} %H:%M '
set -g status-right ""
setw -g window-status-format "#[fg=colour8,bg=colour0] #I #[fg=colour8,bg=colour0] #W"
#setw -g window-status-format "#[fg=bce,bg=bce] #I #[fg=bce,bg=bce] #W"
setw -g window-status-current-format " #[fg=colour46,bold,bg=colour0]#I #[fg=colour2bg=colour0] #W"
  '';
  };
  };
}
