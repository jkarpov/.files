{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { home-manager, nixpkgs, ... }: {

    nixosConfigurations.sea = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./hardware-configuration.sea.nix
        ./configuration.sea.nix 
        ./users.nix 
        home-manager.nixosModules.home-manager 
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ditadi = import ./home.ditadi.nix;
        }
      ];
    };

    nixosConfigurations.ec2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.ec2.nix 
        ./users.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ditadi = import ./home.ditadi.nix; 
        }
	    ];
    };

  };
}
