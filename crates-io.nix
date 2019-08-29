{ lib, buildRustCrate, buildRustCrateHelpers }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {

# adler32-1.0.3

  crates.adler32."1.0.3" = deps: { features?(features_.adler32."1.0.3" deps {}) }: buildRustCrate {
    crateName = "adler32";
    version = "1.0.3";
    authors = [ "Remi Rampin <remirampin@gmail.com>" ];
    sha256 = "1z3mvjgw02mbqk98kizzibrca01d5wfkpazsrp3vkkv3i56pn6fb";
  };
  features_.adler32."1.0.3" = deps: f: updateFeatures f (rec {
    adler32."1.0.3".default = (f.adler32."1.0.3".default or true);
  }) [];


# end
# aho-corasick-0.7.6

  crates.aho_corasick."0.7.6" = deps: { features?(features_.aho_corasick."0.7.6" deps {}) }: buildRustCrate {
    crateName = "aho-corasick";
    version = "0.7.6";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1srdggg7iawz7rfyb79qfnz6vmzkgl6g6gabyd9ad6pbx7zzj8gz";
    libName = "aho_corasick";
    dependencies = mapFeatures features ([
      (crates."memchr"."${deps."aho_corasick"."0.7.6"."memchr"}" deps)
    ]);
    features = mkFeatures (features."aho_corasick"."0.7.6" or {});
  };
  features_.aho_corasick."0.7.6" = deps: f: updateFeatures f (rec {
    aho_corasick = fold recursiveUpdate {} [
      { "0.7.6".default = (f.aho_corasick."0.7.6".default or true); }
      { "0.7.6".std =
        (f.aho_corasick."0.7.6".std or false) ||
        (f.aho_corasick."0.7.6".default or false) ||
        (aho_corasick."0.7.6"."default" or false); }
    ];
    memchr = fold recursiveUpdate {} [
      { "${deps.aho_corasick."0.7.6".memchr}"."use_std" =
        (f.memchr."${deps.aho_corasick."0.7.6".memchr}"."use_std" or false) ||
        (aho_corasick."0.7.6"."std" or false) ||
        (f."aho_corasick"."0.7.6"."std" or false); }
      { "${deps.aho_corasick."0.7.6".memchr}".default = (f.memchr."${deps.aho_corasick."0.7.6".memchr}".default or false); }
    ];
  }) [
    (features_.memchr."${deps."aho_corasick"."0.7.6"."memchr"}" deps)
  ];


# end
# ansi_term-0.11.0

  crates.ansi_term."0.11.0" = deps: { features?(features_.ansi_term."0.11.0" deps {}) }: buildRustCrate {
    crateName = "ansi_term";
    version = "0.11.0";
    authors = [ "ogham@bsago.me" "Ryan Scheel (Havvy) <ryan.havvy@gmail.com>" "Josh Triplett <josh@joshtriplett.org>" ];
    sha256 = "08fk0p2xvkqpmz3zlrwnf6l8sj2vngw464rvzspzp31sbgxbwm4v";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."ansi_term"."0.11.0"."winapi"}" deps)
    ]) else []);
  };
  features_.ansi_term."0.11.0" = deps: f: updateFeatures f (rec {
    ansi_term."0.11.0".default = (f.ansi_term."0.11.0".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.ansi_term."0.11.0".winapi}"."consoleapi" = true; }
      { "${deps.ansi_term."0.11.0".winapi}"."errhandlingapi" = true; }
      { "${deps.ansi_term."0.11.0".winapi}"."processenv" = true; }
      { "${deps.ansi_term."0.11.0".winapi}".default = true; }
    ];
  }) [
    (features_.winapi."${deps."ansi_term"."0.11.0"."winapi"}" deps)
  ];


# end
# approx-0.1.1

  crates.approx."0.1.1" = deps: { features?(features_.approx."0.1.1" deps {}) }: buildRustCrate {
    crateName = "approx";
    version = "0.1.1";
    authors = [ "Brendan Zabarauskas <bjzaba@yahoo.com.au>" ];
    sha256 = "1wrhjjqhdg9qvw59489iw3cy1dy96v63isbflbkwbrv79ayksa3c";
    features = mkFeatures (features."approx"."0.1.1" or {});
  };
  features_.approx."0.1.1" = deps: f: updateFeatures f (rec {
    approx."0.1.1".default = (f.approx."0.1.1".default or true);
  }) [];


# end
# arrayref-0.3.5

  crates.arrayref."0.3.5" = deps: { features?(features_.arrayref."0.3.5" deps {}) }: buildRustCrate {
    crateName = "arrayref";
    version = "0.3.5";
    authors = [ "David Roundy <roundyd@physics.oregonstate.edu>" ];
    sha256 = "00dfn9lbr4pc524imc25v3rbmswiqk3jldsgmx4rdngcpxb8ssjf";
  };
  features_.arrayref."0.3.5" = deps: f: updateFeatures f (rec {
    arrayref."0.3.5".default = (f.arrayref."0.3.5".default or true);
  }) [];


# end
# arrayvec-0.4.11

  crates.arrayvec."0.4.11" = deps: { features?(features_.arrayvec."0.4.11" deps {}) }: buildRustCrate {
    crateName = "arrayvec";
    version = "0.4.11";
    authors = [ "bluss" ];
    sha256 = "1bd08rakkyr9jlf538cs80s3ly464ni3afr63zlw860ndar1zfmv";
    dependencies = mapFeatures features ([
      (crates."nodrop"."${deps."arrayvec"."0.4.11"."nodrop"}" deps)
    ]);
    features = mkFeatures (features."arrayvec"."0.4.11" or {});
  };
  features_.arrayvec."0.4.11" = deps: f: updateFeatures f (rec {
    arrayvec = fold recursiveUpdate {} [
      { "0.4.11".default = (f.arrayvec."0.4.11".default or true); }
      { "0.4.11".serde =
        (f.arrayvec."0.4.11".serde or false) ||
        (f.arrayvec."0.4.11".serde-1 or false) ||
        (arrayvec."0.4.11"."serde-1" or false); }
      { "0.4.11".std =
        (f.arrayvec."0.4.11".std or false) ||
        (f.arrayvec."0.4.11".default or false) ||
        (arrayvec."0.4.11"."default" or false); }
    ];
    nodrop."${deps.arrayvec."0.4.11".nodrop}".default = (f.nodrop."${deps.arrayvec."0.4.11".nodrop}".default or false);
  }) [
    (features_.nodrop."${deps."arrayvec"."0.4.11"."nodrop"}" deps)
  ];


# end
# assert-json-diff-1.0.0

  crates.assert_json_diff."1.0.0" = deps: { features?(features_.assert_json_diff."1.0.0" deps {}) }: buildRustCrate {
    crateName = "assert-json-diff";
    version = "1.0.0";
    authors = [ "David Pedersen <david.pdrsn@gmail.com>" ];
    sha256 = "1ajsmqik57riyz9k85r5nd7mcshcskqgw5hzw60piz0bsavzqj4k";
    dependencies = mapFeatures features ([
      (crates."serde"."${deps."assert_json_diff"."1.0.0"."serde"}" deps)
      (crates."serde_json"."${deps."assert_json_diff"."1.0.0"."serde_json"}" deps)
    ]);
  };
  features_.assert_json_diff."1.0.0" = deps: f: updateFeatures f (rec {
    assert_json_diff."1.0.0".default = (f.assert_json_diff."1.0.0".default or true);
    serde."${deps.assert_json_diff."1.0.0".serde}".default = true;
    serde_json."${deps.assert_json_diff."1.0.0".serde_json}".default = true;
  }) [
    (features_.serde."${deps."assert_json_diff"."1.0.0"."serde"}" deps)
    (features_.serde_json."${deps."assert_json_diff"."1.0.0"."serde_json"}" deps)
  ];


# end
# atty-0.2.13

  crates.atty."0.2.13" = deps: { features?(features_.atty."0.2.13" deps {}) }: buildRustCrate {
    crateName = "atty";
    version = "0.2.13";
    authors = [ "softprops <d.tangren@gmail.com>" ];
    sha256 = "0a1ii8h9fvvrq05bz7j135zjjz1sjz6n2invn2ngxqri0jxgmip2";
    dependencies = (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."atty"."0.2.13"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."atty"."0.2.13"."winapi"}" deps)
    ]) else []);
  };
  features_.atty."0.2.13" = deps: f: updateFeatures f (rec {
    atty."0.2.13".default = (f.atty."0.2.13".default or true);
    libc."${deps.atty."0.2.13".libc}".default = (f.libc."${deps.atty."0.2.13".libc}".default or false);
    winapi = fold recursiveUpdate {} [
      { "${deps.atty."0.2.13".winapi}"."consoleapi" = true; }
      { "${deps.atty."0.2.13".winapi}"."minwinbase" = true; }
      { "${deps.atty."0.2.13".winapi}"."minwindef" = true; }
      { "${deps.atty."0.2.13".winapi}"."processenv" = true; }
      { "${deps.atty."0.2.13".winapi}"."winbase" = true; }
      { "${deps.atty."0.2.13".winapi}".default = true; }
    ];
  }) [
    (features_.libc."${deps."atty"."0.2.13"."libc"}" deps)
    (features_.winapi."${deps."atty"."0.2.13"."winapi"}" deps)
  ];


# end
# autocfg-0.1.6

  crates.autocfg."0.1.6" = deps: { features?(features_.autocfg."0.1.6" deps {}) }: buildRustCrate {
    crateName = "autocfg";
    version = "0.1.6";
    authors = [ "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "1yzawpsmrcy3x60i59hfwwg7mfdwc74199m2lgkc4vam5ijy8mz7";
  };
  features_.autocfg."0.1.6" = deps: f: updateFeatures f (rec {
    autocfg."0.1.6".default = (f.autocfg."0.1.6".default or true);
  }) [];


# end
# backtrace-0.3.35

  crates.backtrace."0.3.35" = deps: { features?(features_.backtrace."0.3.35" deps {}) }: buildRustCrate {
    crateName = "backtrace";
    version = "0.3.35";
    authors = [ "The Rust Project Developers" ];
    edition = "2018";
    sha256 = "1sbfj486psr51qh54vsqyyj4qk4m9k74lm883idrn9da5jmj04pj";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."backtrace"."0.3.35"."cfg_if"}" deps)
      (crates."libc"."${deps."backtrace"."0.3.35"."libc"}" deps)
      (crates."rustc_demangle"."${deps."backtrace"."0.3.35"."rustc_demangle"}" deps)
    ]
      ++ (if features.backtrace."0.3.35".backtrace-sys or false then [ (crates.backtrace_sys."${deps."backtrace"."0.3.35".backtrace_sys}" deps) ] else []))
      ++ (if !(kernel == "darwin" || kernel == "windows") then mapFeatures features ([
]) else [])
      ++ (if kernel == "darwin" then mapFeatures features ([
]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."backtrace"."0.3.35" or {});
  };
  features_.backtrace."0.3.35" = deps: f: updateFeatures f (rec {
    backtrace = fold recursiveUpdate {} [
      { "0.3.35".addr2line =
        (f.backtrace."0.3.35".addr2line or false) ||
        (f.backtrace."0.3.35".gimli-symbolize or false) ||
        (backtrace."0.3.35"."gimli-symbolize" or false); }
      { "0.3.35".backtrace-sys =
        (f.backtrace."0.3.35".backtrace-sys or false) ||
        (f.backtrace."0.3.35".libbacktrace or false) ||
        (backtrace."0.3.35"."libbacktrace" or false); }
      { "0.3.35".compiler_builtins =
        (f.backtrace."0.3.35".compiler_builtins or false) ||
        (f.backtrace."0.3.35".rustc-dep-of-std or false) ||
        (backtrace."0.3.35"."rustc-dep-of-std" or false); }
      { "0.3.35".core =
        (f.backtrace."0.3.35".core or false) ||
        (f.backtrace."0.3.35".rustc-dep-of-std or false) ||
        (backtrace."0.3.35"."rustc-dep-of-std" or false); }
      { "0.3.35".dbghelp =
        (f.backtrace."0.3.35".dbghelp or false) ||
        (f.backtrace."0.3.35".default or false) ||
        (backtrace."0.3.35"."default" or false); }
      { "0.3.35".default = (f.backtrace."0.3.35".default or true); }
      { "0.3.35".dladdr =
        (f.backtrace."0.3.35".dladdr or false) ||
        (f.backtrace."0.3.35".default or false) ||
        (backtrace."0.3.35"."default" or false); }
      { "0.3.35".findshlibs =
        (f.backtrace."0.3.35".findshlibs or false) ||
        (f.backtrace."0.3.35".gimli-symbolize or false) ||
        (backtrace."0.3.35"."gimli-symbolize" or false); }
      { "0.3.35".goblin =
        (f.backtrace."0.3.35".goblin or false) ||
        (f.backtrace."0.3.35".gimli-symbolize or false) ||
        (backtrace."0.3.35"."gimli-symbolize" or false); }
      { "0.3.35".libbacktrace =
        (f.backtrace."0.3.35".libbacktrace or false) ||
        (f.backtrace."0.3.35".default or false) ||
        (backtrace."0.3.35"."default" or false); }
      { "0.3.35".libunwind =
        (f.backtrace."0.3.35".libunwind or false) ||
        (f.backtrace."0.3.35".default or false) ||
        (backtrace."0.3.35"."default" or false); }
      { "0.3.35".memmap =
        (f.backtrace."0.3.35".memmap or false) ||
        (f.backtrace."0.3.35".gimli-symbolize or false) ||
        (backtrace."0.3.35"."gimli-symbolize" or false); }
      { "0.3.35".rustc-serialize =
        (f.backtrace."0.3.35".rustc-serialize or false) ||
        (f.backtrace."0.3.35".serialize-rustc or false) ||
        (backtrace."0.3.35"."serialize-rustc" or false); }
      { "0.3.35".serde =
        (f.backtrace."0.3.35".serde or false) ||
        (f.backtrace."0.3.35".serialize-serde or false) ||
        (backtrace."0.3.35"."serialize-serde" or false); }
      { "0.3.35".std =
        (f.backtrace."0.3.35".std or false) ||
        (f.backtrace."0.3.35".default or false) ||
        (backtrace."0.3.35"."default" or false); }
    ];
    backtrace_sys = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.35".backtrace_sys}"."rustc-dep-of-std" =
        (f.backtrace_sys."${deps.backtrace."0.3.35".backtrace_sys}"."rustc-dep-of-std" or false) ||
        (backtrace."0.3.35"."rustc-dep-of-std" or false) ||
        (f."backtrace"."0.3.35"."rustc-dep-of-std" or false); }
      { "${deps.backtrace."0.3.35".backtrace_sys}".default = true; }
    ];
    cfg_if = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.35".cfg_if}"."rustc-dep-of-std" =
        (f.cfg_if."${deps.backtrace."0.3.35".cfg_if}"."rustc-dep-of-std" or false) ||
        (backtrace."0.3.35"."rustc-dep-of-std" or false) ||
        (f."backtrace"."0.3.35"."rustc-dep-of-std" or false); }
      { "${deps.backtrace."0.3.35".cfg_if}".default = true; }
    ];
    libc = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.35".libc}"."rustc-dep-of-std" =
        (f.libc."${deps.backtrace."0.3.35".libc}"."rustc-dep-of-std" or false) ||
        (backtrace."0.3.35"."rustc-dep-of-std" or false) ||
        (f."backtrace"."0.3.35"."rustc-dep-of-std" or false); }
      { "${deps.backtrace."0.3.35".libc}".default = (f.libc."${deps.backtrace."0.3.35".libc}".default or false); }
    ];
    rustc_demangle = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.35".rustc_demangle}"."rustc-dep-of-std" =
        (f.rustc_demangle."${deps.backtrace."0.3.35".rustc_demangle}"."rustc-dep-of-std" or false) ||
        (backtrace."0.3.35"."rustc-dep-of-std" or false) ||
        (f."backtrace"."0.3.35"."rustc-dep-of-std" or false); }
      { "${deps.backtrace."0.3.35".rustc_demangle}".default = true; }
    ];
  }) [
    (features_.backtrace_sys."${deps."backtrace"."0.3.35"."backtrace_sys"}" deps)
    (features_.cfg_if."${deps."backtrace"."0.3.35"."cfg_if"}" deps)
    (features_.libc."${deps."backtrace"."0.3.35"."libc"}" deps)
    (features_.rustc_demangle."${deps."backtrace"."0.3.35"."rustc_demangle"}" deps)
  ];


# end
# backtrace-sys-0.1.31

  crates.backtrace_sys."0.1.31" = deps: { features?(features_.backtrace_sys."0.1.31" deps {}) }: buildRustCrate {
    crateName = "backtrace-sys";
    version = "0.1.31";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1gv41cypl4y5r32za4gx2fks43d76sp1r3yb5524i4gs50lrkypv";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."backtrace_sys"."0.1.31"."libc"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."cc"."${deps."backtrace_sys"."0.1.31"."cc"}" deps)
    ]);
    features = mkFeatures (features."backtrace_sys"."0.1.31" or {});
  };
  features_.backtrace_sys."0.1.31" = deps: f: updateFeatures f (rec {
    backtrace_sys = fold recursiveUpdate {} [
      { "0.1.31".compiler_builtins =
        (f.backtrace_sys."0.1.31".compiler_builtins or false) ||
        (f.backtrace_sys."0.1.31".rustc-dep-of-std or false) ||
        (backtrace_sys."0.1.31"."rustc-dep-of-std" or false); }
      { "0.1.31".core =
        (f.backtrace_sys."0.1.31".core or false) ||
        (f.backtrace_sys."0.1.31".rustc-dep-of-std or false) ||
        (backtrace_sys."0.1.31"."rustc-dep-of-std" or false); }
      { "0.1.31".default = (f.backtrace_sys."0.1.31".default or true); }
    ];
    cc."${deps.backtrace_sys."0.1.31".cc}".default = true;
    libc."${deps.backtrace_sys."0.1.31".libc}".default = (f.libc."${deps.backtrace_sys."0.1.31".libc}".default or false);
  }) [
    (features_.libc."${deps."backtrace_sys"."0.1.31"."libc"}" deps)
    (features_.cc."${deps."backtrace_sys"."0.1.31"."cc"}" deps)
  ];


# end
# base64-0.10.1

  crates.base64."0.10.1" = deps: { features?(features_.base64."0.10.1" deps {}) }: buildRustCrate {
    crateName = "base64";
    version = "0.10.1";
    authors = [ "Alice Maz <alice@alicemaz.com>" "Marshall Pierce <marshall@mpierce.org>" ];
    sha256 = "1zz3jq619hahla1f70ra38818b5n8cp4iilij81i90jq6z7hlfhg";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."base64"."0.10.1"."byteorder"}" deps)
    ]);
  };
  features_.base64."0.10.1" = deps: f: updateFeatures f (rec {
    base64."0.10.1".default = (f.base64."0.10.1".default or true);
    byteorder."${deps.base64."0.10.1".byteorder}".default = true;
  }) [
    (features_.byteorder."${deps."base64"."0.10.1"."byteorder"}" deps)
  ];


# end
# bitflags-1.1.0

  crates.bitflags."1.1.0" = deps: { features?(features_.bitflags."1.1.0" deps {}) }: buildRustCrate {
    crateName = "bitflags";
    version = "1.1.0";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1iwa4jrqcf4lnbwl562a3lx3r0jkh1j88b219bsqvbm4sni67dyv";
    build = "build.rs";
    features = mkFeatures (features."bitflags"."1.1.0" or {});
  };
  features_.bitflags."1.1.0" = deps: f: updateFeatures f (rec {
    bitflags."1.1.0".default = (f.bitflags."1.1.0".default or true);
  }) [];


# end
# blake2b_simd-0.5.7

  crates.blake2b_simd."0.5.7" = deps: { features?(features_.blake2b_simd."0.5.7" deps {}) }: buildRustCrate {
    crateName = "blake2b_simd";
    version = "0.5.7";
    authors = [ "Jack O'Connor" ];
    edition = "2018";
    sha256 = "09xh78w6kjkm5l9521jzc6j1m8dqpaw13jlgr2dwj5kq9rghx88j";
    dependencies = mapFeatures features ([
      (crates."arrayref"."${deps."blake2b_simd"."0.5.7"."arrayref"}" deps)
      (crates."arrayvec"."${deps."blake2b_simd"."0.5.7"."arrayvec"}" deps)
      (crates."constant_time_eq"."${deps."blake2b_simd"."0.5.7"."constant_time_eq"}" deps)
    ]);
    features = mkFeatures (features."blake2b_simd"."0.5.7" or {});
  };
  features_.blake2b_simd."0.5.7" = deps: f: updateFeatures f (rec {
    arrayref."${deps.blake2b_simd."0.5.7".arrayref}".default = true;
    arrayvec."${deps.blake2b_simd."0.5.7".arrayvec}".default = (f.arrayvec."${deps.blake2b_simd."0.5.7".arrayvec}".default or false);
    blake2b_simd = fold recursiveUpdate {} [
      { "0.5.7".default = (f.blake2b_simd."0.5.7".default or true); }
      { "0.5.7".std =
        (f.blake2b_simd."0.5.7".std or false) ||
        (f.blake2b_simd."0.5.7".default or false) ||
        (blake2b_simd."0.5.7"."default" or false); }
    ];
    constant_time_eq."${deps.blake2b_simd."0.5.7".constant_time_eq}".default = true;
  }) [
    (features_.arrayref."${deps."blake2b_simd"."0.5.7"."arrayref"}" deps)
    (features_.arrayvec."${deps."blake2b_simd"."0.5.7"."arrayvec"}" deps)
    (features_.constant_time_eq."${deps."blake2b_simd"."0.5.7"."constant_time_eq"}" deps)
  ];


# end
# bstr-0.2.7

  crates.bstr."0.2.7" = deps: { features?(features_.bstr."0.2.7" deps {}) }: buildRustCrate {
    crateName = "bstr";
    version = "0.2.7";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1wh18nnpn19adjv1q89njzwsf833b3fzq7jaxxw86xzb30lpv1r7";
    dependencies = mapFeatures features ([
      (crates."memchr"."${deps."bstr"."0.2.7"."memchr"}" deps)
    ]
      ++ (if features.bstr."0.2.7".lazy_static or false then [ (crates.lazy_static."${deps."bstr"."0.2.7".lazy_static}" deps) ] else [])
      ++ (if features.bstr."0.2.7".regex-automata or false then [ (crates.regex_automata."${deps."bstr"."0.2.7".regex_automata}" deps) ] else [])
      ++ (if features.bstr."0.2.7".serde or false then [ (crates.serde."${deps."bstr"."0.2.7".serde}" deps) ] else []));
    features = mkFeatures (features."bstr"."0.2.7" or {});
  };
  features_.bstr."0.2.7" = deps: f: updateFeatures f (rec {
    bstr = fold recursiveUpdate {} [
      { "0.2.7".default = (f.bstr."0.2.7".default or true); }
      { "0.2.7".lazy_static =
        (f.bstr."0.2.7".lazy_static or false) ||
        (f.bstr."0.2.7".unicode or false) ||
        (bstr."0.2.7"."unicode" or false); }
      { "0.2.7".regex-automata =
        (f.bstr."0.2.7".regex-automata or false) ||
        (f.bstr."0.2.7".unicode or false) ||
        (bstr."0.2.7"."unicode" or false); }
      { "0.2.7".serde =
        (f.bstr."0.2.7".serde or false) ||
        (f.bstr."0.2.7".serde1-nostd or false) ||
        (bstr."0.2.7"."serde1-nostd" or false); }
      { "0.2.7".serde1-nostd =
        (f.bstr."0.2.7".serde1-nostd or false) ||
        (f.bstr."0.2.7".serde1 or false) ||
        (bstr."0.2.7"."serde1" or false); }
      { "0.2.7".std =
        (f.bstr."0.2.7".std or false) ||
        (f.bstr."0.2.7".default or false) ||
        (bstr."0.2.7"."default" or false) ||
        (f.bstr."0.2.7".serde1 or false) ||
        (bstr."0.2.7"."serde1" or false); }
      { "0.2.7".unicode =
        (f.bstr."0.2.7".unicode or false) ||
        (f.bstr."0.2.7".default or false) ||
        (bstr."0.2.7"."default" or false); }
    ];
    lazy_static."${deps.bstr."0.2.7".lazy_static}".default = true;
    memchr = fold recursiveUpdate {} [
      { "${deps.bstr."0.2.7".memchr}"."use_std" =
        (f.memchr."${deps.bstr."0.2.7".memchr}"."use_std" or false) ||
        (bstr."0.2.7"."std" or false) ||
        (f."bstr"."0.2.7"."std" or false); }
      { "${deps.bstr."0.2.7".memchr}".default = (f.memchr."${deps.bstr."0.2.7".memchr}".default or false); }
    ];
    regex_automata."${deps.bstr."0.2.7".regex_automata}".default = (f.regex_automata."${deps.bstr."0.2.7".regex_automata}".default or false);
    serde = fold recursiveUpdate {} [
      { "${deps.bstr."0.2.7".serde}"."std" =
        (f.serde."${deps.bstr."0.2.7".serde}"."std" or false) ||
        (bstr."0.2.7"."serde1" or false) ||
        (f."bstr"."0.2.7"."serde1" or false); }
      { "${deps.bstr."0.2.7".serde}".default = (f.serde."${deps.bstr."0.2.7".serde}".default or false); }
    ];
  }) [
    (features_.lazy_static."${deps."bstr"."0.2.7"."lazy_static"}" deps)
    (features_.memchr."${deps."bstr"."0.2.7"."memchr"}" deps)
    (features_.regex_automata."${deps."bstr"."0.2.7"."regex_automata"}" deps)
    (features_.serde."${deps."bstr"."0.2.7"."serde"}" deps)
  ];


# end
# byteorder-1.3.2

  crates.byteorder."1.3.2" = deps: { features?(features_.byteorder."1.3.2" deps {}) }: buildRustCrate {
    crateName = "byteorder";
    version = "1.3.2";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "099fxwc79ncpcl8dgg9hql8gznz11a3sjs7pai0mg6w8r05khvdx";
    build = "build.rs";
    features = mkFeatures (features."byteorder"."1.3.2" or {});
  };
  features_.byteorder."1.3.2" = deps: f: updateFeatures f (rec {
    byteorder = fold recursiveUpdate {} [
      { "1.3.2".default = (f.byteorder."1.3.2".default or true); }
      { "1.3.2".std =
        (f.byteorder."1.3.2".std or false) ||
        (f.byteorder."1.3.2".default or false) ||
        (byteorder."1.3.2"."default" or false); }
    ];
  }) [];


# end
# bytes-0.4.12

  crates.bytes."0.4.12" = deps: { features?(features_.bytes."0.4.12" deps {}) }: buildRustCrate {
    crateName = "bytes";
    version = "0.4.12";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0cw577vll9qp0h3l1sy24anr5mcnd5j26q9q7nw4f0mddssvfphf";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."bytes"."0.4.12"."byteorder"}" deps)
      (crates."iovec"."${deps."bytes"."0.4.12"."iovec"}" deps)
    ]
      ++ (if features.bytes."0.4.12".either or false then [ (crates.either."${deps."bytes"."0.4.12".either}" deps) ] else []));
    features = mkFeatures (features."bytes"."0.4.12" or {});
  };
  features_.bytes."0.4.12" = deps: f: updateFeatures f (rec {
    byteorder = fold recursiveUpdate {} [
      { "${deps.bytes."0.4.12".byteorder}"."i128" =
        (f.byteorder."${deps.bytes."0.4.12".byteorder}"."i128" or false) ||
        (bytes."0.4.12"."i128" or false) ||
        (f."bytes"."0.4.12"."i128" or false); }
      { "${deps.bytes."0.4.12".byteorder}".default = true; }
    ];
    bytes."0.4.12".default = (f.bytes."0.4.12".default or true);
    either."${deps.bytes."0.4.12".either}".default = (f.either."${deps.bytes."0.4.12".either}".default or false);
    iovec."${deps.bytes."0.4.12".iovec}".default = true;
  }) [
    (features_.byteorder."${deps."bytes"."0.4.12"."byteorder"}" deps)
    (features_.either."${deps."bytes"."0.4.12"."either"}" deps)
    (features_.iovec."${deps."bytes"."0.4.12"."iovec"}" deps)
  ];


# end
# c2-chacha-0.2.2

  crates.c2_chacha."0.2.2" = deps: { features?(features_.c2_chacha."0.2.2" deps {}) }: buildRustCrate {
    crateName = "c2-chacha";
    version = "0.2.2";
    authors = [ "The CryptoCorrosion Contributors" ];
    edition = "2018";
    sha256 = "1lcfazshbiw8kdpcgphlmls0mz5j4wnvsq1diaz4b2bcvgm3r2cn";
    dependencies = mapFeatures features ([
      (crates."ppv_lite86"."${deps."c2_chacha"."0.2.2"."ppv_lite86"}" deps)
    ]
      ++ (if features.c2_chacha."0.2.2".lazy_static or false then [ (crates.lazy_static."${deps."c2_chacha"."0.2.2".lazy_static}" deps) ] else []));
    features = mkFeatures (features."c2_chacha"."0.2.2" or {});
  };
  features_.c2_chacha."0.2.2" = deps: f: updateFeatures f (rec {
    c2_chacha = fold recursiveUpdate {} [
      { "0.2.2".byteorder =
        (f.c2_chacha."0.2.2".byteorder or false) ||
        (f.c2_chacha."0.2.2".rustcrypto_api or false) ||
        (c2_chacha."0.2.2"."rustcrypto_api" or false); }
      { "0.2.2".default = (f.c2_chacha."0.2.2".default or true); }
      { "0.2.2".lazy_static =
        (f.c2_chacha."0.2.2".lazy_static or false) ||
        (f.c2_chacha."0.2.2".std or false) ||
        (c2_chacha."0.2.2"."std" or false); }
      { "0.2.2".rustcrypto_api =
        (f.c2_chacha."0.2.2".rustcrypto_api or false) ||
        (f.c2_chacha."0.2.2".default or false) ||
        (c2_chacha."0.2.2"."default" or false); }
      { "0.2.2".simd =
        (f.c2_chacha."0.2.2".simd or false) ||
        (f.c2_chacha."0.2.2".default or false) ||
        (c2_chacha."0.2.2"."default" or false); }
      { "0.2.2".std =
        (f.c2_chacha."0.2.2".std or false) ||
        (f.c2_chacha."0.2.2".default or false) ||
        (c2_chacha."0.2.2"."default" or false); }
      { "0.2.2".stream-cipher =
        (f.c2_chacha."0.2.2".stream-cipher or false) ||
        (f.c2_chacha."0.2.2".rustcrypto_api or false) ||
        (c2_chacha."0.2.2"."rustcrypto_api" or false); }
    ];
    lazy_static."${deps.c2_chacha."0.2.2".lazy_static}".default = true;
    ppv_lite86 = fold recursiveUpdate {} [
      { "${deps.c2_chacha."0.2.2".ppv_lite86}"."simd" =
        (f.ppv_lite86."${deps.c2_chacha."0.2.2".ppv_lite86}"."simd" or false) ||
        (c2_chacha."0.2.2"."simd" or false) ||
        (f."c2_chacha"."0.2.2"."simd" or false); }
      { "${deps.c2_chacha."0.2.2".ppv_lite86}".default = true; }
    ];
  }) [
    (features_.lazy_static."${deps."c2_chacha"."0.2.2"."lazy_static"}" deps)
    (features_.ppv_lite86."${deps."c2_chacha"."0.2.2"."ppv_lite86"}" deps)
  ];


# end
# cc-1.0.41

  crates.cc."1.0.41" = deps: { features?(features_.cc."1.0.41" deps {}) }: buildRustCrate {
    crateName = "cc";
    version = "1.0.41";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0i1rji2k9wrxi08n9gn47lxgpslyx8iym4va129jw9l67l1a7fm6";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."cc"."1.0.41" or {});
  };
  features_.cc."1.0.41" = deps: f: updateFeatures f (rec {
    cc = fold recursiveUpdate {} [
      { "1.0.41".default = (f.cc."1.0.41".default or true); }
      { "1.0.41".rayon =
        (f.cc."1.0.41".rayon or false) ||
        (f.cc."1.0.41".parallel or false) ||
        (cc."1.0.41"."parallel" or false); }
    ];
  }) [];


# end
# cfg-if-0.1.9

  crates.cfg_if."0.1.9" = deps: { features?(features_.cfg_if."0.1.9" deps {}) }: buildRustCrate {
    crateName = "cfg-if";
    version = "0.1.9";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "13g9p2mc5b2b5wn716fwvilzib376ycpkgk868yxfp16jzix57p7";
  };
  features_.cfg_if."0.1.9" = deps: f: updateFeatures f (rec {
    cfg_if."0.1.9".default = (f.cfg_if."0.1.9".default or true);
  }) [];


# end
# cgmath-0.16.1

  crates.cgmath."0.16.1" = deps: { features?(features_.cgmath."0.16.1" deps {}) }: buildRustCrate {
    crateName = "cgmath";
    version = "0.16.1";
    authors = [ "Brendan Zabarauskas <bjzaba@yahoo.com.au>" ];
    sha256 = "12xwzi8j3z18f2qlgv9kl83sp12dps9l55qp58id3zg62q4psbnm";
    dependencies = mapFeatures features ([
      (crates."approx"."${deps."cgmath"."0.16.1"."approx"}" deps)
      (crates."num_traits"."${deps."cgmath"."0.16.1"."num_traits"}" deps)
      (crates."rand"."${deps."cgmath"."0.16.1"."rand"}" deps)
    ]);
    features = mkFeatures (features."cgmath"."0.16.1" or {});
  };
  features_.cgmath."0.16.1" = deps: f: updateFeatures f (rec {
    approx."${deps.cgmath."0.16.1".approx}".default = true;
    cgmath."0.16.1".default = (f.cgmath."0.16.1".default or true);
    num_traits."${deps.cgmath."0.16.1".num_traits}".default = true;
    rand."${deps.cgmath."0.16.1".rand}".default = true;
  }) [
    (features_.approx."${deps."cgmath"."0.16.1"."approx"}" deps)
    (features_.num_traits."${deps."cgmath"."0.16.1"."num_traits"}" deps)
    (features_.rand."${deps."cgmath"."0.16.1"."rand"}" deps)
  ];


# end
# chrono-0.4.7

  crates.chrono."0.4.7" = deps: { features?(features_.chrono."0.4.7" deps {}) }: buildRustCrate {
    crateName = "chrono";
    version = "0.4.7";
    authors = [ "Kang Seonghoon <public+rust@mearie.org>" "Brandon W Maister <quodlibetor@gmail.com>" ];
    sha256 = "1f5r3h2vyr8g42fncp0g55qzaq2cxkchd59sjdlda1bl7m4wxnb5";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."chrono"."0.4.7"."libc"}" deps)
      (crates."num_integer"."${deps."chrono"."0.4.7"."num_integer"}" deps)
      (crates."num_traits"."${deps."chrono"."0.4.7"."num_traits"}" deps)
    ]
      ++ (if features.chrono."0.4.7".time or false then [ (crates.time."${deps."chrono"."0.4.7".time}" deps) ] else []));
    features = mkFeatures (features."chrono"."0.4.7" or {});
  };
  features_.chrono."0.4.7" = deps: f: updateFeatures f (rec {
    chrono = fold recursiveUpdate {} [
      { "0.4.7".clock =
        (f.chrono."0.4.7".clock or false) ||
        (f.chrono."0.4.7".default or false) ||
        (chrono."0.4.7"."default" or false); }
      { "0.4.7".default = (f.chrono."0.4.7".default or true); }
      { "0.4.7".time =
        (f.chrono."0.4.7".time or false) ||
        (f.chrono."0.4.7".clock or false) ||
        (chrono."0.4.7"."clock" or false); }
    ];
    libc."${deps.chrono."0.4.7".libc}".default = (f.libc."${deps.chrono."0.4.7".libc}".default or false);
    num_integer."${deps.chrono."0.4.7".num_integer}".default = (f.num_integer."${deps.chrono."0.4.7".num_integer}".default or false);
    num_traits."${deps.chrono."0.4.7".num_traits}".default = (f.num_traits."${deps.chrono."0.4.7".num_traits}".default or false);
    time."${deps.chrono."0.4.7".time}".default = true;
  }) [
    (features_.libc."${deps."chrono"."0.4.7"."libc"}" deps)
    (features_.num_integer."${deps."chrono"."0.4.7"."num_integer"}" deps)
    (features_.num_traits."${deps."chrono"."0.4.7"."num_traits"}" deps)
    (features_.time."${deps."chrono"."0.4.7"."time"}" deps)
  ];


