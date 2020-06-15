# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
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
  nixpkgs.overlays =
      [ (self: super:
        {
          # override with newer version from nixpkgs-unstable
          qemu = super.qemu.overrideAttrs (old: rec {
            patches = old.patches ++ [ ./qemu.patch ];
          });
        })
      ];

  time.timeZone = "US/Central";
  networking.hostName = "tadyshev";

  services.openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
      ports = [ 22 2222 ];
      forwardX11 = false;
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    #screenSection = ''
      #Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    #'';
  };

  services.zfs.autoSnapshot = {
    enable = true;
    frequent = 16; # keep the latest eight 15-minute snapshots (instead of four)
    monthly = 12;  # keep only one monthly snapshot (instead of twelve)
  };

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
    libvirtd = {
      enable = true;
      #onBoot = "ignore";
      onShutdown = "shutdown";
      extraOptions = [ "--verbose" ];
      qemuVerbatimConfig = ''
          namespaces = []
          user = "ditadi"
          group = "kvm"
          cgroup_device_acl = [
              "/dev/null", "/dev/full", "/dev/zero",
              "/dev/random", "/dev/urandom",
              "/dev/ptmx", "/dev/kvm",
              "/dev/rtc","/dev/hpet",
              "/dev/input/by-path/pci-0000:44:00.3-usb-0:4:1.0-event-kbd",
              "/dev/input/by-path/pci-0000:44:00.3-usb-0:3.1:1.2-event-mouse"
          ]
      '';
    };
  };

  users.extraGroups.vboxusers.members = [ "ditadi" ];
  users.groups.libvirtd.members = [ "ditadi" ];

  environment = {
    systemPackages = with pkgs; [
      ntfs3g
      virtmanager
      #looking-glass-client
    ];
    variables = {
        #QT_AUTO_SCREEN_SCALE_FACTOR= "2";
        QT_SCALE_FACTOR = "1.25";
    };
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ditadi qemu-libvirtd -"
  ];

  system.stateVersion = "19.09";
}
