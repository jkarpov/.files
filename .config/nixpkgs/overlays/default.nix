self: super:
{


  # Environment for Dotnet development
  dotnet-env = super.buildEnv {
    name = "dotnetEnv";
    paths = with super.pkgs; [ mono dotnet-sdk icu ];
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

  # Get a not-yet-available version of dotnet core sdk
  dotnet-sdk = super.dotnet-sdk.overrideAttrs (old: rec {
    version = "2.2.103";
    netCoreVersion = "2.2";
    name = "dotnet-sdk-${version}";
    src = self.fetchurl {
      url = "https://dotnetcli.azureedge.net/dotnet/Sdk/${version}/dotnet-sdk-${version}-linux-x64.tar.gz";
      # use sha512 from the download page
      sha512 = "777ac6dcd0200ba447392e451a1779f0fbfa548bd620a7bba3eebdf35892236c3f10b19ff81d4f64b5bc134923cb47f9cc45ee6b004140e1249582249944db69";
    };
  });

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