# end
# clap-2.33.0

  crates.clap."2.33.0" = deps: { features?(features_.clap."2.33.0" deps {}) }: buildRustCrate {
    crateName = "clap";
    version = "2.33.0";
    authors = [ "Kevin K. <kbknapp@gmail.com>" ];
    sha256 = "054n9ngh6pkknpmd4acgdsp40iw6f5jzq8a4h2b76gnbvk6p5xjh";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."clap"."2.33.0"."bitflags"}" deps)
      (crates."textwrap"."${deps."clap"."2.33.0"."textwrap"}" deps)
      (crates."unicode_width"."${deps."clap"."2.33.0"."unicode_width"}" deps)
    ]
      ++ (if features.clap."2.33.0".atty or false then [ (crates.atty."${deps."clap"."2.33.0".atty}" deps) ] else [])
      ++ (if features.clap."2.33.0".strsim or false then [ (crates.strsim."${deps."clap"."2.33.0".strsim}" deps) ] else [])
      ++ (if features.clap."2.33.0".vec_map or false then [ (crates.vec_map."${deps."clap"."2.33.0".vec_map}" deps) ] else []))
      ++ (if !(kernel == "windows") then mapFeatures features ([
    ]
      ++ (if features.clap."2.33.0".ansi_term or false then [ (crates.ansi_term."${deps."clap"."2.33.0".ansi_term}" deps) ] else [])) else []);
    features = mkFeatures (features."clap"."2.33.0" or {});
  };
  features_.clap."2.33.0" = deps: f: updateFeatures f (rec {
    ansi_term."${deps.clap."2.33.0".ansi_term}".default = true;
    atty."${deps.clap."2.33.0".atty}".default = true;
    bitflags."${deps.clap."2.33.0".bitflags}".default = true;
    clap = fold recursiveUpdate {} [
      { "2.33.0".ansi_term =
        (f.clap."2.33.0".ansi_term or false) ||
        (f.clap."2.33.0".color or false) ||
        (clap."2.33.0"."color" or false); }
      { "2.33.0".atty =
        (f.clap."2.33.0".atty or false) ||
        (f.clap."2.33.0".color or false) ||
        (clap."2.33.0"."color" or false); }
      { "2.33.0".clippy =
        (f.clap."2.33.0".clippy or false) ||
        (f.clap."2.33.0".lints or false) ||
        (clap."2.33.0"."lints" or false); }
      { "2.33.0".color =
        (f.clap."2.33.0".color or false) ||
        (f.clap."2.33.0".default or false) ||
        (clap."2.33.0"."default" or false); }
      { "2.33.0".default = (f.clap."2.33.0".default or true); }
      { "2.33.0".strsim =
        (f.clap."2.33.0".strsim or false) ||
        (f.clap."2.33.0".suggestions or false) ||
        (clap."2.33.0"."suggestions" or false); }
      { "2.33.0".suggestions =
        (f.clap."2.33.0".suggestions or false) ||
        (f.clap."2.33.0".default or false) ||
        (clap."2.33.0"."default" or false); }
      { "2.33.0".term_size =
        (f.clap."2.33.0".term_size or false) ||
        (f.clap."2.33.0".wrap_help or false) ||
        (clap."2.33.0"."wrap_help" or false); }
      { "2.33.0".vec_map =
        (f.clap."2.33.0".vec_map or false) ||
        (f.clap."2.33.0".default or false) ||
        (clap."2.33.0"."default" or false); }
      { "2.33.0".yaml =
        (f.clap."2.33.0".yaml or false) ||
        (f.clap."2.33.0".doc or false) ||
        (clap."2.33.0"."doc" or false); }
      { "2.33.0".yaml-rust =
        (f.clap."2.33.0".yaml-rust or false) ||
        (f.clap."2.33.0".yaml or false) ||
        (clap."2.33.0"."yaml" or false); }
    ];
    strsim."${deps.clap."2.33.0".strsim}".default = true;
    textwrap = fold recursiveUpdate {} [
      { "${deps.clap."2.33.0".textwrap}"."term_size" =
        (f.textwrap."${deps.clap."2.33.0".textwrap}"."term_size" or false) ||
        (clap."2.33.0"."wrap_help" or false) ||
        (f."clap"."2.33.0"."wrap_help" or false); }
      { "${deps.clap."2.33.0".textwrap}".default = true; }
    ];
    unicode_width."${deps.clap."2.33.0".unicode_width}".default = true;
    vec_map."${deps.clap."2.33.0".vec_map}".default = true;
  }) [
    (features_.atty."${deps."clap"."2.33.0"."atty"}" deps)
    (features_.bitflags."${deps."clap"."2.33.0"."bitflags"}" deps)
    (features_.strsim."${deps."clap"."2.33.0"."strsim"}" deps)
    (features_.textwrap."${deps."clap"."2.33.0"."textwrap"}" deps)
    (features_.unicode_width."${deps."clap"."2.33.0"."unicode_width"}" deps)
    (features_.vec_map."${deps."clap"."2.33.0"."vec_map"}" deps)
    (features_.ansi_term."${deps."clap"."2.33.0"."ansi_term"}" deps)
  ];


# end
# cloudabi-0.0.3

  crates.cloudabi."0.0.3" = deps: { features?(features_.cloudabi."0.0.3" deps {}) }: buildRustCrate {
    crateName = "cloudabi";
    version = "0.0.3";
    authors = [ "Nuxi (https://nuxi.nl/) and contributors" ];
    sha256 = "1z9lby5sr6vslfd14d6igk03s7awf91mxpsfmsp3prxbxlk0x7h5";
    libPath = "cloudabi.rs";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.cloudabi."0.0.3".bitflags or false then [ (crates.bitflags."${deps."cloudabi"."0.0.3".bitflags}" deps) ] else []));
    features = mkFeatures (features."cloudabi"."0.0.3" or {});
  };
  features_.cloudabi."0.0.3" = deps: f: updateFeatures f (rec {
    bitflags."${deps.cloudabi."0.0.3".bitflags}".default = true;
    cloudabi = fold recursiveUpdate {} [
      { "0.0.3".bitflags =
        (f.cloudabi."0.0.3".bitflags or false) ||
        (f.cloudabi."0.0.3".default or false) ||
        (cloudabi."0.0.3"."default" or false); }
      { "0.0.3".default = (f.cloudabi."0.0.3".default or true); }
    ];
  }) [
    (features_.bitflags."${deps."cloudabi"."0.0.3"."bitflags"}" deps)
  ];


# end
# colored-1.8.0

  crates.colored."1.8.0" = deps: { features?(features_.colored."1.8.0" deps {}) }: buildRustCrate {
    crateName = "colored";
    version = "1.8.0";
    authors = [ "Thomas Wickham <mackwic@gmail.com>" ];
    sha256 = "1gwbq1g26n49wjqacdnr5gc3rfms7zkm8rbw5mc9zcdi6x2wmkya";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."colored"."1.8.0"."lazy_static"}" deps)
      (crates."winconsole"."${deps."colored"."1.8.0"."winconsole"}" deps)
    ]);
    features = mkFeatures (features."colored"."1.8.0" or {});
  };
  features_.colored."1.8.0" = deps: f: updateFeatures f (rec {
    colored."1.8.0".default = (f.colored."1.8.0".default or true);
    lazy_static."${deps.colored."1.8.0".lazy_static}".default = true;
    winconsole."${deps.colored."1.8.0".winconsole}".default = true;
  }) [
    (features_.lazy_static."${deps."colored"."1.8.0"."lazy_static"}" deps)
    (features_.winconsole."${deps."colored"."1.8.0"."winconsole"}" deps)
  ];


# end
# constant_time_eq-0.1.4

  crates.constant_time_eq."0.1.4" = deps: { features?(features_.constant_time_eq."0.1.4" deps {}) }: buildRustCrate {
    crateName = "constant_time_eq";
    version = "0.1.4";
    authors = [ "Cesar Eduardo Barros <cesarb@cesarb.eti.br>" ];
    sha256 = "0k3b5yavx7si8cy030py6bhgmg24sghzs8chbs4d4r13wjp5c5ih";
  };
  features_.constant_time_eq."0.1.4" = deps: f: updateFeatures f (rec {
    constant_time_eq."0.1.4".default = (f.constant_time_eq."0.1.4".default or true);
  }) [];


# end
# cookie-0.12.0

  crates.cookie."0.12.0" = deps: { features?(features_.cookie."0.12.0" deps {}) }: buildRustCrate {
    crateName = "cookie";
    version = "0.12.0";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Sergio Benitez <sb@sergio.bz>" ];
    sha256 = "0gqz78qlza819xakvakjzlk95bizj48x0aba6819z92777vb5y7g";
    dependencies = mapFeatures features ([
      (crates."time"."${deps."cookie"."0.12.0"."time"}" deps)
    ]
      ++ (if features.cookie."0.12.0".url or false then [ (crates.url."${deps."cookie"."0.12.0".url}" deps) ] else []));
    features = mkFeatures (features."cookie"."0.12.0" or {});
  };
  features_.cookie."0.12.0" = deps: f: updateFeatures f (rec {
    cookie = fold recursiveUpdate {} [
      { "0.12.0".base64 =
        (f.cookie."0.12.0".base64 or false) ||
        (f.cookie."0.12.0".secure or false) ||
        (cookie."0.12.0"."secure" or false); }
      { "0.12.0".default = (f.cookie."0.12.0".default or true); }
      { "0.12.0".ring =
        (f.cookie."0.12.0".ring or false) ||
        (f.cookie."0.12.0".secure or false) ||
        (cookie."0.12.0"."secure" or false); }
      { "0.12.0".url =
        (f.cookie."0.12.0".url or false) ||
        (f.cookie."0.12.0".percent-encode or false) ||
        (cookie."0.12.0"."percent-encode" or false); }
    ];
    time."${deps.cookie."0.12.0".time}".default = true;
    url."${deps.cookie."0.12.0".url}".default = true;
  }) [
    (features_.time."${deps."cookie"."0.12.0"."time"}" deps)
    (features_.url."${deps."cookie"."0.12.0"."url"}" deps)
  ];


# end
# cookie_store-0.7.0

  crates.cookie_store."0.7.0" = deps: { features?(features_.cookie_store."0.7.0" deps {}) }: buildRustCrate {
    crateName = "cookie_store";
    version = "0.7.0";
    authors = [ "patrick.fernie@gmail.com" ];
    edition = "2018";
    sha256 = "07wycaaplf613hcz4p54xn1s4l2fwhm0yy5xfr6fsfm17p3pkxln";
    dependencies = mapFeatures features ([
      (crates."cookie"."${deps."cookie_store"."0.7.0"."cookie"}" deps)
      (crates."failure"."${deps."cookie_store"."0.7.0"."failure"}" deps)
      (crates."idna"."${deps."cookie_store"."0.7.0"."idna"}" deps)
      (crates."log"."${deps."cookie_store"."0.7.0"."log"}" deps)
      (crates."publicsuffix"."${deps."cookie_store"."0.7.0"."publicsuffix"}" deps)
      (crates."serde"."${deps."cookie_store"."0.7.0"."serde"}" deps)
      (crates."serde_json"."${deps."cookie_store"."0.7.0"."serde_json"}" deps)
      (crates."time"."${deps."cookie_store"."0.7.0"."time"}" deps)
      (crates."try_from"."${deps."cookie_store"."0.7.0"."try_from"}" deps)
      (crates."url"."${deps."cookie_store"."0.7.0"."url"}" deps)
    ]);
  };
  features_.cookie_store."0.7.0" = deps: f: updateFeatures f (rec {
    cookie = fold recursiveUpdate {} [
      { "${deps.cookie_store."0.7.0".cookie}"."percent-encode" = true; }
      { "${deps.cookie_store."0.7.0".cookie}".default = true; }
    ];
    cookie_store."0.7.0".default = (f.cookie_store."0.7.0".default or true);
    failure."${deps.cookie_store."0.7.0".failure}".default = true;
    idna."${deps.cookie_store."0.7.0".idna}".default = true;
    log."${deps.cookie_store."0.7.0".log}".default = true;
    publicsuffix."${deps.cookie_store."0.7.0".publicsuffix}".default = (f.publicsuffix."${deps.cookie_store."0.7.0".publicsuffix}".default or false);
    serde = fold recursiveUpdate {} [
      { "${deps.cookie_store."0.7.0".serde}"."derive" = true; }
      { "${deps.cookie_store."0.7.0".serde}".default = true; }
    ];
    serde_json."${deps.cookie_store."0.7.0".serde_json}".default = true;
    time."${deps.cookie_store."0.7.0".time}".default = true;
    try_from."${deps.cookie_store."0.7.0".try_from}".default = true;
    url."${deps.cookie_store."0.7.0".url}".default = true;
  }) [
    (features_.cookie."${deps."cookie_store"."0.7.0"."cookie"}" deps)
    (features_.failure."${deps."cookie_store"."0.7.0"."failure"}" deps)
    (features_.idna."${deps."cookie_store"."0.7.0"."idna"}" deps)
    (features_.log."${deps."cookie_store"."0.7.0"."log"}" deps)
    (features_.publicsuffix."${deps."cookie_store"."0.7.0"."publicsuffix"}" deps)
    (features_.serde."${deps."cookie_store"."0.7.0"."serde"}" deps)
    (features_.serde_json."${deps."cookie_store"."0.7.0"."serde_json"}" deps)
    (features_.time."${deps."cookie_store"."0.7.0"."time"}" deps)
    (features_.try_from."${deps."cookie_store"."0.7.0"."try_from"}" deps)
    (features_.url."${deps."cookie_store"."0.7.0"."url"}" deps)
  ];


# end
# core-foundation-0.6.4

  crates.core_foundation."0.6.4" = deps: { features?(features_.core_foundation."0.6.4" deps {}) }: buildRustCrate {
    crateName = "core-foundation";
    version = "0.6.4";
    authors = [ "The Servo Project Developers" ];
    sha256 = "1kabsqxh01m6l2b1gz8wgn0d1k6fyczww9kaks0sbmsz5g78ngzx";
    dependencies = mapFeatures features ([
      (crates."core_foundation_sys"."${deps."core_foundation"."0.6.4"."core_foundation_sys"}" deps)
      (crates."libc"."${deps."core_foundation"."0.6.4"."libc"}" deps)
    ]);
    features = mkFeatures (features."core_foundation"."0.6.4" or {});
  };
  features_.core_foundation."0.6.4" = deps: f: updateFeatures f (rec {
    core_foundation = fold recursiveUpdate {} [
      { "0.6.4".chrono =
        (f.core_foundation."0.6.4".chrono or false) ||
        (f.core_foundation."0.6.4".with-chrono or false) ||
        (core_foundation."0.6.4"."with-chrono" or false); }
      { "0.6.4".default = (f.core_foundation."0.6.4".default or true); }
      { "0.6.4".uuid =
        (f.core_foundation."0.6.4".uuid or false) ||
        (f.core_foundation."0.6.4".with-uuid or false) ||
        (core_foundation."0.6.4"."with-uuid" or false); }
    ];
    core_foundation_sys = fold recursiveUpdate {} [
      { "${deps.core_foundation."0.6.4".core_foundation_sys}"."mac_os_10_7_support" =
        (f.core_foundation_sys."${deps.core_foundation."0.6.4".core_foundation_sys}"."mac_os_10_7_support" or false) ||
        (core_foundation."0.6.4"."mac_os_10_7_support" or false) ||
        (f."core_foundation"."0.6.4"."mac_os_10_7_support" or false); }
      { "${deps.core_foundation."0.6.4".core_foundation_sys}"."mac_os_10_8_features" =
        (f.core_foundation_sys."${deps.core_foundation."0.6.4".core_foundation_sys}"."mac_os_10_8_features" or false) ||
        (core_foundation."0.6.4"."mac_os_10_8_features" or false) ||
        (f."core_foundation"."0.6.4"."mac_os_10_8_features" or false); }
      { "${deps.core_foundation."0.6.4".core_foundation_sys}".default = true; }
    ];
    libc."${deps.core_foundation."0.6.4".libc}".default = true;
  }) [
    (features_.core_foundation_sys."${deps."core_foundation"."0.6.4"."core_foundation_sys"}" deps)
    (features_.libc."${deps."core_foundation"."0.6.4"."libc"}" deps)
  ];


# end
# core-foundation-sys-0.6.2

  crates.core_foundation_sys."0.6.2" = deps: { features?(features_.core_foundation_sys."0.6.2" deps {}) }: buildRustCrate {
    crateName = "core-foundation-sys";
    version = "0.6.2";
    authors = [ "The Servo Project Developers" ];
    sha256 = "1n2v6wlqkmqwhl7k6y50irx51p37xb0fcm3njbman82gnyq8di2c";
    build = "build.rs";
    features = mkFeatures (features."core_foundation_sys"."0.6.2" or {});
  };
  features_.core_foundation_sys."0.6.2" = deps: f: updateFeatures f (rec {
    core_foundation_sys."0.6.2".default = (f.core_foundation_sys."0.6.2".default or true);
  }) [];


# end
# crc32fast-1.2.0

  crates.crc32fast."1.2.0" = deps: { features?(features_.crc32fast."1.2.0" deps {}) }: buildRustCrate {
    crateName = "crc32fast";
    version = "1.2.0";
    authors = [ "Sam Rijs <srijs@airpost.net>" "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1mx88ndqln6vzg7hjhjp8b7g0qggpqggsjrlsdqrfsrbpdzffcn8";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."crc32fast"."1.2.0"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."crc32fast"."1.2.0" or {});
  };
  features_.crc32fast."1.2.0" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.crc32fast."1.2.0".cfg_if}".default = true;
    crc32fast = fold recursiveUpdate {} [
      { "1.2.0".default = (f.crc32fast."1.2.0".default or true); }
      { "1.2.0".std =
        (f.crc32fast."1.2.0".std or false) ||
        (f.crc32fast."1.2.0".default or false) ||
        (crc32fast."1.2.0"."default" or false); }
    ];
  }) [
    (features_.cfg_if."${deps."crc32fast"."1.2.0"."cfg_if"}" deps)
  ];


# end
# crossbeam-deque-0.7.1

  crates.crossbeam_deque."0.7.1" = deps: { features?(features_.crossbeam_deque."0.7.1" deps {}) }: buildRustCrate {
    crateName = "crossbeam-deque";
    version = "0.7.1";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "11l7idrx3diksrxbaa13f9h9i6f3456qq3647f3kglxfjmz9bm8s";
    dependencies = mapFeatures features ([
      (crates."crossbeam_epoch"."${deps."crossbeam_deque"."0.7.1"."crossbeam_epoch"}" deps)
      (crates."crossbeam_utils"."${deps."crossbeam_deque"."0.7.1"."crossbeam_utils"}" deps)
    ]);
  };
  features_.crossbeam_deque."0.7.1" = deps: f: updateFeatures f (rec {
    crossbeam_deque."0.7.1".default = (f.crossbeam_deque."0.7.1".default or true);
    crossbeam_epoch."${deps.crossbeam_deque."0.7.1".crossbeam_epoch}".default = true;
    crossbeam_utils."${deps.crossbeam_deque."0.7.1".crossbeam_utils}".default = true;
  }) [
    (features_.crossbeam_epoch."${deps."crossbeam_deque"."0.7.1"."crossbeam_epoch"}" deps)
    (features_.crossbeam_utils."${deps."crossbeam_deque"."0.7.1"."crossbeam_utils"}" deps)
  ];


# end
# crossbeam-epoch-0.7.2

  crates.crossbeam_epoch."0.7.2" = deps: { features?(features_.crossbeam_epoch."0.7.2" deps {}) }: buildRustCrate {
    crateName = "crossbeam-epoch";
    version = "0.7.2";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "015axh69r6ggj481ncqj09d7ssbqf8psgyqq9hhpkrh3j7xn4vmn";
    dependencies = mapFeatures features ([
      (crates."arrayvec"."${deps."crossbeam_epoch"."0.7.2"."arrayvec"}" deps)
      (crates."cfg_if"."${deps."crossbeam_epoch"."0.7.2"."cfg_if"}" deps)
      (crates."crossbeam_utils"."${deps."crossbeam_epoch"."0.7.2"."crossbeam_utils"}" deps)
      (crates."memoffset"."${deps."crossbeam_epoch"."0.7.2"."memoffset"}" deps)
      (crates."scopeguard"."${deps."crossbeam_epoch"."0.7.2"."scopeguard"}" deps)
    ]
      ++ (if features.crossbeam_epoch."0.7.2".lazy_static or false then [ (crates.lazy_static."${deps."crossbeam_epoch"."0.7.2".lazy_static}" deps) ] else []));
    features = mkFeatures (features."crossbeam_epoch"."0.7.2" or {});
  };
  features_.crossbeam_epoch."0.7.2" = deps: f: updateFeatures f (rec {
    arrayvec = fold recursiveUpdate {} [
      { "${deps.crossbeam_epoch."0.7.2".arrayvec}"."use_union" =
        (f.arrayvec."${deps.crossbeam_epoch."0.7.2".arrayvec}"."use_union" or false) ||
        (crossbeam_epoch."0.7.2"."nightly" or false) ||
        (f."crossbeam_epoch"."0.7.2"."nightly" or false); }
      { "${deps.crossbeam_epoch."0.7.2".arrayvec}".default = (f.arrayvec."${deps.crossbeam_epoch."0.7.2".arrayvec}".default or false); }
    ];
    cfg_if."${deps.crossbeam_epoch."0.7.2".cfg_if}".default = true;
    crossbeam_epoch = fold recursiveUpdate {} [
      { "0.7.2".default = (f.crossbeam_epoch."0.7.2".default or true); }
      { "0.7.2".lazy_static =
        (f.crossbeam_epoch."0.7.2".lazy_static or false) ||
        (f.crossbeam_epoch."0.7.2".std or false) ||
        (crossbeam_epoch."0.7.2"."std" or false); }
      { "0.7.2".std =
        (f.crossbeam_epoch."0.7.2".std or false) ||
        (f.crossbeam_epoch."0.7.2".default or false) ||
        (crossbeam_epoch."0.7.2"."default" or false); }
    ];
    crossbeam_utils = fold recursiveUpdate {} [
      { "${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."alloc" =
        (f.crossbeam_utils."${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."alloc" or false) ||
        (crossbeam_epoch."0.7.2"."alloc" or false) ||
        (f."crossbeam_epoch"."0.7.2"."alloc" or false); }
      { "${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."nightly" =
        (f.crossbeam_utils."${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."nightly" or false) ||
        (crossbeam_epoch."0.7.2"."nightly" or false) ||
        (f."crossbeam_epoch"."0.7.2"."nightly" or false); }
      { "${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."std" =
        (f.crossbeam_utils."${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."std" or false) ||
        (crossbeam_epoch."0.7.2"."std" or false) ||
        (f."crossbeam_epoch"."0.7.2"."std" or false); }
      { "${deps.crossbeam_epoch."0.7.2".crossbeam_utils}".default = (f.crossbeam_utils."${deps.crossbeam_epoch."0.7.2".crossbeam_utils}".default or false); }
    ];
    lazy_static."${deps.crossbeam_epoch."0.7.2".lazy_static}".default = true;
    memoffset."${deps.crossbeam_epoch."0.7.2".memoffset}".default = true;
    scopeguard."${deps.crossbeam_epoch."0.7.2".scopeguard}".default = (f.scopeguard."${deps.crossbeam_epoch."0.7.2".scopeguard}".default or false);
  }) [
    (features_.arrayvec."${deps."crossbeam_epoch"."0.7.2"."arrayvec"}" deps)
    (features_.cfg_if."${deps."crossbeam_epoch"."0.7.2"."cfg_if"}" deps)
    (features_.crossbeam_utils."${deps."crossbeam_epoch"."0.7.2"."crossbeam_utils"}" deps)
    (features_.lazy_static."${deps."crossbeam_epoch"."0.7.2"."lazy_static"}" deps)
    (features_.memoffset."${deps."crossbeam_epoch"."0.7.2"."memoffset"}" deps)
    (features_.scopeguard."${deps."crossbeam_epoch"."0.7.2"."scopeguard"}" deps)
  ];


# end
# crossbeam-queue-0.1.2

  crates.crossbeam_queue."0.1.2" = deps: { features?(features_.crossbeam_queue."0.1.2" deps {}) }: buildRustCrate {
    crateName = "crossbeam-queue";
    version = "0.1.2";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "1hannzr5w6j5061kg5iba4fzi6f2xpqv7bkcspfq17y1i8g0mzjj";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."crossbeam_queue"."0.1.2"."crossbeam_utils"}" deps)
    ]);
  };
  features_.crossbeam_queue."0.1.2" = deps: f: updateFeatures f (rec {
    crossbeam_queue."0.1.2".default = (f.crossbeam_queue."0.1.2".default or true);
    crossbeam_utils."${deps.crossbeam_queue."0.1.2".crossbeam_utils}".default = true;
  }) [
    (features_.crossbeam_utils."${deps."crossbeam_queue"."0.1.2"."crossbeam_utils"}" deps)
  ];


# end
# crossbeam-utils-0.6.6

  crates.crossbeam_utils."0.6.6" = deps: { features?(features_.crossbeam_utils."0.6.6" deps {}) }: buildRustCrate {
    crateName = "crossbeam-utils";
    version = "0.6.6";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "01gxccmrjkkcavdh8fc01kj3b5fmk10f0lkx66jmnv69kcssry72";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."crossbeam_utils"."0.6.6"."cfg_if"}" deps)
    ]
      ++ (if features.crossbeam_utils."0.6.6".lazy_static or false then [ (crates.lazy_static."${deps."crossbeam_utils"."0.6.6".lazy_static}" deps) ] else []));
    features = mkFeatures (features."crossbeam_utils"."0.6.6" or {});
  };
  features_.crossbeam_utils."0.6.6" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.crossbeam_utils."0.6.6".cfg_if}".default = true;
    crossbeam_utils = fold recursiveUpdate {} [
      { "0.6.6".default = (f.crossbeam_utils."0.6.6".default or true); }
      { "0.6.6".lazy_static =
        (f.crossbeam_utils."0.6.6".lazy_static or false) ||
        (f.crossbeam_utils."0.6.6".std or false) ||
        (crossbeam_utils."0.6.6"."std" or false); }
      { "0.6.6".std =
        (f.crossbeam_utils."0.6.6".std or false) ||
        (f.crossbeam_utils."0.6.6".default or false) ||
        (crossbeam_utils."0.6.6"."default" or false); }
    ];
    lazy_static."${deps.crossbeam_utils."0.6.6".lazy_static}".default = true;
  }) [
    (features_.cfg_if."${deps."crossbeam_utils"."0.6.6"."cfg_if"}" deps)
    (features_.lazy_static."${deps."crossbeam_utils"."0.6.6"."lazy_static"}" deps)
  ];


# end
# csv-1.1.1

  crates.csv."1.1.1" = deps: { features?(features_.csv."1.1.1" deps {}) }: buildRustCrate {
    crateName = "csv";
    version = "1.1.1";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    edition = "2018";
    sha256 = "04g8pnrbl29s5binxc8q6yh6rq6kipk27k1xgp54lmbybnyhsp9g";
    dependencies = mapFeatures features ([
      (crates."bstr"."${deps."csv"."1.1.1"."bstr"}" deps)
      (crates."csv_core"."${deps."csv"."1.1.1"."csv_core"}" deps)
      (crates."itoa"."${deps."csv"."1.1.1"."itoa"}" deps)
      (crates."ryu"."${deps."csv"."1.1.1"."ryu"}" deps)
      (crates."serde"."${deps."csv"."1.1.1"."serde"}" deps)
    ]);
  };
  features_.csv."1.1.1" = deps: f: updateFeatures f (rec {
    bstr = fold recursiveUpdate {} [
      { "${deps.csv."1.1.1".bstr}"."serde1" = true; }
      { "${deps.csv."1.1.1".bstr}".default = true; }
    ];
    csv."1.1.1".default = (f.csv."1.1.1".default or true);
    csv_core."${deps.csv."1.1.1".csv_core}".default = true;
    itoa."${deps.csv."1.1.1".itoa}".default = true;
    ryu."${deps.csv."1.1.1".ryu}".default = true;
    serde."${deps.csv."1.1.1".serde}".default = true;
  }) [
    (features_.bstr."${deps."csv"."1.1.1"."bstr"}" deps)
    (features_.csv_core."${deps."csv"."1.1.1"."csv_core"}" deps)
    (features_.itoa."${deps."csv"."1.1.1"."itoa"}" deps)
    (features_.ryu."${deps."csv"."1.1.1"."ryu"}" deps)
    (features_.serde."${deps."csv"."1.1.1"."serde"}" deps)
  ];


# end
# csv-core-0.1.6

  crates.csv_core."0.1.6" = deps: { features?(features_.csv_core."0.1.6" deps {}) }: buildRustCrate {
    crateName = "csv-core";
    version = "0.1.6";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    edition = "2018";
    sha256 = "1fkcrws2cka5hvq7h5y8anargygx4xjzx1xhq8kdp4knn6qnxs2n";
    dependencies = mapFeatures features ([
      (crates."memchr"."${deps."csv_core"."0.1.6"."memchr"}" deps)
    ]);
    features = mkFeatures (features."csv_core"."0.1.6" or {});
  };
  features_.csv_core."0.1.6" = deps: f: updateFeatures f (rec {
    csv_core = fold recursiveUpdate {} [
      { "0.1.6".default = (f.csv_core."0.1.6".default or true); }
      { "0.1.6".libc =
        (f.csv_core."0.1.6".libc or false) ||
        (f.csv_core."0.1.6".default or false) ||
        (csv_core."0.1.6"."default" or false); }
    ];
    memchr = fold recursiveUpdate {} [
      { "${deps.csv_core."0.1.6".memchr}"."libc" =
        (f.memchr."${deps.csv_core."0.1.6".memchr}"."libc" or false) ||
        (csv_core."0.1.6"."libc" or false) ||
        (f."csv_core"."0.1.6"."libc" or false); }
      { "${deps.csv_core."0.1.6".memchr}".default = (f.memchr."${deps.csv_core."0.1.6".memchr}".default or false); }
    ];
  }) [
    (features_.memchr."${deps."csv_core"."0.1.6"."memchr"}" deps)
  ];


# end
# difference-2.0.0

  crates.difference."2.0.0" = deps: { features?(features_.difference."2.0.0" deps {}) }: buildRustCrate {
    crateName = "difference";
    version = "2.0.0";
    authors = [ "Johann Hofmann <mail@johann-hofmann.com>" ];
    sha256 = "1rk24wxxkhhw8drhda229dfy2nb64vvcz0ras6lq7va6wswlrc49";
    crateBin =
      [{  name = "difference"; }];
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."difference"."2.0.0" or {});
  };
  features_.difference."2.0.0" = deps: f: updateFeatures f (rec {
    difference = fold recursiveUpdate {} [
      { "2.0.0".default = (f.difference."2.0.0".default or true); }
      { "2.0.0".getopts =
        (f.difference."2.0.0".getopts or false) ||
        (f.difference."2.0.0".bin or false) ||
        (difference."2.0.0"."bin" or false); }
    ];
  }) [];


# end
# dirs-1.0.5

  crates.dirs."1.0.5" = deps: { features?(features_.dirs."1.0.5" deps {}) }: buildRustCrate {
    crateName = "dirs";
    version = "1.0.5";
    authors = [ "Simon Ochsenreither <simon@ochsenreither.de>" ];
    sha256 = "1py68zwwrhlj5vbz9f9ansjmhc8y4gs5bpamw9ycmqz030pprwf3";
    dependencies = (if kernel == "redox" then mapFeatures features ([
      (crates."redox_users"."${deps."dirs"."1.0.5"."redox_users"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."dirs"."1.0.5"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."dirs"."1.0.5"."winapi"}" deps)
    ]) else []);
  };
  features_.dirs."1.0.5" = deps: f: updateFeatures f (rec {
    dirs."1.0.5".default = (f.dirs."1.0.5".default or true);
    libc."${deps.dirs."1.0.5".libc}".default = true;
    redox_users."${deps.dirs."1.0.5".redox_users}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.dirs."1.0.5".winapi}"."knownfolders" = true; }
      { "${deps.dirs."1.0.5".winapi}"."objbase" = true; }
      { "${deps.dirs."1.0.5".winapi}"."shlobj" = true; }
      { "${deps.dirs."1.0.5".winapi}"."winbase" = true; }
      { "${deps.dirs."1.0.5".winapi}"."winerror" = true; }
      { "${deps.dirs."1.0.5".winapi}".default = true; }
    ];
  }) [
    (features_.redox_users."${deps."dirs"."1.0.5"."redox_users"}" deps)
    (features_.libc."${deps."dirs"."1.0.5"."libc"}" deps)
    (features_.winapi."${deps."dirs"."1.0.5"."winapi"}" deps)
  ];


# end
# dtoa-0.4.4

  crates.dtoa."0.4.4" = deps: { features?(features_.dtoa."0.4.4" deps {}) }: buildRustCrate {
    crateName = "dtoa";
    version = "0.4.4";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1nbq72nc2kp8lbx6i1ml5ird5c0cy4i6dvm7wfydybmanw4m07xz";
  };
  features_.dtoa."0.4.4" = deps: f: updateFeatures f (rec {
    dtoa."0.4.4".default = (f.dtoa."0.4.4".default or true);
  }) [];


# end
# either-1.5.2

  crates.either."1.5.2" = deps: { features?(features_.either."1.5.2" deps {}) }: buildRustCrate {
    crateName = "either";
    version = "1.5.2";
    authors = [ "bluss" ];
    sha256 = "1zqq1057c51f53ga4p9l4dd8ax6md27h1xjrjp2plkvml5iymks5";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."either"."1.5.2" or {});
  };
  features_.either."1.5.2" = deps: f: updateFeatures f (rec {
    either = fold recursiveUpdate {} [
      { "1.5.2".default = (f.either."1.5.2".default or true); }
      { "1.5.2".use_std =
        (f.either."1.5.2".use_std or false) ||
        (f.either."1.5.2".default or false) ||
        (either."1.5.2"."default" or false); }
    ];
  }) [];


# end
# encode_unicode-0.3.6

  crates.encode_unicode."0.3.6" = deps: { features?(features_.encode_unicode."0.3.6" deps {}) }: buildRustCrate {
    crateName = "encode_unicode";
    version = "0.3.6";
    authors = [ "Torbjørn Birch Moltu <t.b.moltu@lyse.net>" ];
    sha256 = "1d87mrirdz691sffc6ghy6ahf3zrs2iynrwzjibbjkb9307fm2dg";
    dependencies = mapFeatures features ([
])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
]) else []);
    features = mkFeatures (features."encode_unicode"."0.3.6" or {});
  };
  features_.encode_unicode."0.3.6" = deps: f: updateFeatures f (rec {
    encode_unicode = fold recursiveUpdate {} [
      { "0.3.6".default = (f.encode_unicode."0.3.6".default or true); }
      { "0.3.6".std =
        (f.encode_unicode."0.3.6".std or false) ||
        (f.encode_unicode."0.3.6".default or false) ||
        (encode_unicode."0.3.6"."default" or false); }
    ];
  }) [];


# end
# encoding_rs-0.8.17

  crates.encoding_rs."0.8.17" = deps: { features?(features_.encoding_rs."0.8.17" deps {}) }: buildRustCrate {
    crateName = "encoding_rs";
    version = "0.8.17";
    authors = [ "Henri Sivonen <hsivonen@hsivonen.fi>" ];
    sha256 = "0p8afcx1flzr1sz2ja2gvn9c000mb8k7ysy5vv0ia3khac3i30li";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."encoding_rs"."0.8.17"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."encoding_rs"."0.8.17" or {});
  };
  features_.encoding_rs."0.8.17" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.encoding_rs."0.8.17".cfg_if}".default = true;
    encoding_rs = fold recursiveUpdate {} [
      { "0.8.17".default = (f.encoding_rs."0.8.17".default or true); }
      { "0.8.17".fast-big5-hanzi-encode =
        (f.encoding_rs."0.8.17".fast-big5-hanzi-encode or false) ||
        (f.encoding_rs."0.8.17".fast-legacy-encode or false) ||
        (encoding_rs."0.8.17"."fast-legacy-encode" or false); }
      { "0.8.17".fast-gb-hanzi-encode =
        (f.encoding_rs."0.8.17".fast-gb-hanzi-encode or false) ||
        (f.encoding_rs."0.8.17".fast-legacy-encode or false) ||
        (encoding_rs."0.8.17"."fast-legacy-encode" or false); }
      { "0.8.17".fast-hangul-encode =
        (f.encoding_rs."0.8.17".fast-hangul-encode or false) ||
        (f.encoding_rs."0.8.17".fast-legacy-encode or false) ||
        (encoding_rs."0.8.17"."fast-legacy-encode" or false); }
      { "0.8.17".fast-hanja-encode =
        (f.encoding_rs."0.8.17".fast-hanja-encode or false) ||
        (f.encoding_rs."0.8.17".fast-legacy-encode or false) ||
        (encoding_rs."0.8.17"."fast-legacy-encode" or false); }
      { "0.8.17".fast-kanji-encode =
        (f.encoding_rs."0.8.17".fast-kanji-encode or false) ||
        (f.encoding_rs."0.8.17".fast-legacy-encode or false) ||
        (encoding_rs."0.8.17"."fast-legacy-encode" or false); }
      { "0.8.17".packed_simd =
        (f.encoding_rs."0.8.17".packed_simd or false) ||
        (f.encoding_rs."0.8.17".simd-accel or false) ||
        (encoding_rs."0.8.17"."simd-accel" or false); }
    ];
  }) [
    (features_.cfg_if."${deps."encoding_rs"."0.8.17"."cfg_if"}" deps)
  ];


# end
# error-chain-0.12.1

  crates.error_chain."0.12.1" = deps: { features?(features_.error_chain."0.12.1" deps {}) }: buildRustCrate {
    crateName = "error-chain";
    version = "0.12.1";
    authors = [ "Brian Anderson <banderson@mozilla.com>" "Paul Colomiets <paul@colomiets.name>" "Colin Kiegel <kiegel@gmx.de>" "Yamakaky <yamakaky@yamaworld.fr>" ];
    sha256 = "1lgs40xn50p0n4yqyryv9gzpvjw7sg355vjqcqmn5ai84rmh14m7";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.error_chain."0.12.1".backtrace or false then [ (crates.backtrace."${deps."error_chain"."0.12.1".backtrace}" deps) ] else []));

    buildDependencies = mapFeatures features ([
      (crates."version_check"."${deps."error_chain"."0.12.1"."version_check"}" deps)
    ]);
    features = mkFeatures (features."error_chain"."0.12.1" or {});
  };
  features_.error_chain."0.12.1" = deps: f: updateFeatures f (rec {
    backtrace."${deps.error_chain."0.12.1".backtrace}".default = true;
    error_chain = fold recursiveUpdate {} [
      { "0.12.1".backtrace =
        (f.error_chain."0.12.1".backtrace or false) ||
        (f.error_chain."0.12.1".default or false) ||
        (error_chain."0.12.1"."default" or false); }
      { "0.12.1".default = (f.error_chain."0.12.1".default or true); }
      { "0.12.1".example_generated =
        (f.error_chain."0.12.1".example_generated or false) ||
        (f.error_chain."0.12.1".default or false) ||
        (error_chain."0.12.1"."default" or false); }
    ];
    version_check."${deps.error_chain."0.12.1".version_check}".default = true;
  }) [
    (features_.backtrace."${deps."error_chain"."0.12.1"."backtrace"}" deps)
    (features_.version_check."${deps."error_chain"."0.12.1"."version_check"}" deps)
  ];


# end
# failure-0.1.5

  crates.failure."0.1.5" = deps: { features?(features_.failure."0.1.5" deps {}) }: buildRustCrate {
    crateName = "failure";
    version = "0.1.5";
    authors = [ "Without Boats <boats@mozilla.com>" ];
    sha256 = "1msaj1c0fg12dzyf4fhxqlx1gfx41lj2smdjmkc9hkrgajk2g3kx";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.failure."0.1.5".backtrace or false then [ (crates.backtrace."${deps."failure"."0.1.5".backtrace}" deps) ] else [])
      ++ (if features.failure."0.1.5".failure_derive or false then [ (crates.failure_derive."${deps."failure"."0.1.5".failure_derive}" deps) ] else []));
    features = mkFeatures (features."failure"."0.1.5" or {});
  };
  features_.failure."0.1.5" = deps: f: updateFeatures f (rec {
    backtrace."${deps.failure."0.1.5".backtrace}".default = true;
    failure = fold recursiveUpdate {} [
      { "0.1.5".backtrace =
        (f.failure."0.1.5".backtrace or false) ||
        (f.failure."0.1.5".std or false) ||
        (failure."0.1.5"."std" or false); }
      { "0.1.5".default = (f.failure."0.1.5".default or true); }
      { "0.1.5".derive =
        (f.failure."0.1.5".derive or false) ||
        (f.failure."0.1.5".default or false) ||
        (failure."0.1.5"."default" or false); }
      { "0.1.5".failure_derive =
        (f.failure."0.1.5".failure_derive or false) ||
        (f.failure."0.1.5".derive or false) ||
        (failure."0.1.5"."derive" or false); }
      { "0.1.5".std =
        (f.failure."0.1.5".std or false) ||
        (f.failure."0.1.5".default or false) ||
        (failure."0.1.5"."default" or false); }
    ];
    failure_derive."${deps.failure."0.1.5".failure_derive}".default = true;
  }) [
    (features_.backtrace."${deps."failure"."0.1.5"."backtrace"}" deps)
    (features_.failure_derive."${deps."failure"."0.1.5"."failure_derive"}" deps)
  ];


