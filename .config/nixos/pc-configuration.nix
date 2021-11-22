# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./pc-hardware-configuration.nix
      ./all-packages.nix
      ./all-users.nix
    ];

  boot.loader.grub.devices = [ "/dev/nvme1n1" "/dev/nvme2n1" ];
  boot.loader.grub.splashImage = null;
  boot.loader.grub.configurationLimit = 1;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.enableUnstable = true;
  nixpkgs.system = "x86_64-linux";

  networking.hostId = "dec1f65b";

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "US/Central";
  networking.hostName = "pc";

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    ports = [ 22 2222 ];
    forwardX11 = false;
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  services.zfs.autoSnapshot = {
    enable = true;
    frequent = 16; # keep the latest eight 15-minute snapshots (instead of four)
    monthly = 12; # keep only one monthly snapshot (instead of twelve)
  };

  services.tailscale.enable = true;

  virtualisation = {
    docker.enable = true;
    virtualbox.guest = {
      enable = false;
      x11 = false;
    };
    virtualbox.host = {
      enable = false;
      headless = true;
    };
  };

  users.extraGroups.vboxusers.members = [ "ditadi" ];
  users.groups.libvirtd.members = [ "ditadi" ];

  environment.systemPackages = [ pkgs.tailscale ];

  system.stateVersion = "20.09";
}
