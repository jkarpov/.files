{ pkgs, fetchgit }:
let buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in {
  "vim-unimpaired" = buildVimPlugin {
    name = "vim-unimpaired";
    src = fetchgit {
      url = "https://github.com/tpope/vim-unimpaired";
      rev = "1ac95a86c0facb1be8abec924cf79fd642cec386";
      sha256 = "1izy6lm7v9rm1xag1lyimc0jj6vk7g0yya5kcs1jyby8p0ldjzk9";
    };
    dependencies = [];
  };
  "vim-ledger" = buildVimPlugin {
    name = "vim-ledger";
    src = fetchgit {
      url = "https://github.com/ledger/vim-ledger";
      rev = "6eb3bb21aa979cc295d0480b2179938c12b33d0d";
      sha256 = "0rbwyaanvl2bqk8xm4kq8fkv8y92lpf9xx5n8gw54iij7xxhnj01";
    };
    dependencies = [];
  };
}