# end
# failure_derive-0.1.5

  crates.failure_derive."0.1.5" = deps: { features?(features_.failure_derive."0.1.5" deps {}) }: buildRustCrate {
    crateName = "failure_derive";
    version = "0.1.5";
    authors = [ "Without Boats <woboats@gmail.com>" ];
    sha256 = "1wzk484b87r4qszcvdl2bkniv5ls4r2f2dshz7hmgiv6z4ln12g0";
    procMacro = true;
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."failure_derive"."0.1.5"."proc_macro2"}" deps)
      (crates."quote"."${deps."failure_derive"."0.1.5"."quote"}" deps)
      (crates."syn"."${deps."failure_derive"."0.1.5"."syn"}" deps)
      (crates."synstructure"."${deps."failure_derive"."0.1.5"."synstructure"}" deps)
    ]);
    features = mkFeatures (features."failure_derive"."0.1.5" or {});
  };
  features_.failure_derive."0.1.5" = deps: f: updateFeatures f (rec {
    failure_derive."0.1.5".default = (f.failure_derive."0.1.5".default or true);
    proc_macro2."${deps.failure_derive."0.1.5".proc_macro2}".default = true;
    quote."${deps.failure_derive."0.1.5".quote}".default = true;
    syn."${deps.failure_derive."0.1.5".syn}".default = true;
    synstructure."${deps.failure_derive."0.1.5".synstructure}".default = true;
  }) [
    (features_.proc_macro2."${deps."failure_derive"."0.1.5"."proc_macro2"}" deps)
    (features_.quote."${deps."failure_derive"."0.1.5"."quote"}" deps)
    (features_.syn."${deps."failure_derive"."0.1.5"."syn"}" deps)
    (features_.synstructure."${deps."failure_derive"."0.1.5"."synstructure"}" deps)
  ];


# end
# flate2-1.0.11

  crates.flate2."1.0.11" = deps: { features?(features_.flate2."1.0.11" deps {}) }: buildRustCrate {
    crateName = "flate2";
    version = "1.0.11";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0cx98sl8nycw6ldb55lmy0gx3w20b3955ybjdlprdp2az16wngp6";
    dependencies = mapFeatures features ([
      (crates."crc32fast"."${deps."flate2"."1.0.11"."crc32fast"}" deps)
      (crates."libc"."${deps."flate2"."1.0.11"."libc"}" deps)
    ]
      ++ (if features.flate2."1.0.11".miniz_oxide or false then [ (crates.miniz_oxide."${deps."flate2"."1.0.11".miniz_oxide}" deps) ] else []))
      ++ (if cpu == "wasm32" && !(kernel == "emscripten") then mapFeatures features ([
      (crates."miniz_oxide"."${deps."flate2"."1.0.11"."miniz_oxide"}" deps)
    ]) else []);
    features = mkFeatures (features."flate2"."1.0.11" or {});
  };
  features_.flate2."1.0.11" = deps: f: updateFeatures f (rec {
    crc32fast."${deps.flate2."1.0.11".crc32fast}".default = true;
    flate2 = fold recursiveUpdate {} [
      { "1.0.11".default = (f.flate2."1.0.11".default or true); }
      { "1.0.11".futures =
        (f.flate2."1.0.11".futures or false) ||
        (f.flate2."1.0.11".tokio or false) ||
        (flate2."1.0.11"."tokio" or false); }
      { "1.0.11".libz-sys =
        (f.flate2."1.0.11".libz-sys or false) ||
        (f.flate2."1.0.11".zlib or false) ||
        (flate2."1.0.11"."zlib" or false); }
      { "1.0.11".miniz-sys =
        (f.flate2."1.0.11".miniz-sys or false) ||
        (f.flate2."1.0.11".default or false) ||
        (flate2."1.0.11"."default" or false); }
      { "1.0.11".miniz_oxide =
        (f.flate2."1.0.11".miniz_oxide or false) ||
        (f.flate2."1.0.11".rust_backend or false) ||
        (flate2."1.0.11"."rust_backend" or false); }
      { "1.0.11".tokio-io =
        (f.flate2."1.0.11".tokio-io or false) ||
        (f.flate2."1.0.11".tokio or false) ||
        (flate2."1.0.11"."tokio" or false); }
    ];
    libc."${deps.flate2."1.0.11".libc}".default = true;
    miniz_oxide."${deps.flate2."1.0.11".miniz_oxide}".default = true;
  }) [
    (features_.crc32fast."${deps."flate2"."1.0.11"."crc32fast"}" deps)
    (features_.libc."${deps."flate2"."1.0.11"."libc"}" deps)
    (features_.miniz_oxide."${deps."flate2"."1.0.11"."miniz_oxide"}" deps)
    (features_.miniz_oxide."${deps."flate2"."1.0.11"."miniz_oxide"}" deps)
  ];


# end
# fnv-1.0.6

  crates.fnv."1.0.6" = deps: { features?(features_.fnv."1.0.6" deps {}) }: buildRustCrate {
    crateName = "fnv";
    version = "1.0.6";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "128mlh23y3gg6ag5h8iiqlcbl59smisdzraqy88ldrf75kbw27ip";
    libPath = "lib.rs";
  };
  features_.fnv."1.0.6" = deps: f: updateFeatures f (rec {
    fnv."1.0.6".default = (f.fnv."1.0.6".default or true);
  }) [];


# end
# foreign-types-0.3.2

  crates.foreign_types."0.3.2" = deps: { features?(features_.foreign_types."0.3.2" deps {}) }: buildRustCrate {
    crateName = "foreign-types";
    version = "0.3.2";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "105n8sp2djb1s5lzrw04p7ss3dchr5qa3canmynx396nh3vwm2p8";
    dependencies = mapFeatures features ([
      (crates."foreign_types_shared"."${deps."foreign_types"."0.3.2"."foreign_types_shared"}" deps)
    ]);
  };
  features_.foreign_types."0.3.2" = deps: f: updateFeatures f (rec {
    foreign_types."0.3.2".default = (f.foreign_types."0.3.2".default or true);
    foreign_types_shared."${deps.foreign_types."0.3.2".foreign_types_shared}".default = true;
  }) [
    (features_.foreign_types_shared."${deps."foreign_types"."0.3.2"."foreign_types_shared"}" deps)
  ];


# end
# foreign-types-shared-0.1.1

  crates.foreign_types_shared."0.1.1" = deps: { features?(features_.foreign_types_shared."0.1.1" deps {}) }: buildRustCrate {
    crateName = "foreign-types-shared";
    version = "0.1.1";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0b6cnvqbflws8dxywk4589vgbz80049lz4x1g9dfy4s1ppd3g4z5";
  };
  features_.foreign_types_shared."0.1.1" = deps: f: updateFeatures f (rec {
    foreign_types_shared."0.1.1".default = (f.foreign_types_shared."0.1.1".default or true);
  }) [];


# end
# fuchsia-cprng-0.1.1

  crates.fuchsia_cprng."0.1.1" = deps: { features?(features_.fuchsia_cprng."0.1.1" deps {}) }: buildRustCrate {
    crateName = "fuchsia-cprng";
    version = "0.1.1";
    authors = [ "Erick Tryzelaar <etryzelaar@google.com>" ];
    edition = "2018";
    sha256 = "07apwv9dj716yjlcj29p94vkqn5zmfh7hlrqvrjx3wzshphc95h9";
  };
  features_.fuchsia_cprng."0.1.1" = deps: f: updateFeatures f (rec {
    fuchsia_cprng."0.1.1".default = (f.fuchsia_cprng."0.1.1".default or true);
  }) [];


# end
# fuchsia-zircon-0.3.3

  crates.fuchsia_zircon."0.3.3" = deps: { features?(features_.fuchsia_zircon."0.3.3" deps {}) }: buildRustCrate {
    crateName = "fuchsia-zircon";
    version = "0.3.3";
    authors = [ "Raph Levien <raph@google.com>" ];
    sha256 = "0jrf4shb1699r4la8z358vri8318w4mdi6qzfqy30p2ymjlca4gk";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."fuchsia_zircon"."0.3.3"."bitflags"}" deps)
      (crates."fuchsia_zircon_sys"."${deps."fuchsia_zircon"."0.3.3"."fuchsia_zircon_sys"}" deps)
    ]);
  };
  features_.fuchsia_zircon."0.3.3" = deps: f: updateFeatures f (rec {
    bitflags."${deps.fuchsia_zircon."0.3.3".bitflags}".default = true;
    fuchsia_zircon."0.3.3".default = (f.fuchsia_zircon."0.3.3".default or true);
    fuchsia_zircon_sys."${deps.fuchsia_zircon."0.3.3".fuchsia_zircon_sys}".default = true;
  }) [
    (features_.bitflags."${deps."fuchsia_zircon"."0.3.3"."bitflags"}" deps)
    (features_.fuchsia_zircon_sys."${deps."fuchsia_zircon"."0.3.3"."fuchsia_zircon_sys"}" deps)
  ];


# end
# fuchsia-zircon-sys-0.3.3

  crates.fuchsia_zircon_sys."0.3.3" = deps: { features?(features_.fuchsia_zircon_sys."0.3.3" deps {}) }: buildRustCrate {
    crateName = "fuchsia-zircon-sys";
    version = "0.3.3";
    authors = [ "Raph Levien <raph@google.com>" ];
    sha256 = "08jp1zxrm9jbrr6l26bjal4dbm8bxfy57ickdgibsqxr1n9j3hf5";
  };
  features_.fuchsia_zircon_sys."0.3.3" = deps: f: updateFeatures f (rec {
    fuchsia_zircon_sys."0.3.3".default = (f.fuchsia_zircon_sys."0.3.3".default or true);
  }) [];


# end
# futures-0.1.28

  crates.futures."0.1.28" = deps: { features?(features_.futures."0.1.28" deps {}) }: buildRustCrate {
    crateName = "futures";
    version = "0.1.28";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0pkxsf15wcizg3qb0qkip52xis8kiq7rdxiw1f2whzq0mb7m6m0s";
    features = mkFeatures (features."futures"."0.1.28" or {});
  };
  features_.futures."0.1.28" = deps: f: updateFeatures f (rec {
    futures = fold recursiveUpdate {} [
      { "0.1.28".default = (f.futures."0.1.28".default or true); }
      { "0.1.28".use_std =
        (f.futures."0.1.28".use_std or false) ||
        (f.futures."0.1.28".default or false) ||
        (futures."0.1.28"."default" or false); }
      { "0.1.28".with-deprecated =
        (f.futures."0.1.28".with-deprecated or false) ||
        (f.futures."0.1.28".default or false) ||
        (futures."0.1.28"."default" or false); }
    ];
  }) [];


# end
# futures-cpupool-0.1.8

  crates.futures_cpupool."0.1.8" = deps: { features?(features_.futures_cpupool."0.1.8" deps {}) }: buildRustCrate {
    crateName = "futures-cpupool";
    version = "0.1.8";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0ficd31n5ljiixy6x0vjglhq4fp0v1p4qzxm3v6ymsrb3z080l5c";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."futures_cpupool"."0.1.8"."futures"}" deps)
      (crates."num_cpus"."${deps."futures_cpupool"."0.1.8"."num_cpus"}" deps)
    ]);
    features = mkFeatures (features."futures_cpupool"."0.1.8" or {});
  };
  features_.futures_cpupool."0.1.8" = deps: f: updateFeatures f (rec {
    futures = fold recursiveUpdate {} [
      { "${deps.futures_cpupool."0.1.8".futures}"."use_std" = true; }
      { "${deps.futures_cpupool."0.1.8".futures}"."with-deprecated" =
        (f.futures."${deps.futures_cpupool."0.1.8".futures}"."with-deprecated" or false) ||
        (futures_cpupool."0.1.8"."with-deprecated" or false) ||
        (f."futures_cpupool"."0.1.8"."with-deprecated" or false); }
      { "${deps.futures_cpupool."0.1.8".futures}".default = (f.futures."${deps.futures_cpupool."0.1.8".futures}".default or false); }
    ];
    futures_cpupool = fold recursiveUpdate {} [
      { "0.1.8".default = (f.futures_cpupool."0.1.8".default or true); }
      { "0.1.8".with-deprecated =
        (f.futures_cpupool."0.1.8".with-deprecated or false) ||
        (f.futures_cpupool."0.1.8".default or false) ||
        (futures_cpupool."0.1.8"."default" or false); }
    ];
    num_cpus."${deps.futures_cpupool."0.1.8".num_cpus}".default = true;
  }) [
    (features_.futures."${deps."futures_cpupool"."0.1.8"."futures"}" deps)
    (features_.num_cpus."${deps."futures_cpupool"."0.1.8"."num_cpus"}" deps)
  ];


# end
# getrandom-0.1.11

  crates.getrandom."0.1.11" = deps: { features?(features_.getrandom."0.1.11" deps {}) }: buildRustCrate {
    crateName = "getrandom";
    version = "0.1.11";
    authors = [ "The Rand Project Developers" ];
    edition = "2018";
    sha256 = "1f9w5rra9zbnamnh8wl81rw5y87mn3ml4ra5cqrzq2wryzr41651";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."getrandom"."0.1.11"."cfg_if"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") || kernel == "redox" then mapFeatures features ([
      (crates."libc"."${deps."getrandom"."0.1.11"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "wasi" then mapFeatures features ([
      (crates."wasi"."${deps."getrandom"."0.1.11"."wasi"}" deps)
    ]) else [])
      ++ (if kernel == "wasm32-unknown-unknown" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."getrandom"."0.1.11" or {});
  };
  features_.getrandom."0.1.11" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.getrandom."0.1.11".cfg_if}".default = true;
    getrandom = fold recursiveUpdate {} [
      { "0.1.11".compiler_builtins =
        (f.getrandom."0.1.11".compiler_builtins or false) ||
        (f.getrandom."0.1.11".rustc-dep-of-std or false) ||
        (getrandom."0.1.11"."rustc-dep-of-std" or false); }
      { "0.1.11".core =
        (f.getrandom."0.1.11".core or false) ||
        (f.getrandom."0.1.11".rustc-dep-of-std or false) ||
        (getrandom."0.1.11"."rustc-dep-of-std" or false); }
      { "0.1.11".default = (f.getrandom."0.1.11".default or true); }
    ];
    libc."${deps.getrandom."0.1.11".libc}".default = (f.libc."${deps.getrandom."0.1.11".libc}".default or false);
    wasi."${deps.getrandom."0.1.11".wasi}".default = true;
  }) [
    (features_.cfg_if."${deps."getrandom"."0.1.11"."cfg_if"}" deps)
    (features_.libc."${deps."getrandom"."0.1.11"."libc"}" deps)
    (features_.wasi."${deps."getrandom"."0.1.11"."wasi"}" deps)
  ];


# end
# h2-0.1.26

  crates.h2."0.1.26" = deps: { features?(features_.h2."0.1.26" deps {}) }: buildRustCrate {
    crateName = "h2";
    version = "0.1.26";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0wb3nsksi568qb44pzfkz7gbagghzb3fbbky8qhm37aan3dgwb8c";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."h2"."0.1.26"."byteorder"}" deps)
      (crates."bytes"."${deps."h2"."0.1.26"."bytes"}" deps)
      (crates."fnv"."${deps."h2"."0.1.26"."fnv"}" deps)
      (crates."futures"."${deps."h2"."0.1.26"."futures"}" deps)
      (crates."http"."${deps."h2"."0.1.26"."http"}" deps)
      (crates."indexmap"."${deps."h2"."0.1.26"."indexmap"}" deps)
      (crates."log"."${deps."h2"."0.1.26"."log"}" deps)
      (crates."slab"."${deps."h2"."0.1.26"."slab"}" deps)
      (crates."string"."${deps."h2"."0.1.26"."string"}" deps)
      (crates."tokio_io"."${deps."h2"."0.1.26"."tokio_io"}" deps)
    ]);
    features = mkFeatures (features."h2"."0.1.26" or {});
  };
  features_.h2."0.1.26" = deps: f: updateFeatures f (rec {
    byteorder."${deps.h2."0.1.26".byteorder}".default = true;
    bytes."${deps.h2."0.1.26".bytes}".default = true;
    fnv."${deps.h2."0.1.26".fnv}".default = true;
    futures."${deps.h2."0.1.26".futures}".default = true;
    h2."0.1.26".default = (f.h2."0.1.26".default or true);
    http."${deps.h2."0.1.26".http}".default = true;
    indexmap."${deps.h2."0.1.26".indexmap}".default = true;
    log."${deps.h2."0.1.26".log}".default = true;
    slab."${deps.h2."0.1.26".slab}".default = true;
    string."${deps.h2."0.1.26".string}".default = true;
    tokio_io."${deps.h2."0.1.26".tokio_io}".default = true;
  }) [
    (features_.byteorder."${deps."h2"."0.1.26"."byteorder"}" deps)
    (features_.bytes."${deps."h2"."0.1.26"."bytes"}" deps)
    (features_.fnv."${deps."h2"."0.1.26"."fnv"}" deps)
    (features_.futures."${deps."h2"."0.1.26"."futures"}" deps)
    (features_.http."${deps."h2"."0.1.26"."http"}" deps)
    (features_.indexmap."${deps."h2"."0.1.26"."indexmap"}" deps)
    (features_.log."${deps."h2"."0.1.26"."log"}" deps)
    (features_.slab."${deps."h2"."0.1.26"."slab"}" deps)
    (features_.string."${deps."h2"."0.1.26"."string"}" deps)
    (features_.tokio_io."${deps."h2"."0.1.26"."tokio_io"}" deps)
  ];


# end
# http-0.1.18

  crates.http."0.1.18" = deps: { features?(features_.http."0.1.18" deps {}) }: buildRustCrate {
    crateName = "http";
    version = "0.1.18";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Carl Lerche <me@carllerche.com>" "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0np5rnnbimmximdl2l7b0x1izzc4iwyw0qhzxlsx7hny423608rq";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."http"."0.1.18"."bytes"}" deps)
      (crates."fnv"."${deps."http"."0.1.18"."fnv"}" deps)
      (crates."itoa"."${deps."http"."0.1.18"."itoa"}" deps)
    ]);
  };
  features_.http."0.1.18" = deps: f: updateFeatures f (rec {
    bytes."${deps.http."0.1.18".bytes}".default = true;
    fnv."${deps.http."0.1.18".fnv}".default = true;
    http."0.1.18".default = (f.http."0.1.18".default or true);
    itoa."${deps.http."0.1.18".itoa}".default = true;
  }) [
    (features_.bytes."${deps."http"."0.1.18"."bytes"}" deps)
    (features_.fnv."${deps."http"."0.1.18"."fnv"}" deps)
    (features_.itoa."${deps."http"."0.1.18"."itoa"}" deps)
  ];


# end
# http-body-0.1.0

  crates.http_body."0.1.0" = deps: { features?(features_.http_body."0.1.0" deps {}) }: buildRustCrate {
    crateName = "http-body";
    version = "0.1.0";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0rbk76455i6l9wrhcgq5p7hbvf9h9fc8ylbfphy4m5qswghly70m";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."http_body"."0.1.0"."bytes"}" deps)
      (crates."futures"."${deps."http_body"."0.1.0"."futures"}" deps)
      (crates."http"."${deps."http_body"."0.1.0"."http"}" deps)
      (crates."tokio_buf"."${deps."http_body"."0.1.0"."tokio_buf"}" deps)
    ]);
  };
  features_.http_body."0.1.0" = deps: f: updateFeatures f (rec {
    bytes."${deps.http_body."0.1.0".bytes}".default = true;
    futures."${deps.http_body."0.1.0".futures}".default = true;
    http."${deps.http_body."0.1.0".http}".default = true;
    http_body."0.1.0".default = (f.http_body."0.1.0".default or true);
    tokio_buf."${deps.http_body."0.1.0".tokio_buf}".default = (f.tokio_buf."${deps.http_body."0.1.0".tokio_buf}".default or false);
  }) [
    (features_.bytes."${deps."http_body"."0.1.0"."bytes"}" deps)
    (features_.futures."${deps."http_body"."0.1.0"."futures"}" deps)
    (features_.http."${deps."http_body"."0.1.0"."http"}" deps)
    (features_.tokio_buf."${deps."http_body"."0.1.0"."tokio_buf"}" deps)
  ];


# end
# httparse-1.3.4

  crates.httparse."1.3.4" = deps: { features?(features_.httparse."1.3.4" deps {}) }: buildRustCrate {
    crateName = "httparse";
    version = "1.3.4";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0dggj4s0cq69bn63q9nqzzay5acmwl33nrbhjjsh5xys8sk2x4jw";
    build = "build.rs";
    features = mkFeatures (features."httparse"."1.3.4" or {});
  };
  features_.httparse."1.3.4" = deps: f: updateFeatures f (rec {
    httparse = fold recursiveUpdate {} [
      { "1.3.4".default = (f.httparse."1.3.4".default or true); }
      { "1.3.4".std =
        (f.httparse."1.3.4".std or false) ||
        (f.httparse."1.3.4".default or false) ||
        (httparse."1.3.4"."default" or false); }
    ];
  }) [];


# end
# hyper-0.12.33

  crates.hyper."0.12.33" = deps: { features?(features_.hyper."0.12.33" deps {}) }: buildRustCrate {
    crateName = "hyper";
    version = "0.12.33";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "07w2qnh5p67ls89v9vwgibnp0qw5992rn71d1vcy1ks4h5jmx85p";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."hyper"."0.12.33"."bytes"}" deps)
      (crates."futures"."${deps."hyper"."0.12.33"."futures"}" deps)
      (crates."h2"."${deps."hyper"."0.12.33"."h2"}" deps)
      (crates."http"."${deps."hyper"."0.12.33"."http"}" deps)
      (crates."http_body"."${deps."hyper"."0.12.33"."http_body"}" deps)
      (crates."httparse"."${deps."hyper"."0.12.33"."httparse"}" deps)
      (crates."iovec"."${deps."hyper"."0.12.33"."iovec"}" deps)
      (crates."itoa"."${deps."hyper"."0.12.33"."itoa"}" deps)
      (crates."log"."${deps."hyper"."0.12.33"."log"}" deps)
      (crates."time"."${deps."hyper"."0.12.33"."time"}" deps)
      (crates."tokio_buf"."${deps."hyper"."0.12.33"."tokio_buf"}" deps)
      (crates."tokio_io"."${deps."hyper"."0.12.33"."tokio_io"}" deps)
      (crates."want"."${deps."hyper"."0.12.33"."want"}" deps)
    ]
      ++ (if features.hyper."0.12.33".futures-cpupool or false then [ (crates.futures_cpupool."${deps."hyper"."0.12.33".futures_cpupool}" deps) ] else [])
      ++ (if features.hyper."0.12.33".net2 or false then [ (crates.net2."${deps."hyper"."0.12.33".net2}" deps) ] else [])
      ++ (if features.hyper."0.12.33".tokio or false then [ (crates.tokio."${deps."hyper"."0.12.33".tokio}" deps) ] else [])
      ++ (if features.hyper."0.12.33".tokio-executor or false then [ (crates.tokio_executor."${deps."hyper"."0.12.33".tokio_executor}" deps) ] else [])
      ++ (if features.hyper."0.12.33".tokio-reactor or false then [ (crates.tokio_reactor."${deps."hyper"."0.12.33".tokio_reactor}" deps) ] else [])
      ++ (if features.hyper."0.12.33".tokio-tcp or false then [ (crates.tokio_tcp."${deps."hyper"."0.12.33".tokio_tcp}" deps) ] else [])
      ++ (if features.hyper."0.12.33".tokio-threadpool or false then [ (crates.tokio_threadpool."${deps."hyper"."0.12.33".tokio_threadpool}" deps) ] else [])
      ++ (if features.hyper."0.12.33".tokio-timer or false then [ (crates.tokio_timer."${deps."hyper"."0.12.33".tokio_timer}" deps) ] else []));

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."hyper"."0.12.33"."rustc_version"}" deps)
    ]);
    features = mkFeatures (features."hyper"."0.12.33" or {});
  };
  features_.hyper."0.12.33" = deps: f: updateFeatures f (rec {
    bytes."${deps.hyper."0.12.33".bytes}".default = true;
    futures."${deps.hyper."0.12.33".futures}".default = true;
    futures_cpupool."${deps.hyper."0.12.33".futures_cpupool}".default = true;
    h2."${deps.hyper."0.12.33".h2}".default = true;
    http."${deps.hyper."0.12.33".http}".default = true;
    http_body."${deps.hyper."0.12.33".http_body}".default = true;
    httparse."${deps.hyper."0.12.33".httparse}".default = true;
    hyper = fold recursiveUpdate {} [
      { "0.12.33".__internal_flaky_tests =
        (f.hyper."0.12.33".__internal_flaky_tests or false) ||
        (f.hyper."0.12.33".default or false) ||
        (hyper."0.12.33"."default" or false); }
      { "0.12.33".default = (f.hyper."0.12.33".default or true); }
      { "0.12.33".futures-cpupool =
        (f.hyper."0.12.33".futures-cpupool or false) ||
        (f.hyper."0.12.33".runtime or false) ||
        (hyper."0.12.33"."runtime" or false); }
      { "0.12.33".net2 =
        (f.hyper."0.12.33".net2 or false) ||
        (f.hyper."0.12.33".runtime or false) ||
        (hyper."0.12.33"."runtime" or false); }
      { "0.12.33".runtime =
        (f.hyper."0.12.33".runtime or false) ||
        (f.hyper."0.12.33".default or false) ||
        (hyper."0.12.33"."default" or false); }
      { "0.12.33".tokio =
        (f.hyper."0.12.33".tokio or false) ||
        (f.hyper."0.12.33".runtime or false) ||
        (hyper."0.12.33"."runtime" or false); }
      { "0.12.33".tokio-executor =
        (f.hyper."0.12.33".tokio-executor or false) ||
        (f.hyper."0.12.33".runtime or false) ||
        (hyper."0.12.33"."runtime" or false); }
      { "0.12.33".tokio-reactor =
        (f.hyper."0.12.33".tokio-reactor or false) ||
        (f.hyper."0.12.33".runtime or false) ||
        (hyper."0.12.33"."runtime" or false); }
      { "0.12.33".tokio-tcp =
        (f.hyper."0.12.33".tokio-tcp or false) ||
        (f.hyper."0.12.33".runtime or false) ||
        (hyper."0.12.33"."runtime" or false); }
      { "0.12.33".tokio-threadpool =
        (f.hyper."0.12.33".tokio-threadpool or false) ||
        (f.hyper."0.12.33".runtime or false) ||
        (hyper."0.12.33"."runtime" or false); }
      { "0.12.33".tokio-timer =
        (f.hyper."0.12.33".tokio-timer or false) ||
        (f.hyper."0.12.33".runtime or false) ||
        (hyper."0.12.33"."runtime" or false); }
    ];
    iovec."${deps.hyper."0.12.33".iovec}".default = true;
    itoa."${deps.hyper."0.12.33".itoa}".default = true;
    log."${deps.hyper."0.12.33".log}".default = true;
    net2."${deps.hyper."0.12.33".net2}".default = true;
    rustc_version."${deps.hyper."0.12.33".rustc_version}".default = true;
    time."${deps.hyper."0.12.33".time}".default = true;
    tokio = fold recursiveUpdate {} [
      { "${deps.hyper."0.12.33".tokio}"."rt-full" = true; }
      { "${deps.hyper."0.12.33".tokio}".default = (f.tokio."${deps.hyper."0.12.33".tokio}".default or false); }
    ];
    tokio_buf."${deps.hyper."0.12.33".tokio_buf}".default = true;
    tokio_executor."${deps.hyper."0.12.33".tokio_executor}".default = true;
    tokio_io."${deps.hyper."0.12.33".tokio_io}".default = true;
    tokio_reactor."${deps.hyper."0.12.33".tokio_reactor}".default = true;
    tokio_tcp."${deps.hyper."0.12.33".tokio_tcp}".default = true;
    tokio_threadpool."${deps.hyper."0.12.33".tokio_threadpool}".default = true;
    tokio_timer."${deps.hyper."0.12.33".tokio_timer}".default = true;
    want."${deps.hyper."0.12.33".want}".default = true;
  }) [
    (features_.bytes."${deps."hyper"."0.12.33"."bytes"}" deps)
    (features_.futures."${deps."hyper"."0.12.33"."futures"}" deps)
    (features_.futures_cpupool."${deps."hyper"."0.12.33"."futures_cpupool"}" deps)
    (features_.h2."${deps."hyper"."0.12.33"."h2"}" deps)
    (features_.http."${deps."hyper"."0.12.33"."http"}" deps)
    (features_.http_body."${deps."hyper"."0.12.33"."http_body"}" deps)
    (features_.httparse."${deps."hyper"."0.12.33"."httparse"}" deps)
    (features_.iovec."${deps."hyper"."0.12.33"."iovec"}" deps)
    (features_.itoa."${deps."hyper"."0.12.33"."itoa"}" deps)
    (features_.log."${deps."hyper"."0.12.33"."log"}" deps)
    (features_.net2."${deps."hyper"."0.12.33"."net2"}" deps)
    (features_.time."${deps."hyper"."0.12.33"."time"}" deps)
    (features_.tokio."${deps."hyper"."0.12.33"."tokio"}" deps)
    (features_.tokio_buf."${deps."hyper"."0.12.33"."tokio_buf"}" deps)
    (features_.tokio_executor."${deps."hyper"."0.12.33"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."hyper"."0.12.33"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."hyper"."0.12.33"."tokio_reactor"}" deps)
    (features_.tokio_tcp."${deps."hyper"."0.12.33"."tokio_tcp"}" deps)
    (features_.tokio_threadpool."${deps."hyper"."0.12.33"."tokio_threadpool"}" deps)
    (features_.tokio_timer."${deps."hyper"."0.12.33"."tokio_timer"}" deps)
    (features_.want."${deps."hyper"."0.12.33"."want"}" deps)
    (features_.rustc_version."${deps."hyper"."0.12.33"."rustc_version"}" deps)
  ];


# end
# hyper-tls-0.3.2

  crates.hyper_tls."0.3.2" = deps: { features?(features_.hyper_tls."0.3.2" deps {}) }: buildRustCrate {
    crateName = "hyper-tls";
    version = "0.3.2";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "01naqv4zxfj3vzwa5m56vh6l8kg8y8wp8qgc1pm883vsrawa7anx";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."hyper_tls"."0.3.2"."bytes"}" deps)
      (crates."futures"."${deps."hyper_tls"."0.3.2"."futures"}" deps)
      (crates."hyper"."${deps."hyper_tls"."0.3.2"."hyper"}" deps)
      (crates."native_tls"."${deps."hyper_tls"."0.3.2"."native_tls"}" deps)
      (crates."tokio_io"."${deps."hyper_tls"."0.3.2"."tokio_io"}" deps)
    ]);
    features = mkFeatures (features."hyper_tls"."0.3.2" or {});
  };
  features_.hyper_tls."0.3.2" = deps: f: updateFeatures f (rec {
    bytes."${deps.hyper_tls."0.3.2".bytes}".default = true;
    futures."${deps.hyper_tls."0.3.2".futures}".default = true;
    hyper."${deps.hyper_tls."0.3.2".hyper}".default = true;
    hyper_tls."0.3.2".default = (f.hyper_tls."0.3.2".default or true);
    native_tls = fold recursiveUpdate {} [
      { "${deps.hyper_tls."0.3.2".native_tls}"."vendored" =
        (f.native_tls."${deps.hyper_tls."0.3.2".native_tls}"."vendored" or false) ||
        (hyper_tls."0.3.2"."vendored" or false) ||
        (f."hyper_tls"."0.3.2"."vendored" or false); }
      { "${deps.hyper_tls."0.3.2".native_tls}".default = true; }
    ];
    tokio_io."${deps.hyper_tls."0.3.2".tokio_io}".default = true;
  }) [
    (features_.bytes."${deps."hyper_tls"."0.3.2"."bytes"}" deps)
    (features_.futures."${deps."hyper_tls"."0.3.2"."futures"}" deps)
    (features_.hyper."${deps."hyper_tls"."0.3.2"."hyper"}" deps)
    (features_.native_tls."${deps."hyper_tls"."0.3.2"."native_tls"}" deps)
    (features_.tokio_io."${deps."hyper_tls"."0.3.2"."tokio_io"}" deps)
  ];


# end
# idna-0.1.5

  crates.idna."0.1.5" = deps: { features?(features_.idna."0.1.5" deps {}) }: buildRustCrate {
    crateName = "idna";
    version = "0.1.5";
    authors = [ "The rust-url developers" ];
    sha256 = "1gwgl19rz5vzi67rrhamczhxy050f5ynx4ybabfapyalv7z1qmjy";
    dependencies = mapFeatures features ([
      (crates."matches"."${deps."idna"."0.1.5"."matches"}" deps)
      (crates."unicode_bidi"."${deps."idna"."0.1.5"."unicode_bidi"}" deps)
      (crates."unicode_normalization"."${deps."idna"."0.1.5"."unicode_normalization"}" deps)
    ]);
  };
  features_.idna."0.1.5" = deps: f: updateFeatures f (rec {
    idna."0.1.5".default = (f.idna."0.1.5".default or true);
    matches."${deps.idna."0.1.5".matches}".default = true;
    unicode_bidi."${deps.idna."0.1.5".unicode_bidi}".default = true;
    unicode_normalization."${deps.idna."0.1.5".unicode_normalization}".default = true;
  }) [
    (features_.matches."${deps."idna"."0.1.5"."matches"}" deps)
    (features_.unicode_bidi."${deps."idna"."0.1.5"."unicode_bidi"}" deps)
    (features_.unicode_normalization."${deps."idna"."0.1.5"."unicode_normalization"}" deps)
  ];


# end
# idna-0.2.0

  crates.idna."0.2.0" = deps: { features?(features_.idna."0.2.0" deps {}) }: buildRustCrate {
    crateName = "idna";
    version = "0.2.0";
    authors = [ "The rust-url developers" ];
    sha256 = "1mm05aq43qc5n492njnac5xn4rhiraii25xc0hwppr471jzijh8d";
    dependencies = mapFeatures features ([
      (crates."matches"."${deps."idna"."0.2.0"."matches"}" deps)
      (crates."unicode_bidi"."${deps."idna"."0.2.0"."unicode_bidi"}" deps)
      (crates."unicode_normalization"."${deps."idna"."0.2.0"."unicode_normalization"}" deps)
    ]);
  };
  features_.idna."0.2.0" = deps: f: updateFeatures f (rec {
    idna."0.2.0".default = (f.idna."0.2.0".default or true);
    matches."${deps.idna."0.2.0".matches}".default = true;
    unicode_bidi."${deps.idna."0.2.0".unicode_bidi}".default = true;
    unicode_normalization."${deps.idna."0.2.0".unicode_normalization}".default = true;
  }) [
    (features_.matches."${deps."idna"."0.2.0"."matches"}" deps)
    (features_.unicode_bidi."${deps."idna"."0.2.0"."unicode_bidi"}" deps)
    (features_.unicode_normalization."${deps."idna"."0.2.0"."unicode_normalization"}" deps)
  ];


# end
# indexmap-1.1.0

  crates.indexmap."1.1.0" = deps: { features?(features_.indexmap."1.1.0" deps {}) }: buildRustCrate {
    crateName = "indexmap";
    version = "1.1.0";
    authors = [ "bluss" "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "0z15q1p8ng7fj3r3dznd4pf4128v8z4mlc3bs13xh63ydjxi6dmf";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."indexmap"."1.1.0" or {});
  };
  features_.indexmap."1.1.0" = deps: f: updateFeatures f (rec {
    indexmap = fold recursiveUpdate {} [
      { "1.1.0".default = (f.indexmap."1.1.0".default or true); }
      { "1.1.0".serde =
        (f.indexmap."1.1.0".serde or false) ||
        (f.indexmap."1.1.0".serde-1 or false) ||
        (indexmap."1.1.0"."serde-1" or false); }
    ];
  }) [];


# end
# iovec-0.1.2

  crates.iovec."0.1.2" = deps: { features?(features_.iovec."0.1.2" deps {}) }: buildRustCrate {
    crateName = "iovec";
    version = "0.1.2";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0vjymmb7wj4v4kza5jjn48fcdb85j3k37y7msjl3ifz0p9yiyp2r";
    dependencies = (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."iovec"."0.1.2"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."iovec"."0.1.2"."winapi"}" deps)
    ]) else []);
  };
  features_.iovec."0.1.2" = deps: f: updateFeatures f (rec {
    iovec."0.1.2".default = (f.iovec."0.1.2".default or true);
    libc."${deps.iovec."0.1.2".libc}".default = true;
    winapi."${deps.iovec."0.1.2".winapi}".default = true;
  }) [
    (features_.libc."${deps."iovec"."0.1.2"."libc"}" deps)
    (features_.winapi."${deps."iovec"."0.1.2"."winapi"}" deps)
  ];


# end
# itoa-0.4.4

  crates.itoa."0.4.4" = deps: { features?(features_.itoa."0.4.4" deps {}) }: buildRustCrate {
    crateName = "itoa";
    version = "0.4.4";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1fqc34xzzl2spfdawxd9awhzl0fwf1y6y4i94l8bq8rfrzd90awl";
    features = mkFeatures (features."itoa"."0.4.4" or {});
  };
  features_.itoa."0.4.4" = deps: f: updateFeatures f (rec {
    itoa = fold recursiveUpdate {} [
      { "0.4.4".default = (f.itoa."0.4.4".default or true); }
      { "0.4.4".std =
        (f.itoa."0.4.4".std or false) ||
        (f.itoa."0.4.4".default or false) ||
        (itoa."0.4.4"."default" or false); }
    ];
  }) [];


# end
# kernel32-sys-0.2.2

  crates.kernel32_sys."0.2.2" = deps: { features?(features_.kernel32_sys."0.2.2" deps {}) }: buildRustCrate {
    crateName = "kernel32-sys";
    version = "0.2.2";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1lrw1hbinyvr6cp28g60z97w32w8vsk6pahk64pmrv2fmby8srfj";
    libName = "kernel32";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."kernel32_sys"."0.2.2"."winapi"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."winapi_build"."${deps."kernel32_sys"."0.2.2"."winapi_build"}" deps)
    ]);
  };
  features_.kernel32_sys."0.2.2" = deps: f: updateFeatures f (rec {
    kernel32_sys."0.2.2".default = (f.kernel32_sys."0.2.2".default or true);
    winapi."${deps.kernel32_sys."0.2.2".winapi}".default = true;
    winapi_build."${deps.kernel32_sys."0.2.2".winapi_build}".default = true;
  }) [
    (features_.winapi."${deps."kernel32_sys"."0.2.2"."winapi"}" deps)
    (features_.winapi_build."${deps."kernel32_sys"."0.2.2"."winapi_build"}" deps)
  ];


