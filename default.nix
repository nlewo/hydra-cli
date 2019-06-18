{ nixpkgs ? (import ./nix/sources.nix).nixpkgs
, pkgs ? import nixpkgs {}
}:

with pkgs;

rec {
  hydra-cli = rustPlatform.buildRustPackage rec {
    name = "hydra-cli-${version}";
    version = "0.1";
    src = nix-gitignore.gitignoreSource [ "default.nix" "README*" ] ./.;
    buildInputs = [ pkgconfig openssl ];
    cargoSha256 = "1zfrv0psgg9g7dbg5p2pl68v1zigfipi6k6j137bvz27qfzdn540";
    meta = with stdenv.lib; {
      description = "The Hydra CLI";
      homepage = https://github.com/nlewo/hydra-cli;
      license = licenses.mit;
      platforms = platforms.all;
    };
  };
  readme = pkgs.runCommand "generate-readme" { buildInputs = [ hydra-cli ]; }
  ''
    cat ${./README.header.md} > $out
    echo >> $out
    echo "## hydra-cli" >> $out
    echo >> $out

    hydra-cli help | sed -e 's/^/    /' >> $out
    echo >> $out

    for s in $(hydra-cli help | sed -n -e '/SUBCOMMANDS/,$p' | grep -v SUBCOMMANDS | grep "^  " | grep -v "^$" | grep -v "^    help" | tr -s " " | cut -d" " -f2); do
      echo "## Command `hydra-cli $s`" >> $out
      echo >> $out
      hydra-cli help $s | sed -e 's/^/    /' >> $out
      echo >> $out
    done
  '';
}
