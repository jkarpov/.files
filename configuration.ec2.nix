{ modulesPath, pkgs, ... }: 

{
  imports = [ 
	  "${modulesPath}/virtualisation/amazon-image.nix" 
  ];

  ec2.hvm = true;
  systemd.services.amazon-init.enable = false;
  networking.hostName = "ec2";  

  services.tailscale.enable = true;
  networking.firewall.allowedUDPPorts = [ 41641 ];
  environment.systemPackages = [ pkgs.tailscale ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

}
