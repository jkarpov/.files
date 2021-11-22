{ config, pkgs, ... }:
{

  boot.cleanTmpDir = true;

  security.sudo.wheelNeedsPassword = false;

  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      allowedTCPPorts = [ 22 ];
      interfaces."tailscale0".allowedTCPPorts = [
        80
        443
        8080
        5000
      ];
    };

    hosts = {
      "172.31.98.1" = [ "aruba.odyssys.net" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nix = {
      trustedUsers = [ "root" "ditadi" ];
  };


  hardware = {
    enableAllFirmware = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
    #pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.support32Bit = true;
  };

  services = {
    #fail2ban.enable = true;
    timesyncd.enable = true;
    xserver = {
      enable = false;
      xkbOptions = "ctrl:nocaps";
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
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
      hack-font
    ];
  };


  # zsh completion for system wide packages e.g., systemd
  environment.pathsToLink = [ "/share/zsh" ];

  environment.systemPackages = with pkgs; [
  ];
}