# end
# lazy_static-1.4.0

  crates.lazy_static."1.4.0" = deps: { features?(features_.lazy_static."1.4.0" deps {}) }: buildRustCrate {
    crateName = "lazy_static";
    version = "1.4.0";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "13h6sdghdcy7vcqsm2gasfw3qg7ssa0fl3sw7lq6pdkbk52wbyfr";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."lazy_static"."1.4.0" or {});
  };
  features_.lazy_static."1.4.0" = deps: f: updateFeatures f (rec {
    lazy_static = fold recursiveUpdate {} [
      { "1.4.0".default = (f.lazy_static."1.4.0".default or true); }
      { "1.4.0".spin =
        (f.lazy_static."1.4.0".spin or false) ||
        (f.lazy_static."1.4.0".spin_no_std or false) ||
        (lazy_static."1.4.0"."spin_no_std" or false); }
    ];
  }) [];


# end
# libc-0.2.62

  crates.libc."0.2.62" = deps: { features?(features_.libc."0.2.62" deps {}) }: buildRustCrate {
    crateName = "libc";
    version = "0.2.62";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1vsb4pyn6gl6sri6cv5hin5wjfgk7lk2bshzmxb1xnkckjhz4gbx";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."libc"."0.2.62" or {});
  };
  features_.libc."0.2.62" = deps: f: updateFeatures f (rec {
    libc = fold recursiveUpdate {} [
      { "0.2.62".align =
        (f.libc."0.2.62".align or false) ||
        (f.libc."0.2.62".rustc-dep-of-std or false) ||
        (libc."0.2.62"."rustc-dep-of-std" or false); }
      { "0.2.62".default = (f.libc."0.2.62".default or true); }
      { "0.2.62".rustc-std-workspace-core =
        (f.libc."0.2.62".rustc-std-workspace-core or false) ||
        (f.libc."0.2.62".rustc-dep-of-std or false) ||
        (libc."0.2.62"."rustc-dep-of-std" or false); }
      { "0.2.62".std =
        (f.libc."0.2.62".std or false) ||
        (f.libc."0.2.62".default or false) ||
        (libc."0.2.62"."default" or false) ||
        (f.libc."0.2.62".use_std or false) ||
        (libc."0.2.62"."use_std" or false); }
    ];
  }) [];


# end
# lock_api-0.1.5

  crates.lock_api."0.1.5" = deps: { features?(features_.lock_api."0.1.5" deps {}) }: buildRustCrate {
    crateName = "lock_api";
    version = "0.1.5";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "132sidr5hvjfkaqm3l95zpcpi8yk5ddd0g79zf1ad4v65sxirqqm";
    dependencies = mapFeatures features ([
      (crates."scopeguard"."${deps."lock_api"."0.1.5"."scopeguard"}" deps)
    ]
      ++ (if features.lock_api."0.1.5".owning_ref or false then [ (crates.owning_ref."${deps."lock_api"."0.1.5".owning_ref}" deps) ] else []));
    features = mkFeatures (features."lock_api"."0.1.5" or {});
  };
  features_.lock_api."0.1.5" = deps: f: updateFeatures f (rec {
    lock_api."0.1.5".default = (f.lock_api."0.1.5".default or true);
    owning_ref."${deps.lock_api."0.1.5".owning_ref}".default = true;
    scopeguard."${deps.lock_api."0.1.5".scopeguard}".default = (f.scopeguard."${deps.lock_api."0.1.5".scopeguard}".default or false);
  }) [
    (features_.owning_ref."${deps."lock_api"."0.1.5"."owning_ref"}" deps)
    (features_.scopeguard."${deps."lock_api"."0.1.5"."scopeguard"}" deps)
  ];


# end
# log-0.4.8

  crates.log."0.4.8" = deps: { features?(features_.log."0.4.8" deps {}) }: buildRustCrate {
    crateName = "log";
    version = "0.4.8";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0wvzzzcn89dai172rrqcyz06pzldyyy0lf0w71csmn206rdpnb15";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."log"."0.4.8"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."log"."0.4.8" or {});
  };
  features_.log."0.4.8" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.log."0.4.8".cfg_if}".default = true;
    log = fold recursiveUpdate {} [
      { "0.4.8".default = (f.log."0.4.8".default or true); }
      { "0.4.8".kv_unstable =
        (f.log."0.4.8".kv_unstable or false) ||
        (f.log."0.4.8".kv_unstable_sval or false) ||
        (log."0.4.8"."kv_unstable_sval" or false); }
    ];
  }) [
    (features_.cfg_if."${deps."log"."0.4.8"."cfg_if"}" deps)
  ];


# end
# matches-0.1.8

  crates.matches."0.1.8" = deps: { features?(features_.matches."0.1.8" deps {}) }: buildRustCrate {
    crateName = "matches";
    version = "0.1.8";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "03hl636fg6xggy0a26200xs74amk3k9n0908rga2szn68agyz3cv";
    libPath = "lib.rs";
  };
  features_.matches."0.1.8" = deps: f: updateFeatures f (rec {
    matches."0.1.8".default = (f.matches."0.1.8".default or true);
  }) [];


# end
# memchr-2.2.1

  crates.memchr."2.2.1" = deps: { features?(features_.memchr."2.2.1" deps {}) }: buildRustCrate {
    crateName = "memchr";
    version = "2.2.1";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" "bluss" ];
    sha256 = "1mj5z8lhz6jbapslpq8a39pwcsl1p0jmgp7wgcj7nv4pcqhya7a0";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.memchr."2.2.1".libc or false then [ (crates.libc."${deps."memchr"."2.2.1".libc}" deps) ] else []));
    features = mkFeatures (features."memchr"."2.2.1" or {});
  };
  features_.memchr."2.2.1" = deps: f: updateFeatures f (rec {
    libc."${deps.memchr."2.2.1".libc}".default = (f.libc."${deps.memchr."2.2.1".libc}".default or false);
    memchr = fold recursiveUpdate {} [
      { "2.2.1".default = (f.memchr."2.2.1".default or true); }
      { "2.2.1".use_std =
        (f.memchr."2.2.1".use_std or false) ||
        (f.memchr."2.2.1".default or false) ||
        (memchr."2.2.1"."default" or false); }
    ];
  }) [
    (features_.libc."${deps."memchr"."2.2.1"."libc"}" deps)
  ];


# end
# memoffset-0.5.1

  crates.memoffset."0.5.1" = deps: { features?(features_.memoffset."0.5.1" deps {}) }: buildRustCrate {
    crateName = "memoffset";
    version = "0.5.1";
    authors = [ "Gilad Naaman <gilad.naaman@gmail.com>" ];
    sha256 = "0fsk7kfk193f1aamafl45vvcp7j6p7c14ss7d583fijw3w5kj69k";

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."memoffset"."0.5.1"."rustc_version"}" deps)
    ]);
  };
  features_.memoffset."0.5.1" = deps: f: updateFeatures f (rec {
    memoffset."0.5.1".default = (f.memoffset."0.5.1".default or true);
    rustc_version."${deps.memoffset."0.5.1".rustc_version}".default = true;
  }) [
    (features_.rustc_version."${deps."memoffset"."0.5.1"."rustc_version"}" deps)
  ];


# end
# mime-0.3.13

  crates.mime."0.3.13" = deps: { features?(features_.mime."0.3.13" deps {}) }: buildRustCrate {
    crateName = "mime";
    version = "0.3.13";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "191b240rj0l8hq2bmn74z1c9rqnrfx0dbfxgyq7vnf3jkrbc5v86";
    dependencies = mapFeatures features ([
      (crates."unicase"."${deps."mime"."0.3.13"."unicase"}" deps)
    ]);
  };
  features_.mime."0.3.13" = deps: f: updateFeatures f (rec {
    mime."0.3.13".default = (f.mime."0.3.13".default or true);
    unicase."${deps.mime."0.3.13".unicase}".default = true;
  }) [
    (features_.unicase."${deps."mime"."0.3.13"."unicase"}" deps)
  ];


# end
# mime_guess-2.0.1

  crates.mime_guess."2.0.1" = deps: { features?(features_.mime_guess."2.0.1" deps {}) }: buildRustCrate {
    crateName = "mime_guess";
    version = "2.0.1";
    authors = [ "Austin Bonander <austin.bonander@gmail.com>" ];
    sha256 = "18wrpddfxipwhhw5q7wdykdcp0sm0zq7jizjrcvdnrg80kyg8nsk";
    dependencies = mapFeatures features ([
      (crates."mime"."${deps."mime_guess"."2.0.1"."mime"}" deps)
      (crates."unicase"."${deps."mime_guess"."2.0.1"."unicase"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."unicase"."${deps."mime_guess"."2.0.1"."unicase"}" deps)
    ]);
    features = mkFeatures (features."mime_guess"."2.0.1" or {});
  };
  features_.mime_guess."2.0.1" = deps: f: updateFeatures f (rec {
    mime."${deps.mime_guess."2.0.1".mime}".default = true;
    mime_guess = fold recursiveUpdate {} [
      { "2.0.1".default = (f.mime_guess."2.0.1".default or true); }
      { "2.0.1".rev-mappings =
        (f.mime_guess."2.0.1".rev-mappings or false) ||
        (f.mime_guess."2.0.1".default or false) ||
        (mime_guess."2.0.1"."default" or false); }
    ];
    unicase."${deps.mime_guess."2.0.1".unicase}".default = true;
  }) [
    (features_.mime."${deps."mime_guess"."2.0.1"."mime"}" deps)
    (features_.unicase."${deps."mime_guess"."2.0.1"."unicase"}" deps)
    (features_.unicase."${deps."mime_guess"."2.0.1"."unicase"}" deps)
  ];


# end
# miniz_oxide-0.3.2

  crates.miniz_oxide."0.3.2" = deps: { features?(features_.miniz_oxide."0.3.2" deps {}) }: buildRustCrate {
    crateName = "miniz_oxide";
    version = "0.3.2";
    authors = [ "Frommi <daniil.liferenko@gmail.com>" "oyvindln <oyvindln@users.noreply.github.com>" ];
    edition = "2018";
    sha256 = "013d6pswvpnxq6i43i96m9ba2c5ljda1x96hxsc5c180zqvb3b08";
    dependencies = mapFeatures features ([
      (crates."adler32"."${deps."miniz_oxide"."0.3.2"."adler32"}" deps)
    ]);
  };
  features_.miniz_oxide."0.3.2" = deps: f: updateFeatures f (rec {
    adler32."${deps.miniz_oxide."0.3.2".adler32}".default = true;
    miniz_oxide."0.3.2".default = (f.miniz_oxide."0.3.2".default or true);
  }) [
    (features_.adler32."${deps."miniz_oxide"."0.3.2"."adler32"}" deps)
  ];


# end
# mio-0.6.19

  crates.mio."0.6.19" = deps: { features?(features_.mio."0.6.19" deps {}) }: buildRustCrate {
    crateName = "mio";
    version = "0.6.19";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0pjazzvqwkb4fgmm4b3m8i05c2gq60lvqqia0faawswgqy7rvgac";
    dependencies = mapFeatures features ([
      (crates."iovec"."${deps."mio"."0.6.19"."iovec"}" deps)
      (crates."log"."${deps."mio"."0.6.19"."log"}" deps)
      (crates."net2"."${deps."mio"."0.6.19"."net2"}" deps)
      (crates."slab"."${deps."mio"."0.6.19"."slab"}" deps)
    ])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_zircon"."${deps."mio"."0.6.19"."fuchsia_zircon"}" deps)
      (crates."fuchsia_zircon_sys"."${deps."mio"."0.6.19"."fuchsia_zircon_sys"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."mio"."0.6.19"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."kernel32_sys"."${deps."mio"."0.6.19"."kernel32_sys"}" deps)
      (crates."miow"."${deps."mio"."0.6.19"."miow"}" deps)
      (crates."winapi"."${deps."mio"."0.6.19"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."mio"."0.6.19" or {});
  };
  features_.mio."0.6.19" = deps: f: updateFeatures f (rec {
    fuchsia_zircon."${deps.mio."0.6.19".fuchsia_zircon}".default = true;
    fuchsia_zircon_sys."${deps.mio."0.6.19".fuchsia_zircon_sys}".default = true;
    iovec."${deps.mio."0.6.19".iovec}".default = true;
    kernel32_sys."${deps.mio."0.6.19".kernel32_sys}".default = true;
    libc."${deps.mio."0.6.19".libc}".default = true;
    log."${deps.mio."0.6.19".log}".default = true;
    mio = fold recursiveUpdate {} [
      { "0.6.19".default = (f.mio."0.6.19".default or true); }
      { "0.6.19".with-deprecated =
        (f.mio."0.6.19".with-deprecated or false) ||
        (f.mio."0.6.19".default or false) ||
        (mio."0.6.19"."default" or false); }
    ];
    miow."${deps.mio."0.6.19".miow}".default = true;
    net2."${deps.mio."0.6.19".net2}".default = true;
    slab."${deps.mio."0.6.19".slab}".default = true;
    winapi."${deps.mio."0.6.19".winapi}".default = true;
  }) [
    (features_.iovec."${deps."mio"."0.6.19"."iovec"}" deps)
    (features_.log."${deps."mio"."0.6.19"."log"}" deps)
    (features_.net2."${deps."mio"."0.6.19"."net2"}" deps)
    (features_.slab."${deps."mio"."0.6.19"."slab"}" deps)
    (features_.fuchsia_zircon."${deps."mio"."0.6.19"."fuchsia_zircon"}" deps)
    (features_.fuchsia_zircon_sys."${deps."mio"."0.6.19"."fuchsia_zircon_sys"}" deps)
    (features_.libc."${deps."mio"."0.6.19"."libc"}" deps)
    (features_.kernel32_sys."${deps."mio"."0.6.19"."kernel32_sys"}" deps)
    (features_.miow."${deps."mio"."0.6.19"."miow"}" deps)
    (features_.winapi."${deps."mio"."0.6.19"."winapi"}" deps)
  ];


# end
# miow-0.2.1

  crates.miow."0.2.1" = deps: { features?(features_.miow."0.2.1" deps {}) }: buildRustCrate {
    crateName = "miow";
    version = "0.2.1";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "14f8zkc6ix7mkyis1vsqnim8m29b6l55abkba3p2yz7j1ibcvrl0";
    dependencies = mapFeatures features ([
      (crates."kernel32_sys"."${deps."miow"."0.2.1"."kernel32_sys"}" deps)
      (crates."net2"."${deps."miow"."0.2.1"."net2"}" deps)
      (crates."winapi"."${deps."miow"."0.2.1"."winapi"}" deps)
      (crates."ws2_32_sys"."${deps."miow"."0.2.1"."ws2_32_sys"}" deps)
    ]);
  };
  features_.miow."0.2.1" = deps: f: updateFeatures f (rec {
    kernel32_sys."${deps.miow."0.2.1".kernel32_sys}".default = true;
    miow."0.2.1".default = (f.miow."0.2.1".default or true);
    net2."${deps.miow."0.2.1".net2}".default = (f.net2."${deps.miow."0.2.1".net2}".default or false);
    winapi."${deps.miow."0.2.1".winapi}".default = true;
    ws2_32_sys."${deps.miow."0.2.1".ws2_32_sys}".default = true;
  }) [
    (features_.kernel32_sys."${deps."miow"."0.2.1"."kernel32_sys"}" deps)
    (features_.net2."${deps."miow"."0.2.1"."net2"}" deps)
    (features_.winapi."${deps."miow"."0.2.1"."winapi"}" deps)
    (features_.ws2_32_sys."${deps."miow"."0.2.1"."ws2_32_sys"}" deps)
  ];


# end
# mockito-0.20.0

  crates.mockito."0.20.0" = deps: { features?(features_.mockito."0.20.0" deps {}) }: buildRustCrate {
    crateName = "mockito";
    version = "0.20.0";
    authors = [ "Florin Lipan <florinlipan@gmail.com>" ];
    sha256 = "0rf61kwzmxnslinc4kgzinxdhxskxl8g8d55qknwf80la9h52f17";
    dependencies = mapFeatures features ([
      (crates."assert_json_diff"."${deps."mockito"."0.20.0"."assert_json_diff"}" deps)
      (crates."colored"."${deps."mockito"."0.20.0"."colored"}" deps)
      (crates."difference"."${deps."mockito"."0.20.0"."difference"}" deps)
      (crates."httparse"."${deps."mockito"."0.20.0"."httparse"}" deps)
      (crates."lazy_static"."${deps."mockito"."0.20.0"."lazy_static"}" deps)
      (crates."log"."${deps."mockito"."0.20.0"."log"}" deps)
      (crates."percent_encoding"."${deps."mockito"."0.20.0"."percent_encoding"}" deps)
      (crates."rand"."${deps."mockito"."0.20.0"."rand"}" deps)
      (crates."regex"."${deps."mockito"."0.20.0"."regex"}" deps)
      (crates."serde_json"."${deps."mockito"."0.20.0"."serde_json"}" deps)
    ]);
  };
  features_.mockito."0.20.0" = deps: f: updateFeatures f (rec {
    assert_json_diff."${deps.mockito."0.20.0".assert_json_diff}".default = true;
    colored."${deps.mockito."0.20.0".colored}".default = true;
    difference."${deps.mockito."0.20.0".difference}".default = true;
    httparse."${deps.mockito."0.20.0".httparse}".default = true;
    lazy_static."${deps.mockito."0.20.0".lazy_static}".default = true;
    log."${deps.mockito."0.20.0".log}".default = true;
    mockito."0.20.0".default = (f.mockito."0.20.0".default or true);
    percent_encoding."${deps.mockito."0.20.0".percent_encoding}".default = true;
    rand."${deps.mockito."0.20.0".rand}".default = true;
    regex."${deps.mockito."0.20.0".regex}".default = true;
    serde_json."${deps.mockito."0.20.0".serde_json}".default = true;
  }) [
    (features_.assert_json_diff."${deps."mockito"."0.20.0"."assert_json_diff"}" deps)
    (features_.colored."${deps."mockito"."0.20.0"."colored"}" deps)
    (features_.difference."${deps."mockito"."0.20.0"."difference"}" deps)
    (features_.httparse."${deps."mockito"."0.20.0"."httparse"}" deps)
    (features_.lazy_static."${deps."mockito"."0.20.0"."lazy_static"}" deps)
    (features_.log."${deps."mockito"."0.20.0"."log"}" deps)
    (features_.percent_encoding."${deps."mockito"."0.20.0"."percent_encoding"}" deps)
    (features_.rand."${deps."mockito"."0.20.0"."rand"}" deps)
    (features_.regex."${deps."mockito"."0.20.0"."regex"}" deps)
    (features_.serde_json."${deps."mockito"."0.20.0"."serde_json"}" deps)
  ];


# end
# native-tls-0.2.3

  crates.native_tls."0.2.3" = deps: { features?(features_.native_tls."0.2.3" deps {}) }: buildRustCrate {
    crateName = "native-tls";
    version = "0.2.3";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "19bmkzcj2qvyxchlqa1yg2g5awjmk6sigm20mfwajfcczbq3dc6j";
    dependencies = (if kernel == "darwin" || kernel == "ios" then mapFeatures features ([
      (crates."lazy_static"."${deps."native_tls"."0.2.3"."lazy_static"}" deps)
      (crates."libc"."${deps."native_tls"."0.2.3"."libc"}" deps)
      (crates."security_framework"."${deps."native_tls"."0.2.3"."security_framework"}" deps)
      (crates."security_framework_sys"."${deps."native_tls"."0.2.3"."security_framework_sys"}" deps)
      (crates."tempfile"."${deps."native_tls"."0.2.3"."tempfile"}" deps)
    ]) else [])
      ++ (if !(kernel == "windows" || kernel == "darwin" || kernel == "ios") then mapFeatures features ([
      (crates."log"."${deps."native_tls"."0.2.3"."log"}" deps)
      (crates."openssl"."${deps."native_tls"."0.2.3"."openssl"}" deps)
      (crates."openssl_probe"."${deps."native_tls"."0.2.3"."openssl_probe"}" deps)
      (crates."openssl_sys"."${deps."native_tls"."0.2.3"."openssl_sys"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."schannel"."${deps."native_tls"."0.2.3"."schannel"}" deps)
    ]) else []);
    features = mkFeatures (features."native_tls"."0.2.3" or {});
  };
  features_.native_tls."0.2.3" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.native_tls."0.2.3".lazy_static}".default = true;
    libc."${deps.native_tls."0.2.3".libc}".default = true;
    log."${deps.native_tls."0.2.3".log}".default = true;
    native_tls."0.2.3".default = (f.native_tls."0.2.3".default or true);
    openssl."${deps.native_tls."0.2.3".openssl}".default = true;
    openssl_probe."${deps.native_tls."0.2.3".openssl_probe}".default = true;
    openssl_sys."${deps.native_tls."0.2.3".openssl_sys}".default = true;
    schannel."${deps.native_tls."0.2.3".schannel}".default = true;
    security_framework."${deps.native_tls."0.2.3".security_framework}".default = true;
    security_framework_sys."${deps.native_tls."0.2.3".security_framework_sys}".default = true;
    tempfile."${deps.native_tls."0.2.3".tempfile}".default = true;
  }) [
    (features_.lazy_static."${deps."native_tls"."0.2.3"."lazy_static"}" deps)
    (features_.libc."${deps."native_tls"."0.2.3"."libc"}" deps)
    (features_.security_framework."${deps."native_tls"."0.2.3"."security_framework"}" deps)
    (features_.security_framework_sys."${deps."native_tls"."0.2.3"."security_framework_sys"}" deps)
    (features_.tempfile."${deps."native_tls"."0.2.3"."tempfile"}" deps)
    (features_.log."${deps."native_tls"."0.2.3"."log"}" deps)
    (features_.openssl."${deps."native_tls"."0.2.3"."openssl"}" deps)
    (features_.openssl_probe."${deps."native_tls"."0.2.3"."openssl_probe"}" deps)
    (features_.openssl_sys."${deps."native_tls"."0.2.3"."openssl_sys"}" deps)
    (features_.schannel."${deps."native_tls"."0.2.3"."schannel"}" deps)
  ];


# end
# net2-0.2.33

  crates.net2."0.2.33" = deps: { features?(features_.net2."0.2.33" deps {}) }: buildRustCrate {
    crateName = "net2";
    version = "0.2.33";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1qnmajafgybj5wyxz9iffa8x5wgbwd2znfklmhqj7vl6lw1m65mq";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."net2"."0.2.33"."cfg_if"}" deps)
    ])
      ++ (if kernel == "redox" || (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."net2"."0.2.33"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."net2"."0.2.33"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."net2"."0.2.33" or {});
  };
  features_.net2."0.2.33" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.net2."0.2.33".cfg_if}".default = true;
    libc."${deps.net2."0.2.33".libc}".default = true;
    net2 = fold recursiveUpdate {} [
      { "0.2.33".default = (f.net2."0.2.33".default or true); }
      { "0.2.33".duration =
        (f.net2."0.2.33".duration or false) ||
        (f.net2."0.2.33".default or false) ||
        (net2."0.2.33"."default" or false); }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.net2."0.2.33".winapi}"."handleapi" = true; }
      { "${deps.net2."0.2.33".winapi}"."winsock2" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2def" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2ipdef" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2tcpip" = true; }
      { "${deps.net2."0.2.33".winapi}".default = true; }
    ];
  }) [
    (features_.cfg_if."${deps."net2"."0.2.33"."cfg_if"}" deps)
    (features_.libc."${deps."net2"."0.2.33"."libc"}" deps)
    (features_.winapi."${deps."net2"."0.2.33"."winapi"}" deps)
  ];


# end
# nodrop-0.1.13

  crates.nodrop."0.1.13" = deps: { features?(features_.nodrop."0.1.13" deps {}) }: buildRustCrate {
    crateName = "nodrop";
    version = "0.1.13";
    authors = [ "bluss" ];
    sha256 = "0gkfx6wihr9z0m8nbdhma5pyvbipznjpkzny2d4zkc05b0vnhinb";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."nodrop"."0.1.13" or {});
  };
  features_.nodrop."0.1.13" = deps: f: updateFeatures f (rec {
    nodrop = fold recursiveUpdate {} [
      { "0.1.13".default = (f.nodrop."0.1.13".default or true); }
      { "0.1.13".nodrop-union =
        (f.nodrop."0.1.13".nodrop-union or false) ||
        (f.nodrop."0.1.13".use_union or false) ||
        (nodrop."0.1.13"."use_union" or false); }
      { "0.1.13".std =
        (f.nodrop."0.1.13".std or false) ||
        (f.nodrop."0.1.13".default or false) ||
        (nodrop."0.1.13"."default" or false); }
    ];
  }) [];


# end
# num-integer-0.1.41

  crates.num_integer."0.1.41" = deps: { features?(features_.num_integer."0.1.41" deps {}) }: buildRustCrate {
    crateName = "num-integer";
    version = "0.1.41";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1y45nh9xlp2dra9svb1wfsy65fysm3k1w4m8jynywccq645yixid";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."num_traits"."${deps."num_integer"."0.1.41"."num_traits"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."num_integer"."0.1.41"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."num_integer"."0.1.41" or {});
  };
  features_.num_integer."0.1.41" = deps: f: updateFeatures f (rec {
    autocfg."${deps.num_integer."0.1.41".autocfg}".default = true;
    num_integer = fold recursiveUpdate {} [
      { "0.1.41".default = (f.num_integer."0.1.41".default or true); }
      { "0.1.41".std =
        (f.num_integer."0.1.41".std or false) ||
        (f.num_integer."0.1.41".default or false) ||
        (num_integer."0.1.41"."default" or false); }
    ];
    num_traits = fold recursiveUpdate {} [
      { "${deps.num_integer."0.1.41".num_traits}"."i128" =
        (f.num_traits."${deps.num_integer."0.1.41".num_traits}"."i128" or false) ||
        (num_integer."0.1.41"."i128" or false) ||
        (f."num_integer"."0.1.41"."i128" or false); }
      { "${deps.num_integer."0.1.41".num_traits}"."std" =
        (f.num_traits."${deps.num_integer."0.1.41".num_traits}"."std" or false) ||
        (num_integer."0.1.41"."std" or false) ||
        (f."num_integer"."0.1.41"."std" or false); }
      { "${deps.num_integer."0.1.41".num_traits}".default = (f.num_traits."${deps.num_integer."0.1.41".num_traits}".default or false); }
    ];
  }) [
    (features_.num_traits."${deps."num_integer"."0.1.41"."num_traits"}" deps)
    (features_.autocfg."${deps."num_integer"."0.1.41"."autocfg"}" deps)
  ];


# end
# num-traits-0.1.43

  crates.num_traits."0.1.43" = deps: { features?(features_.num_traits."0.1.43" deps {}) }: buildRustCrate {
    crateName = "num-traits";
    version = "0.1.43";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1zdzx78vrcg3f39w94pqjs1mwxl1phyv7843hwgwkzggwcxhhf6s";
    dependencies = mapFeatures features ([
      (crates."num_traits"."${deps."num_traits"."0.1.43"."num_traits"}" deps)
    ]);
  };
  features_.num_traits."0.1.43" = deps: f: updateFeatures f (rec {
    num_traits = fold recursiveUpdate {} [
      { "${deps.num_traits."0.1.43".num_traits}".default = true; }
      { "0.1.43".default = (f.num_traits."0.1.43".default or true); }
    ];
  }) [
    (features_.num_traits."${deps."num_traits"."0.1.43"."num_traits"}" deps)
  ];


# end
# num-traits-0.2.8

  crates.num_traits."0.2.8" = deps: { features?(features_.num_traits."0.2.8" deps {}) }: buildRustCrate {
    crateName = "num-traits";
    version = "0.2.8";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1mnlmy35n734n9xlq0qkfbgzz33x09a1s4rfj30p1976p09b862v";
    build = "build.rs";

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."num_traits"."0.2.8"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."num_traits"."0.2.8" or {});
  };
  features_.num_traits."0.2.8" = deps: f: updateFeatures f (rec {
    autocfg."${deps.num_traits."0.2.8".autocfg}".default = true;
    num_traits = fold recursiveUpdate {} [
      { "0.2.8".default = (f.num_traits."0.2.8".default or true); }
      { "0.2.8".std =
        (f.num_traits."0.2.8".std or false) ||
        (f.num_traits."0.2.8".default or false) ||
        (num_traits."0.2.8"."default" or false); }
    ];
  }) [
    (features_.autocfg."${deps."num_traits"."0.2.8"."autocfg"}" deps)
  ];


# end
# num_cpus-1.10.1

  crates.num_cpus."1.10.1" = deps: { features?(features_.num_cpus."1.10.1" deps {}) }: buildRustCrate {
    crateName = "num_cpus";
    version = "1.10.1";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1zi5s2cbnqqb0k0kdd6gqn2x97f9bssv44430h6w28awwzppyh8i";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."num_cpus"."1.10.1"."libc"}" deps)
    ]);
  };
  features_.num_cpus."1.10.1" = deps: f: updateFeatures f (rec {
    libc."${deps.num_cpus."1.10.1".libc}".default = true;
    num_cpus."1.10.1".default = (f.num_cpus."1.10.1".default or true);
  }) [
    (features_.libc."${deps."num_cpus"."1.10.1"."libc"}" deps)
  ];


# end
# openssl-0.10.24

  crates.openssl."0.10.24" = deps: { features?(features_.openssl."0.10.24" deps {}) }: buildRustCrate {
    crateName = "openssl";
    version = "0.10.24";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0w0ibpy5waw192xqz889znqdvzdnigwwfknqm9038l6id4xmw1mr";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."openssl"."0.10.24"."bitflags"}" deps)
      (crates."cfg_if"."${deps."openssl"."0.10.24"."cfg_if"}" deps)
      (crates."foreign_types"."${deps."openssl"."0.10.24"."foreign_types"}" deps)
      (crates."lazy_static"."${deps."openssl"."0.10.24"."lazy_static"}" deps)
      (crates."libc"."${deps."openssl"."0.10.24"."libc"}" deps)
      (crates."openssl_sys"."${deps."openssl"."0.10.24"."openssl_sys"}" deps)
    ]);
    features = mkFeatures (features."openssl"."0.10.24" or {});
  };
  features_.openssl."0.10.24" = deps: f: updateFeatures f (rec {
    bitflags."${deps.openssl."0.10.24".bitflags}".default = true;
    cfg_if."${deps.openssl."0.10.24".cfg_if}".default = true;
    foreign_types."${deps.openssl."0.10.24".foreign_types}".default = true;
    lazy_static."${deps.openssl."0.10.24".lazy_static}".default = true;
    libc."${deps.openssl."0.10.24".libc}".default = true;
    openssl."0.10.24".default = (f.openssl."0.10.24".default or true);
    openssl_sys = fold recursiveUpdate {} [
      { "${deps.openssl."0.10.24".openssl_sys}"."vendored" =
        (f.openssl_sys."${deps.openssl."0.10.24".openssl_sys}"."vendored" or false) ||
        (openssl."0.10.24"."vendored" or false) ||
        (f."openssl"."0.10.24"."vendored" or false); }
      { "${deps.openssl."0.10.24".openssl_sys}".default = true; }
    ];
  }) [
    (features_.bitflags."${deps."openssl"."0.10.24"."bitflags"}" deps)
    (features_.cfg_if."${deps."openssl"."0.10.24"."cfg_if"}" deps)
    (features_.foreign_types."${deps."openssl"."0.10.24"."foreign_types"}" deps)
    (features_.lazy_static."${deps."openssl"."0.10.24"."lazy_static"}" deps)
    (features_.libc."${deps."openssl"."0.10.24"."libc"}" deps)
    (features_.openssl_sys."${deps."openssl"."0.10.24"."openssl_sys"}" deps)
  ];


# end
# openssl-probe-0.1.2

  crates.openssl_probe."0.1.2" = deps: { features?(features_.openssl_probe."0.1.2" deps {}) }: buildRustCrate {
    crateName = "openssl-probe";
    version = "0.1.2";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1a89fznx26vvaxyrxdvgf6iwai5xvs6xjvpjin68fgvrslv6n15a";
  };
  features_.openssl_probe."0.1.2" = deps: f: updateFeatures f (rec {
    openssl_probe."0.1.2".default = (f.openssl_probe."0.1.2".default or true);
  }) [];


# end
# openssl-sys-0.9.49

  crates.openssl_sys."0.9.49" = deps: { features?(features_.openssl_sys."0.9.49" deps {}) }: buildRustCrate {
    crateName = "openssl-sys";
    version = "0.9.49";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0bjgw81f5ry05yrhqyby68g9acfsg6yadbzwm2yh3axd77c7zq8a";
    build = "build/main.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."openssl_sys"."0.9.49"."libc"}" deps)
    ])
      ++ (if abi == "msvc" then mapFeatures features ([
]) else []);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."openssl_sys"."0.9.49"."autocfg"}" deps)
      (crates."cc"."${deps."openssl_sys"."0.9.49"."cc"}" deps)
      (crates."pkg_config"."${deps."openssl_sys"."0.9.49"."pkg_config"}" deps)
    ]);
    features = mkFeatures (features."openssl_sys"."0.9.49" or {});
  };
  features_.openssl_sys."0.9.49" = deps: f: updateFeatures f (rec {
    autocfg."${deps.openssl_sys."0.9.49".autocfg}".default = true;
    cc."${deps.openssl_sys."0.9.49".cc}".default = true;
    libc."${deps.openssl_sys."0.9.49".libc}".default = true;
    openssl_sys = fold recursiveUpdate {} [
      { "0.9.49".default = (f.openssl_sys."0.9.49".default or true); }
      { "0.9.49".openssl-src =
        (f.openssl_sys."0.9.49".openssl-src or false) ||
        (f.openssl_sys."0.9.49".vendored or false) ||
        (openssl_sys."0.9.49"."vendored" or false); }
    ];
    pkg_config."${deps.openssl_sys."0.9.49".pkg_config}".default = true;
  }) [
    (features_.libc."${deps."openssl_sys"."0.9.49"."libc"}" deps)
    (features_.autocfg."${deps."openssl_sys"."0.9.49"."autocfg"}" deps)
    (features_.cc."${deps."openssl_sys"."0.9.49"."cc"}" deps)
    (features_.pkg_config."${deps."openssl_sys"."0.9.49"."pkg_config"}" deps)
  ];


# end
# owning_ref-0.4.0

  crates.owning_ref."0.4.0" = deps: { features?(features_.owning_ref."0.4.0" deps {}) }: buildRustCrate {
    crateName = "owning_ref";
    version = "0.4.0";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "1m95qpc3hamkw9wlbfzqkzk7h6skyj40zr6sa3ps151slcfnnchm";
    dependencies = mapFeatures features ([
      (crates."stable_deref_trait"."${deps."owning_ref"."0.4.0"."stable_deref_trait"}" deps)
    ]);
  };
  features_.owning_ref."0.4.0" = deps: f: updateFeatures f (rec {
    owning_ref."0.4.0".default = (f.owning_ref."0.4.0".default or true);
    stable_deref_trait."${deps.owning_ref."0.4.0".stable_deref_trait}".default = true;
  }) [
    (features_.stable_deref_trait."${deps."owning_ref"."0.4.0"."stable_deref_trait"}" deps)
  ];


# end
# parking_lot-0.7.1

  crates.parking_lot."0.7.1" = deps: { features?(features_.parking_lot."0.7.1" deps {}) }: buildRustCrate {
    crateName = "parking_lot";
    version = "0.7.1";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "1qpb49xd176hqqabxdb48f1hvylfbf68rpz8yfrhw0x68ys0lkq1";
    dependencies = mapFeatures features ([
      (crates."lock_api"."${deps."parking_lot"."0.7.1"."lock_api"}" deps)
      (crates."parking_lot_core"."${deps."parking_lot"."0.7.1"."parking_lot_core"}" deps)
    ]);
    features = mkFeatures (features."parking_lot"."0.7.1" or {});
  };
  features_.parking_lot."0.7.1" = deps: f: updateFeatures f (rec {
    lock_api = fold recursiveUpdate {} [
      { "${deps.parking_lot."0.7.1".lock_api}"."nightly" =
        (f.lock_api."${deps.parking_lot."0.7.1".lock_api}"."nightly" or false) ||
        (parking_lot."0.7.1"."nightly" or false) ||
        (f."parking_lot"."0.7.1"."nightly" or false); }
      { "${deps.parking_lot."0.7.1".lock_api}"."owning_ref" =
        (f.lock_api."${deps.parking_lot."0.7.1".lock_api}"."owning_ref" or false) ||
        (parking_lot."0.7.1"."owning_ref" or false) ||
        (f."parking_lot"."0.7.1"."owning_ref" or false); }
      { "${deps.parking_lot."0.7.1".lock_api}".default = true; }
    ];
    parking_lot = fold recursiveUpdate {} [
      { "0.7.1".default = (f.parking_lot."0.7.1".default or true); }
      { "0.7.1".owning_ref =
        (f.parking_lot."0.7.1".owning_ref or false) ||
        (f.parking_lot."0.7.1".default or false) ||
        (parking_lot."0.7.1"."default" or false); }
    ];
    parking_lot_core = fold recursiveUpdate {} [
      { "${deps.parking_lot."0.7.1".parking_lot_core}"."deadlock_detection" =
        (f.parking_lot_core."${deps.parking_lot."0.7.1".parking_lot_core}"."deadlock_detection" or false) ||
        (parking_lot."0.7.1"."deadlock_detection" or false) ||
        (f."parking_lot"."0.7.1"."deadlock_detection" or false); }
      { "${deps.parking_lot."0.7.1".parking_lot_core}"."nightly" =
        (f.parking_lot_core."${deps.parking_lot."0.7.1".parking_lot_core}"."nightly" or false) ||
        (parking_lot."0.7.1"."nightly" or false) ||
        (f."parking_lot"."0.7.1"."nightly" or false); }
      { "${deps.parking_lot."0.7.1".parking_lot_core}".default = true; }
    ];
  }) [
    (features_.lock_api."${deps."parking_lot"."0.7.1"."lock_api"}" deps)
    (features_.parking_lot_core."${deps."parking_lot"."0.7.1"."parking_lot_core"}" deps)
  ];


