self: super:
{


  # Environment for Dotnet development
  dotnet-env = super.buildEnv {
    name = "dotnetEnv";
    paths = with super.pkgs; [ mono dotnet-sdk icu libunwind ];
  };

  # Environment for nixops
  nixops-env = super.buildEnv {
    name = "nixopsEnv";
    paths = with super.pkgs; [ nixops ];
  };

  # Environment for inklings
  inklings-env = super.buildEnv {
    name = "inklingsEnv";
    paths = with super.pkgs; [ pgcli openjdk leiningen ];
  };

  # Environment for nixops
  clojure-env = super.buildEnv {
    name = "inklingsEnv";
    paths = with super.pkgs; [ openjdk leiningen ];
  };

  ## Albert Fix for firefox bookmarks
  #albert = super.albert.overrideAttrs (old: rec {
  #  version = "0.20.1";
  #  src = super.fetchFromGitHub {
  #    owner  = "albertlauncher";
  #    repo   = "albert";
  #    rev    = "cb2a79ed54a4602dc664c152e384af0f1a15abd8";
  #    sha256 = "063z9yq6bsxcsqsw1n93ks5dzhzv6i252mjz1d5mxhxvgmqlfk0v";
  #    fetchSubmodules = true;
  #  };
  #});

  ## Get a not-yet-available version of dotnet core sdk
  #dotnet-sdk = super.dotnet-sdk.overrideAttrs (old: rec {
  #  version = "2.2.107";
  #  netCoreVersion = "2.2";
  #  name = "dotnet-sdk-${version}";
  #  src = self.fetchurl {
  #    url = "https://dotnetcli.azureedge.net/dotnet/Sdk/${version}/dotnet-sdk-${version}-linux-x64.tar.gz";
  #    # use sha512 from the download page
  #    sha512 = "E75F9B2190787F3CE665FF231BC6A2EE395B81B3D3D8D41ED5E8F4528791E5A8728D81310EA6751768645EEE82C0F0E1287818D29411A150AB9E7A227B4F41D0";
  #  };
  #});

  ## Get a not-yet-available version of dotnet core sdk
  #dotnet-sdk = super.dotnet-sdk.overrideAttrs (old: rec {
  #  version = "2.2.401";
  #  netCoreVersion = "3.2";
  #  name = "dotnet-sdk-${version}";
  #  src = self.fetchurl {
  #    url = "https://dotnetcli.azureedge.net/dotnet/Sdk/${version}/dotnet-sdk-${version}-linux-x64.tar.gz";
  #    # use sha512 from the download page
  #    sha512 = "08E1FCAFA4F898C80FF5E88EEB40C7497B4F5651AF3B8EC85F65A3DAA2F1509A766D833477358D3FF83D179E014034AB0C48120847EF24736C8D1A5B67FEC10B";
  #  };
  #});


  myHaskellEnv =
    super.haskellPackages.ghcWithHoogle
          (haskellPackages: with haskellPackages; [
            # libraries
            xmonad
            xmonad-contrib
            xmonad-extras
            # tools
            cabal-install
          ]);


  haskell-env = self.buildEnv {
      name = "haskell-environment";
      paths = with self; [
        #cabal2nix
        #ctags
        #cachix
        #haskellPackages.xmonad
        #haskell.compiler.ghc863Binary
        stack
        myHaskellEnv
        #cabal-install
        (import (builtins.fetchTarball https://github.com/domenkozar/hie-nix/tarball/master ) {}).hie86
      ];
  };

}

