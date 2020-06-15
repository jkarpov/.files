{ stdenv, fetchurl }:
#with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "cortex-cli";
  version = "0.17.1";
  os = "linux";

  src = fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/get-cortex/${version}/cli/${os}/cortex";
    sha256 = "12y5dnwnwair1bm1sba7zhyg3hpncg13ydk4pg75s6hsanrhpvm4";
    # get sha256
    # nix-prefetch-url https://s3-us-west-2.amazonaws.com/get-cortex/0.17.1/cli/linux/cortex
  };

  # patchPhase fixes "exec format error"
  phases = [ "installPhase" "patchPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${src} $out/bin/cortex
    chmod +x $out/bin/cortex
  '';

}