# end
# parking_lot_core-0.4.0

  crates.parking_lot_core."0.4.0" = deps: { features?(features_.parking_lot_core."0.4.0" deps {}) }: buildRustCrate {
    crateName = "parking_lot_core";
    version = "0.4.0";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "1mzk5i240ddvhwnz65hhjk4cq61z235g1n8bd7al4mg6vx437c16";
    dependencies = mapFeatures features ([
      (crates."rand"."${deps."parking_lot_core"."0.4.0"."rand"}" deps)
      (crates."smallvec"."${deps."parking_lot_core"."0.4.0"."smallvec"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."parking_lot_core"."0.4.0"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."parking_lot_core"."0.4.0"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."parking_lot_core"."0.4.0"."rustc_version"}" deps)
    ]);
    features = mkFeatures (features."parking_lot_core"."0.4.0" or {});
  };
  features_.parking_lot_core."0.4.0" = deps: f: updateFeatures f (rec {
    libc."${deps.parking_lot_core."0.4.0".libc}".default = true;
    parking_lot_core = fold recursiveUpdate {} [
      { "0.4.0".backtrace =
        (f.parking_lot_core."0.4.0".backtrace or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
      { "0.4.0".default = (f.parking_lot_core."0.4.0".default or true); }
      { "0.4.0".petgraph =
        (f.parking_lot_core."0.4.0".petgraph or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
      { "0.4.0".thread-id =
        (f.parking_lot_core."0.4.0".thread-id or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
    ];
    rand."${deps.parking_lot_core."0.4.0".rand}".default = true;
    rustc_version."${deps.parking_lot_core."0.4.0".rustc_version}".default = true;
    smallvec."${deps.parking_lot_core."0.4.0".smallvec}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.parking_lot_core."0.4.0".winapi}"."errhandlingapi" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."handleapi" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."minwindef" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."ntstatus" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winbase" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winerror" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winnt" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}".default = true; }
    ];
  }) [
    (features_.rand."${deps."parking_lot_core"."0.4.0"."rand"}" deps)
    (features_.smallvec."${deps."parking_lot_core"."0.4.0"."smallvec"}" deps)
    (features_.rustc_version."${deps."parking_lot_core"."0.4.0"."rustc_version"}" deps)
    (features_.libc."${deps."parking_lot_core"."0.4.0"."libc"}" deps)
    (features_.winapi."${deps."parking_lot_core"."0.4.0"."winapi"}" deps)
  ];


# end
# percent-encoding-1.0.1

  crates.percent_encoding."1.0.1" = deps: { features?(features_.percent_encoding."1.0.1" deps {}) }: buildRustCrate {
    crateName = "percent-encoding";
    version = "1.0.1";
    authors = [ "The rust-url developers" ];
    sha256 = "04ahrp7aw4ip7fmadb0bknybmkfav0kk0gw4ps3ydq5w6hr0ib5i";
    libPath = "lib.rs";
  };
  features_.percent_encoding."1.0.1" = deps: f: updateFeatures f (rec {
    percent_encoding."1.0.1".default = (f.percent_encoding."1.0.1".default or true);
  }) [];


# end
# percent-encoding-2.1.0

  crates.percent_encoding."2.1.0" = deps: { features?(features_.percent_encoding."2.1.0" deps {}) }: buildRustCrate {
    crateName = "percent-encoding";
    version = "2.1.0";
    authors = [ "The rust-url developers" ];
    sha256 = "0i838f2nr81585ckmfymf8l1x1vdmx6n8xqvli0lgcy60yl2axy3";
    libPath = "lib.rs";
  };
  features_.percent_encoding."2.1.0" = deps: f: updateFeatures f (rec {
    percent_encoding."2.1.0".default = (f.percent_encoding."2.1.0".default or true);
  }) [];


# end
# pkg-config-0.3.15

  crates.pkg_config."0.3.15" = deps: { features?(features_.pkg_config."0.3.15" deps {}) }: buildRustCrate {
    crateName = "pkg-config";
    version = "0.3.15";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "02yh110i3bh5v7b2lb7sj4l335w2zdlliqqd5i5qf28f94w1rry5";
  };
  features_.pkg_config."0.3.15" = deps: f: updateFeatures f (rec {
    pkg_config."0.3.15".default = (f.pkg_config."0.3.15".default or true);
  }) [];


# end
# ppv-lite86-0.2.5

  crates.ppv_lite86."0.2.5" = deps: { features?(features_.ppv_lite86."0.2.5" deps {}) }: buildRustCrate {
    crateName = "ppv-lite86";
    version = "0.2.5";
    authors = [ "The CryptoCorrosion Contributors" ];
    edition = "2018";
    sha256 = "1r3bhih75vhl8v7q0flmywl7hmfg902yf3jjzracsh0jlkldij6r";
    features = mkFeatures (features."ppv_lite86"."0.2.5" or {});
  };
  features_.ppv_lite86."0.2.5" = deps: f: updateFeatures f (rec {
    ppv_lite86 = fold recursiveUpdate {} [
      { "0.2.5".default = (f.ppv_lite86."0.2.5".default or true); }
      { "0.2.5".simd =
        (f.ppv_lite86."0.2.5".simd or false) ||
        (f.ppv_lite86."0.2.5".default or false) ||
        (ppv_lite86."0.2.5"."default" or false); }
      { "0.2.5".std =
        (f.ppv_lite86."0.2.5".std or false) ||
        (f.ppv_lite86."0.2.5".default or false) ||
        (ppv_lite86."0.2.5"."default" or false); }
    ];
  }) [];


# end
# prettytable-rs-0.8.0

  crates.prettytable_rs."0.8.0" = deps: { features?(features_.prettytable_rs."0.8.0" deps {}) }: buildRustCrate {
    crateName = "prettytable-rs";
    version = "0.8.0";
    authors = [ "Pierre-Henri Symoneaux" ];
    sha256 = "1v1xqaz5zar87jn1lcwl74c4y5avxx1fwa7d1vr7qrz109z7ipl0";
    libName = "prettytable";
    crateBin =
      [{  name = "main";  path = "src/main.rs"; }];
    dependencies = mapFeatures features ([
      (crates."atty"."${deps."prettytable_rs"."0.8.0"."atty"}" deps)
      (crates."encode_unicode"."${deps."prettytable_rs"."0.8.0"."encode_unicode"}" deps)
      (crates."lazy_static"."${deps."prettytable_rs"."0.8.0"."lazy_static"}" deps)
      (crates."term"."${deps."prettytable_rs"."0.8.0"."term"}" deps)
      (crates."unicode_width"."${deps."prettytable_rs"."0.8.0"."unicode_width"}" deps)
    ]
      ++ (if features.prettytable_rs."0.8.0".csv or false then [ (crates.csv."${deps."prettytable_rs"."0.8.0".csv}" deps) ] else []));
    features = mkFeatures (features."prettytable_rs"."0.8.0" or {});
  };
  features_.prettytable_rs."0.8.0" = deps: f: updateFeatures f (rec {
    atty."${deps.prettytable_rs."0.8.0".atty}".default = true;
    csv."${deps.prettytable_rs."0.8.0".csv}".default = true;
    encode_unicode."${deps.prettytable_rs."0.8.0".encode_unicode}".default = true;
    lazy_static."${deps.prettytable_rs."0.8.0".lazy_static}".default = true;
    prettytable_rs = fold recursiveUpdate {} [
      { "0.8.0".csv =
        (f.prettytable_rs."0.8.0".csv or false) ||
        (f.prettytable_rs."0.8.0".default or false) ||
        (prettytable_rs."0.8.0"."default" or false); }
      { "0.8.0".default = (f.prettytable_rs."0.8.0".default or true); }
      { "0.8.0".win_crlf =
        (f.prettytable_rs."0.8.0".win_crlf or false) ||
        (f.prettytable_rs."0.8.0".default or false) ||
        (prettytable_rs."0.8.0"."default" or false); }
    ];
    term."${deps.prettytable_rs."0.8.0".term}".default = true;
    unicode_width."${deps.prettytable_rs."0.8.0".unicode_width}".default = true;
  }) [
    (features_.atty."${deps."prettytable_rs"."0.8.0"."atty"}" deps)
    (features_.csv."${deps."prettytable_rs"."0.8.0"."csv"}" deps)
    (features_.encode_unicode."${deps."prettytable_rs"."0.8.0"."encode_unicode"}" deps)
    (features_.lazy_static."${deps."prettytable_rs"."0.8.0"."lazy_static"}" deps)
    (features_.term."${deps."prettytable_rs"."0.8.0"."term"}" deps)
    (features_.unicode_width."${deps."prettytable_rs"."0.8.0"."unicode_width"}" deps)
  ];


# end
# proc-macro2-0.4.30

  crates.proc_macro2."0.4.30" = deps: { features?(features_.proc_macro2."0.4.30" deps {}) }: buildRustCrate {
    crateName = "proc-macro2";
    version = "0.4.30";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0iifv51wrm6r4r2gghw6rray3nv53zcap355bbz1nsmbhj5s09b9";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."unicode_xid"."${deps."proc_macro2"."0.4.30"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."proc_macro2"."0.4.30" or {});
  };
  features_.proc_macro2."0.4.30" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "0.4.30".default = (f.proc_macro2."0.4.30".default or true); }
      { "0.4.30".proc-macro =
        (f.proc_macro2."0.4.30".proc-macro or false) ||
        (f.proc_macro2."0.4.30".default or false) ||
        (proc_macro2."0.4.30"."default" or false); }
    ];
    unicode_xid."${deps.proc_macro2."0.4.30".unicode_xid}".default = true;
  }) [
    (features_.unicode_xid."${deps."proc_macro2"."0.4.30"."unicode_xid"}" deps)
  ];


# end
# proc-macro2-1.0.1

  crates.proc_macro2."1.0.1" = deps: { features?(features_.proc_macro2."1.0.1" deps {}) }: buildRustCrate {
    crateName = "proc-macro2";
    version = "1.0.1";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "120c9z5y8zz6gfl9c593k6vjss3sqz5x4nxd4ckwk27zi95h35i8";
    libName = "proc_macro2";
    dependencies = mapFeatures features ([
      (crates."unicode_xid"."${deps."proc_macro2"."1.0.1"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."proc_macro2"."1.0.1" or {});
  };
  features_.proc_macro2."1.0.1" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "1.0.1".default = (f.proc_macro2."1.0.1".default or true); }
      { "1.0.1".proc-macro =
        (f.proc_macro2."1.0.1".proc-macro or false) ||
        (f.proc_macro2."1.0.1".default or false) ||
        (proc_macro2."1.0.1"."default" or false); }
    ];
    unicode_xid."${deps.proc_macro2."1.0.1".unicode_xid}".default = true;
  }) [
    (features_.unicode_xid."${deps."proc_macro2"."1.0.1"."unicode_xid"}" deps)
  ];


# end
# publicsuffix-1.5.3

  crates.publicsuffix."1.5.3" = deps: { features?(features_.publicsuffix."1.5.3" deps {}) }: buildRustCrate {
    crateName = "publicsuffix";
    version = "1.5.3";
    authors = [ "rushmorem <rushmore@webenchanter.com>" ];
    sha256 = "1cynqhsq870q3xqn1630d6m7p4x0a6w1vngsxlcjl89c37wmcbrc";
    dependencies = mapFeatures features ([
      (crates."error_chain"."${deps."publicsuffix"."1.5.3"."error_chain"}" deps)
      (crates."idna"."${deps."publicsuffix"."1.5.3"."idna"}" deps)
      (crates."lazy_static"."${deps."publicsuffix"."1.5.3"."lazy_static"}" deps)
      (crates."regex"."${deps."publicsuffix"."1.5.3"."regex"}" deps)
      (crates."url"."${deps."publicsuffix"."1.5.3"."url"}" deps)
    ]);
    features = mkFeatures (features."publicsuffix"."1.5.3" or {});
  };
  features_.publicsuffix."1.5.3" = deps: f: updateFeatures f (rec {
    error_chain."${deps.publicsuffix."1.5.3".error_chain}".default = true;
    idna."${deps.publicsuffix."1.5.3".idna}".default = true;
    lazy_static."${deps.publicsuffix."1.5.3".lazy_static}".default = true;
    publicsuffix = fold recursiveUpdate {} [
      { "1.5.3".default = (f.publicsuffix."1.5.3".default or true); }
      { "1.5.3".native-tls =
        (f.publicsuffix."1.5.3".native-tls or false) ||
        (f.publicsuffix."1.5.3".remote_list or false) ||
        (publicsuffix."1.5.3"."remote_list" or false); }
      { "1.5.3".remote_list =
        (f.publicsuffix."1.5.3".remote_list or false) ||
        (f.publicsuffix."1.5.3".default or false) ||
        (publicsuffix."1.5.3"."default" or false); }
    ];
    regex."${deps.publicsuffix."1.5.3".regex}".default = true;
    url."${deps.publicsuffix."1.5.3".url}".default = true;
  }) [
    (features_.error_chain."${deps."publicsuffix"."1.5.3"."error_chain"}" deps)
    (features_.idna."${deps."publicsuffix"."1.5.3"."idna"}" deps)
    (features_.lazy_static."${deps."publicsuffix"."1.5.3"."lazy_static"}" deps)
    (features_.regex."${deps."publicsuffix"."1.5.3"."regex"}" deps)
    (features_.url."${deps."publicsuffix"."1.5.3"."url"}" deps)
  ];


# end
# quote-0.6.13

  crates.quote."0.6.13" = deps: { features?(features_.quote."0.6.13" deps {}) }: buildRustCrate {
    crateName = "quote";
    version = "0.6.13";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1hrvsin40i4q8swrhlj9057g7nsp0lg02h8zbzmgz14av9mzv8g8";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."quote"."0.6.13"."proc_macro2"}" deps)
    ]);
    features = mkFeatures (features."quote"."0.6.13" or {});
  };
  features_.quote."0.6.13" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.quote."0.6.13".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.quote."0.6.13".proc_macro2}"."proc-macro" or false) ||
        (quote."0.6.13"."proc-macro" or false) ||
        (f."quote"."0.6.13"."proc-macro" or false); }
      { "${deps.quote."0.6.13".proc_macro2}".default = (f.proc_macro2."${deps.quote."0.6.13".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "0.6.13".default = (f.quote."0.6.13".default or true); }
      { "0.6.13".proc-macro =
        (f.quote."0.6.13".proc-macro or false) ||
        (f.quote."0.6.13".default or false) ||
        (quote."0.6.13"."default" or false); }
    ];
  }) [
    (features_.proc_macro2."${deps."quote"."0.6.13"."proc_macro2"}" deps)
  ];


# end
# quote-1.0.2

  crates.quote."1.0.2" = deps: { features?(features_.quote."1.0.2" deps {}) }: buildRustCrate {
    crateName = "quote";
    version = "1.0.2";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "0r7030w7dymarn92gjgm02hsm04fwsfs6f1l20wdqiyrm9z8rs5q";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."quote"."1.0.2"."proc_macro2"}" deps)
    ]);
    features = mkFeatures (features."quote"."1.0.2" or {});
  };
  features_.quote."1.0.2" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.quote."1.0.2".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.quote."1.0.2".proc_macro2}"."proc-macro" or false) ||
        (quote."1.0.2"."proc-macro" or false) ||
        (f."quote"."1.0.2"."proc-macro" or false); }
      { "${deps.quote."1.0.2".proc_macro2}".default = (f.proc_macro2."${deps.quote."1.0.2".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "1.0.2".default = (f.quote."1.0.2".default or true); }
      { "1.0.2".proc-macro =
        (f.quote."1.0.2".proc-macro or false) ||
        (f.quote."1.0.2".default or false) ||
        (quote."1.0.2"."default" or false); }
    ];
  }) [
    (features_.proc_macro2."${deps."quote"."1.0.2"."proc_macro2"}" deps)
  ];


# end
# rand-0.4.6

  crates.rand."0.4.6" = deps: { features?(features_.rand."0.4.6" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.4.6";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0c3rmg5q7d6qdi7cbmg5py9alm70wd3xsg0mmcawrnl35qv37zfs";
    dependencies = (if abi == "sgx" then mapFeatures features ([
      (crates."rand_core"."${deps."rand"."0.4.6"."rand_core"}" deps)
      (crates."rdrand"."${deps."rand"."0.4.6"."rdrand"}" deps)
    ]) else [])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_cprng"."${deps."rand"."0.4.6"."fuchsia_cprng"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
    ]
      ++ (if features.rand."0.4.6".libc or false then [ (crates.libc."${deps."rand"."0.4.6".libc}" deps) ] else [])) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand"."0.4.6"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."rand"."0.4.6" or {});
  };
  features_.rand."0.4.6" = deps: f: updateFeatures f (rec {
    fuchsia_cprng."${deps.rand."0.4.6".fuchsia_cprng}".default = true;
    libc."${deps.rand."0.4.6".libc}".default = true;
    rand = fold recursiveUpdate {} [
      { "0.4.6".default = (f.rand."0.4.6".default or true); }
      { "0.4.6".i128_support =
        (f.rand."0.4.6".i128_support or false) ||
        (f.rand."0.4.6".nightly or false) ||
        (rand."0.4.6"."nightly" or false); }
      { "0.4.6".libc =
        (f.rand."0.4.6".libc or false) ||
        (f.rand."0.4.6".std or false) ||
        (rand."0.4.6"."std" or false); }
      { "0.4.6".std =
        (f.rand."0.4.6".std or false) ||
        (f.rand."0.4.6".default or false) ||
        (rand."0.4.6"."default" or false); }
    ];
    rand_core."${deps.rand."0.4.6".rand_core}".default = (f.rand_core."${deps.rand."0.4.6".rand_core}".default or false);
    rdrand."${deps.rand."0.4.6".rdrand}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.4.6".winapi}"."minwindef" = true; }
      { "${deps.rand."0.4.6".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.4.6".winapi}"."profileapi" = true; }
      { "${deps.rand."0.4.6".winapi}"."winnt" = true; }
      { "${deps.rand."0.4.6".winapi}".default = true; }
    ];
  }) [
    (features_.rand_core."${deps."rand"."0.4.6"."rand_core"}" deps)
    (features_.rdrand."${deps."rand"."0.4.6"."rdrand"}" deps)
    (features_.fuchsia_cprng."${deps."rand"."0.4.6"."fuchsia_cprng"}" deps)
    (features_.libc."${deps."rand"."0.4.6"."libc"}" deps)
    (features_.winapi."${deps."rand"."0.4.6"."winapi"}" deps)
  ];


# end
# rand-0.6.5

  crates.rand."0.6.5" = deps: { features?(features_.rand."0.6.5" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.6.5";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0zbck48159aj8zrwzf80sd9xxh96w4f4968nshwjpysjvflimvgb";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_chacha"."${deps."rand"."0.6.5"."rand_chacha"}" deps)
      (crates."rand_core"."${deps."rand"."0.6.5"."rand_core"}" deps)
      (crates."rand_hc"."${deps."rand"."0.6.5"."rand_hc"}" deps)
      (crates."rand_isaac"."${deps."rand"."0.6.5"."rand_isaac"}" deps)
      (crates."rand_jitter"."${deps."rand"."0.6.5"."rand_jitter"}" deps)
      (crates."rand_pcg"."${deps."rand"."0.6.5"."rand_pcg"}" deps)
      (crates."rand_xorshift"."${deps."rand"."0.6.5"."rand_xorshift"}" deps)
    ]
      ++ (if features.rand."0.6.5".rand_os or false then [ (crates.rand_os."${deps."rand"."0.6.5".rand_os}" deps) ] else []))
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."rand"."0.6.5"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand"."0.6.5"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand"."0.6.5"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."rand"."0.6.5" or {});
  };
  features_.rand."0.6.5" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand."0.6.5".autocfg}".default = true;
    libc."${deps.rand."0.6.5".libc}".default = (f.libc."${deps.rand."0.6.5".libc}".default or false);
    rand = fold recursiveUpdate {} [
      { "0.6.5".alloc =
        (f.rand."0.6.5".alloc or false) ||
        (f.rand."0.6.5".std or false) ||
        (rand."0.6.5"."std" or false); }
      { "0.6.5".default = (f.rand."0.6.5".default or true); }
      { "0.6.5".packed_simd =
        (f.rand."0.6.5".packed_simd or false) ||
        (f.rand."0.6.5".simd_support or false) ||
        (rand."0.6.5"."simd_support" or false); }
      { "0.6.5".rand_os =
        (f.rand."0.6.5".rand_os or false) ||
        (f.rand."0.6.5".std or false) ||
        (rand."0.6.5"."std" or false); }
      { "0.6.5".simd_support =
        (f.rand."0.6.5".simd_support or false) ||
        (f.rand."0.6.5".nightly or false) ||
        (rand."0.6.5"."nightly" or false); }
      { "0.6.5".std =
        (f.rand."0.6.5".std or false) ||
        (f.rand."0.6.5".default or false) ||
        (rand."0.6.5"."default" or false); }
    ];
    rand_chacha."${deps.rand."0.6.5".rand_chacha}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_core}"."alloc" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."alloc" or false) ||
        (rand."0.6.5"."alloc" or false) ||
        (f."rand"."0.6.5"."alloc" or false); }
      { "${deps.rand."0.6.5".rand_core}"."serde1" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_core}"."std" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."std" or false) ||
        (rand."0.6.5"."std" or false) ||
        (f."rand"."0.6.5"."std" or false); }
      { "${deps.rand."0.6.5".rand_core}".default = true; }
    ];
    rand_hc."${deps.rand."0.6.5".rand_hc}".default = true;
    rand_isaac = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_isaac}"."serde1" =
        (f.rand_isaac."${deps.rand."0.6.5".rand_isaac}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_isaac}".default = true; }
    ];
    rand_jitter = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_jitter}"."std" =
        (f.rand_jitter."${deps.rand."0.6.5".rand_jitter}"."std" or false) ||
        (rand."0.6.5"."std" or false) ||
        (f."rand"."0.6.5"."std" or false); }
      { "${deps.rand."0.6.5".rand_jitter}".default = true; }
    ];
    rand_os = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_os}"."stdweb" =
        (f.rand_os."${deps.rand."0.6.5".rand_os}"."stdweb" or false) ||
        (rand."0.6.5"."stdweb" or false) ||
        (f."rand"."0.6.5"."stdweb" or false); }
      { "${deps.rand."0.6.5".rand_os}"."wasm-bindgen" =
        (f.rand_os."${deps.rand."0.6.5".rand_os}"."wasm-bindgen" or false) ||
        (rand."0.6.5"."wasm-bindgen" or false) ||
        (f."rand"."0.6.5"."wasm-bindgen" or false); }
      { "${deps.rand."0.6.5".rand_os}".default = true; }
    ];
    rand_pcg."${deps.rand."0.6.5".rand_pcg}".default = true;
    rand_xorshift = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_xorshift}"."serde1" =
        (f.rand_xorshift."${deps.rand."0.6.5".rand_xorshift}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_xorshift}".default = true; }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".winapi}"."minwindef" = true; }
      { "${deps.rand."0.6.5".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.6.5".winapi}"."profileapi" = true; }
      { "${deps.rand."0.6.5".winapi}"."winnt" = true; }
      { "${deps.rand."0.6.5".winapi}".default = true; }
    ];
  }) [
    (features_.rand_chacha."${deps."rand"."0.6.5"."rand_chacha"}" deps)
    (features_.rand_core."${deps."rand"."0.6.5"."rand_core"}" deps)
    (features_.rand_hc."${deps."rand"."0.6.5"."rand_hc"}" deps)
    (features_.rand_isaac."${deps."rand"."0.6.5"."rand_isaac"}" deps)
    (features_.rand_jitter."${deps."rand"."0.6.5"."rand_jitter"}" deps)
    (features_.rand_os."${deps."rand"."0.6.5"."rand_os"}" deps)
    (features_.rand_pcg."${deps."rand"."0.6.5"."rand_pcg"}" deps)
    (features_.rand_xorshift."${deps."rand"."0.6.5"."rand_xorshift"}" deps)
    (features_.autocfg."${deps."rand"."0.6.5"."autocfg"}" deps)
    (features_.libc."${deps."rand"."0.6.5"."libc"}" deps)
    (features_.winapi."${deps."rand"."0.6.5"."winapi"}" deps)
  ];


# end
# rand-0.7.0

  crates.rand."0.7.0" = deps: { features?(features_.rand."0.7.0" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.7.0";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    edition = "2018";
    sha256 = "00nfv8p95nf985sxdfd7j23br77v47sf9hp95qjna1zsz4fyjs8v";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand"."0.7.0"."rand_core"}" deps)
    ])
      ++ (if !(kernel == "emscripten") then mapFeatures features ([
      (crates."rand_chacha"."${deps."rand"."0.7.0"."rand_chacha"}" deps)
    ]) else [])
      ++ (if kernel == "emscripten" then mapFeatures features ([
      (crates."rand_hc"."${deps."rand"."0.7.0"."rand_hc"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."rand"."0.7.0"."libc"}" deps)
    ]) else []);
    features = mkFeatures (features."rand"."0.7.0" or {});
  };
  features_.rand."0.7.0" = deps: f: updateFeatures f (rec {
    libc."${deps.rand."0.7.0".libc}".default = (f.libc."${deps.rand."0.7.0".libc}".default or false);
    rand = fold recursiveUpdate {} [
      { "0.7.0".alloc =
        (f.rand."0.7.0".alloc or false) ||
        (f.rand."0.7.0".std or false) ||
        (rand."0.7.0"."std" or false); }
      { "0.7.0".default = (f.rand."0.7.0".default or true); }
      { "0.7.0".getrandom =
        (f.rand."0.7.0".getrandom or false) ||
        (f.rand."0.7.0".std or false) ||
        (rand."0.7.0"."std" or false); }
      { "0.7.0".getrandom_package =
        (f.rand."0.7.0".getrandom_package or false) ||
        (f.rand."0.7.0".getrandom or false) ||
        (rand."0.7.0"."getrandom" or false); }
      { "0.7.0".packed_simd =
        (f.rand."0.7.0".packed_simd or false) ||
        (f.rand."0.7.0".simd_support or false) ||
        (rand."0.7.0"."simd_support" or false); }
      { "0.7.0".rand_pcg =
        (f.rand."0.7.0".rand_pcg or false) ||
        (f.rand."0.7.0".small_rng or false) ||
        (rand."0.7.0"."small_rng" or false); }
      { "0.7.0".simd_support =
        (f.rand."0.7.0".simd_support or false) ||
        (f.rand."0.7.0".nightly or false) ||
        (rand."0.7.0"."nightly" or false); }
      { "0.7.0".std =
        (f.rand."0.7.0".std or false) ||
        (f.rand."0.7.0".default or false) ||
        (rand."0.7.0"."default" or false); }
    ];
    rand_chacha."${deps.rand."0.7.0".rand_chacha}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand."0.7.0".rand_core}"."alloc" =
        (f.rand_core."${deps.rand."0.7.0".rand_core}"."alloc" or false) ||
        (rand."0.7.0"."alloc" or false) ||
        (f."rand"."0.7.0"."alloc" or false); }
      { "${deps.rand."0.7.0".rand_core}"."getrandom" =
        (f.rand_core."${deps.rand."0.7.0".rand_core}"."getrandom" or false) ||
        (rand."0.7.0"."getrandom" or false) ||
        (f."rand"."0.7.0"."getrandom" or false); }
      { "${deps.rand."0.7.0".rand_core}"."std" =
        (f.rand_core."${deps.rand."0.7.0".rand_core}"."std" or false) ||
        (rand."0.7.0"."std" or false) ||
        (f."rand"."0.7.0"."std" or false); }
      { "${deps.rand."0.7.0".rand_core}".default = true; }
    ];
    rand_hc."${deps.rand."0.7.0".rand_hc}".default = true;
  }) [
    (features_.rand_core."${deps."rand"."0.7.0"."rand_core"}" deps)
    (features_.rand_chacha."${deps."rand"."0.7.0"."rand_chacha"}" deps)
    (features_.rand_hc."${deps."rand"."0.7.0"."rand_hc"}" deps)
    (features_.libc."${deps."rand"."0.7.0"."libc"}" deps)
  ];


# end
# rand_chacha-0.1.1

  crates.rand_chacha."0.1.1" = deps: { features?(features_.rand_chacha."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_chacha";
    version = "0.1.1";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0xnxm4mjd7wjnh18zxc1yickw58axbycp35ciraplqdfwn1gffwi";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_chacha"."0.1.1"."rand_core"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand_chacha"."0.1.1"."autocfg"}" deps)
    ]);
  };
  features_.rand_chacha."0.1.1" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand_chacha."0.1.1".autocfg}".default = true;
    rand_chacha."0.1.1".default = (f.rand_chacha."0.1.1".default or true);
    rand_core."${deps.rand_chacha."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_chacha."0.1.1".rand_core}".default or false);
  }) [
    (features_.rand_core."${deps."rand_chacha"."0.1.1"."rand_core"}" deps)
    (features_.autocfg."${deps."rand_chacha"."0.1.1"."autocfg"}" deps)
  ];


# end
# rand_chacha-0.2.1

  crates.rand_chacha."0.2.1" = deps: { features?(features_.rand_chacha."0.2.1" deps {}) }: buildRustCrate {
    crateName = "rand_chacha";
    version = "0.2.1";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" "The CryptoCorrosion Contributors" ];
    edition = "2018";
    sha256 = "0zpp3wmxhhmripb6bywhzhx5rfwl4dfbny85hpalwdj0sncv0p0k";
    dependencies = mapFeatures features ([
      (crates."c2_chacha"."${deps."rand_chacha"."0.2.1"."c2_chacha"}" deps)
      (crates."rand_core"."${deps."rand_chacha"."0.2.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_chacha"."0.2.1" or {});
  };
  features_.rand_chacha."0.2.1" = deps: f: updateFeatures f (rec {
    c2_chacha = fold recursiveUpdate {} [
      { "${deps.rand_chacha."0.2.1".c2_chacha}"."simd" = true; }
      { "${deps.rand_chacha."0.2.1".c2_chacha}"."std" =
        (f.c2_chacha."${deps.rand_chacha."0.2.1".c2_chacha}"."std" or false) ||
        (rand_chacha."0.2.1"."std" or false) ||
        (f."rand_chacha"."0.2.1"."std" or false); }
      { "${deps.rand_chacha."0.2.1".c2_chacha}".default = (f.c2_chacha."${deps.rand_chacha."0.2.1".c2_chacha}".default or false); }
    ];
    rand_chacha = fold recursiveUpdate {} [
      { "0.2.1".default = (f.rand_chacha."0.2.1".default or true); }
      { "0.2.1".simd =
        (f.rand_chacha."0.2.1".simd or false) ||
        (f.rand_chacha."0.2.1".default or false) ||
        (rand_chacha."0.2.1"."default" or false); }
      { "0.2.1".std =
        (f.rand_chacha."0.2.1".std or false) ||
        (f.rand_chacha."0.2.1".default or false) ||
        (rand_chacha."0.2.1"."default" or false); }
    ];
    rand_core."${deps.rand_chacha."0.2.1".rand_core}".default = true;
  }) [
    (features_.c2_chacha."${deps."rand_chacha"."0.2.1"."c2_chacha"}" deps)
    (features_.rand_core."${deps."rand_chacha"."0.2.1"."rand_core"}" deps)
  ];


# end
# rand_core-0.3.1

  crates.rand_core."0.3.1" = deps: { features?(features_.rand_core."0.3.1" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.3.1";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0q0ssgpj9x5a6fda83nhmfydy7a6c0wvxm0jhncsmjx8qp8gw91m";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_core"."0.3.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_core"."0.3.1" or {});
  };
  features_.rand_core."0.3.1" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_core."0.3.1".rand_core}"."alloc" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."alloc" or false) ||
        (rand_core."0.3.1"."alloc" or false) ||
        (f."rand_core"."0.3.1"."alloc" or false); }
      { "${deps.rand_core."0.3.1".rand_core}"."serde1" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."serde1" or false) ||
        (rand_core."0.3.1"."serde1" or false) ||
        (f."rand_core"."0.3.1"."serde1" or false); }
      { "${deps.rand_core."0.3.1".rand_core}"."std" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."std" or false) ||
        (rand_core."0.3.1"."std" or false) ||
        (f."rand_core"."0.3.1"."std" or false); }
      { "${deps.rand_core."0.3.1".rand_core}".default = true; }
      { "0.3.1".default = (f.rand_core."0.3.1".default or true); }
      { "0.3.1".std =
        (f.rand_core."0.3.1".std or false) ||
        (f.rand_core."0.3.1".default or false) ||
        (rand_core."0.3.1"."default" or false); }
    ];
  }) [
    (features_.rand_core."${deps."rand_core"."0.3.1"."rand_core"}" deps)
  ];


# end
# rand_core-0.4.2

  crates.rand_core."0.4.2" = deps: { features?(features_.rand_core."0.4.2" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.4.2";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "18zpzwn4bl7lp9f36iacy8mvdnfrhfmzsl35gmln98dcindff2ly";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."rand_core"."0.4.2" or {});
  };
  features_.rand_core."0.4.2" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "0.4.2".alloc =
        (f.rand_core."0.4.2".alloc or false) ||
        (f.rand_core."0.4.2".std or false) ||
        (rand_core."0.4.2"."std" or false); }
      { "0.4.2".default = (f.rand_core."0.4.2".default or true); }
      { "0.4.2".serde =
        (f.rand_core."0.4.2".serde or false) ||
        (f.rand_core."0.4.2".serde1 or false) ||
        (rand_core."0.4.2"."serde1" or false); }
      { "0.4.2".serde_derive =
        (f.rand_core."0.4.2".serde_derive or false) ||
        (f.rand_core."0.4.2".serde1 or false) ||
        (rand_core."0.4.2"."serde1" or false); }
    ];
  }) [];


# end
# rand_core-0.5.1

  crates.rand_core."0.5.1" = deps: { features?(features_.rand_core."0.5.1" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.5.1";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    edition = "2018";
    sha256 = "19qfnh77bzz0x2gfsk91h0gygy0z1s5l3yyc2j91gmprq60d6s3r";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.rand_core."0.5.1".getrandom or false then [ (crates.getrandom."${deps."rand_core"."0.5.1".getrandom}" deps) ] else []));
    features = mkFeatures (features."rand_core"."0.5.1" or {});
  };
  features_.rand_core."0.5.1" = deps: f: updateFeatures f (rec {
    getrandom = fold recursiveUpdate {} [
      { "${deps.rand_core."0.5.1".getrandom}"."std" =
        (f.getrandom."${deps.rand_core."0.5.1".getrandom}"."std" or false) ||
        (rand_core."0.5.1"."std" or false) ||
        (f."rand_core"."0.5.1"."std" or false); }
      { "${deps.rand_core."0.5.1".getrandom}".default = true; }
    ];
    rand_core = fold recursiveUpdate {} [
      { "0.5.1".alloc =
        (f.rand_core."0.5.1".alloc or false) ||
        (f.rand_core."0.5.1".std or false) ||
        (rand_core."0.5.1"."std" or false); }
      { "0.5.1".default = (f.rand_core."0.5.1".default or true); }
      { "0.5.1".getrandom =
        (f.rand_core."0.5.1".getrandom or false) ||
        (f.rand_core."0.5.1".std or false) ||
        (rand_core."0.5.1"."std" or false); }
      { "0.5.1".serde =
        (f.rand_core."0.5.1".serde or false) ||
        (f.rand_core."0.5.1".serde1 or false) ||
        (rand_core."0.5.1"."serde1" or false); }
    ];
  }) [
    (features_.getrandom."${deps."rand_core"."0.5.1"."getrandom"}" deps)
  ];


# end
# rand_hc-0.1.0

  crates.rand_hc."0.1.0" = deps: { features?(features_.rand_hc."0.1.0" deps {}) }: buildRustCrate {
    crateName = "rand_hc";
    version = "0.1.0";
    authors = [ "The Rand Project Developers" ];
    sha256 = "05agb75j87yp7y1zk8yf7bpm66hc0673r3dlypn0kazynr6fdgkz";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_hc"."0.1.0"."rand_core"}" deps)
    ]);
  };
  features_.rand_hc."0.1.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_hc."0.1.0".rand_core}".default = (f.rand_core."${deps.rand_hc."0.1.0".rand_core}".default or false);
    rand_hc."0.1.0".default = (f.rand_hc."0.1.0".default or true);
  }) [
    (features_.rand_core."${deps."rand_hc"."0.1.0"."rand_core"}" deps)
  ];


# end
# rand_hc-0.2.0

  crates.rand_hc."0.2.0" = deps: { features?(features_.rand_hc."0.2.0" deps {}) }: buildRustCrate {
    crateName = "rand_hc";
    version = "0.2.0";
    authors = [ "The Rand Project Developers" ];
    edition = "2018";
    sha256 = "0592q9kqcna9aiyzy6vp3fadxkkbpfkmi2cnkv48zhybr0v2yf01";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_hc"."0.2.0"."rand_core"}" deps)
    ]);
  };
  features_.rand_hc."0.2.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_hc."0.2.0".rand_core}".default = true;
    rand_hc."0.2.0".default = (f.rand_hc."0.2.0".default or true);
  }) [
    (features_.rand_core."${deps."rand_hc"."0.2.0"."rand_core"}" deps)
  ];


# end
# rand_isaac-0.1.1

  crates.rand_isaac."0.1.1" = deps: { features?(features_.rand_isaac."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_isaac";
    version = "0.1.1";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "10hhdh5b5sa03s6b63y9bafm956jwilx41s71jbrzl63ccx8lxdq";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_isaac"."0.1.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_isaac"."0.1.1" or {});
  };
  features_.rand_isaac."0.1.1" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_isaac."0.1.1".rand_core}"."serde1" =
        (f.rand_core."${deps.rand_isaac."0.1.1".rand_core}"."serde1" or false) ||
        (rand_isaac."0.1.1"."serde1" or false) ||
        (f."rand_isaac"."0.1.1"."serde1" or false); }
      { "${deps.rand_isaac."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_isaac."0.1.1".rand_core}".default or false); }
    ];
    rand_isaac = fold recursiveUpdate {} [
      { "0.1.1".default = (f.rand_isaac."0.1.1".default or true); }
      { "0.1.1".serde =
        (f.rand_isaac."0.1.1".serde or false) ||
        (f.rand_isaac."0.1.1".serde1 or false) ||
        (rand_isaac."0.1.1"."serde1" or false); }
      { "0.1.1".serde_derive =
        (f.rand_isaac."0.1.1".serde_derive or false) ||
        (f.rand_isaac."0.1.1".serde1 or false) ||
        (rand_isaac."0.1.1"."serde1" or false); }
    ];
  }) [
    (features_.rand_core."${deps."rand_isaac"."0.1.1"."rand_core"}" deps)
  ];


# end
# rand_jitter-0.1.4

  crates.rand_jitter."0.1.4" = deps: { features?(features_.rand_jitter."0.1.4" deps {}) }: buildRustCrate {
    crateName = "rand_jitter";
    version = "0.1.4";
    authors = [ "The Rand Project Developers" ];
    sha256 = "13nr4h042ab9l7qcv47bxrxw3gkf2pc3cni6c9pyi4nxla0mm7b6";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_jitter"."0.1.4"."rand_core"}" deps)
    ])
      ++ (if kernel == "darwin" || kernel == "ios" then mapFeatures features ([
      (crates."libc"."${deps."rand_jitter"."0.1.4"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand_jitter"."0.1.4"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."rand_jitter"."0.1.4" or {});
  };
  features_.rand_jitter."0.1.4" = deps: f: updateFeatures f (rec {
    libc."${deps.rand_jitter."0.1.4".libc}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_jitter."0.1.4".rand_core}"."std" =
        (f.rand_core."${deps.rand_jitter."0.1.4".rand_core}"."std" or false) ||
        (rand_jitter."0.1.4"."std" or false) ||
        (f."rand_jitter"."0.1.4"."std" or false); }
      { "${deps.rand_jitter."0.1.4".rand_core}".default = true; }
    ];
    rand_jitter."0.1.4".default = (f.rand_jitter."0.1.4".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.rand_jitter."0.1.4".winapi}"."profileapi" = true; }
      { "${deps.rand_jitter."0.1.4".winapi}".default = true; }
    ];
  }) [
    (features_.rand_core."${deps."rand_jitter"."0.1.4"."rand_core"}" deps)
    (features_.libc."${deps."rand_jitter"."0.1.4"."libc"}" deps)
    (features_.winapi."${deps."rand_jitter"."0.1.4"."winapi"}" deps)
  ];


