{ config, pkgs, ... }:
{
  #users.defaultUserShell = pkgs.bash;
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
    #useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfzW8cMR/+eRv7tCWc7GZ/DmmzjhowgogBgm//Xi4r7yfwJyzOkWyMR/CLFQR/83qRRZV3VteSF3R8HYNjL4Rl6lYCN5pRUbcAgU9ZXxeEAVGXDVHUr2rxNBDfIzimFDCiwRQzM2XOoCEEd2oi7FyXGJ+VV16LqKkSmDtPfN9BP+bUYVRqzDY57Y6Mjlv0G66T5GegyJ/lEI5sL/Y5wVtIOcHkSMkpq4QhW6X8CIYsQrve2Derx/d2pqWDhuMhxi+D8P2x0KjztwIHuNjxRP8sHg/e4jC1+ambu/OwqRDQfdYM8yK5AUt9PRR5pd9myPHtKlkuXZsKdPMhgmlvemA5 dmitriy@tadyshev.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzc40HdmNxpX7gyu5OPc/JbSJZgfqsDTTWhq7jurA/rBF/eN12qGEdrK3uF++6AdABiAnJugmuDbYGjcBN/xSp21OWMYYh/c2CYsVQKQjPV5CXwqL+82OdIOJdvXv4s/jfqh/Sb0LXaoi2mYZ6SnGfkhsoycuQh12A5VKNcGeSPzMcvcpv/5+glLSlJPyVWyXKG1mn5smHKCzPJAhijVgPbvVDPPyIjmQTwUI0O41GXeqOB115nmp5YgsSrYK/P8y6lt+wyB70oVBHrCLadDwUv9NHW1JfsE5iDw3Pq88PexGrrzXvxbELy1NMEA7+oZMZjHtknWEQNQT+zMb+P0K7sduA5nQN1dNaHMDMPTKfngs54xVayhIEyxQys1iTmUHc/lJcX1OG/seLMKz+vuXE+lJbNNQNPrysfjojob9/TnSw4Jc7CNttAdN1qIogF+aI0L+FshUAoDH2QQ96xiWVdEo/iubuRfn/1Ctg4h25pu+Ip72Oc0MsAvZi91EkCpjyZk0B6j84NJS6Ng4VWIm7k6PR1FL01vrKAbdP/CjkMtRNA2ROHpKd0b/TR19BMMSv5AF9Woq27KD3Updp7CXYS7Ff94KvsYyhq0TDCo40ukThvoKfe7u1h+o5vJAPSxiaBYc9fY3a+nuvM5lpSEVzUVs9qHM9UbFayuWchkwVNw== dmitriy@tadyshev.com"
    ];
  };

  users.extraGroups.ditadi = {
    gid = 1000;
  };
}
