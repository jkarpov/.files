{ config, pkgs, ... }:
{

  boot.cleanTmpDir = true;

  security.sudo.wheelNeedsPassword = false;

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 139 445 ];
    firewall.allowedUDPPorts = [ 137 138 ];
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
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
    xserver = {
      enable = true;
      xkbOptions = "ctrl:nocaps";
    };
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
    ];
  };


  environment.systemPackages = with pkgs; [
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
  ];
}