# end
# rand_os-0.1.3

  crates.rand_os."0.1.3" = deps: { features?(features_.rand_os."0.1.3" deps {}) }: buildRustCrate {
    crateName = "rand_os";
    version = "0.1.3";
    authors = [ "The Rand Project Developers" ];
    sha256 = "0ywwspizgs9g8vzn6m5ix9yg36n15119d6n792h7mk4r5vs0ww4j";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_os"."0.1.3"."rand_core"}" deps)
    ])
      ++ (if abi == "sgx" then mapFeatures features ([
      (crates."rdrand"."${deps."rand_os"."0.1.3"."rdrand"}" deps)
    ]) else [])
      ++ (if kernel == "cloudabi" then mapFeatures features ([
      (crates."cloudabi"."${deps."rand_os"."0.1.3"."cloudabi"}" deps)
    ]) else [])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_cprng"."${deps."rand_os"."0.1.3"."fuchsia_cprng"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."rand_os"."0.1.3"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand_os"."0.1.3"."winapi"}" deps)
    ]) else [])
      ++ (if kernel == "wasm32-unknown-unknown" then mapFeatures features ([
]) else []);
  };
  features_.rand_os."0.1.3" = deps: f: updateFeatures f (rec {
    cloudabi."${deps.rand_os."0.1.3".cloudabi}".default = true;
    fuchsia_cprng."${deps.rand_os."0.1.3".fuchsia_cprng}".default = true;
    libc."${deps.rand_os."0.1.3".libc}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_os."0.1.3".rand_core}"."std" = true; }
      { "${deps.rand_os."0.1.3".rand_core}".default = true; }
    ];
    rand_os."0.1.3".default = (f.rand_os."0.1.3".default or true);
    rdrand."${deps.rand_os."0.1.3".rdrand}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.rand_os."0.1.3".winapi}"."minwindef" = true; }
      { "${deps.rand_os."0.1.3".winapi}"."ntsecapi" = true; }
      { "${deps.rand_os."0.1.3".winapi}"."winnt" = true; }
      { "${deps.rand_os."0.1.3".winapi}".default = true; }
    ];
  }) [
    (features_.rand_core."${deps."rand_os"."0.1.3"."rand_core"}" deps)
    (features_.rdrand."${deps."rand_os"."0.1.3"."rdrand"}" deps)
    (features_.cloudabi."${deps."rand_os"."0.1.3"."cloudabi"}" deps)
    (features_.fuchsia_cprng."${deps."rand_os"."0.1.3"."fuchsia_cprng"}" deps)
    (features_.libc."${deps."rand_os"."0.1.3"."libc"}" deps)
    (features_.winapi."${deps."rand_os"."0.1.3"."winapi"}" deps)
  ];


# end
# rand_pcg-0.1.2

  crates.rand_pcg."0.1.2" = deps: { features?(features_.rand_pcg."0.1.2" deps {}) }: buildRustCrate {
    crateName = "rand_pcg";
    version = "0.1.2";
    authors = [ "The Rand Project Developers" ];
    sha256 = "04qgi2ai2z42li5h4aawvxbpnlqyjfnipz9d6k73mdnl6p1xq938";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_pcg"."0.1.2"."rand_core"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand_pcg"."0.1.2"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."rand_pcg"."0.1.2" or {});
  };
  features_.rand_pcg."0.1.2" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand_pcg."0.1.2".autocfg}".default = true;
    rand_core."${deps.rand_pcg."0.1.2".rand_core}".default = true;
    rand_pcg = fold recursiveUpdate {} [
      { "0.1.2".default = (f.rand_pcg."0.1.2".default or true); }
      { "0.1.2".serde =
        (f.rand_pcg."0.1.2".serde or false) ||
        (f.rand_pcg."0.1.2".serde1 or false) ||
        (rand_pcg."0.1.2"."serde1" or false); }
      { "0.1.2".serde_derive =
        (f.rand_pcg."0.1.2".serde_derive or false) ||
        (f.rand_pcg."0.1.2".serde1 or false) ||
        (rand_pcg."0.1.2"."serde1" or false); }
    ];
  }) [
    (features_.rand_core."${deps."rand_pcg"."0.1.2"."rand_core"}" deps)
    (features_.autocfg."${deps."rand_pcg"."0.1.2"."autocfg"}" deps)
  ];


# end
# rand_xorshift-0.1.1

  crates.rand_xorshift."0.1.1" = deps: { features?(features_.rand_xorshift."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_xorshift";
    version = "0.1.1";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0v365c4h4lzxwz5k5kp9m0661s0sss7ylv74if0xb4svis9sswnn";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_xorshift"."0.1.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_xorshift"."0.1.1" or {});
  };
  features_.rand_xorshift."0.1.1" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_xorshift."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_xorshift."0.1.1".rand_core}".default or false);
    rand_xorshift = fold recursiveUpdate {} [
      { "0.1.1".default = (f.rand_xorshift."0.1.1".default or true); }
      { "0.1.1".serde =
        (f.rand_xorshift."0.1.1".serde or false) ||
        (f.rand_xorshift."0.1.1".serde1 or false) ||
        (rand_xorshift."0.1.1"."serde1" or false); }
      { "0.1.1".serde_derive =
        (f.rand_xorshift."0.1.1".serde_derive or false) ||
        (f.rand_xorshift."0.1.1".serde1 or false) ||
        (rand_xorshift."0.1.1"."serde1" or false); }
    ];
  }) [
    (features_.rand_core."${deps."rand_xorshift"."0.1.1"."rand_core"}" deps)
  ];


# end
# rdrand-0.4.0

  crates.rdrand."0.4.0" = deps: { features?(features_.rdrand."0.4.0" deps {}) }: buildRustCrate {
    crateName = "rdrand";
    version = "0.4.0";
    authors = [ "Simonas Kazlauskas <rdrand@kazlauskas.me>" ];
    sha256 = "15hrcasn0v876wpkwab1dwbk9kvqwrb3iv4y4dibb6yxnfvzwajk";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rdrand"."0.4.0"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rdrand"."0.4.0" or {});
  };
  features_.rdrand."0.4.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rdrand."0.4.0".rand_core}".default = (f.rand_core."${deps.rdrand."0.4.0".rand_core}".default or false);
    rdrand = fold recursiveUpdate {} [
      { "0.4.0".default = (f.rdrand."0.4.0".default or true); }
      { "0.4.0".std =
        (f.rdrand."0.4.0".std or false) ||
        (f.rdrand."0.4.0".default or false) ||
        (rdrand."0.4.0"."default" or false); }
    ];
  }) [
    (features_.rand_core."${deps."rdrand"."0.4.0"."rand_core"}" deps)
  ];


# end
# redox_syscall-0.1.56

  crates.redox_syscall."0.1.56" = deps: { features?(features_.redox_syscall."0.1.56" deps {}) }: buildRustCrate {
    crateName = "redox_syscall";
    version = "0.1.56";
    authors = [ "Jeremy Soller <jackpot51@gmail.com>" ];
    sha256 = "0jcp8nd947zcy938bz09pzlmi3vyxfdzg92pjxdvvk0699vwcc26";
    libName = "syscall";
  };
  features_.redox_syscall."0.1.56" = deps: f: updateFeatures f (rec {
    redox_syscall."0.1.56".default = (f.redox_syscall."0.1.56".default or true);
  }) [];


# end
# redox_users-0.3.1

  crates.redox_users."0.3.1" = deps: { features?(features_.redox_users."0.3.1" deps {}) }: buildRustCrate {
    crateName = "redox_users";
    version = "0.3.1";
    authors = [ "Jose Narvaez <goyox86@gmail.com>" "Wesley Hershberger <mggmugginsmc@gmail.com>" ];
    sha256 = "0kqc1vjmkcvgkxjpqva3nyqd9dixivsh4qswxclyqf7ql8a2g17s";
    dependencies = mapFeatures features ([
      (crates."failure"."${deps."redox_users"."0.3.1"."failure"}" deps)
      (crates."rand_os"."${deps."redox_users"."0.3.1"."rand_os"}" deps)
      (crates."redox_syscall"."${deps."redox_users"."0.3.1"."redox_syscall"}" deps)
      (crates."rust_argon2"."${deps."redox_users"."0.3.1"."rust_argon2"}" deps)
    ]);
  };
  features_.redox_users."0.3.1" = deps: f: updateFeatures f (rec {
    failure."${deps.redox_users."0.3.1".failure}".default = true;
    rand_os."${deps.redox_users."0.3.1".rand_os}".default = true;
    redox_syscall."${deps.redox_users."0.3.1".redox_syscall}".default = true;
    redox_users."0.3.1".default = (f.redox_users."0.3.1".default or true);
    rust_argon2."${deps.redox_users."0.3.1".rust_argon2}".default = true;
  }) [
    (features_.failure."${deps."redox_users"."0.3.1"."failure"}" deps)
    (features_.rand_os."${deps."redox_users"."0.3.1"."rand_os"}" deps)
    (features_.redox_syscall."${deps."redox_users"."0.3.1"."redox_syscall"}" deps)
    (features_.rust_argon2."${deps."redox_users"."0.3.1"."rust_argon2"}" deps)
  ];


# end
# regex-1.2.1

  crates.regex."1.2.1" = deps: { features?(features_.regex."1.2.1" deps {}) }: buildRustCrate {
    crateName = "regex";
    version = "1.2.1";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0bshyi2rpv9jams2qj7krmjlrfsk1cddhin0kjqd18y9lbvrvvlp";
    dependencies = mapFeatures features ([
      (crates."aho_corasick"."${deps."regex"."1.2.1"."aho_corasick"}" deps)
      (crates."memchr"."${deps."regex"."1.2.1"."memchr"}" deps)
      (crates."regex_syntax"."${deps."regex"."1.2.1"."regex_syntax"}" deps)
      (crates."thread_local"."${deps."regex"."1.2.1"."thread_local"}" deps)
    ]);
    features = mkFeatures (features."regex"."1.2.1" or {});
  };
  features_.regex."1.2.1" = deps: f: updateFeatures f (rec {
    aho_corasick."${deps.regex."1.2.1".aho_corasick}".default = true;
    memchr."${deps.regex."1.2.1".memchr}".default = true;
    regex = fold recursiveUpdate {} [
      { "1.2.1".default = (f.regex."1.2.1".default or true); }
      { "1.2.1".pattern =
        (f.regex."1.2.1".pattern or false) ||
        (f.regex."1.2.1".unstable or false) ||
        (regex."1.2.1"."unstable" or false); }
      { "1.2.1".use_std =
        (f.regex."1.2.1".use_std or false) ||
        (f.regex."1.2.1".default or false) ||
        (regex."1.2.1"."default" or false); }
    ];
    regex_syntax."${deps.regex."1.2.1".regex_syntax}".default = true;
    thread_local."${deps.regex."1.2.1".thread_local}".default = true;
  }) [
    (features_.aho_corasick."${deps."regex"."1.2.1"."aho_corasick"}" deps)
    (features_.memchr."${deps."regex"."1.2.1"."memchr"}" deps)
    (features_.regex_syntax."${deps."regex"."1.2.1"."regex_syntax"}" deps)
    (features_.thread_local."${deps."regex"."1.2.1"."thread_local"}" deps)
  ];


# end
# regex-automata-0.1.8

  crates.regex_automata."0.1.8" = deps: { features?(features_.regex_automata."0.1.8" deps {}) }: buildRustCrate {
    crateName = "regex-automata";
    version = "0.1.8";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1bsqc2cm0xd07y7sr2dfgp3cj1m57lasxwxcz2i39c31aw5d5ndx";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."regex_automata"."0.1.8"."byteorder"}" deps)
    ]);
    features = mkFeatures (features."regex_automata"."0.1.8" or {});
  };
  features_.regex_automata."0.1.8" = deps: f: updateFeatures f (rec {
    byteorder."${deps.regex_automata."0.1.8".byteorder}".default = (f.byteorder."${deps.regex_automata."0.1.8".byteorder}".default or false);
    regex_automata = fold recursiveUpdate {} [
      { "0.1.8".default = (f.regex_automata."0.1.8".default or true); }
      { "0.1.8".regex-syntax =
        (f.regex_automata."0.1.8".regex-syntax or false) ||
        (f.regex_automata."0.1.8".std or false) ||
        (regex_automata."0.1.8"."std" or false); }
      { "0.1.8".std =
        (f.regex_automata."0.1.8".std or false) ||
        (f.regex_automata."0.1.8".default or false) ||
        (regex_automata."0.1.8"."default" or false); }
      { "0.1.8".utf8-ranges =
        (f.regex_automata."0.1.8".utf8-ranges or false) ||
        (f.regex_automata."0.1.8".std or false) ||
        (regex_automata."0.1.8"."std" or false); }
    ];
  }) [
    (features_.byteorder."${deps."regex_automata"."0.1.8"."byteorder"}" deps)
  ];


# end
# regex-syntax-0.6.11

  crates.regex_syntax."0.6.11" = deps: { features?(features_.regex_syntax."0.6.11" deps {}) }: buildRustCrate {
    crateName = "regex-syntax";
    version = "0.6.11";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1ynlyhjlcvhhqiaz6n649h4jmr45c1x6nwxzkfjdv7gazv94fdbh";
  };
  features_.regex_syntax."0.6.11" = deps: f: updateFeatures f (rec {
    regex_syntax."0.6.11".default = (f.regex_syntax."0.6.11".default or true);
  }) [];


# end
# remove_dir_all-0.5.2

  crates.remove_dir_all."0.5.2" = deps: { features?(features_.remove_dir_all."0.5.2" deps {}) }: buildRustCrate {
    crateName = "remove_dir_all";
    version = "0.5.2";
    authors = [ "Aaronepower <theaaronepower@gmail.com>" ];
    sha256 = "04sxg2ppvxiljc2i13bwvpbi540rf9d2a89cq0wmqf9pjvr3a1wm";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."remove_dir_all"."0.5.2"."winapi"}" deps)
    ]) else []);
  };
  features_.remove_dir_all."0.5.2" = deps: f: updateFeatures f (rec {
    remove_dir_all."0.5.2".default = (f.remove_dir_all."0.5.2".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.remove_dir_all."0.5.2".winapi}"."errhandlingapi" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}"."fileapi" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}"."std" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}"."winbase" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}"."winerror" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}".default = true; }
    ];
  }) [
    (features_.winapi."${deps."remove_dir_all"."0.5.2"."winapi"}" deps)
  ];


# end
# reqwest-0.9.20

  crates.reqwest."0.9.20" = deps: { features?(features_.reqwest."0.9.20" deps {}) }: buildRustCrate {
    crateName = "reqwest";
    version = "0.9.20";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1fjcjvh9qqcxzxbb2vws1j7xsjigkzdrzvkma0rdi10y5bnaikii";
    dependencies = mapFeatures features ([
      (crates."base64"."${deps."reqwest"."0.9.20"."base64"}" deps)
      (crates."bytes"."${deps."reqwest"."0.9.20"."bytes"}" deps)
      (crates."cookie"."${deps."reqwest"."0.9.20"."cookie"}" deps)
      (crates."cookie_store"."${deps."reqwest"."0.9.20"."cookie_store"}" deps)
      (crates."encoding_rs"."${deps."reqwest"."0.9.20"."encoding_rs"}" deps)
      (crates."flate2"."${deps."reqwest"."0.9.20"."flate2"}" deps)
      (crates."futures"."${deps."reqwest"."0.9.20"."futures"}" deps)
      (crates."http"."${deps."reqwest"."0.9.20"."http"}" deps)
      (crates."hyper"."${deps."reqwest"."0.9.20"."hyper"}" deps)
      (crates."log"."${deps."reqwest"."0.9.20"."log"}" deps)
      (crates."mime"."${deps."reqwest"."0.9.20"."mime"}" deps)
      (crates."mime_guess"."${deps."reqwest"."0.9.20"."mime_guess"}" deps)
      (crates."serde"."${deps."reqwest"."0.9.20"."serde"}" deps)
      (crates."serde_json"."${deps."reqwest"."0.9.20"."serde_json"}" deps)
      (crates."serde_urlencoded"."${deps."reqwest"."0.9.20"."serde_urlencoded"}" deps)
      (crates."time"."${deps."reqwest"."0.9.20"."time"}" deps)
      (crates."tokio"."${deps."reqwest"."0.9.20"."tokio"}" deps)
      (crates."tokio_executor"."${deps."reqwest"."0.9.20"."tokio_executor"}" deps)
      (crates."tokio_io"."${deps."reqwest"."0.9.20"."tokio_io"}" deps)
      (crates."tokio_threadpool"."${deps."reqwest"."0.9.20"."tokio_threadpool"}" deps)
      (crates."tokio_timer"."${deps."reqwest"."0.9.20"."tokio_timer"}" deps)
      (crates."url"."${deps."reqwest"."0.9.20"."url"}" deps)
      (crates."uuid"."${deps."reqwest"."0.9.20"."uuid"}" deps)
    ]
      ++ (if features.reqwest."0.9.20".hyper-tls or false then [ (crates.hyper_tls."${deps."reqwest"."0.9.20".hyper_tls}" deps) ] else [])
      ++ (if features.reqwest."0.9.20".native-tls or false then [ (crates.native_tls."${deps."reqwest"."0.9.20".native_tls}" deps) ] else []))
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winreg"."${deps."reqwest"."0.9.20"."winreg"}" deps)
    ]) else []);
    features = mkFeatures (features."reqwest"."0.9.20" or {});
  };
  features_.reqwest."0.9.20" = deps: f: updateFeatures f (rec {
    base64."${deps.reqwest."0.9.20".base64}".default = true;
    bytes."${deps.reqwest."0.9.20".bytes}".default = true;
    cookie."${deps.reqwest."0.9.20".cookie}".default = true;
    cookie_store."${deps.reqwest."0.9.20".cookie_store}".default = true;
    encoding_rs."${deps.reqwest."0.9.20".encoding_rs}".default = true;
    flate2 = fold recursiveUpdate {} [
      { "${deps.reqwest."0.9.20".flate2}"."rust_backend" = true; }
      { "${deps.reqwest."0.9.20".flate2}".default = (f.flate2."${deps.reqwest."0.9.20".flate2}".default or false); }
    ];
    futures."${deps.reqwest."0.9.20".futures}".default = true;
    http."${deps.reqwest."0.9.20".http}".default = true;
    hyper."${deps.reqwest."0.9.20".hyper}".default = true;
    hyper_tls."${deps.reqwest."0.9.20".hyper_tls}".default = true;
    log."${deps.reqwest."0.9.20".log}".default = true;
    mime."${deps.reqwest."0.9.20".mime}".default = true;
    mime_guess."${deps.reqwest."0.9.20".mime_guess}".default = true;
    native_tls = fold recursiveUpdate {} [
      { "${deps.reqwest."0.9.20".native_tls}"."vendored" =
        (f.native_tls."${deps.reqwest."0.9.20".native_tls}"."vendored" or false) ||
        (reqwest."0.9.20"."default-tls-vendored" or false) ||
        (f."reqwest"."0.9.20"."default-tls-vendored" or false); }
      { "${deps.reqwest."0.9.20".native_tls}".default = true; }
    ];
    reqwest = fold recursiveUpdate {} [
      { "0.9.20".default = (f.reqwest."0.9.20".default or true); }
      { "0.9.20".default-tls =
        (f.reqwest."0.9.20".default-tls or false) ||
        (f.reqwest."0.9.20".default or false) ||
        (reqwest."0.9.20"."default" or false) ||
        (f.reqwest."0.9.20".default-tls-vendored or false) ||
        (reqwest."0.9.20"."default-tls-vendored" or false); }
      { "0.9.20".hyper-old-types =
        (f.reqwest."0.9.20".hyper-old-types or false) ||
        (f.reqwest."0.9.20".hyper-011 or false) ||
        (reqwest."0.9.20"."hyper-011" or false); }
      { "0.9.20".hyper-rustls =
        (f.reqwest."0.9.20".hyper-rustls or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20".hyper-tls =
        (f.reqwest."0.9.20".hyper-tls or false) ||
        (f.reqwest."0.9.20".default-tls or false) ||
        (reqwest."0.9.20"."default-tls" or false); }
      { "0.9.20".native-tls =
        (f.reqwest."0.9.20".native-tls or false) ||
        (f.reqwest."0.9.20".default-tls or false) ||
        (reqwest."0.9.20"."default-tls" or false); }
      { "0.9.20".rustls =
        (f.reqwest."0.9.20".rustls or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20".tls =
        (f.reqwest."0.9.20".tls or false) ||
        (f.reqwest."0.9.20".default-tls or false) ||
        (reqwest."0.9.20"."default-tls" or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20".tokio-rustls =
        (f.reqwest."0.9.20".tokio-rustls or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20".trust-dns-resolver =
        (f.reqwest."0.9.20".trust-dns-resolver or false) ||
        (f.reqwest."0.9.20".trust-dns or false) ||
        (reqwest."0.9.20"."trust-dns" or false); }
      { "0.9.20".webpki-roots =
        (f.reqwest."0.9.20".webpki-roots or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
    ];
    serde."${deps.reqwest."0.9.20".serde}".default = true;
    serde_json."${deps.reqwest."0.9.20".serde_json}".default = true;
    serde_urlencoded."${deps.reqwest."0.9.20".serde_urlencoded}".default = true;
    time."${deps.reqwest."0.9.20".time}".default = true;
    tokio = fold recursiveUpdate {} [
      { "${deps.reqwest."0.9.20".tokio}"."rt-full" = true; }
      { "${deps.reqwest."0.9.20".tokio}"."tcp" = true; }
      { "${deps.reqwest."0.9.20".tokio}".default = (f.tokio."${deps.reqwest."0.9.20".tokio}".default or false); }
    ];
    tokio_executor."${deps.reqwest."0.9.20".tokio_executor}".default = true;
    tokio_io."${deps.reqwest."0.9.20".tokio_io}".default = true;
    tokio_threadpool."${deps.reqwest."0.9.20".tokio_threadpool}".default = true;
    tokio_timer."${deps.reqwest."0.9.20".tokio_timer}".default = true;
    url."${deps.reqwest."0.9.20".url}".default = true;
    uuid = fold recursiveUpdate {} [
      { "${deps.reqwest."0.9.20".uuid}"."v4" = true; }
      { "${deps.reqwest."0.9.20".uuid}".default = true; }
    ];
    winreg."${deps.reqwest."0.9.20".winreg}".default = true;
  }) [
    (features_.base64."${deps."reqwest"."0.9.20"."base64"}" deps)
    (features_.bytes."${deps."reqwest"."0.9.20"."bytes"}" deps)
    (features_.cookie."${deps."reqwest"."0.9.20"."cookie"}" deps)
    (features_.cookie_store."${deps."reqwest"."0.9.20"."cookie_store"}" deps)
    (features_.encoding_rs."${deps."reqwest"."0.9.20"."encoding_rs"}" deps)
    (features_.flate2."${deps."reqwest"."0.9.20"."flate2"}" deps)
    (features_.futures."${deps."reqwest"."0.9.20"."futures"}" deps)
    (features_.http."${deps."reqwest"."0.9.20"."http"}" deps)
    (features_.hyper."${deps."reqwest"."0.9.20"."hyper"}" deps)
    (features_.hyper_tls."${deps."reqwest"."0.9.20"."hyper_tls"}" deps)
    (features_.log."${deps."reqwest"."0.9.20"."log"}" deps)
    (features_.mime."${deps."reqwest"."0.9.20"."mime"}" deps)
    (features_.mime_guess."${deps."reqwest"."0.9.20"."mime_guess"}" deps)
    (features_.native_tls."${deps."reqwest"."0.9.20"."native_tls"}" deps)
    (features_.serde."${deps."reqwest"."0.9.20"."serde"}" deps)
    (features_.serde_json."${deps."reqwest"."0.9.20"."serde_json"}" deps)
    (features_.serde_urlencoded."${deps."reqwest"."0.9.20"."serde_urlencoded"}" deps)
    (features_.time."${deps."reqwest"."0.9.20"."time"}" deps)
    (features_.tokio."${deps."reqwest"."0.9.20"."tokio"}" deps)
    (features_.tokio_executor."${deps."reqwest"."0.9.20"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."reqwest"."0.9.20"."tokio_io"}" deps)
    (features_.tokio_threadpool."${deps."reqwest"."0.9.20"."tokio_threadpool"}" deps)
    (features_.tokio_timer."${deps."reqwest"."0.9.20"."tokio_timer"}" deps)
    (features_.url."${deps."reqwest"."0.9.20"."url"}" deps)
    (features_.uuid."${deps."reqwest"."0.9.20"."uuid"}" deps)
    (features_.winreg."${deps."reqwest"."0.9.20"."winreg"}" deps)
  ];


# end
# rgb-0.8.14

  crates.rgb."0.8.14" = deps: { features?(features_.rgb."0.8.14" deps {}) }: buildRustCrate {
    crateName = "rgb";
    version = "0.8.14";
    authors = [ "Kornel Lesiński <kornel@geekhood.net>" ];
    edition = "2018";
    sha256 = "0pjg11g40biyxd39jc0ky371a76lnb9hfmza45iybd4fhyz23l0f";
    dependencies = mapFeatures features ([
]);
  };
  features_.rgb."0.8.14" = deps: f: updateFeatures f (rec {
    rgb."0.8.14".default = (f.rgb."0.8.14".default or true);
  }) [];


# end
# rust-argon2-0.5.1

  crates.rust_argon2."0.5.1" = deps: { features?(features_.rust_argon2."0.5.1" deps {}) }: buildRustCrate {
    crateName = "rust-argon2";
    version = "0.5.1";
    authors = [ "Martijn Rijkeboer <mrr@sru-systems.com>" ];
    sha256 = "049dqwn63i6xix55cnh8n4iqm2d3yzpisfsc2568vfmaaa4866d2";
    libName = "argon2";
    dependencies = mapFeatures features ([
      (crates."base64"."${deps."rust_argon2"."0.5.1"."base64"}" deps)
      (crates."blake2b_simd"."${deps."rust_argon2"."0.5.1"."blake2b_simd"}" deps)
      (crates."crossbeam_utils"."${deps."rust_argon2"."0.5.1"."crossbeam_utils"}" deps)
    ]);
  };
  features_.rust_argon2."0.5.1" = deps: f: updateFeatures f (rec {
    base64."${deps.rust_argon2."0.5.1".base64}".default = true;
    blake2b_simd."${deps.rust_argon2."0.5.1".blake2b_simd}".default = true;
    crossbeam_utils."${deps.rust_argon2."0.5.1".crossbeam_utils}".default = true;
    rust_argon2."0.5.1".default = (f.rust_argon2."0.5.1".default or true);
  }) [
    (features_.base64."${deps."rust_argon2"."0.5.1"."base64"}" deps)
    (features_.blake2b_simd."${deps."rust_argon2"."0.5.1"."blake2b_simd"}" deps)
    (features_.crossbeam_utils."${deps."rust_argon2"."0.5.1"."crossbeam_utils"}" deps)
  ];


# end
# rustc-demangle-0.1.16

  crates.rustc_demangle."0.1.16" = deps: { features?(features_.rustc_demangle."0.1.16" deps {}) }: buildRustCrate {
    crateName = "rustc-demangle";
    version = "0.1.16";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0zmn448d0f898ahfkz7cir0fi0vk84dabjpw84mk6a1r6nf9vzmi";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."rustc_demangle"."0.1.16" or {});
  };
  features_.rustc_demangle."0.1.16" = deps: f: updateFeatures f (rec {
    rustc_demangle = fold recursiveUpdate {} [
      { "0.1.16".compiler_builtins =
        (f.rustc_demangle."0.1.16".compiler_builtins or false) ||
        (f.rustc_demangle."0.1.16".rustc-dep-of-std or false) ||
        (rustc_demangle."0.1.16"."rustc-dep-of-std" or false); }
      { "0.1.16".core =
        (f.rustc_demangle."0.1.16".core or false) ||
        (f.rustc_demangle."0.1.16".rustc-dep-of-std or false) ||
        (rustc_demangle."0.1.16"."rustc-dep-of-std" or false); }
      { "0.1.16".default = (f.rustc_demangle."0.1.16".default or true); }
    ];
  }) [];


# end
# rustc_version-0.2.3

  crates.rustc_version."0.2.3" = deps: { features?(features_.rustc_version."0.2.3" deps {}) }: buildRustCrate {
    crateName = "rustc_version";
    version = "0.2.3";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "0rgwzbgs3i9fqjm1p4ra3n7frafmpwl29c8lw85kv1rxn7n2zaa7";
    dependencies = mapFeatures features ([
      (crates."semver"."${deps."rustc_version"."0.2.3"."semver"}" deps)
    ]);
  };
  features_.rustc_version."0.2.3" = deps: f: updateFeatures f (rec {
    rustc_version."0.2.3".default = (f.rustc_version."0.2.3".default or true);
    semver."${deps.rustc_version."0.2.3".semver}".default = true;
  }) [
    (features_.semver."${deps."rustc_version"."0.2.3"."semver"}" deps)
  ];


# end
# ryu-1.0.0

  crates.ryu."1.0.0" = deps: { features?(features_.ryu."1.0.0" deps {}) }: buildRustCrate {
    crateName = "ryu";
    version = "1.0.0";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0hysqba7hi31xw1jka8jh7qb4m9fx5l6vik55wpc3rpsg46cwgbf";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."ryu"."1.0.0" or {});
  };
  features_.ryu."1.0.0" = deps: f: updateFeatures f (rec {
    ryu."1.0.0".default = (f.ryu."1.0.0".default or true);
  }) [];


# end
# schannel-0.1.15

  crates.schannel."0.1.15" = deps: { features?(features_.schannel."0.1.15" deps {}) }: buildRustCrate {
    crateName = "schannel";
    version = "0.1.15";
    authors = [ "Steven Fackler <sfackler@gmail.com>" "Steffen Butzer <steffen.butzer@outlook.com>" ];
    sha256 = "1x9i0z9y8n5cg23ppyglgqdlz6rwcv2a489m5qpfk6l2ib8a1jdv";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."schannel"."0.1.15"."lazy_static"}" deps)
      (crates."winapi"."${deps."schannel"."0.1.15"."winapi"}" deps)
    ]);
  };
  features_.schannel."0.1.15" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.schannel."0.1.15".lazy_static}".default = true;
    schannel."0.1.15".default = (f.schannel."0.1.15".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.schannel."0.1.15".winapi}"."lmcons" = true; }
      { "${deps.schannel."0.1.15".winapi}"."minschannel" = true; }
      { "${deps.schannel."0.1.15".winapi}"."schannel" = true; }
      { "${deps.schannel."0.1.15".winapi}"."securitybaseapi" = true; }
      { "${deps.schannel."0.1.15".winapi}"."sspi" = true; }
      { "${deps.schannel."0.1.15".winapi}"."sysinfoapi" = true; }
      { "${deps.schannel."0.1.15".winapi}"."timezoneapi" = true; }
      { "${deps.schannel."0.1.15".winapi}"."winbase" = true; }
      { "${deps.schannel."0.1.15".winapi}"."wincrypt" = true; }
      { "${deps.schannel."0.1.15".winapi}"."winerror" = true; }
      { "${deps.schannel."0.1.15".winapi}".default = true; }
    ];
  }) [
    (features_.lazy_static."${deps."schannel"."0.1.15"."lazy_static"}" deps)
    (features_.winapi."${deps."schannel"."0.1.15"."winapi"}" deps)
  ];


# end
# scopeguard-0.3.3

  crates.scopeguard."0.3.3" = deps: { features?(features_.scopeguard."0.3.3" deps {}) }: buildRustCrate {
    crateName = "scopeguard";
    version = "0.3.3";
    authors = [ "bluss" ];
    sha256 = "0i1l013csrqzfz6c68pr5pi01hg5v5yahq8fsdmaxy6p8ygsjf3r";
    features = mkFeatures (features."scopeguard"."0.3.3" or {});
  };
  features_.scopeguard."0.3.3" = deps: f: updateFeatures f (rec {
    scopeguard = fold recursiveUpdate {} [
      { "0.3.3".default = (f.scopeguard."0.3.3".default or true); }
      { "0.3.3".use_std =
        (f.scopeguard."0.3.3".use_std or false) ||
        (f.scopeguard."0.3.3".default or false) ||
        (scopeguard."0.3.3"."default" or false); }
    ];
  }) [];


# end
# scopeguard-1.0.0

  crates.scopeguard."1.0.0" = deps: { features?(features_.scopeguard."1.0.0" deps {}) }: buildRustCrate {
    crateName = "scopeguard";
    version = "1.0.0";
    authors = [ "bluss" ];
    sha256 = "15vrix0jx3i4naqnjswddzn4m036krrv71a8vkh3b1zq4hxmrb0q";
    features = mkFeatures (features."scopeguard"."1.0.0" or {});
  };
  features_.scopeguard."1.0.0" = deps: f: updateFeatures f (rec {
    scopeguard = fold recursiveUpdate {} [
      { "1.0.0".default = (f.scopeguard."1.0.0".default or true); }
      { "1.0.0".use_std =
        (f.scopeguard."1.0.0".use_std or false) ||
        (f.scopeguard."1.0.0".default or false) ||
        (scopeguard."1.0.0"."default" or false); }
    ];
  }) [];


# end
# security-framework-0.3.1

  crates.security_framework."0.3.1" = deps: { features?(features_.security_framework."0.3.1" deps {}) }: buildRustCrate {
    crateName = "security-framework";
    version = "0.3.1";
    authors = [ "Steven Fackler <sfackler@gmail.com>" "Kornel <kornel@geekhood.net>" ];
    sha256 = "1vycb3xhdd91sy2j6a19iykn6wzdjj0r7cd9p3bx4522fl0l5m84";
    dependencies = mapFeatures features ([
      (crates."core_foundation"."${deps."security_framework"."0.3.1"."core_foundation"}" deps)
      (crates."core_foundation_sys"."${deps."security_framework"."0.3.1"."core_foundation_sys"}" deps)
      (crates."libc"."${deps."security_framework"."0.3.1"."libc"}" deps)
      (crates."security_framework_sys"."${deps."security_framework"."0.3.1"."security_framework_sys"}" deps)
    ]);
    features = mkFeatures (features."security_framework"."0.3.1" or {});
  };
  features_.security_framework."0.3.1" = deps: f: updateFeatures f (rec {
    core_foundation."${deps.security_framework."0.3.1".core_foundation}".default = true;
    core_foundation_sys."${deps.security_framework."0.3.1".core_foundation_sys}".default = true;
    libc."${deps.security_framework."0.3.1".libc}".default = true;
    security_framework = fold recursiveUpdate {} [
      { "0.3.1".OSX_10_10 =
        (f.security_framework."0.3.1".OSX_10_10 or false) ||
        (f.security_framework."0.3.1".OSX_10_11 or false) ||
        (security_framework."0.3.1"."OSX_10_11" or false); }
      { "0.3.1".OSX_10_11 =
        (f.security_framework."0.3.1".OSX_10_11 or false) ||
        (f.security_framework."0.3.1".OSX_10_12 or false) ||
        (security_framework."0.3.1"."OSX_10_12" or false); }
      { "0.3.1".OSX_10_12 =
        (f.security_framework."0.3.1".OSX_10_12 or false) ||
        (f.security_framework."0.3.1".OSX_10_13 or false) ||
        (security_framework."0.3.1"."OSX_10_13" or false); }
      { "0.3.1".OSX_10_9 =
        (f.security_framework."0.3.1".OSX_10_9 or false) ||
        (f.security_framework."0.3.1".OSX_10_10 or false) ||
        (security_framework."0.3.1"."OSX_10_10" or false); }
      { "0.3.1".alpn =
        (f.security_framework."0.3.1".alpn or false) ||
        (f.security_framework."0.3.1".OSX_10_13 or false) ||
        (security_framework."0.3.1"."OSX_10_13" or false); }
      { "0.3.1".default = (f.security_framework."0.3.1".default or true); }
    ];
    security_framework_sys = fold recursiveUpdate {} [
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_10" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_10" or false) ||
        (security_framework."0.3.1"."OSX_10_10" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_10" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_11" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_11" or false) ||
        (security_framework."0.3.1"."OSX_10_11" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_11" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_12" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_12" or false) ||
        (security_framework."0.3.1"."OSX_10_12" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_12" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_13" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_13" or false) ||
        (security_framework."0.3.1"."OSX_10_13" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_13" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_9" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_9" or false) ||
        (security_framework."0.3.1"."OSX_10_9" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_9" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}".default = true; }
    ];
  }) [
    (features_.core_foundation."${deps."security_framework"."0.3.1"."core_foundation"}" deps)
    (features_.core_foundation_sys."${deps."security_framework"."0.3.1"."core_foundation_sys"}" deps)
    (features_.libc."${deps."security_framework"."0.3.1"."libc"}" deps)
    (features_.security_framework_sys."${deps."security_framework"."0.3.1"."security_framework_sys"}" deps)
  ];


# end
# security-framework-sys-0.3.1

  crates.security_framework_sys."0.3.1" = deps: { features?(features_.security_framework_sys."0.3.1" deps {}) }: buildRustCrate {
    crateName = "security-framework-sys";
    version = "0.3.1";
    authors = [ "Steven Fackler <sfackler@gmail.com>" "Kornel <kornel@geekhood.net>" ];
    sha256 = "11anqpw72d7xjiaz3pbd2r5d3dx0vddya4f6vjnpfjpnldiyd917";
    dependencies = mapFeatures features ([
      (crates."core_foundation_sys"."${deps."security_framework_sys"."0.3.1"."core_foundation_sys"}" deps)
    ]);
    features = mkFeatures (features."security_framework_sys"."0.3.1" or {});
  };
  features_.security_framework_sys."0.3.1" = deps: f: updateFeatures f (rec {
    core_foundation_sys."${deps.security_framework_sys."0.3.1".core_foundation_sys}".default = true;
    security_framework_sys = fold recursiveUpdate {} [
      { "0.3.1".OSX_10_10 =
        (f.security_framework_sys."0.3.1".OSX_10_10 or false) ||
        (f.security_framework_sys."0.3.1".OSX_10_11 or false) ||
        (security_framework_sys."0.3.1"."OSX_10_11" or false); }
      { "0.3.1".OSX_10_11 =
        (f.security_framework_sys."0.3.1".OSX_10_11 or false) ||
        (f.security_framework_sys."0.3.1".OSX_10_12 or false) ||
        (security_framework_sys."0.3.1"."OSX_10_12" or false); }
      { "0.3.1".OSX_10_12 =
        (f.security_framework_sys."0.3.1".OSX_10_12 or false) ||
        (f.security_framework_sys."0.3.1".OSX_10_13 or false) ||
        (security_framework_sys."0.3.1"."OSX_10_13" or false); }
      { "0.3.1".OSX_10_9 =
        (f.security_framework_sys."0.3.1".OSX_10_9 or false) ||
        (f.security_framework_sys."0.3.1".OSX_10_10 or false) ||
        (security_framework_sys."0.3.1"."OSX_10_10" or false); }
      { "0.3.1".default = (f.security_framework_sys."0.3.1".default or true); }
    ];
  }) [
    (features_.core_foundation_sys."${deps."security_framework_sys"."0.3.1"."core_foundation_sys"}" deps)
  ];


# end
# semver-0.9.0

  crates.semver."0.9.0" = deps: { features?(features_.semver."0.9.0" deps {}) }: buildRustCrate {
    crateName = "semver";
    version = "0.9.0";
    authors = [ "Steve Klabnik <steve@steveklabnik.com>" "The Rust Project Developers" ];
    sha256 = "0azak2lb2wc36s3x15az886kck7rpnksrw14lalm157rg9sc9z63";
    dependencies = mapFeatures features ([
      (crates."semver_parser"."${deps."semver"."0.9.0"."semver_parser"}" deps)
    ]);
    features = mkFeatures (features."semver"."0.9.0" or {});
  };
  features_.semver."0.9.0" = deps: f: updateFeatures f (rec {
    semver = fold recursiveUpdate {} [
      { "0.9.0".default = (f.semver."0.9.0".default or true); }
      { "0.9.0".serde =
        (f.semver."0.9.0".serde or false) ||
        (f.semver."0.9.0".ci or false) ||
        (semver."0.9.0"."ci" or false); }
    ];
    semver_parser."${deps.semver."0.9.0".semver_parser}".default = true;
  }) [
    (features_.semver_parser."${deps."semver"."0.9.0"."semver_parser"}" deps)
  ];


# end
# semver-parser-0.7.0

  crates.semver_parser."0.7.0" = deps: { features?(features_.semver_parser."0.7.0" deps {}) }: buildRustCrate {
    crateName = "semver-parser";
    version = "0.7.0";
    authors = [ "Steve Klabnik <steve@steveklabnik.com>" ];
    sha256 = "1da66c8413yakx0y15k8c055yna5lyb6fr0fw9318kdwkrk5k12h";
  };
  features_.semver_parser."0.7.0" = deps: f: updateFeatures f (rec {
    semver_parser."0.7.0".default = (f.semver_parser."0.7.0".default or true);
  }) [];


# end
# serde-1.0.99

  crates.serde."1.0.99" = deps: { features?(features_.serde."1.0.99" deps {}) }: buildRustCrate {
    crateName = "serde";
    version = "1.0.99";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1wwj6rv8h7k1sc0s8b8jcwcr54ayg46zjfv8z9a59hgnzg17nr86";
    build = "build.rs";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.serde."1.0.99".serde_derive or false then [ (crates.serde_derive."${deps."serde"."1.0.99".serde_derive}" deps) ] else []));
    features = mkFeatures (features."serde"."1.0.99" or {});
  };
  features_.serde."1.0.99" = deps: f: updateFeatures f (rec {
    serde = fold recursiveUpdate {} [
      { "1.0.99".default = (f.serde."1.0.99".default or true); }
      { "1.0.99".serde_derive =
        (f.serde."1.0.99".serde_derive or false) ||
        (f.serde."1.0.99".derive or false) ||
        (serde."1.0.99"."derive" or false); }
      { "1.0.99".std =
        (f.serde."1.0.99".std or false) ||
        (f.serde."1.0.99".default or false) ||
        (serde."1.0.99"."default" or false); }
    ];
    serde_derive."${deps.serde."1.0.99".serde_derive}".default = true;
  }) [
    (features_.serde_derive."${deps."serde"."1.0.99"."serde_derive"}" deps)
  ];


# end
# serde_derive-1.0.99

  crates.serde_derive."1.0.99" = deps: { features?(features_.serde_derive."1.0.99" deps {}) }: buildRustCrate {
    crateName = "serde_derive";
    version = "1.0.99";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "03isppdkcccmdynm7garjf7vmri7dmza3lzqb56jlffzy08i518g";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."serde_derive"."1.0.99"."proc_macro2"}" deps)
      (crates."quote"."${deps."serde_derive"."1.0.99"."quote"}" deps)
      (crates."syn"."${deps."serde_derive"."1.0.99"."syn"}" deps)
    ]);
    features = mkFeatures (features."serde_derive"."1.0.99" or {});
  };
  features_.serde_derive."1.0.99" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.serde_derive."1.0.99".proc_macro2}".default = true;
    quote."${deps.serde_derive."1.0.99".quote}".default = true;
    serde_derive."1.0.99".default = (f.serde_derive."1.0.99".default or true);
    syn = fold recursiveUpdate {} [
      { "${deps.serde_derive."1.0.99".syn}"."visit" = true; }
      { "${deps.serde_derive."1.0.99".syn}".default = true; }
    ];
  }) [
    (features_.proc_macro2."${deps."serde_derive"."1.0.99"."proc_macro2"}" deps)
    (features_.quote."${deps."serde_derive"."1.0.99"."quote"}" deps)
    (features_.syn."${deps."serde_derive"."1.0.99"."syn"}" deps)
  ];


