let qemu_overlay = self: super:
{

  qemu = super.qemu.overrideAttrs (old: rec {
    src = super.fetchFromGitHub {
      owner  = "ditadi";
      repo   = "qemu";
      rev    = "920882b8d75350286788dff612710362b3017a00";
      sha256 = "168rsln4ja9mqzr3wxb6n1aqrvs8m6d9vf8l0vnm5z0n2dwc5vhw";
      fetchSubmodules = true;
    };
  })

};
