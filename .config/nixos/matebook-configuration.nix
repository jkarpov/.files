{ config, pkgs, ... }:
{
  imports =
    [ ./matebook-hardware-configuration.nix
      ./all-packages.nix
      ./all-users.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.enableUnstable = true;

  networking.networkmanager.enable = true;
  networking.hostId = "664d4279";

  networking.nat = {
    enable = true;
    internalInterfaces = [ "wg0" ];
    externalInterface = "wlp60s0";
  };
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.13.13.102/32" ];
      listenPort = 51820;
      privateKey = "eDgfrU1hKqtXNttZJm2ayHHiuF2FGG+V7LyecA92uHs=";
      allowedIPsAsRoutes = false;
      peers = [
        {
          publicKey = "bcPctKwpG9Wp0SE1I5jxoXdUjd1Kct+58VzsagJdjyg=";
          presharedKey = "Hz4xwmyJZvr224QVn5wNxj/oUgO5kOSXXP3yrVRQAjY=";
          allowedIPs = [ "10.13.13.1" ];
          endpoint = "lfo6dacsshyqo.southcentralus.cloudapp.azure.com:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  services.zfs.autoSnapshot = {
    enable = true;
    frequent = 16; # keep the latest eight 15-minute snapshots (instead of four)
    monthly = 12;  # keep only one monthly snapshot (instead of twelve)
  };


  time.timeZone = "US/Central";
  networking.hostName = "matebook";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.extraConfig = "
    [General]
    Enable=Source,Sink,Media,Socket
  ";
  hardware.bumblebee.enable = false;
  services.upower.enable = true;
  services.logind.lidSwitch = "suspend";

  services.xserver = {
    synaptics = {
      enable = true;
      palmDetect = true;
      twoFingerScroll = true;
      minSpeed = "1.0";
      maxSpeed = "2.0";
    };
    videoDrivers = [ "intel" ];
  };

  #hardware.nvidia.optimus_prime.enable = true;
  #hardware.nvidia.optimus_prime.nvidiaBusId = "PCI:1:0:0";
  #hardware.nvidia.optimus_prime.intelBusId = "PCI:0:2:0";
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    xorg.xbacklight
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