# end
# serde_json-1.0.40

  crates.serde_json."1.0.40" = deps: { features?(features_.serde_json."1.0.40" deps {}) }: buildRustCrate {
    crateName = "serde_json";
    version = "1.0.40";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1wf8lkisjvyg4ghp2fwm3ysymjy66l030l8d7p6033wiayfzpyh3";
    dependencies = mapFeatures features ([
      (crates."itoa"."${deps."serde_json"."1.0.40"."itoa"}" deps)
      (crates."ryu"."${deps."serde_json"."1.0.40"."ryu"}" deps)
      (crates."serde"."${deps."serde_json"."1.0.40"."serde"}" deps)
    ]);
    features = mkFeatures (features."serde_json"."1.0.40" or {});
  };
  features_.serde_json."1.0.40" = deps: f: updateFeatures f (rec {
    itoa."${deps.serde_json."1.0.40".itoa}".default = true;
    ryu."${deps.serde_json."1.0.40".ryu}".default = true;
    serde."${deps.serde_json."1.0.40".serde}".default = true;
    serde_json = fold recursiveUpdate {} [
      { "1.0.40".default = (f.serde_json."1.0.40".default or true); }
      { "1.0.40".indexmap =
        (f.serde_json."1.0.40".indexmap or false) ||
        (f.serde_json."1.0.40".preserve_order or false) ||
        (serde_json."1.0.40"."preserve_order" or false); }
    ];
  }) [
    (features_.itoa."${deps."serde_json"."1.0.40"."itoa"}" deps)
    (features_.ryu."${deps."serde_json"."1.0.40"."ryu"}" deps)
    (features_.serde."${deps."serde_json"."1.0.40"."serde"}" deps)
  ];


# end
# serde_urlencoded-0.5.5

  crates.serde_urlencoded."0.5.5" = deps: { features?(features_.serde_urlencoded."0.5.5" deps {}) }: buildRustCrate {
    crateName = "serde_urlencoded";
    version = "0.5.5";
    authors = [ "Anthony Ramine <n.oxyde@gmail.com>" ];
    sha256 = "1rf49i9w1p1yhr9fr5xsq6mi23i9ggj7132qwrfsaiimfvs6y7i0";
    dependencies = mapFeatures features ([
      (crates."dtoa"."${deps."serde_urlencoded"."0.5.5"."dtoa"}" deps)
      (crates."itoa"."${deps."serde_urlencoded"."0.5.5"."itoa"}" deps)
      (crates."serde"."${deps."serde_urlencoded"."0.5.5"."serde"}" deps)
      (crates."url"."${deps."serde_urlencoded"."0.5.5"."url"}" deps)
    ]);
  };
  features_.serde_urlencoded."0.5.5" = deps: f: updateFeatures f (rec {
    dtoa."${deps.serde_urlencoded."0.5.5".dtoa}".default = true;
    itoa."${deps.serde_urlencoded."0.5.5".itoa}".default = true;
    serde."${deps.serde_urlencoded."0.5.5".serde}".default = true;
    serde_urlencoded."0.5.5".default = (f.serde_urlencoded."0.5.5".default or true);
    url."${deps.serde_urlencoded."0.5.5".url}".default = true;
  }) [
    (features_.dtoa."${deps."serde_urlencoded"."0.5.5"."dtoa"}" deps)
    (features_.itoa."${deps."serde_urlencoded"."0.5.5"."itoa"}" deps)
    (features_.serde."${deps."serde_urlencoded"."0.5.5"."serde"}" deps)
    (features_.url."${deps."serde_urlencoded"."0.5.5"."url"}" deps)
  ];


# end
# slab-0.4.2

  crates.slab."0.4.2" = deps: { features?(features_.slab."0.4.2" deps {}) }: buildRustCrate {
    crateName = "slab";
    version = "0.4.2";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0h1l2z7qy6207kv0v3iigdf2xfk9yrhbwj1svlxk6wxjmdxvgdl7";
  };
  features_.slab."0.4.2" = deps: f: updateFeatures f (rec {
    slab."0.4.2".default = (f.slab."0.4.2".default or true);
  }) [];


# end
# smallvec-0.6.10

  crates.smallvec."0.6.10" = deps: { features?(features_.smallvec."0.6.10" deps {}) }: buildRustCrate {
    crateName = "smallvec";
    version = "0.6.10";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "01w7xd79q0bwn683gk4ryw50ad1zzxkny10f7gkbaaj1ax6f4q4h";
    libPath = "lib.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."smallvec"."0.6.10" or {});
  };
  features_.smallvec."0.6.10" = deps: f: updateFeatures f (rec {
    smallvec = fold recursiveUpdate {} [
      { "0.6.10".default = (f.smallvec."0.6.10".default or true); }
      { "0.6.10".std =
        (f.smallvec."0.6.10".std or false) ||
        (f.smallvec."0.6.10".default or false) ||
        (smallvec."0.6.10"."default" or false); }
    ];
  }) [];


# end
# stable_deref_trait-1.1.1

  crates.stable_deref_trait."1.1.1" = deps: { features?(features_.stable_deref_trait."1.1.1" deps {}) }: buildRustCrate {
    crateName = "stable_deref_trait";
    version = "1.1.1";
    authors = [ "Robert Grosse <n210241048576@gmail.com>" ];
    sha256 = "1xy9slzslrzr31nlnw52sl1d820b09y61b7f13lqgsn8n7y0l4g8";
    features = mkFeatures (features."stable_deref_trait"."1.1.1" or {});
  };
  features_.stable_deref_trait."1.1.1" = deps: f: updateFeatures f (rec {
    stable_deref_trait = fold recursiveUpdate {} [
      { "1.1.1".default = (f.stable_deref_trait."1.1.1".default or true); }
      { "1.1.1".std =
        (f.stable_deref_trait."1.1.1".std or false) ||
        (f.stable_deref_trait."1.1.1".default or false) ||
        (stable_deref_trait."1.1.1"."default" or false); }
    ];
  }) [];


# end
# string-0.2.1

  crates.string."0.2.1" = deps: { features?(features_.string."0.2.1" deps {}) }: buildRustCrate {
    crateName = "string";
    version = "0.2.1";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "066vpc33qik0f8hpa1841hdzwcwj6ai3vdwsd34k1s2w9p3n7jqk";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.string."0.2.1".bytes or false then [ (crates.bytes."${deps."string"."0.2.1".bytes}" deps) ] else []));
    features = mkFeatures (features."string"."0.2.1" or {});
  };
  features_.string."0.2.1" = deps: f: updateFeatures f (rec {
    bytes."${deps.string."0.2.1".bytes}".default = true;
    string = fold recursiveUpdate {} [
      { "0.2.1".bytes =
        (f.string."0.2.1".bytes or false) ||
        (f.string."0.2.1".default or false) ||
        (string."0.2.1"."default" or false); }
      { "0.2.1".default = (f.string."0.2.1".default or true); }
    ];
  }) [
    (features_.bytes."${deps."string"."0.2.1"."bytes"}" deps)
  ];


# end
# strsim-0.8.0

  crates.strsim."0.8.0" = deps: { features?(features_.strsim."0.8.0" deps {}) }: buildRustCrate {
    crateName = "strsim";
    version = "0.8.0";
    authors = [ "Danny Guo <dannyguo91@gmail.com>" ];
    sha256 = "0d3jsdz22wgjyxdakqnvdgmwjdvkximz50d9zfk4qlalw635qcvy";
  };
  features_.strsim."0.8.0" = deps: f: updateFeatures f (rec {
    strsim."0.8.0".default = (f.strsim."0.8.0".default or true);
  }) [];


# end
# syn-0.15.44

  crates.syn."0.15.44" = deps: { features?(features_.syn."0.15.44" deps {}) }: buildRustCrate {
    crateName = "syn";
    version = "0.15.44";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "09v11h141grmsnamd5j14mn8vpnfng6p60kdmsm8akz9m0qn7s1n";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."syn"."0.15.44"."proc_macro2"}" deps)
      (crates."unicode_xid"."${deps."syn"."0.15.44"."unicode_xid"}" deps)
    ]
      ++ (if features.syn."0.15.44".quote or false then [ (crates.quote."${deps."syn"."0.15.44".quote}" deps) ] else []));
    features = mkFeatures (features."syn"."0.15.44" or {});
  };
  features_.syn."0.15.44" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.syn."0.15.44".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.syn."0.15.44".proc_macro2}"."proc-macro" or false) ||
        (syn."0.15.44"."proc-macro" or false) ||
        (f."syn"."0.15.44"."proc-macro" or false); }
      { "${deps.syn."0.15.44".proc_macro2}".default = (f.proc_macro2."${deps.syn."0.15.44".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "${deps.syn."0.15.44".quote}"."proc-macro" =
        (f.quote."${deps.syn."0.15.44".quote}"."proc-macro" or false) ||
        (syn."0.15.44"."proc-macro" or false) ||
        (f."syn"."0.15.44"."proc-macro" or false); }
      { "${deps.syn."0.15.44".quote}".default = (f.quote."${deps.syn."0.15.44".quote}".default or false); }
    ];
    syn = fold recursiveUpdate {} [
      { "0.15.44".clone-impls =
        (f.syn."0.15.44".clone-impls or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44".default = (f.syn."0.15.44".default or true); }
      { "0.15.44".derive =
        (f.syn."0.15.44".derive or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44".parsing =
        (f.syn."0.15.44".parsing or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44".printing =
        (f.syn."0.15.44".printing or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44".proc-macro =
        (f.syn."0.15.44".proc-macro or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44".quote =
        (f.syn."0.15.44".quote or false) ||
        (f.syn."0.15.44".printing or false) ||
        (syn."0.15.44"."printing" or false); }
    ];
    unicode_xid."${deps.syn."0.15.44".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."syn"."0.15.44"."proc_macro2"}" deps)
    (features_.quote."${deps."syn"."0.15.44"."quote"}" deps)
    (features_.unicode_xid."${deps."syn"."0.15.44"."unicode_xid"}" deps)
  ];


# end
# syn-1.0.5

  crates.syn."1.0.5" = deps: { features?(features_.syn."1.0.5" deps {}) }: buildRustCrate {
    crateName = "syn";
    version = "1.0.5";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "08qbk425r8c4q4rrpq1q9wkd3v3bji8nlfaxj8v4l7lkpjkh0xgs";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."syn"."1.0.5"."proc_macro2"}" deps)
      (crates."unicode_xid"."${deps."syn"."1.0.5"."unicode_xid"}" deps)
    ]
      ++ (if features.syn."1.0.5".quote or false then [ (crates.quote."${deps."syn"."1.0.5".quote}" deps) ] else []));
    features = mkFeatures (features."syn"."1.0.5" or {});
  };
  features_.syn."1.0.5" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.syn."1.0.5".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.syn."1.0.5".proc_macro2}"."proc-macro" or false) ||
        (syn."1.0.5"."proc-macro" or false) ||
        (f."syn"."1.0.5"."proc-macro" or false); }
      { "${deps.syn."1.0.5".proc_macro2}".default = (f.proc_macro2."${deps.syn."1.0.5".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "${deps.syn."1.0.5".quote}"."proc-macro" =
        (f.quote."${deps.syn."1.0.5".quote}"."proc-macro" or false) ||
        (syn."1.0.5"."proc-macro" or false) ||
        (f."syn"."1.0.5"."proc-macro" or false); }
      { "${deps.syn."1.0.5".quote}".default = (f.quote."${deps.syn."1.0.5".quote}".default or false); }
    ];
    syn = fold recursiveUpdate {} [
      { "1.0.5".clone-impls =
        (f.syn."1.0.5".clone-impls or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5".default = (f.syn."1.0.5".default or true); }
      { "1.0.5".derive =
        (f.syn."1.0.5".derive or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5".parsing =
        (f.syn."1.0.5".parsing or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5".printing =
        (f.syn."1.0.5".printing or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5".proc-macro =
        (f.syn."1.0.5".proc-macro or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5".quote =
        (f.syn."1.0.5".quote or false) ||
        (f.syn."1.0.5".printing or false) ||
        (syn."1.0.5"."printing" or false); }
    ];
    unicode_xid."${deps.syn."1.0.5".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."syn"."1.0.5"."proc_macro2"}" deps)
    (features_.quote."${deps."syn"."1.0.5"."quote"}" deps)
    (features_.unicode_xid."${deps."syn"."1.0.5"."unicode_xid"}" deps)
  ];


# end
# synstructure-0.10.2

  crates.synstructure."0.10.2" = deps: { features?(features_.synstructure."0.10.2" deps {}) }: buildRustCrate {
    crateName = "synstructure";
    version = "0.10.2";
    authors = [ "Nika Layzell <nika@thelayzells.com>" ];
    sha256 = "0bp29grjsim99xm1l6h38mbl98gnk47lf82rawlmws5zn4asdpj4";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."synstructure"."0.10.2"."proc_macro2"}" deps)
      (crates."quote"."${deps."synstructure"."0.10.2"."quote"}" deps)
      (crates."syn"."${deps."synstructure"."0.10.2"."syn"}" deps)
      (crates."unicode_xid"."${deps."synstructure"."0.10.2"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."synstructure"."0.10.2" or {});
  };
  features_.synstructure."0.10.2" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.synstructure."0.10.2".proc_macro2}".default = true;
    quote."${deps.synstructure."0.10.2".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.synstructure."0.10.2".syn}"."extra-traits" = true; }
      { "${deps.synstructure."0.10.2".syn}"."visit" = true; }
      { "${deps.synstructure."0.10.2".syn}".default = true; }
    ];
    synstructure."0.10.2".default = (f.synstructure."0.10.2".default or true);
    unicode_xid."${deps.synstructure."0.10.2".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."synstructure"."0.10.2"."proc_macro2"}" deps)
    (features_.quote."${deps."synstructure"."0.10.2"."quote"}" deps)
    (features_.syn."${deps."synstructure"."0.10.2"."syn"}" deps)
    (features_.unicode_xid."${deps."synstructure"."0.10.2"."unicode_xid"}" deps)
  ];


# end
# tempfile-3.1.0

  crates.tempfile."3.1.0" = deps: { features?(features_.tempfile."3.1.0" deps {}) }: buildRustCrate {
    crateName = "tempfile";
    version = "3.1.0";
    authors = [ "Steven Allen <steven@stebalien.com>" "The Rust Project Developers" "Ashley Mannix <ashleymannix@live.com.au>" "Jason White <jasonaw0@gmail.com>" ];
    edition = "2018";
    sha256 = "1r7ykxw90p5hm1g46i8ia33j5iwl3q252kbb6b074qhdav3sqndk";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."tempfile"."3.1.0"."cfg_if"}" deps)
      (crates."rand"."${deps."tempfile"."3.1.0"."rand"}" deps)
      (crates."remove_dir_all"."${deps."tempfile"."3.1.0"."remove_dir_all"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."tempfile"."3.1.0"."redox_syscall"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."tempfile"."3.1.0"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."tempfile"."3.1.0"."winapi"}" deps)
    ]) else []);
  };
  features_.tempfile."3.1.0" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.tempfile."3.1.0".cfg_if}".default = true;
    libc."${deps.tempfile."3.1.0".libc}".default = true;
    rand."${deps.tempfile."3.1.0".rand}".default = true;
    redox_syscall."${deps.tempfile."3.1.0".redox_syscall}".default = true;
    remove_dir_all."${deps.tempfile."3.1.0".remove_dir_all}".default = true;
    tempfile."3.1.0".default = (f.tempfile."3.1.0".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.tempfile."3.1.0".winapi}"."fileapi" = true; }
      { "${deps.tempfile."3.1.0".winapi}"."handleapi" = true; }
      { "${deps.tempfile."3.1.0".winapi}"."winbase" = true; }
      { "${deps.tempfile."3.1.0".winapi}".default = true; }
    ];
  }) [
    (features_.cfg_if."${deps."tempfile"."3.1.0"."cfg_if"}" deps)
    (features_.rand."${deps."tempfile"."3.1.0"."rand"}" deps)
    (features_.remove_dir_all."${deps."tempfile"."3.1.0"."remove_dir_all"}" deps)
    (features_.redox_syscall."${deps."tempfile"."3.1.0"."redox_syscall"}" deps)
    (features_.libc."${deps."tempfile"."3.1.0"."libc"}" deps)
    (features_.winapi."${deps."tempfile"."3.1.0"."winapi"}" deps)
  ];


# end
# term-0.5.2

  crates.term."0.5.2" = deps: { features?(features_.term."0.5.2" deps {}) }: buildRustCrate {
    crateName = "term";
    version = "0.5.2";
    authors = [ "The Rust Project Developers" "Steven Allen" ];
    sha256 = "1c3pjrkl9sy4b62xlvilszlrksjn3c4zfhrdfg7247c2il3lnn9x";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."term"."0.5.2"."byteorder"}" deps)
      (crates."dirs"."${deps."term"."0.5.2"."dirs"}" deps)
    ])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."term"."0.5.2"."winapi"}" deps)
    ]) else []);
  };
  features_.term."0.5.2" = deps: f: updateFeatures f (rec {
    byteorder."${deps.term."0.5.2".byteorder}".default = true;
    dirs."${deps.term."0.5.2".dirs}".default = true;
    term."0.5.2".default = (f.term."0.5.2".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.term."0.5.2".winapi}"."consoleapi" = true; }
      { "${deps.term."0.5.2".winapi}"."fileapi" = true; }
      { "${deps.term."0.5.2".winapi}"."handleapi" = true; }
      { "${deps.term."0.5.2".winapi}"."wincon" = true; }
      { "${deps.term."0.5.2".winapi}".default = true; }
    ];
  }) [
    (features_.byteorder."${deps."term"."0.5.2"."byteorder"}" deps)
    (features_.dirs."${deps."term"."0.5.2"."dirs"}" deps)
    (features_.winapi."${deps."term"."0.5.2"."winapi"}" deps)
  ];


# end
# textwrap-0.11.0

  crates.textwrap."0.11.0" = deps: { features?(features_.textwrap."0.11.0" deps {}) }: buildRustCrate {
    crateName = "textwrap";
    version = "0.11.0";
    authors = [ "Martin Geisler <martin@geisler.net>" ];
    sha256 = "0s25qh49n7kjayrdj4q3v0jk0jc6vy88rdw0bvgfxqlscpqpxi7d";
    dependencies = mapFeatures features ([
      (crates."unicode_width"."${deps."textwrap"."0.11.0"."unicode_width"}" deps)
    ]);
  };
  features_.textwrap."0.11.0" = deps: f: updateFeatures f (rec {
    textwrap."0.11.0".default = (f.textwrap."0.11.0".default or true);
    unicode_width."${deps.textwrap."0.11.0".unicode_width}".default = true;
  }) [
    (features_.unicode_width."${deps."textwrap"."0.11.0"."unicode_width"}" deps)
  ];


# end
# thread_local-0.3.6

  crates.thread_local."0.3.6" = deps: { features?(features_.thread_local."0.3.6" deps {}) }: buildRustCrate {
    crateName = "thread_local";
    version = "0.3.6";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "02rksdwjmz2pw9bmgbb4c0bgkbq5z6nvg510sq1s6y2j1gam0c7i";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."thread_local"."0.3.6"."lazy_static"}" deps)
    ]);
  };
  features_.thread_local."0.3.6" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.thread_local."0.3.6".lazy_static}".default = true;
    thread_local."0.3.6".default = (f.thread_local."0.3.6".default or true);
  }) [
    (features_.lazy_static."${deps."thread_local"."0.3.6"."lazy_static"}" deps)
  ];


# end
# time-0.1.42

  crates.time."0.1.42" = deps: { features?(features_.time."0.1.42" deps {}) }: buildRustCrate {
    crateName = "time";
    version = "0.1.42";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1ny809kmdjwd4b478ipc33dz7q6nq7rxk766x8cnrg6zygcksmmx";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."time"."0.1.42"."libc"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."time"."0.1.42"."redox_syscall"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."time"."0.1.42"."winapi"}" deps)
    ]) else []);
  };
  features_.time."0.1.42" = deps: f: updateFeatures f (rec {
    libc."${deps.time."0.1.42".libc}".default = true;
    redox_syscall."${deps.time."0.1.42".redox_syscall}".default = true;
    time."0.1.42".default = (f.time."0.1.42".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.time."0.1.42".winapi}"."minwinbase" = true; }
      { "${deps.time."0.1.42".winapi}"."minwindef" = true; }
      { "${deps.time."0.1.42".winapi}"."ntdef" = true; }
      { "${deps.time."0.1.42".winapi}"."profileapi" = true; }
      { "${deps.time."0.1.42".winapi}"."std" = true; }
      { "${deps.time."0.1.42".winapi}"."sysinfoapi" = true; }
      { "${deps.time."0.1.42".winapi}"."timezoneapi" = true; }
      { "${deps.time."0.1.42".winapi}".default = true; }
    ];
  }) [
    (features_.libc."${deps."time"."0.1.42"."libc"}" deps)
    (features_.redox_syscall."${deps."time"."0.1.42"."redox_syscall"}" deps)
    (features_.winapi."${deps."time"."0.1.42"."winapi"}" deps)
  ];


# end
# tokio-0.1.22

  crates.tokio."0.1.22" = deps: { features?(features_.tokio."0.1.22" deps {}) }: buildRustCrate {
    crateName = "tokio";
    version = "0.1.22";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1nx8yg8fdwf5nm2ykfza24cx8xy5in6da5va5w76mv347r1irr0b";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio"."0.1.22"."futures"}" deps)
    ]
      ++ (if features.tokio."0.1.22".bytes or false then [ (crates.bytes."${deps."tokio"."0.1.22".bytes}" deps) ] else [])
      ++ (if features.tokio."0.1.22".mio or false then [ (crates.mio."${deps."tokio"."0.1.22".mio}" deps) ] else [])
      ++ (if features.tokio."0.1.22".num_cpus or false then [ (crates.num_cpus."${deps."tokio"."0.1.22".num_cpus}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-current-thread or false then [ (crates.tokio_current_thread."${deps."tokio"."0.1.22".tokio_current_thread}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-executor or false then [ (crates.tokio_executor."${deps."tokio"."0.1.22".tokio_executor}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-io or false then [ (crates.tokio_io."${deps."tokio"."0.1.22".tokio_io}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-reactor or false then [ (crates.tokio_reactor."${deps."tokio"."0.1.22".tokio_reactor}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-tcp or false then [ (crates.tokio_tcp."${deps."tokio"."0.1.22".tokio_tcp}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-threadpool or false then [ (crates.tokio_threadpool."${deps."tokio"."0.1.22".tokio_threadpool}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-timer or false then [ (crates.tokio_timer."${deps."tokio"."0.1.22".tokio_timer}" deps) ] else []))
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
]) else []);
    features = mkFeatures (features."tokio"."0.1.22" or {});
  };
  features_.tokio."0.1.22" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio."0.1.22".bytes}".default = true;
    futures."${deps.tokio."0.1.22".futures}".default = true;
    mio."${deps.tokio."0.1.22".mio}".default = true;
    num_cpus."${deps.tokio."0.1.22".num_cpus}".default = true;
    tokio = fold recursiveUpdate {} [
      { "0.1.22".bytes =
        (f.tokio."0.1.22".bytes or false) ||
        (f.tokio."0.1.22".io or false) ||
        (tokio."0.1.22"."io" or false); }
      { "0.1.22".codec =
        (f.tokio."0.1.22".codec or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22".default = (f.tokio."0.1.22".default or true); }
      { "0.1.22".fs =
        (f.tokio."0.1.22".fs or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22".io =
        (f.tokio."0.1.22".io or false) ||
        (f.tokio."0.1.22".codec or false) ||
        (tokio."0.1.22"."codec" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false) ||
        (f.tokio."0.1.22".reactor or false) ||
        (tokio."0.1.22"."reactor" or false); }
      { "0.1.22".mio =
        (f.tokio."0.1.22".mio or false) ||
        (f.tokio."0.1.22".reactor or false) ||
        (tokio."0.1.22"."reactor" or false); }
      { "0.1.22".num_cpus =
        (f.tokio."0.1.22".num_cpus or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22".reactor =
        (f.tokio."0.1.22".reactor or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22".rt-full =
        (f.tokio."0.1.22".rt-full or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22".sync =
        (f.tokio."0.1.22".sync or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22".tcp =
        (f.tokio."0.1.22".tcp or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22".timer =
        (f.tokio."0.1.22".timer or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22".tokio-codec =
        (f.tokio."0.1.22".tokio-codec or false) ||
        (f.tokio."0.1.22".codec or false) ||
        (tokio."0.1.22"."codec" or false); }
      { "0.1.22".tokio-current-thread =
        (f.tokio."0.1.22".tokio-current-thread or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22".tokio-executor =
        (f.tokio."0.1.22".tokio-executor or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22".tokio-fs =
        (f.tokio."0.1.22".tokio-fs or false) ||
        (f.tokio."0.1.22".fs or false) ||
        (tokio."0.1.22"."fs" or false); }
      { "0.1.22".tokio-io =
        (f.tokio."0.1.22".tokio-io or false) ||
        (f.tokio."0.1.22".io or false) ||
        (tokio."0.1.22"."io" or false); }
      { "0.1.22".tokio-reactor =
        (f.tokio."0.1.22".tokio-reactor or false) ||
        (f.tokio."0.1.22".reactor or false) ||
        (tokio."0.1.22"."reactor" or false); }
      { "0.1.22".tokio-sync =
        (f.tokio."0.1.22".tokio-sync or false) ||
        (f.tokio."0.1.22".sync or false) ||
        (tokio."0.1.22"."sync" or false); }
      { "0.1.22".tokio-tcp =
        (f.tokio."0.1.22".tokio-tcp or false) ||
        (f.tokio."0.1.22".tcp or false) ||
        (tokio."0.1.22"."tcp" or false); }
      { "0.1.22".tokio-threadpool =
        (f.tokio."0.1.22".tokio-threadpool or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22".tokio-timer =
        (f.tokio."0.1.22".tokio-timer or false) ||
        (f.tokio."0.1.22".timer or false) ||
        (tokio."0.1.22"."timer" or false); }
      { "0.1.22".tokio-udp =
        (f.tokio."0.1.22".tokio-udp or false) ||
        (f.tokio."0.1.22".udp or false) ||
        (tokio."0.1.22"."udp" or false); }
      { "0.1.22".tokio-uds =
        (f.tokio."0.1.22".tokio-uds or false) ||
        (f.tokio."0.1.22".uds or false) ||
        (tokio."0.1.22"."uds" or false); }
      { "0.1.22".tracing-core =
        (f.tokio."0.1.22".tracing-core or false) ||
        (f.tokio."0.1.22".experimental-tracing or false) ||
        (tokio."0.1.22"."experimental-tracing" or false); }
      { "0.1.22".udp =
        (f.tokio."0.1.22".udp or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22".uds =
        (f.tokio."0.1.22".uds or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
    ];
    tokio_current_thread."${deps.tokio."0.1.22".tokio_current_thread}".default = true;
    tokio_executor."${deps.tokio."0.1.22".tokio_executor}".default = true;
    tokio_io."${deps.tokio."0.1.22".tokio_io}".default = true;
    tokio_reactor."${deps.tokio."0.1.22".tokio_reactor}".default = true;
    tokio_tcp."${deps.tokio."0.1.22".tokio_tcp}".default = true;
    tokio_threadpool."${deps.tokio."0.1.22".tokio_threadpool}".default = true;
    tokio_timer."${deps.tokio."0.1.22".tokio_timer}".default = true;
  }) [
    (features_.bytes."${deps."tokio"."0.1.22"."bytes"}" deps)
    (features_.futures."${deps."tokio"."0.1.22"."futures"}" deps)
    (features_.mio."${deps."tokio"."0.1.22"."mio"}" deps)
    (features_.num_cpus."${deps."tokio"."0.1.22"."num_cpus"}" deps)
    (features_.tokio_current_thread."${deps."tokio"."0.1.22"."tokio_current_thread"}" deps)
    (features_.tokio_executor."${deps."tokio"."0.1.22"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."tokio"."0.1.22"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio"."0.1.22"."tokio_reactor"}" deps)
    (features_.tokio_tcp."${deps."tokio"."0.1.22"."tokio_tcp"}" deps)
    (features_.tokio_threadpool."${deps."tokio"."0.1.22"."tokio_threadpool"}" deps)
    (features_.tokio_timer."${deps."tokio"."0.1.22"."tokio_timer"}" deps)
  ];


# end
# tokio-buf-0.1.1

  crates.tokio_buf."0.1.1" = deps: { features?(features_.tokio_buf."0.1.1" deps {}) }: buildRustCrate {
    crateName = "tokio-buf";
    version = "0.1.1";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "11qjcqvhsjwwy66njn2c3nzl0i89a9k06l08s0vz9cswwkjc2427";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_buf"."0.1.1"."bytes"}" deps)
      (crates."futures"."${deps."tokio_buf"."0.1.1"."futures"}" deps)
    ]
      ++ (if features.tokio_buf."0.1.1".either or false then [ (crates.either."${deps."tokio_buf"."0.1.1".either}" deps) ] else []));
    features = mkFeatures (features."tokio_buf"."0.1.1" or {});
  };
  features_.tokio_buf."0.1.1" = deps: f: updateFeatures f (rec {
    bytes = fold recursiveUpdate {} [
      { "${deps.tokio_buf."0.1.1".bytes}"."either" =
        (f.bytes."${deps.tokio_buf."0.1.1".bytes}"."either" or false) ||
        (tokio_buf."0.1.1"."util" or false) ||
        (f."tokio_buf"."0.1.1"."util" or false); }
      { "${deps.tokio_buf."0.1.1".bytes}".default = true; }
    ];
    either."${deps.tokio_buf."0.1.1".either}".default = true;
    futures."${deps.tokio_buf."0.1.1".futures}".default = true;
    tokio_buf = fold recursiveUpdate {} [
      { "0.1.1".default = (f.tokio_buf."0.1.1".default or true); }
      { "0.1.1".either =
        (f.tokio_buf."0.1.1".either or false) ||
        (f.tokio_buf."0.1.1".util or false) ||
        (tokio_buf."0.1.1"."util" or false); }
      { "0.1.1".util =
        (f.tokio_buf."0.1.1".util or false) ||
        (f.tokio_buf."0.1.1".default or false) ||
        (tokio_buf."0.1.1"."default" or false); }
    ];
  }) [
    (features_.bytes."${deps."tokio_buf"."0.1.1"."bytes"}" deps)
    (features_.either."${deps."tokio_buf"."0.1.1"."either"}" deps)
    (features_.futures."${deps."tokio_buf"."0.1.1"."futures"}" deps)
  ];


# end
# tokio-current-thread-0.1.6

  crates.tokio_current_thread."0.1.6" = deps: { features?(features_.tokio_current_thread."0.1.6" deps {}) }: buildRustCrate {
    crateName = "tokio-current-thread";
    version = "0.1.6";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "07dm43svkrpifkcnv8f5w477cd9260pnkvnps39qkhkf5ixi8fzg";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio_current_thread"."0.1.6"."futures"}" deps)
      (crates."tokio_executor"."${deps."tokio_current_thread"."0.1.6"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_current_thread."0.1.6" = deps: f: updateFeatures f (rec {
    futures."${deps.tokio_current_thread."0.1.6".futures}".default = true;
    tokio_current_thread."0.1.6".default = (f.tokio_current_thread."0.1.6".default or true);
    tokio_executor."${deps.tokio_current_thread."0.1.6".tokio_executor}".default = true;
  }) [
    (features_.futures."${deps."tokio_current_thread"."0.1.6"."futures"}" deps)
    (features_.tokio_executor."${deps."tokio_current_thread"."0.1.6"."tokio_executor"}" deps)
  ];


# end
# tokio-executor-0.1.8

  crates.tokio_executor."0.1.8" = deps: { features?(features_.tokio_executor."0.1.8" deps {}) }: buildRustCrate {
    crateName = "tokio-executor";
    version = "0.1.8";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "017pvi6ii0wb1s78vrbjhzwrjlc0mga3x98dz3g19lhylcl50f7r";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."tokio_executor"."0.1.8"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_executor"."0.1.8"."futures"}" deps)
    ]);
  };
  features_.tokio_executor."0.1.8" = deps: f: updateFeatures f (rec {
    crossbeam_utils."${deps.tokio_executor."0.1.8".crossbeam_utils}".default = true;
    futures."${deps.tokio_executor."0.1.8".futures}".default = true;
    tokio_executor."0.1.8".default = (f.tokio_executor."0.1.8".default or true);
  }) [
    (features_.crossbeam_utils."${deps."tokio_executor"."0.1.8"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_executor"."0.1.8"."futures"}" deps)
  ];


# end
# tokio-io-0.1.12

  crates.tokio_io."0.1.12" = deps: { features?(features_.tokio_io."0.1.12" deps {}) }: buildRustCrate {
    crateName = "tokio-io";
    version = "0.1.12";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0z64yfcm9i5ci2h9h7npa292plia9kb04xbm7cp0bzp1wsddv91r";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_io"."0.1.12"."bytes"}" deps)
      (crates."futures"."${deps."tokio_io"."0.1.12"."futures"}" deps)
      (crates."log"."${deps."tokio_io"."0.1.12"."log"}" deps)
    ]);
  };
  features_.tokio_io."0.1.12" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_io."0.1.12".bytes}".default = true;
    futures."${deps.tokio_io."0.1.12".futures}".default = true;
    log."${deps.tokio_io."0.1.12".log}".default = true;
    tokio_io."0.1.12".default = (f.tokio_io."0.1.12".default or true);
  }) [
    (features_.bytes."${deps."tokio_io"."0.1.12"."bytes"}" deps)
    (features_.futures."${deps."tokio_io"."0.1.12"."futures"}" deps)
    (features_.log."${deps."tokio_io"."0.1.12"."log"}" deps)
  ];


# end
# tokio-reactor-0.1.9

  crates.tokio_reactor."0.1.9" = deps: { features?(features_.tokio_reactor."0.1.9" deps {}) }: buildRustCrate {
    crateName = "tokio-reactor";
    version = "0.1.9";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "11gpxrykd6lbpj9b26dh4fymzawfxgqdx1pbhc771gxbf8qyj1gc";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."tokio_reactor"."0.1.9"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_reactor"."0.1.9"."futures"}" deps)
      (crates."lazy_static"."${deps."tokio_reactor"."0.1.9"."lazy_static"}" deps)
      (crates."log"."${deps."tokio_reactor"."0.1.9"."log"}" deps)
      (crates."mio"."${deps."tokio_reactor"."0.1.9"."mio"}" deps)
      (crates."num_cpus"."${deps."tokio_reactor"."0.1.9"."num_cpus"}" deps)
      (crates."parking_lot"."${deps."tokio_reactor"."0.1.9"."parking_lot"}" deps)
      (crates."slab"."${deps."tokio_reactor"."0.1.9"."slab"}" deps)
      (crates."tokio_executor"."${deps."tokio_reactor"."0.1.9"."tokio_executor"}" deps)
      (crates."tokio_io"."${deps."tokio_reactor"."0.1.9"."tokio_io"}" deps)
      (crates."tokio_sync"."${deps."tokio_reactor"."0.1.9"."tokio_sync"}" deps)
    ]);
  };
  features_.tokio_reactor."0.1.9" = deps: f: updateFeatures f (rec {
    crossbeam_utils."${deps.tokio_reactor."0.1.9".crossbeam_utils}".default = true;
    futures."${deps.tokio_reactor."0.1.9".futures}".default = true;
    lazy_static."${deps.tokio_reactor."0.1.9".lazy_static}".default = true;
    log."${deps.tokio_reactor."0.1.9".log}".default = true;
    mio."${deps.tokio_reactor."0.1.9".mio}".default = true;
    num_cpus."${deps.tokio_reactor."0.1.9".num_cpus}".default = true;
    parking_lot."${deps.tokio_reactor."0.1.9".parking_lot}".default = true;
    slab."${deps.tokio_reactor."0.1.9".slab}".default = true;
    tokio_executor."${deps.tokio_reactor."0.1.9".tokio_executor}".default = true;
    tokio_io."${deps.tokio_reactor."0.1.9".tokio_io}".default = true;
    tokio_reactor."0.1.9".default = (f.tokio_reactor."0.1.9".default or true);
    tokio_sync."${deps.tokio_reactor."0.1.9".tokio_sync}".default = true;
  }) [
    (features_.crossbeam_utils."${deps."tokio_reactor"."0.1.9"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_reactor"."0.1.9"."futures"}" deps)
    (features_.lazy_static."${deps."tokio_reactor"."0.1.9"."lazy_static"}" deps)
    (features_.log."${deps."tokio_reactor"."0.1.9"."log"}" deps)
    (features_.mio."${deps."tokio_reactor"."0.1.9"."mio"}" deps)
    (features_.num_cpus."${deps."tokio_reactor"."0.1.9"."num_cpus"}" deps)
    (features_.parking_lot."${deps."tokio_reactor"."0.1.9"."parking_lot"}" deps)
    (features_.slab."${deps."tokio_reactor"."0.1.9"."slab"}" deps)
    (features_.tokio_executor."${deps."tokio_reactor"."0.1.9"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."tokio_reactor"."0.1.9"."tokio_io"}" deps)
    (features_.tokio_sync."${deps."tokio_reactor"."0.1.9"."tokio_sync"}" deps)
  ];


# end
# tokio-sync-0.1.6

  crates.tokio_sync."0.1.6" = deps: { features?(features_.tokio_sync."0.1.6" deps {}) }: buildRustCrate {
    crateName = "tokio-sync";
    version = "0.1.6";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0csjpxf7m088lh3nfkhj5q1zi5hycdk5xqcginw328rnl1srzyl7";
    dependencies = mapFeatures features ([
      (crates."fnv"."${deps."tokio_sync"."0.1.6"."fnv"}" deps)
      (crates."futures"."${deps."tokio_sync"."0.1.6"."futures"}" deps)
    ]);
  };
  features_.tokio_sync."0.1.6" = deps: f: updateFeatures f (rec {
    fnv."${deps.tokio_sync."0.1.6".fnv}".default = true;
    futures."${deps.tokio_sync."0.1.6".futures}".default = true;
    tokio_sync."0.1.6".default = (f.tokio_sync."0.1.6".default or true);
  }) [
    (features_.fnv."${deps."tokio_sync"."0.1.6"."fnv"}" deps)
    (features_.futures."${deps."tokio_sync"."0.1.6"."futures"}" deps)
  ];


# end
# tokio-tcp-0.1.3

  crates.tokio_tcp."0.1.3" = deps: { features?(features_.tokio_tcp."0.1.3" deps {}) }: buildRustCrate {
    crateName = "tokio-tcp";
    version = "0.1.3";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "07v5p339660zjy1w73wddagj3n5wa4v7v5gj7hnvw95ka407zvcz";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_tcp"."0.1.3"."bytes"}" deps)
      (crates."futures"."${deps."tokio_tcp"."0.1.3"."futures"}" deps)
      (crates."iovec"."${deps."tokio_tcp"."0.1.3"."iovec"}" deps)
      (crates."mio"."${deps."tokio_tcp"."0.1.3"."mio"}" deps)
      (crates."tokio_io"."${deps."tokio_tcp"."0.1.3"."tokio_io"}" deps)
      (crates."tokio_reactor"."${deps."tokio_tcp"."0.1.3"."tokio_reactor"}" deps)
    ]);
  };
  features_.tokio_tcp."0.1.3" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_tcp."0.1.3".bytes}".default = true;
    futures."${deps.tokio_tcp."0.1.3".futures}".default = true;
    iovec."${deps.tokio_tcp."0.1.3".iovec}".default = true;
    mio."${deps.tokio_tcp."0.1.3".mio}".default = true;
    tokio_io."${deps.tokio_tcp."0.1.3".tokio_io}".default = true;
    tokio_reactor."${deps.tokio_tcp."0.1.3".tokio_reactor}".default = true;
    tokio_tcp."0.1.3".default = (f.tokio_tcp."0.1.3".default or true);
  }) [
    (features_.bytes."${deps."tokio_tcp"."0.1.3"."bytes"}" deps)
    (features_.futures."${deps."tokio_tcp"."0.1.3"."futures"}" deps)
    (features_.iovec."${deps."tokio_tcp"."0.1.3"."iovec"}" deps)
    (features_.mio."${deps."tokio_tcp"."0.1.3"."mio"}" deps)
    (features_.tokio_io."${deps."tokio_tcp"."0.1.3"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio_tcp"."0.1.3"."tokio_reactor"}" deps)
  ];


