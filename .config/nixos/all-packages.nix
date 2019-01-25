{ config, pkgs, ... }:
{

  boot.cleanTmpDir = true;

  security.sudo.wheelNeedsPassword = false;
  security.wrappers = { slock = { source = "${pkgs.slock}/bin/slock"; }; };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 139 445 ];
    firewall.allowedUDPPorts = [ 137 138 ];
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
      binaryCaches = [
        "https://cache.nixos.org/"
        "https://cachix.cachix.org"
        "https://nixcache.reflex-frp.org"
        "http://hydra.qfpl.io"
        "https://hie-nix.cachix.org"
      ];
      binaryCachePublicKeys = [
        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
        "qfpl.io:xME0cdnyFcOlMD1nwmn6VrkkGgDNLLpMXoMYl58bz5g="
        "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      ];
      trustedUsers = [ "root" "ditadi" ];
  };


  hardware = {
    enableAllFirmware = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
  };

  services = {
    timesyncd.enable = true;
    #printing.enable = true;
    samba.enable = true;
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
      ports = [ 22 2222 ];
    };
    #offlineimap = {
    #  install = true;
    #  enable = true;
    #  path = [ pkgs.python pkgs.gnupg pkgs.pass pkgs.bash ];
    #  onCalendar = "*:0/2";
    #};
    compton = {
      enable = true;
      fade = false;
      shadow = true;
      fadeDelta = 4;
      extraOptions = ''
        clear-shadow = true;
        no-dock-shadow = true;
      '';
    };
    redshift = {
      enable = true;
      latitude = "29.8";
      longitude = "-95.4";
    };
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:nocaps";
      exportConfiguration = true;
      windowManager = {
        default = "xmonad";
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
      };
      displayManager.slim = {
        enable = true;
        theme = pkgs.fetchurl {
          url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
          sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
        };
      }; };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.ultimate.enable = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      hasklig
      fira-code
      powerline-fonts
      ttf_bitstream_vera
      dejavu_fonts
     # nerdfonts
      vistafonts
      terminus_font
      latinmodern-math
      cm_unicode
      bakoma_ttf
    ];
  };


  environment.systemPackages = with pkgs; [
    slim slock albert

    # cli
    gnupg
    nodejs gnumake cabal2nix
    dmenu fuse

    spotify
    slack zathura
    signal-desktop

    (texlive.combine {
        inherit (texlive)
        #scheme-minimal # plain
        #scheme-basic   # + latex
        #scheme-small   # + xetex
        #scheme-medium  # + packages
        scheme-full    # + more packages
        adjustbox algorithm2e anyfontsize
        babel babel-greek booktabs boondox
        bussproofs caption cbfonts ccicons
        cleveref cmap collectbox collection-fontsrecommended
        collection-pictures comment dejavu
        doublestroke draftwatermark enumitem
        environ etoolbox euenc everypage
        filehook float fontaxes fontspec
        gfsartemisia gfsbaskerville gfsdidot
        gfsneohellenic greek-fontenc greektex
        inconsolata latexmk libertine listings
        mathpartir mdwtools metafont microtype
        ms mweights ncctools newtx relsize soul
        stmaryrd textcase totpages trimspaces
        ucs upquote xcolor xetex xstring ;
    })

    (pkgs.haskellPackages.ghcWithPackages (self : [
      self.cabal-install
      #self.cabal-helper
      self.xmobar
      #self.yeganesh
      #self.ghc
     ]))
  ];
}
