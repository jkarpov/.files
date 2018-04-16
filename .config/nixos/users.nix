{ config, pkgs, ... }:
{
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  users.extraUsers.dima = {
    uid = 1000;
    isNormalUser = true;
    name = "dima";
    group = "dima";
    extraGroups = [
      "wheel" "disk" "audio" "video" "network-manager" "systemd-journal"
    ];
    createHome = true;
    home = "/home/dima";
    shell = "/run/current-system/sw/bin/zsh";
  };

  users.extraGroups.dima = {
    gid = 1000;
  };
}