# end
# tokio-threadpool-0.1.15

  crates.tokio_threadpool."0.1.15" = deps: { features?(features_.tokio_threadpool."0.1.15" deps {}) }: buildRustCrate {
    crateName = "tokio-threadpool";
    version = "0.1.15";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "07wsanfx01hjz6gr1pfbr8v0b3wwbnckc0z52svrkh5msy74wgrj";
    dependencies = mapFeatures features ([
      (crates."crossbeam_deque"."${deps."tokio_threadpool"."0.1.15"."crossbeam_deque"}" deps)
      (crates."crossbeam_queue"."${deps."tokio_threadpool"."0.1.15"."crossbeam_queue"}" deps)
      (crates."crossbeam_utils"."${deps."tokio_threadpool"."0.1.15"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_threadpool"."0.1.15"."futures"}" deps)
      (crates."log"."${deps."tokio_threadpool"."0.1.15"."log"}" deps)
      (crates."num_cpus"."${deps."tokio_threadpool"."0.1.15"."num_cpus"}" deps)
      (crates."rand"."${deps."tokio_threadpool"."0.1.15"."rand"}" deps)
      (crates."slab"."${deps."tokio_threadpool"."0.1.15"."slab"}" deps)
      (crates."tokio_executor"."${deps."tokio_threadpool"."0.1.15"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_threadpool."0.1.15" = deps: f: updateFeatures f (rec {
    crossbeam_deque."${deps.tokio_threadpool."0.1.15".crossbeam_deque}".default = true;
    crossbeam_queue."${deps.tokio_threadpool."0.1.15".crossbeam_queue}".default = true;
    crossbeam_utils."${deps.tokio_threadpool."0.1.15".crossbeam_utils}".default = true;
    futures."${deps.tokio_threadpool."0.1.15".futures}".default = true;
    log."${deps.tokio_threadpool."0.1.15".log}".default = true;
    num_cpus."${deps.tokio_threadpool."0.1.15".num_cpus}".default = true;
    rand."${deps.tokio_threadpool."0.1.15".rand}".default = true;
    slab."${deps.tokio_threadpool."0.1.15".slab}".default = true;
    tokio_executor."${deps.tokio_threadpool."0.1.15".tokio_executor}".default = true;
    tokio_threadpool."0.1.15".default = (f.tokio_threadpool."0.1.15".default or true);
  }) [
    (features_.crossbeam_deque."${deps."tokio_threadpool"."0.1.15"."crossbeam_deque"}" deps)
    (features_.crossbeam_queue."${deps."tokio_threadpool"."0.1.15"."crossbeam_queue"}" deps)
    (features_.crossbeam_utils."${deps."tokio_threadpool"."0.1.15"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_threadpool"."0.1.15"."futures"}" deps)
    (features_.log."${deps."tokio_threadpool"."0.1.15"."log"}" deps)
    (features_.num_cpus."${deps."tokio_threadpool"."0.1.15"."num_cpus"}" deps)
    (features_.rand."${deps."tokio_threadpool"."0.1.15"."rand"}" deps)
    (features_.slab."${deps."tokio_threadpool"."0.1.15"."slab"}" deps)
    (features_.tokio_executor."${deps."tokio_threadpool"."0.1.15"."tokio_executor"}" deps)
  ];


# end
# tokio-timer-0.2.11

  crates.tokio_timer."0.2.11" = deps: { features?(features_.tokio_timer."0.2.11" deps {}) }: buildRustCrate {
    crateName = "tokio-timer";
    version = "0.2.11";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1g1np0mdhiwl52kxp543q9jdidf9vws403jh2nay3srlpnqhrkx9";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."tokio_timer"."0.2.11"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_timer"."0.2.11"."futures"}" deps)
      (crates."slab"."${deps."tokio_timer"."0.2.11"."slab"}" deps)
      (crates."tokio_executor"."${deps."tokio_timer"."0.2.11"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_timer."0.2.11" = deps: f: updateFeatures f (rec {
    crossbeam_utils."${deps.tokio_timer."0.2.11".crossbeam_utils}".default = true;
    futures."${deps.tokio_timer."0.2.11".futures}".default = true;
    slab."${deps.tokio_timer."0.2.11".slab}".default = true;
    tokio_executor."${deps.tokio_timer."0.2.11".tokio_executor}".default = true;
    tokio_timer."0.2.11".default = (f.tokio_timer."0.2.11".default or true);
  }) [
    (features_.crossbeam_utils."${deps."tokio_timer"."0.2.11"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_timer"."0.2.11"."futures"}" deps)
    (features_.slab."${deps."tokio_timer"."0.2.11"."slab"}" deps)
    (features_.tokio_executor."${deps."tokio_timer"."0.2.11"."tokio_executor"}" deps)
  ];


# end
# try-lock-0.2.2

  crates.try_lock."0.2.2" = deps: { features?(features_.try_lock."0.2.2" deps {}) }: buildRustCrate {
    crateName = "try-lock";
    version = "0.2.2";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1k8xc0jpbrmzp0fwghdh6pwzjb9xx2p8yy0xxnnb8065smc5fsrv";
  };
  features_.try_lock."0.2.2" = deps: f: updateFeatures f (rec {
    try_lock."0.2.2".default = (f.try_lock."0.2.2".default or true);
  }) [];


# end
# try_from-0.3.2

  crates.try_from."0.3.2" = deps: { features?(features_.try_from."0.3.2" deps {}) }: buildRustCrate {
    crateName = "try_from";
    version = "0.3.2";
    authors = [ "Derek Williams <derek@fyrie.net>" ];
    sha256 = "05jnndmiqz2sf8xsnf7ysaj3fpl3rhgzbfn1jx6casaahakrzald";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."try_from"."0.3.2"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."try_from"."0.3.2" or {});
  };
  features_.try_from."0.3.2" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.try_from."0.3.2".cfg_if}".default = true;
    try_from."0.3.2".default = (f.try_from."0.3.2".default or true);
  }) [
    (features_.cfg_if."${deps."try_from"."0.3.2"."cfg_if"}" deps)
  ];


# end
# unicase-2.4.0

  crates.unicase."2.4.0" = deps: { features?(features_.unicase."2.4.0" deps {}) }: buildRustCrate {
    crateName = "unicase";
    version = "2.4.0";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0f4ay81kfrvs0l2frpci367j3dmnd3jx1x3q5fismmr6a4546piz";
    build = "build.rs";

    buildDependencies = mapFeatures features ([
      (crates."version_check"."${deps."unicase"."2.4.0"."version_check"}" deps)
    ]);
    features = mkFeatures (features."unicase"."2.4.0" or {});
  };
  features_.unicase."2.4.0" = deps: f: updateFeatures f (rec {
    unicase."2.4.0".default = (f.unicase."2.4.0".default or true);
    version_check."${deps.unicase."2.4.0".version_check}".default = true;
  }) [
    (features_.version_check."${deps."unicase"."2.4.0"."version_check"}" deps)
  ];


# end
# unicode-bidi-0.3.4

  crates.unicode_bidi."0.3.4" = deps: { features?(features_.unicode_bidi."0.3.4" deps {}) }: buildRustCrate {
    crateName = "unicode-bidi";
    version = "0.3.4";
    authors = [ "The Servo Project Developers" ];
    sha256 = "0lcd6jasrf8p9p0q20qyf10c6xhvw40m2c4rr105hbk6zy26nj1q";
    libName = "unicode_bidi";
    dependencies = mapFeatures features ([
      (crates."matches"."${deps."unicode_bidi"."0.3.4"."matches"}" deps)
    ]);
    features = mkFeatures (features."unicode_bidi"."0.3.4" or {});
  };
  features_.unicode_bidi."0.3.4" = deps: f: updateFeatures f (rec {
    matches."${deps.unicode_bidi."0.3.4".matches}".default = true;
    unicode_bidi = fold recursiveUpdate {} [
      { "0.3.4".default = (f.unicode_bidi."0.3.4".default or true); }
      { "0.3.4".flame =
        (f.unicode_bidi."0.3.4".flame or false) ||
        (f.unicode_bidi."0.3.4".flame_it or false) ||
        (unicode_bidi."0.3.4"."flame_it" or false); }
      { "0.3.4".flamer =
        (f.unicode_bidi."0.3.4".flamer or false) ||
        (f.unicode_bidi."0.3.4".flame_it or false) ||
        (unicode_bidi."0.3.4"."flame_it" or false); }
      { "0.3.4".serde =
        (f.unicode_bidi."0.3.4".serde or false) ||
        (f.unicode_bidi."0.3.4".with_serde or false) ||
        (unicode_bidi."0.3.4"."with_serde" or false); }
    ];
  }) [
    (features_.matches."${deps."unicode_bidi"."0.3.4"."matches"}" deps)
  ];


# end
# unicode-normalization-0.1.8

  crates.unicode_normalization."0.1.8" = deps: { features?(features_.unicode_normalization."0.1.8" deps {}) }: buildRustCrate {
    crateName = "unicode-normalization";
    version = "0.1.8";
    authors = [ "kwantam <kwantam@gmail.com>" ];
    sha256 = "1pb26i2xd5zz0icabyqahikpca0iwj2jd4145pczc4bb7p641dsz";
    dependencies = mapFeatures features ([
      (crates."smallvec"."${deps."unicode_normalization"."0.1.8"."smallvec"}" deps)
    ]);
  };
  features_.unicode_normalization."0.1.8" = deps: f: updateFeatures f (rec {
    smallvec."${deps.unicode_normalization."0.1.8".smallvec}".default = true;
    unicode_normalization."0.1.8".default = (f.unicode_normalization."0.1.8".default or true);
  }) [
    (features_.smallvec."${deps."unicode_normalization"."0.1.8"."smallvec"}" deps)
  ];


# end
# unicode-width-0.1.6

  crates.unicode_width."0.1.6" = deps: { features?(features_.unicode_width."0.1.6" deps {}) }: buildRustCrate {
    crateName = "unicode-width";
    version = "0.1.6";
    authors = [ "kwantam <kwantam@gmail.com>" ];
    sha256 = "1mss965j7d8pv7z7zg6qfkcb7lyhxkxvbh8akzr4xxxx3vzazwsi";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."unicode_width"."0.1.6" or {});
  };
  features_.unicode_width."0.1.6" = deps: f: updateFeatures f (rec {
    unicode_width = fold recursiveUpdate {} [
      { "0.1.6".compiler_builtins =
        (f.unicode_width."0.1.6".compiler_builtins or false) ||
        (f.unicode_width."0.1.6".rustc-dep-of-std or false) ||
        (unicode_width."0.1.6"."rustc-dep-of-std" or false); }
      { "0.1.6".core =
        (f.unicode_width."0.1.6".core or false) ||
        (f.unicode_width."0.1.6".rustc-dep-of-std or false) ||
        (unicode_width."0.1.6"."rustc-dep-of-std" or false); }
      { "0.1.6".default = (f.unicode_width."0.1.6".default or true); }
      { "0.1.6".std =
        (f.unicode_width."0.1.6".std or false) ||
        (f.unicode_width."0.1.6".rustc-dep-of-std or false) ||
        (unicode_width."0.1.6"."rustc-dep-of-std" or false); }
    ];
  }) [];


# end
# unicode-xid-0.1.0

  crates.unicode_xid."0.1.0" = deps: { features?(features_.unicode_xid."0.1.0" deps {}) }: buildRustCrate {
    crateName = "unicode-xid";
    version = "0.1.0";
    authors = [ "erick.tryzelaar <erick.tryzelaar@gmail.com>" "kwantam <kwantam@gmail.com>" ];
    sha256 = "05wdmwlfzxhq3nhsxn6wx4q8dhxzzfb9szsz6wiw092m1rjj01zj";
    features = mkFeatures (features."unicode_xid"."0.1.0" or {});
  };
  features_.unicode_xid."0.1.0" = deps: f: updateFeatures f (rec {
    unicode_xid."0.1.0".default = (f.unicode_xid."0.1.0".default or true);
  }) [];


# end
# unicode-xid-0.2.0

  crates.unicode_xid."0.2.0" = deps: { features?(features_.unicode_xid."0.2.0" deps {}) }: buildRustCrate {
    crateName = "unicode-xid";
    version = "0.2.0";
    authors = [ "erick.tryzelaar <erick.tryzelaar@gmail.com>" "kwantam <kwantam@gmail.com>" ];
    sha256 = "1c85gb3p3qhbjvfyjb31m06la4f024jx319k10ig7n47dz2fk8v7";
    features = mkFeatures (features."unicode_xid"."0.2.0" or {});
  };
  features_.unicode_xid."0.2.0" = deps: f: updateFeatures f (rec {
    unicode_xid."0.2.0".default = (f.unicode_xid."0.2.0".default or true);
  }) [];


# end
# url-1.7.2

  crates.url."1.7.2" = deps: { features?(features_.url."1.7.2" deps {}) }: buildRustCrate {
    crateName = "url";
    version = "1.7.2";
    authors = [ "The rust-url developers" ];
    sha256 = "0qzrjzd9r1niv7037x4cgnv98fs1vj0k18lpxx890ipc47x5gc09";
    dependencies = mapFeatures features ([
      (crates."idna"."${deps."url"."1.7.2"."idna"}" deps)
      (crates."matches"."${deps."url"."1.7.2"."matches"}" deps)
      (crates."percent_encoding"."${deps."url"."1.7.2"."percent_encoding"}" deps)
    ]);
    features = mkFeatures (features."url"."1.7.2" or {});
  };
  features_.url."1.7.2" = deps: f: updateFeatures f (rec {
    idna."${deps.url."1.7.2".idna}".default = true;
    matches."${deps.url."1.7.2".matches}".default = true;
    percent_encoding."${deps.url."1.7.2".percent_encoding}".default = true;
    url = fold recursiveUpdate {} [
      { "1.7.2".default = (f.url."1.7.2".default or true); }
      { "1.7.2".encoding =
        (f.url."1.7.2".encoding or false) ||
        (f.url."1.7.2".query_encoding or false) ||
        (url."1.7.2"."query_encoding" or false); }
      { "1.7.2".heapsize =
        (f.url."1.7.2".heapsize or false) ||
        (f.url."1.7.2".heap_size or false) ||
        (url."1.7.2"."heap_size" or false); }
    ];
  }) [
    (features_.idna."${deps."url"."1.7.2"."idna"}" deps)
    (features_.matches."${deps."url"."1.7.2"."matches"}" deps)
    (features_.percent_encoding."${deps."url"."1.7.2"."percent_encoding"}" deps)
  ];


# end
# url-2.1.0

  crates.url."2.1.0" = deps: { features?(features_.url."2.1.0" deps {}) }: buildRustCrate {
    crateName = "url";
    version = "2.1.0";
    authors = [ "The rust-url developers" ];
    sha256 = "0mvv28fvrrv3hc064gjgpqjvjn1j151qbi9i5bcilal6rkcd1brq";
    dependencies = mapFeatures features ([
      (crates."idna"."${deps."url"."2.1.0"."idna"}" deps)
      (crates."matches"."${deps."url"."2.1.0"."matches"}" deps)
      (crates."percent_encoding"."${deps."url"."2.1.0"."percent_encoding"}" deps)
    ]);
  };
  features_.url."2.1.0" = deps: f: updateFeatures f (rec {
    idna."${deps.url."2.1.0".idna}".default = true;
    matches."${deps.url."2.1.0".matches}".default = true;
    percent_encoding."${deps.url."2.1.0".percent_encoding}".default = true;
    url."2.1.0".default = (f.url."2.1.0".default or true);
  }) [
    (features_.idna."${deps."url"."2.1.0"."idna"}" deps)
    (features_.matches."${deps."url"."2.1.0"."matches"}" deps)
    (features_.percent_encoding."${deps."url"."2.1.0"."percent_encoding"}" deps)
  ];


# end
# uuid-0.7.4

  crates.uuid."0.7.4" = deps: { features?(features_.uuid."0.7.4" deps {}) }: buildRustCrate {
    crateName = "uuid";
    version = "0.7.4";
    authors = [ "Ashley Mannix<ashleymannix@live.com.au>" "Christopher Armstrong" "Dylan DPC<dylan.dpc@gmail.com>" "Hunar Roop Kahlon<hunar.roop@gmail.com>" ];
    sha256 = "1kzjah6i8vf51hrla6qnplymaqx2fadhhlnbvgivgld311lqyz9m";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.uuid."0.7.4".rand or false then [ (crates.rand."${deps."uuid"."0.7.4".rand}" deps) ] else []))
      ++ (if kernel == "windows" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."uuid"."0.7.4" or {});
  };
  features_.uuid."0.7.4" = deps: f: updateFeatures f (rec {
    rand = fold recursiveUpdate {} [
      { "${deps.uuid."0.7.4".rand}"."stdweb" =
        (f.rand."${deps.uuid."0.7.4".rand}"."stdweb" or false) ||
        (uuid."0.7.4"."stdweb" or false) ||
        (f."uuid"."0.7.4"."stdweb" or false); }
      { "${deps.uuid."0.7.4".rand}"."wasm-bindgen" =
        (f.rand."${deps.uuid."0.7.4".rand}"."wasm-bindgen" or false) ||
        (uuid."0.7.4"."wasm-bindgen" or false) ||
        (f."uuid"."0.7.4"."wasm-bindgen" or false); }
      { "${deps.uuid."0.7.4".rand}".default = true; }
    ];
    uuid = fold recursiveUpdate {} [
      { "0.7.4".byteorder =
        (f.uuid."0.7.4".byteorder or false) ||
        (f.uuid."0.7.4".u128 or false) ||
        (uuid."0.7.4"."u128" or false); }
      { "0.7.4".default = (f.uuid."0.7.4".default or true); }
      { "0.7.4".md5 =
        (f.uuid."0.7.4".md5 or false) ||
        (f.uuid."0.7.4".v3 or false) ||
        (uuid."0.7.4"."v3" or false); }
      { "0.7.4".nightly =
        (f.uuid."0.7.4".nightly or false) ||
        (f.uuid."0.7.4".const_fn or false) ||
        (uuid."0.7.4"."const_fn" or false); }
      { "0.7.4".rand =
        (f.uuid."0.7.4".rand or false) ||
        (f.uuid."0.7.4".v4 or false) ||
        (uuid."0.7.4"."v4" or false); }
      { "0.7.4".sha1 =
        (f.uuid."0.7.4".sha1 or false) ||
        (f.uuid."0.7.4".v5 or false) ||
        (uuid."0.7.4"."v5" or false); }
      { "0.7.4".std =
        (f.uuid."0.7.4".std or false) ||
        (f.uuid."0.7.4".default or false) ||
        (uuid."0.7.4"."default" or false); }
      { "0.7.4".winapi =
        (f.uuid."0.7.4".winapi or false) ||
        (f.uuid."0.7.4".guid or false) ||
        (uuid."0.7.4"."guid" or false); }
    ];
  }) [
    (features_.rand."${deps."uuid"."0.7.4"."rand"}" deps)
  ];


# end
# vcpkg-0.2.7

  crates.vcpkg."0.2.7" = deps: { features?(features_.vcpkg."0.2.7" deps {}) }: buildRustCrate {
    crateName = "vcpkg";
    version = "0.2.7";
    authors = [ "Jim McGrath <jimmc2@gmail.com>" ];
    sha256 = "1lwykbbscbdy4nhrfidgg3rk2xw9cvx5672sx1c97wm8y3vjpcd9";
  };
  features_.vcpkg."0.2.7" = deps: f: updateFeatures f (rec {
    vcpkg."0.2.7".default = (f.vcpkg."0.2.7".default or true);
  }) [];


# end
# vec_map-0.8.1

  crates.vec_map."0.8.1" = deps: { features?(features_.vec_map."0.8.1" deps {}) }: buildRustCrate {
    crateName = "vec_map";
    version = "0.8.1";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Jorge Aparicio <japaricious@gmail.com>" "Alexis Beingessner <a.beingessner@gmail.com>" "Brian Anderson <>" "tbu- <>" "Manish Goregaokar <>" "Aaron Turon <aturon@mozilla.com>" "Adolfo Ochagavía <>" "Niko Matsakis <>" "Steven Fackler <>" "Chase Southwood <csouth3@illinois.edu>" "Eduard Burtescu <>" "Florian Wilkens <>" "Félix Raimundo <>" "Tibor Benke <>" "Markus Siemens <markus@m-siemens.de>" "Josh Branchaud <jbranchaud@gmail.com>" "Huon Wilson <dbau.pp@gmail.com>" "Corey Farwell <coref@rwell.org>" "Aaron Liblong <>" "Nick Cameron <nrc@ncameron.org>" "Patrick Walton <pcwalton@mimiga.net>" "Felix S Klock II <>" "Andrew Paseltiner <apaseltiner@gmail.com>" "Sean McArthur <sean.monstar@gmail.com>" "Vadim Petrochenkov <>" ];
    sha256 = "1jj2nrg8h3l53d43rwkpkikq5a5x15ms4rf1rw92hp5lrqhi8mpi";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."vec_map"."0.8.1" or {});
  };
  features_.vec_map."0.8.1" = deps: f: updateFeatures f (rec {
    vec_map = fold recursiveUpdate {} [
      { "0.8.1".default = (f.vec_map."0.8.1".default or true); }
      { "0.8.1".serde =
        (f.vec_map."0.8.1".serde or false) ||
        (f.vec_map."0.8.1".eders or false) ||
        (vec_map."0.8.1"."eders" or false); }
    ];
  }) [];


# end
# version_check-0.1.5

  crates.version_check."0.1.5" = deps: { features?(features_.version_check."0.1.5" deps {}) }: buildRustCrate {
    crateName = "version_check";
    version = "0.1.5";
    authors = [ "Sergio Benitez <sb@sergio.bz>" ];
    sha256 = "1yrx9xblmwbafw2firxyqbj8f771kkzfd24n3q7xgwiqyhi0y8qd";
  };
  features_.version_check."0.1.5" = deps: f: updateFeatures f (rec {
    version_check."0.1.5".default = (f.version_check."0.1.5".default or true);
  }) [];


# end
# want-0.2.0

  crates.want."0.2.0" = deps: { features?(features_.want."0.2.0" deps {}) }: buildRustCrate {
    crateName = "want";
    version = "0.2.0";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1qyd7cixai7f58zfbz8v3lg52q7p6805b9vw7vblw1pysg6vnrxb";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."want"."0.2.0"."futures"}" deps)
      (crates."log"."${deps."want"."0.2.0"."log"}" deps)
      (crates."try_lock"."${deps."want"."0.2.0"."try_lock"}" deps)
    ]);
  };
  features_.want."0.2.0" = deps: f: updateFeatures f (rec {
    futures."${deps.want."0.2.0".futures}".default = true;
    log."${deps.want."0.2.0".log}".default = true;
    try_lock."${deps.want."0.2.0".try_lock}".default = true;
    want."0.2.0".default = (f.want."0.2.0".default or true);
  }) [
    (features_.futures."${deps."want"."0.2.0"."futures"}" deps)
    (features_.log."${deps."want"."0.2.0"."log"}" deps)
    (features_.try_lock."${deps."want"."0.2.0"."try_lock"}" deps)
  ];


# end
# wasi-0.5.0

  crates.wasi."0.5.0" = deps: { features?(features_.wasi."0.5.0" deps {}) }: buildRustCrate {
    crateName = "wasi";
    version = "0.5.0";
    authors = [ "The Cranelift Project Developers" ];
    edition = "2018";
    sha256 = "07lkhjfx9ab19ri5gliqgga0jhafd1gv42y5ckb97l08wb7862k6";
  };
  features_.wasi."0.5.0" = deps: f: updateFeatures f (rec {
    wasi."0.5.0".default = (f.wasi."0.5.0".default or true);
  }) [];


# end
# winapi-0.2.8

  crates.winapi."0.2.8" = deps: { features?(features_.winapi."0.2.8" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.2.8";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0a45b58ywf12vb7gvj6h3j264nydynmzyqz8d8rqxsj6icqv82as";
  };
  features_.winapi."0.2.8" = deps: f: updateFeatures f (rec {
    winapi."0.2.8".default = (f.winapi."0.2.8".default or true);
  }) [];


# end
# winapi-0.3.8

  crates.winapi."0.3.8" = deps: { features?(features_.winapi."0.3.8" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.3.8";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "084ialbgww1vxry341fmkg5crgpvab3w52ahx1wa54yqjgym0vxs";
    build = "build.rs";
    dependencies = (if kernel == "i686-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_i686_pc_windows_gnu"."${deps."winapi"."0.3.8"."winapi_i686_pc_windows_gnu"}" deps)
    ]) else [])
      ++ (if kernel == "x86_64-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_x86_64_pc_windows_gnu"."${deps."winapi"."0.3.8"."winapi_x86_64_pc_windows_gnu"}" deps)
    ]) else []);
    features = mkFeatures (features."winapi"."0.3.8" or {});
  };
  features_.winapi."0.3.8" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "0.3.8".default = (f.winapi."0.3.8".default or true); }
      { "0.3.8".impl-debug =
        (f.winapi."0.3.8".impl-debug or false) ||
        (f.winapi."0.3.8".debug or false) ||
        (winapi."0.3.8"."debug" or false); }
    ];
    winapi_i686_pc_windows_gnu."${deps.winapi."0.3.8".winapi_i686_pc_windows_gnu}".default = true;
    winapi_x86_64_pc_windows_gnu."${deps.winapi."0.3.8".winapi_x86_64_pc_windows_gnu}".default = true;
  }) [
    (features_.winapi_i686_pc_windows_gnu."${deps."winapi"."0.3.8"."winapi_i686_pc_windows_gnu"}" deps)
    (features_.winapi_x86_64_pc_windows_gnu."${deps."winapi"."0.3.8"."winapi_x86_64_pc_windows_gnu"}" deps)
  ];


# end
# winapi-build-0.1.1

  crates.winapi_build."0.1.1" = deps: { features?(features_.winapi_build."0.1.1" deps {}) }: buildRustCrate {
    crateName = "winapi-build";
    version = "0.1.1";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1lxlpi87rkhxcwp2ykf1ldw3p108hwm24nywf3jfrvmff4rjhqga";
    libName = "build";
  };
  features_.winapi_build."0.1.1" = deps: f: updateFeatures f (rec {
    winapi_build."0.1.1".default = (f.winapi_build."0.1.1".default or true);
  }) [];


# end
# winapi-i686-pc-windows-gnu-0.4.0

  crates.winapi_i686_pc_windows_gnu."0.4.0" = deps: { features?(features_.winapi_i686_pc_windows_gnu."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-i686-pc-windows-gnu";
    version = "0.4.0";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "05ihkij18r4gamjpxj4gra24514can762imjzlmak5wlzidplzrp";
    build = "build.rs";
  };
  features_.winapi_i686_pc_windows_gnu."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_i686_pc_windows_gnu."0.4.0".default = (f.winapi_i686_pc_windows_gnu."0.4.0".default or true);
  }) [];


# end
# winapi-x86_64-pc-windows-gnu-0.4.0

  crates.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: { features?(features_.winapi_x86_64_pc_windows_gnu."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-x86_64-pc-windows-gnu";
    version = "0.4.0";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0n1ylmlsb8yg1v583i4xy0qmqg42275flvbc51hdqjjfjcl9vlbj";
    build = "build.rs";
  };
  features_.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_x86_64_pc_windows_gnu."0.4.0".default = (f.winapi_x86_64_pc_windows_gnu."0.4.0".default or true);
  }) [];


# end
# winconsole-0.10.0

  crates.winconsole."0.10.0" = deps: { features?(features_.winconsole."0.10.0" deps {}) }: buildRustCrate {
    crateName = "winconsole";
    version = "0.10.0";
    authors = [ "Omar M. <omarkmu@gmail.com>" ];
    sha256 = "1l477dbqblnajm4l7gydi7gjgfwb5g9kkpq15ynzyi7y5g4pq6cm";
    dependencies = mapFeatures features ([
      (crates."cgmath"."${deps."winconsole"."0.10.0"."cgmath"}" deps)
      (crates."lazy_static"."${deps."winconsole"."0.10.0"."lazy_static"}" deps)
      (crates."rgb"."${deps."winconsole"."0.10.0"."rgb"}" deps)
      (crates."winapi"."${deps."winconsole"."0.10.0"."winapi"}" deps)
    ]);
    features = mkFeatures (features."winconsole"."0.10.0" or {});
  };
  features_.winconsole."0.10.0" = deps: f: updateFeatures f (rec {
    cgmath."${deps.winconsole."0.10.0".cgmath}".default = true;
    lazy_static."${deps.winconsole."0.10.0".lazy_static}".default = true;
    rgb."${deps.winconsole."0.10.0".rgb}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.winconsole."0.10.0".winapi}"."consoleapi" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."minwindef" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."processenv" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."utilapiset" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."winbase" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."wincon" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."windef" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."winnls" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."winnt" = true; }
      { "${deps.winconsole."0.10.0".winapi}"."winuser" = true; }
      { "${deps.winconsole."0.10.0".winapi}".default = true; }
    ];
    winconsole."0.10.0".default = (f.winconsole."0.10.0".default or true);
  }) [
    (features_.cgmath."${deps."winconsole"."0.10.0"."cgmath"}" deps)
    (features_.lazy_static."${deps."winconsole"."0.10.0"."lazy_static"}" deps)
    (features_.rgb."${deps."winconsole"."0.10.0"."rgb"}" deps)
    (features_.winapi."${deps."winconsole"."0.10.0"."winapi"}" deps)
  ];


# end
# winreg-0.6.2

  crates.winreg."0.6.2" = deps: { features?(features_.winreg."0.6.2" deps {}) }: buildRustCrate {
    crateName = "winreg";
    version = "0.6.2";
    authors = [ "Igor Shaula <gentoo90@gmail.com>" ];
    sha256 = "0yxz0sph88wsj7cy94kfy17c5jaj0665m3qqll5saqind1fnfb90";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."winreg"."0.6.2"."winapi"}" deps)
    ]);
    features = mkFeatures (features."winreg"."0.6.2" or {});
  };
  features_.winreg."0.6.2" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "${deps.winreg."0.6.2".winapi}"."handleapi" = true; }
      { "${deps.winreg."0.6.2".winapi}"."impl-debug" = true; }
      { "${deps.winreg."0.6.2".winapi}"."impl-default" = true; }
      { "${deps.winreg."0.6.2".winapi}"."ktmw32" =
        (f.winapi."${deps.winreg."0.6.2".winapi}"."ktmw32" or false) ||
        (winreg."0.6.2"."transactions" or false) ||
        (f."winreg"."0.6.2"."transactions" or false); }
      { "${deps.winreg."0.6.2".winapi}"."minwinbase" = true; }
      { "${deps.winreg."0.6.2".winapi}"."minwindef" = true; }
      { "${deps.winreg."0.6.2".winapi}"."timezoneapi" = true; }
      { "${deps.winreg."0.6.2".winapi}"."winerror" = true; }
      { "${deps.winreg."0.6.2".winapi}"."winnt" = true; }
      { "${deps.winreg."0.6.2".winapi}"."winreg" = true; }
      { "${deps.winreg."0.6.2".winapi}".default = true; }
    ];
    winreg = fold recursiveUpdate {} [
      { "0.6.2".default = (f.winreg."0.6.2".default or true); }
      { "0.6.2".serde =
        (f.winreg."0.6.2".serde or false) ||
        (f.winreg."0.6.2".serialization-serde or false) ||
        (winreg."0.6.2"."serialization-serde" or false); }
      { "0.6.2".transactions =
        (f.winreg."0.6.2".transactions or false) ||
        (f.winreg."0.6.2".serialization-serde or false) ||
        (winreg."0.6.2"."serialization-serde" or false); }
    ];
  }) [
    (features_.winapi."${deps."winreg"."0.6.2"."winapi"}" deps)
  ];


# end
# ws2_32-sys-0.2.1

  crates.ws2_32_sys."0.2.1" = deps: { features?(features_.ws2_32_sys."0.2.1" deps {}) }: buildRustCrate {
    crateName = "ws2_32-sys";
    version = "0.2.1";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1zpy9d9wk11sj17fczfngcj28w4xxjs3b4n036yzpy38dxp4f7kc";
    libName = "ws2_32";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."ws2_32_sys"."0.2.1"."winapi"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."winapi_build"."${deps."ws2_32_sys"."0.2.1"."winapi_build"}" deps)
    ]);
  };
  features_.ws2_32_sys."0.2.1" = deps: f: updateFeatures f (rec {
    winapi."${deps.ws2_32_sys."0.2.1".winapi}".default = true;
    winapi_build."${deps.ws2_32_sys."0.2.1".winapi_build}".default = true;
    ws2_32_sys."0.2.1".default = (f.ws2_32_sys."0.2.1".default or true);
  }) [
    (features_.winapi."${deps."ws2_32_sys"."0.2.1"."winapi"}" deps)
    (features_.winapi_build."${deps."ws2_32_sys"."0.2.1"."winapi_build"}" deps)
  ];


# end
}
