{ config, pkgs, ... }:
{

  users.extraUsers.ditadi = {
    uid = 1000;
    isNormalUser = true;
    name = "ditadi";
    group = "ditadi";
    extraGroups = [
      "wheel" "disk" "audio" "video" "network-manager" "systemd-journal" "docker"
    ];
    createHome = true;
    home = "/home/ditadi";
  };

  users.extraGroups.ditadi = {
    gid = 1000;
  };
}
