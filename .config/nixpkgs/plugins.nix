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
  "gruvbox-haskell" = buildVimPlugin {
    name = "gruvbox-haskell";
    src = fetchgit {
      url = "https://github.com/dkasak/gruvbox";
      rev = "9be4583512181d3503b6d7bfa6a50c40c889512a";
      sha256 = "0lisk1r1wqgk30jnb2wrhaxzjiqzgwki7l6hwl2p5a5alq529i46";
    };
    dependencies = [];
  };
  "ayu" = buildVimPlugin {
    name = "ayu";
    src = fetchgit {
      url = "https://github.com/ayu-theme/ayu-vim";
      rev = "4c418ff99fe898121643bf60cc0d9752c31c2937";
      sha256 = "0qfajz5g9fi65wkshyhcbcvqhbg7pgiirnazy1875nk3537kwl4z";
    };
    dependencies = [];
  };
  "neo-solarized" = buildVimPlugin {
    name = "neo-solarized";
    src = fetchgit {
      url = "https://github.com/iCyMind/NeoSolarized";
      rev = "8a9ff861f2bd4b214b9f106edf252f7c5be02a41";
      sha256 = "18cv8j679725jmd67v6fqv3r2n3pi1fh84alm2x7hqggaqh8nd8p";
    };
    dependencies = [];
  };
  "seiya" = buildVimPlugin {
    name = "seiya";
    src = fetchgit {
      url = "https://github.com/miyakogi/seiya.vim";
      rev = "d2406e8b52b8df7ac0e40ef8f5f01cf105e15c0c";
      sha256 = "01xqa2dmbag2fcgzsl473gmqvxy1swv7zan6qfxsp8anxbs47lv4";
    };
    dependencies = [];
  };
  "monodark" = buildVimPlugin {
    name = "monodark";
    src = fetchgit {
      url = "https://github.com/raichoo/monodark";
      rev = "3d90108511d8deee938ef5d5bb0a4b0b5c779005";
      sha256 = "08rdpl3liq4slirn5jqvb9q3gp3z5ji17pbyisy6ihw7ld9ik9k5";
    };
    dependencies = [];
  };
  "solarized8" = buildVimPlugin {
    name = "solarized8";
    src = fetchgit {
      url = "https://github.com/lifepillar/vim-solarized8";
      rev = "a534e726e55ce478875ffc19e39164ffacb83f8f";
      sha256 = "0y7v8sn0q86km04xm6y6zdz0q4zk38nf3fl76zmc91ss2bnc2wy4";
    };
    dependencies = [];
  };
  "mopkai" = buildVimPlugin {
    name = "mopkai";
    src = fetchgit {
      url = "https://github.com/mopp/mopkai.vim";
      rev = "033c0d4e6fa801928cc401d8a84fc8846ca975c7";
      sha256 = "0584lgzj1bg9fbgzbc7pv51pxjqhj3xhzpbmmjwv1bl4c22bly0l";
    };
    dependencies = [];
  };
  "github-colorscheme" = buildVimPlugin { 
    name = "github-colorscheme";
    src = fetchgit {
      url = "https://github.com/endel/vim-github-colorscheme.git";
      rev = "37b0ca027f638f3349ed8fb99c54ab65b8e65c04";
      sha256 = "0j3m4hd3sykjk7vs96yh82lmfgga5n6r5b0vqzjg1r2sgyxzig05";
    };
    dependencies = [];
  };
}

