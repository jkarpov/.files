{ config, pkgs, ... }:
{
  imports =
    [ ./pc-hardware.nix
      ./packages.nix
      ./users.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda3";
      preLVM = true;
    }
  ];

  time.timeZone = "US/Central";

  networking.hostName = "pc";

  security.wrappers = { slock = { source = "${pkgs.slock}/bin/slock"; }; };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    #screenSection = ''
    #$  Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    #'';
  };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "dima" ];

  environment.systemPackages = with pkgs; [
    nixopsUnstable
    steam
    irssi
    qemu
    ntfs3g
    linuxPackages.virtualbox
    awscli
    azure-cli
    nodejs
  ];

}
