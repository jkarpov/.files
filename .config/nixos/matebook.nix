{ config, pkgs, ... }:
{
  imports =
    [ ./matebook-hardware.nix
      ./packages.nix
      ./users.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];

  boot.initrd.luks.cryptoModules = [ "aes" "xts" "sha512" ];
  boot.initrd.luks.yubikeySupport = true;
  boot.initrd.luks.devices = [ {
    name = "luksroot";
    device = "/dev/sda2";
    preLVM = true;
    yubikey = {
      storage = {
        device = "/dev/sda1";
      };
    };
  } ];

  time.timeZone = "US/Central";

  networking.hostName = "matebook";

  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.logind.extraConfig = "HandleLidSwitch=hibernate";
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.synaptics = {
    enable = true;
    palmDetect = true;
    twoFingerScroll = true;
  };

  environment.systemPackages = with pkgs; [
    xorg.xbacklight
  ];
}
