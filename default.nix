{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;
rec {
  hydra-cli = rustPlatform.buildRustPackage rec {
    name = "hydra-cli-${version}";
    version = "0.1";
    src = nix-gitignore.gitignoreSource [ "default.nix" "README*" ] ./.;
    buildInputs = [ pkgconfig openssl ];
    cargoSha256 = "11qj50rx2x9hrva7m0gnhp8sj5283z320w01qb153zpgzf9d7nrs";
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
  echo "## Usage \`hydra-cli\`" >> $out
  echo >> $out

      hydra-cli help | sed -e 's/^/    /' >> $out
      echo >> $out

      for s in $(hydra-cli help | sed -n -e '/SUBCOMMANDS/,$p' | grep -v SUBCOMMANDS | grep "^  " | grep -v "^$" | grep -v "^    help" | tr -s " " | cut -d" " -f2); do
      echo "### Command \`hydra-cli $s\`" >> $out
      echo >> $out
      hydra-cli $s --help | sed -e 's/^/    /' >> $out
      echo >> $out
      done
  '';
}
