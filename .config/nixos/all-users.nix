{ config, pkgs, ... }:
{
  users.defaultUserShell = pkgs.bash;
  users.extraUsers.ditadi = {
    uid = 1000;
    isNormalUser = true;
    name = "ditadi";
    group = "ditadi";
    extraGroups = [
      "wheel" "disk" "audio" "video"
      "network-manager" "systemd-journal"
      "docker"
    ];
    createHome = true;
    home = "/home/ditadi";
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfzW8cMR/+eRv7tCWc7GZ/DmmzjhowgogBgm//Xi4r7yfwJyzOkWyMR/CLFQR/83qRRZV3VteSF3R8HYNjL4Rl6lYCN5pRUbcAgU9ZXxeEAVGXDVHUr2rxNBDfIzimFDCiwRQzM2XOoCEEd2oi7FyXGJ+VV16LqKkSmDtPfN9BP+bUYVRqzDY57Y6Mjlv0G66T5GegyJ/lEI5sL/Y5wVtIOcHkSMkpq4QhW6X8CIYsQrve2Derx/d2pqWDhuMhxi+D8P2x0KjztwIHuNjxRP8sHg/e4jC1+ambu/OwqRDQfdYM8yK5AUt9PRR5pd9myPHtKlkuXZsKdPMhgmlvemA5 dmitriy@tadyshev.com"
    ];
  };

  users.extraGroups.ditadi = {
    gid = 1000;
  };
}
