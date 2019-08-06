self: super: {
  mdsh = super.rustPlatform.buildRustPackage rec {
    name = "mdsh-${version}";
    version = "master";

    src = super.fetchFromGitHub {
      owner = "zimbatm";
      repo = "mdsh";
      rev = "a20057262e243ffeeeb5bd510e1d63975665dafd";
      sha256 = "1xz3yqm4g15mfvb11sc70m5bwlaia0b7sf1a0wmsw0gr06wgaz5w";
    };

    cargoSha256 = "1i2xrwsypnzllby4yag7h9h64fppig7vrkndaj7pyxdr4vp9kv0h";
  };
}
