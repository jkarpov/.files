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
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  hardware = {
    enableAllFirmware = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.support32Bit = true;
  };

  services = {
    timesyncd.enable = true;
    xserver = {
      enable = false;
      xkbOptions = "ctrl:nocaps";
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  #fonts = {
  #  enableFontDir = true;
  #  enableGhostscriptFonts = true;
  #  fonts = with pkgs; [
  #    #corefonts
  #    inconsolata
  #    #hasklig
  #    #fira-code
  #    #powerline-fonts
  #    #ttf_bitstream_vera
  #    #dejavu_fonts
  #    #vistafonts
  #    #terminus_font
  #    #latinmodern-math
  #    #hack-font
  #  ];
  #};

  # zsh completion for system wide packages e.g., systemd
  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
  ];
}
