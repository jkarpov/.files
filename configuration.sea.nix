{ config, pkgs, ... }:
{
  boot = {
    supportedFilesystems = [ "btrfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services = {
    tailscale.enable = true;
    timesyncd.enable = true;
    xserver = {
      enable = false;
      xkbOptions = "ctrl:nocaps";
      videoDrivers = [ "nvidia" ];
    };
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
      ports = [ 22 2222 ];
      forwardX11 = false;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking.hostName = "sea";
  networking.hostId = "dec1f65b";
  time.timeZone = "America/Los_Angeles";
  system.stateVersion = "21.11"; 
}
