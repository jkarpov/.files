self: super: {

  ## Albert Fix for firefox bookmarks
  #albert = super.albert.overrideAttrs (old: rec {
  #  version = "0.16.1";
  #  src = super.fetchFromGitHub {
  #    owner  = "ditadi";
  #    repo   = "albert";
  #    rev    = "d89e9f4b27c5aa0336629fed290e02a656125656";
  #    sha256 = "168rsln4ja9mqzr3wxb6n1aqrvs8m6d9vf8l0vnm5z0n2dwc5vhw";
  #    fetchSubmodules = true;
  #  };
  #});

  looking-glass-client = super.looking-glass-client.overrideAttrs (old: rec {
    src = super.fetchFromGitHub {
      owner = "gnif";
      repo = "LookingGlass";
      rev = "163a2e5d0a1168637da2524717b1328165c3c0b0";
      sha256 = "1sxdcqbkbj7n0s7d16w3wi7yhcl47xmvw9k84743hphwi93jgszi";
    };
  });

  tmux-mine = super.pkgs.tmux.overrideAttrs (oldAttr: rec {
    name = "tmux-2.4";
    version = "2.4";
    src = super.pkgs.fetchurl {
      url = "https://github.com/tmux/tmux/releases/download/2.4/tmux-2.4.tar.gz";
      sha256 = "0jdkk7vncwabrp85lw3msh2y02dc2k0qz5h4hka9s38x4c9nnzbm";
    };
  });

  dotnet-sdk-3_1_300 = super.dotnet-sdk.overrideAttrs (old: rec {
    version = "3.1.300";
    netCoreVersion = "3.1";
    name = "dotnet-sdk-${version}";
    src = self.fetchurl {
      url = "https://dotnetcli.azureedge.net/dotnet/Sdk/${version}/dotnet-sdk-${version}-linux-x64.tar.gz";
      sha512 = "05zvhnbfjhwriy2fxdik6xnxn07vfjzd8gsic30z6rfnp4xifzss5dnpyln672prq5a22mckjchk3xhxclpbrnsf8ixjiw8bzm48f0w";
    };
  });

  # latest version of dotnet-sdk
  dotnet-sdk = self.dotnet-sdk-3_1_300;


  cortex-cli = super.callPackage ./../cortex-cli.nix { };

}

