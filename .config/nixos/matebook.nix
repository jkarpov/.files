# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./matebook-hardware.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 # boot.kernelPackages = pkgs.linuxPackages_4_14_24;

  # Minimal list of modules to use the efi system partition and the YubiKey
  boot.initrd.kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];

  # Crypto setup, set modules accordingly
  boot.initrd.luks.cryptoModules = [ "aes" "xts" "sha512" ];

  # Enable support for the YubiKey PBA
  boot.initrd.luks.yubikeySupport = true;
  # Configuration to use your Luks device
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

  # File systems
  swapDevices = [ { device = "/dev/partitions/swap"; } ];

  fileSystems."/" = {
    label = "root";
    device = "/dev/partitions/fsroot";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  fileSystems."/home" = {
    label = "home";
    device = "/dev/partitions/fsroot";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };
  
  fileSystems."/boot" =
  { device = "/dev/disk/by-uuid/5806-A791";
    fsType = "vfat";
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  #
  # User account.
  #

  # Enable Netowrking.
  networking = {
    hostName = "matebook";
    wireless.enable = false;    
    networkmanager.enable = true;
    #firewall.enable = true;
    #firewall.allowPing = true;
    #firewall.allowedTCPPorts = [ 22 80 443 587 ];
  };
  
  programs = {
    zsh = {
      enable = true;
    }; 
  };
  
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

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

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
