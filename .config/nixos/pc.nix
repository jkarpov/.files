{ config, pkgs, ... }:
let
  keymap = pkgs.writeText "keymap.xkb" ''
      xkb_keymap {
        xkb_keycodes  { include "evdev+aliases(qwerty)"  };
        xkb_types     { include "complete"	};
        xkb_compat    { include "complete"	};
        xkb_symbols   {
          include "pc+us+inet(evdev)+ctrl(nocaps)"
          key <TAB> { [ Escape ] };
          key <ESC> { [ Tab, ISO_Left_Tab ] };
        };
        xkb_geometry  { include "pc(pc104)"	};
      };
    '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./pc-hardware.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.cleanTmpDir = true;


  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda3";
      preLVM = true;
    }
  ];

  boot.loader.grub.device = "/dev/sda";

  hardware = {
    enableAllFirmware = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    sane.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.sane.snapscanFirmware = pkgs.fetchurl {
    # https://wiki.ubuntuusers.de/Scanner/Epson_Perfection/#Unterstuetzte-Geraete
    url = "https://media-cdn.ubuntu-de.org/wiki/attachments/52/46/Esfw41.bin"; #Epson Perfection 2480
    sha256 = "00cv25v4xlrgp3di9bdfd07pffh9jq2j0hncmjv3c65m8bqhjglq";
  };
  #nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  #nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # System
    slim
    #wpa_supplicant_gui
    #wayland
    #xwayland
    #sway

    # Fonts
    hasklig
    fira-code

    # CLI
    #rxvt_unicode
    kitty
    zsh
    tmuxinator
    #oh-my-zsh
    #neovim
    python36Packages.glances
    htop
    xclip
    wget
    git
    tree
    feh
    cabal2nix
    gnumake
    slock
    jq
    dos2unix
    weechat
    hledger
    neomutt
    msmtp
    notmuch
    notmuch-mutt
    pass
    gnupg
    pgcli
    #texlive

    # Development
    #stack

    # GUI
    dmenu
    firefox
    spotify
    slack
    zathura

    xorg.xkbcomp

    #haskellPackages.xmobar
    #haskellPackages.yeganesh


    # Haskell Packages
    (pkgs.haskell.packages.ghc822.ghcWithPackages (self : [
      self.cabal-install
      self.cabal-helper
      self.xmobar
      self.yeganesh
      self.ghc
     ]))

  ];

  environment.interactiveShellInit = ''
    export FZF_DEFAULT_OPTS="--extended --color=light --reverse"
  '';

  security.wrappers = { slock = { source = "${pkgs.slock}/bin/slock"; }; };

  # Enable Netowrking.
  networking = {
    hostName = "td";
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowPing = true;
    firewall.allowedTCPPorts = [ 22 80 443 587 ];
  };

  # Enabled Services
  services = {
    # Enable the OpenSSH daemon.
    sssd.enable = true;
    openssh.enable = true;

    # Email
    offlineimap = {
      install = true;
      enable = true;
      path = [ pkgs.python pkgs.gnupg pkgs.pass pkgs.bash ];
      onCalendar = "*:0/2";
    };

    # PostgreSQL
    postgresql = {
      enable = true;
      package = pkgs.postgresql96;
    };


    # Enable Compton compositor
    compton = {
      enable = true;
      fade = true;
      #inactiveOpacity = "0.9";
      shadow = true;
      fadeDelta = 4;
      extraOptions = ''
        clear-shadow = true;
        no-dock-shadow = true;
      '';
    };

    # Enable warm colors at night
    redshift = {
      enable = true;
      latitude = "41.9";
      longitude = "-87.6";
    };

    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:nocaps";
      exportConfiguration = true;

      # Enable Proprietery Nvidia Drivers
      videoDrivers = [ "nvidia" ];
      #videoDrivers = [ "nouveau" ];
      screenSection = ''
        Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      '';

      # Enable XMonad Desktop Environment
      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
      };

      # When X started, load the customized one
      displayManager.sessionCommands = ''
        ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${keymap} $DISPLAY
      '';

      displayManager.slim = {
        enable = true;
        #theme = pkgs.fetchurl {
        #  url = "https://github.com/jagajaga/nixos-slim-theme/archive/2.0.tar.gz";
        #  sha256 = "0lldizhigx7bjhxkipii87y432hlf5wdvamnfxrryf9z7zkfypc8";
        #};
        theme = pkgs.fetchurl {
          url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
          sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
        };
      };
    };

  };

 environment.etc."X11/keymap.xkb".source = keymap;

  fonts = {
    fontconfig.ultimate.enable = true;
    enableFontDir = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      hasklig
      powerline-fonts
      nerdfonts
      vistafonts
      terminus_font
    ];

  };

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  programs = {

    vim.defaultEditor = true;

    gnupg.agent.enable = true;

    tmux = {
      enable = true;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "af-magic";
        plugins = [
          "common-aliases"
          "compleat"
          "cabal"
          "git"
          "git-extras"
          "sudo"
          "systemd"
          "tmux"
          "tmuxinator"
          "vi-mode"
          "dirhistory"
          "dirpersisthistory"
          "zsh-autosuggestions"
          "colored-man-pages"
          "colorize"
          "pass"
        ];
      };
      shellInit = ''
        unsetopt beep
      '';
      interactiveShellInit = ''
        export HISTSIZE=1000
        export SAVEHIST=50000
        export KEYTIMEOUT=10
        setopt autocd extended_glob
        setopt hist_ignore_space
        setopt hist_ignore_dups
        unsetopt share_history
      '';
    };
  };

  # User account.
  users.extraUsers.dima = {
    name = "dima";
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video" "network-manager" "systemd-journal"
    ];
    createHome = true;
    uid = 1000;
    home = "/home/dima";
    shell = "/run/current-system/sw/bin/zsh";
  };

  ## Enable CUPS to print documents.
  ## services.printing.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "18.03";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;

}
