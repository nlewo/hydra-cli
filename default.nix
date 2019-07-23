{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;
rec {
  hydra-cli = ((pkgs.callPackage ./Cargo.nix {
    cratesIO = pkgs.callPackage ./crates-io.nix {};
  }).hydra_cli {}).overrideDerivation(_: {
    src = nix-gitignore.gitignoreSource [ "default.nix" "README*" "ci" ] ./.;});

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
