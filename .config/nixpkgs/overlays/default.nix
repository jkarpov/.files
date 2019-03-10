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

  # Environment for nixops
  inklings-env = super.buildEnv {
    name = "inklingsEnv";
    paths = with super.pkgs; [ pgcli leiningen ];
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


  python36 = super.python36.override {
    packageOverrides = python-self: python-super:

    let
      #
      # urllib3, isodate & jmespath are available from nixpkgs-unstable also, yet in
      # too old versions (or with buggy dependency metainfo).  Use compatible versions
      # for azure-cli, yet don't override/touch main package tree.
      #
      my_urllib3 = python-super.callPackage ./pkgs/development/python-modules/urllib3 {};

      my_isodate = python-super.callPackage ./pkgs/development/python-modules/isodate { };

      my_jmespath = python-super.callPackage ./pkgs/development/python-modules/jmespath { };


      #
      # get transitive dependencies right as well ....
      #
      my_requests = python-super.requests.override { urllib3 = my_urllib3; };

      my_requests_oauthlib = python-super.requests_oauthlib.override { requests = my_requests; };

      my_adal = python-super.adal.override { requests = my_requests; };

      my_argcomplete = python-super.argcomplete.override {
        requests_toolbelt = python-super.requests_toolbelt.override {
          requests = my_requests;
          betamax = python-super.betamax.override { requests = my_requests; };
        };
      };


    in

    {

      applicationinsights = python-super.callPackage ./pkgs/development/python-modules/applicationinsights {};

      azure-batch = python-super.callPackage ./pkgs/development/python-modules/azure-batch { };

      azure-cli = python-super.callPackage ./pkgs/development/python-modules/azure-cli { };

      azure-cli-acr = python-super.callPackage ./pkgs/development/python-modules/azure-cli-acr { };

      azure-cli-acs = python-super.callPackage ./pkgs/development/python-modules/azure-cli-acs { };

      azure-cli-advisor = python-super.callPackage ./pkgs/development/python-modules/azure-cli-advisor { };

      azure-cli-ams = python-super.callPackage ./pkgs/development/python-modules/azure-cli-ams { };

      azure-cli-appservice = python-super.callPackage ./pkgs/development/python-modules/azure-cli-appservice {
        urllib3 = my_urllib3;
      };

      azure-cli-backup = python-super.callPackage ./pkgs/development/python-modules/azure-cli-backup { };

      azure-cli-batch = python-super.callPackage ./pkgs/development/python-modules/azure-cli-batch { };

      azure-cli-batchai = python-super.callPackage ./pkgs/development/python-modules/azure-cli-batchai { };

      azure-cli-billing = python-super.callPackage ./pkgs/development/python-modules/azure-cli-billing { };

      azure-cli-cdn = python-super.callPackage ./pkgs/development/python-modules/azure-cli-cdn { };

      azure-cli-cloud = python-super.callPackage ./pkgs/development/python-modules/azure-cli-cloud { };

      azure-cli-cognitiveservices = python-super.callPackage ./pkgs/development/python-modules/azure-cli-cognitiveservices { };

      azure-cli-command-modules-nspkg = python-super.callPackage ./pkgs/development/python-modules/azure-cli-command-modules-nspkg { };

      azure-cli-configure = python-super.callPackage ./pkgs/development/python-modules/azure-cli-configure { };

      azure-cli-consumption = python-super.callPackage ./pkgs/development/python-modules/azure-cli-consumption { };

      azure-cli-container = python-super.callPackage ./pkgs/development/python-modules/azure-cli-container { };

      azure-cli-core = python-super.callPackage ./pkgs/development/python-modules/azure-cli-core {
        adal = my_adal;
        argcomplete = my_argcomplete;
        jmespath = my_jmespath;
        requests = my_requests;
      };

      azure-cli-cosmosdb = python-super.callPackage ./pkgs/development/python-modules/azure-cli-cosmosdb { };

      azure-cli-dla = python-super.callPackage ./pkgs/development/python-modules/azure-cli-dla { };

      azure-cli-dls = python-super.callPackage ./pkgs/development/python-modules/azure-cli-dls { };

      azure-cli-dms = python-super.callPackage ./pkgs/development/python-modules/azure-cli-dms { };

      azure-cli-eventgrid = python-super.callPackage ./pkgs/development/python-modules/azure-cli-eventgrid { };

      azure-cli-eventhubs = python-super.callPackage ./pkgs/development/python-modules/azure-cli-eventhubs { };

      azure-cli-extension = python-super.callPackage ./pkgs/development/python-modules/azure-cli-extension { };

      azure-cli-feedback = python-super.callPackage ./pkgs/development/python-modules/azure-cli-feedback { };

      azure-cli-find = python-super.callPackage ./pkgs/development/python-modules/azure-cli-find { };

      azure-cli-interactive = python-super.callPackage ./pkgs/development/python-modules/azure-cli-interactive {
        jmespath = my_jmespath;
      };

      azure-cli-iot = python-super.callPackage ./pkgs/development/python-modules/azure-cli-iot { };

      azure-cli-keyvault = python-super.callPackage ./pkgs/development/python-modules/azure-cli-keyvault { };

      azure-cli-lab = python-super.callPackage ./pkgs/development/python-modules/azure-cli-lab { };

      azure-cli-monitor = python-super.callPackage ./pkgs/development/python-modules/azure-cli-monitor { };

      azure-cli-network = python-super.callPackage ./pkgs/development/python-modules/azure-cli-network { };

      azure-cli-nspkg = python-super.callPackage ./pkgs/development/python-modules/azure-cli-nspkg { };

      azure-cli-profile = python-super.callPackage ./pkgs/development/python-modules/azure-cli-profile { };

      azure-cli-rdbms = python-super.callPackage ./pkgs/development/python-modules/azure-cli-rdbms { };

      azure-cli-redis = python-super.callPackage ./pkgs/development/python-modules/azure-cli-redis { };

      azure-cli-reservations = python-super.callPackage ./pkgs/development/python-modules/azure-cli-reservations { };

      azure-cli-resource = python-super.callPackage ./pkgs/development/python-modules/azure-cli-resource { };

      azure-cli-role = python-super.callPackage ./pkgs/development/python-modules/azure-cli-role { };

      azure-cli-search = python-super.callPackage ./pkgs/development/python-modules/azure-cli-search { };

      azure-cli-servicebus = python-super.callPackage ./pkgs/development/python-modules/azure-cli-servicebus { };

      azure-cli-servicefabric = python-super.callPackage ./pkgs/development/python-modules/azure-cli-servicefabric { };

      azure-cli-sql = python-super.callPackage ./pkgs/development/python-modules/azure-cli-sql { };

      azure-cli-storage = python-super.callPackage ./pkgs/development/python-modules/azure-cli-storage { };

      azure-cli-telemetry = python-super.callPackage ./pkgs/development/python-modules/azure-cli-telemetry { };

      azure-cli-vm = python-super.callPackage ./pkgs/development/python-modules/azure-cli-vm { };

      azure-common = python-super.callPackage ./pkgs/development/python-modules/azure-common { };

      azure-datalake-store = python-super.callPackage ./pkgs/development/python-modules/azure-datalake-store {
        adal = my_adal;
      };

      azure-graphrbac = python-super.callPackage ./pkgs/development/python-modules/azure-graphrbac { };

      azure-keyvault = python-super.callPackage ./pkgs/development/python-modules/azure-keyvault {
        requests = my_requests;
      };

      azure-mgmt-advisor = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-advisor { };

      azure-mgmt-authorization = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-authorization { };

      azure-mgmt-batch = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-batch { };

      azure-mgmt-batchai = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-batchai { };

      azure-mgmt-billing = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-billing { };

      azure-mgmt-cdn = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-cdn { };

      azure-mgmt-cognitiveservices = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-cognitiveservices { };

      azure-mgmt-compute = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-compute { };

      azure-mgmt-consumption = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-consumption { };

      azure-mgmt-containerinstance = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-containerinstance { };

      azure-mgmt-containerregistry = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-containerregistry { };

      azure-mgmt-containerservice = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-containerservice { };

      azure-mgmt-cosmosdb = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-cosmosdb { };

      azure-mgmt-datalake-analytics = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-datalake-analytics { };

      azure-mgmt-datalake-nspkg = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-datalake-nspkg { };

      azure-mgmt-datalake-store = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-datalake-store { };

      azure-mgmt-datamigration = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-datamigration { };

      azure-mgmt-devtestlabs = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-devtestlabs { };

      azure-mgmt-dns = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-dns { };

      azure-mgmt-eventgrid = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-eventgrid { };

      azure-mgmt-eventhub = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-eventhub { };

      azure-mgmt-iothub = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-iothub { };

      azure-mgmt-iothubprovisioningservices = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-iothubprovisioningservices { };

      azure-mgmt-keyvault = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-keyvault { };

      azure-mgmt-loganalytics = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-loganalytics { };

      azure-mgmt-managementgroups = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-managementgroups { };

      azure-mgmt-marketplaceordering = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-marketplaceordering { };

      azure-mgmt-media = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-media { };

      azure-mgmt-monitor = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-monitor { };

      azure-mgmt-msi = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-msi { };

      azure-mgmt-network = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-network { };

      azure-mgmt-nspkg = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-nspkg { };

      azure-mgmt-rdbms = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-rdbms { };

      azure-mgmt-recoveryservices = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-recoveryservices { };

      azure-mgmt-recoveryservicesbackup = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-recoveryservicesbackup { };

      azure-mgmt-redis = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-redis { };

      azure-mgmt-reservations = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-reservations { };

      azure-mgmt-resource = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-resource { };

      azure-mgmt-search = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-search { };

      azure-mgmt-servicebus = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-servicebus { };

      azure-mgmt-servicefabric = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-servicefabric { };

      azure-mgmt-sql = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-sql { };

      azure-mgmt-storage = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-storage { };

      azure-mgmt-trafficmanager = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-trafficmanager { };

      azure-mgmt-web = python-super.callPackage ./pkgs/development/python-modules/azure-mgmt-web { };

      azure-multiapi-storage = python-super.callPackage ./pkgs/development/python-modules/azure-multiapi-storage {
        requests = my_requests;
      };

      azure-nspkg = python-super.callPackage ./pkgs/development/python-modules/azure-nspkg { };

      azure-storage-blob = python-super.callPackage ./pkgs/development/python-modules/azure-storage-blob { };

      azure-storage-common = python-super.callPackage ./pkgs/development/python-modules/azure-storage-common {
        requests = my_requests;
      };

      azure-storage-nspkg = python-super.callPackage ./pkgs/development/python-modules/azure-storage-nspkg { };

      humanfriendly = python-super.callPackage ./pkgs/development/python-modules/humanfriendly {};

      knack = python-super.callPackage ./pkgs/development/python-modules/knack {
        argcomplete = my_argcomplete;
        jmespath = my_jmespath;

      };

      msrest = python-super.callPackage ./pkgs/development/python-modules/msrest {
        isodate = my_isodate;
        requests = my_requests;
        requests_oauthlib = my_requests_oauthlib;
      };

      msrestazure = python-super.callPackage ./pkgs/development/python-modules/msrestazure {
        adal = my_adal;
      };

      portalocker = python-super.callPackage ./pkgs/development/python-modules/portalocker { };

      pydocumentdb = python-super.callPackage ./pkgs/development/python-modules/pydocumentdb {
        requests = my_requests;
      };

      sshtunnel = python-super.callPackage ./pkgs/development/python-modules/sshtunnel { };

      vsts-cd-manager = python-super.callPackage ./pkgs/development/python-modules/vsts-cd-manager { };

    };
  };

}

