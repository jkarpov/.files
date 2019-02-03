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
  "vim-ledger" = buildVimPlugin { name = "vim-ledger";
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
  "fsharp-vim" = buildVimPlugin {
    name = "fsharp-vim";
    src = fetchgit {
      url = "https://github.com/kongo2002/fsharp-vim.git";
      rev = "64aec6089558ec290287a9c935b53feeedd0c974";
      sha256 = "0whbjmgavhn84w353s724m2191q49m8z61xvzrlm61xcz5mygnr2";
    };
    dependencies = [];
  };
  "vim-better-whitespace" = buildVimPlugin {
    name = "vim-better-whitespace";
    src = fetchgit {
      url = "https://github.com/ntpeters/vim-better-whitespace";
      rev = "f5726c4bbe84a762d5ec62d57af439138a36af76";
      sha256 = "0mk15jv0vsqvww0jk3469755lb4hhjmxqkbk7byvxch63ai8jlsy";
    };
    dependencies = [];
  };
  "vim-tmux-focus-events" = buildVimPlugin {
    name = "vim-tmux-focus-events";
    src = fetchgit {
      url = "https://github.com/tmux-plugins/vim-tmux-focus-events";
      rev = "32723c5d778905a2a2e40030990c80c17f456649";
      sha256 = "0symr2xymxxxyplb3pa0zr7whzmwwpw8bz4alkaf65niik7jsnk2";
    };
  };
  "vim-tmux-clipboard" = buildVimPlugin {
    name = "vim-tmux-clipboard";
    src = fetchgit {
      url = "https://github.com/roxma/vim-tmux-clipboard";
      rev = "24e636396cc02ee9b5a952cec1576c8309674ac2";
      sha256 = "199akycz63qxq3cz3slb8n6ix60fpyn7pmygx318ba1r4im1dr3h";
    };
  };
  "vim-obsession" = buildVimPlugin {
    name = "vim-obsession";
    src = fetchgit {
      url = "https://github.com/tpope/vim-obsession";
      rev = "d2f78ce466186839b1838c7e85115f96d051c7a5";
      sha256 = "1027iln716cmycvl4zgkqp0ybzdy7r1bl32x5l776yyjby1ssmqb";
    };
  };
  "vim-easy-align" = buildVimPlugin {
    name = "vim-easy-align";
    src = fetchgit {
      url = "https://github.com/junegunn/vim-easy-align";
      rev = "1cd724dc239c3a0f7a12e0fac85945cc3dbe07b0";
      sha256 = "0bqk1sdqamfgagh31a60c7gvvsvjpg1xys7ivqh62iqlny5i9774";
    };
  };
  "neovim-fuzzy" = buildVimPlugin {
    name = "neovim-fuzzy";
    src = fetchgit {
      url = "https://github.com/cloudhead/neovim-fuzzy";
      rev = "c177209678477d091ee4576e231c5b80b44514d0";
      sha256 = "069phpy1p8dindi6whddsb9x5zyw1adzsnv7br7q955hf6x9bxxj";
    };
  };
  "lessspace.vim" = buildVimPlugin {
    name = "lessspace.vim";
    src = fetchgit {
      url = "https://github.com/thirtythreeforty/lessspace.vim";
      rev = "fd16589b8b0a45a7ed5ce48f24c71fae21950057";
      sha256 = "1kddb2vrvs6km15wwlygz8d2klb53nkbr7xfwx3bpg8r5d4iapa4";
    };
  };
  "hlsl.vim" = buildVimPlugin {
    name = "hlsl.vim";
    src = fetchgit {
      url = "https://github.com/beyondmarc/hlsl.vim";
      rev = "f255936d1e37899f46cac92e39bfda1cd36be04b";
      sha256 = "1adlfwxb2fgiksy8s0nz1139m6xj6xksrzsphc4qszwmyy8n6nsp";
    };
  };
}

