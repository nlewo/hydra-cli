{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;

let
  sources = nix-gitignore.gitignoreSource [ "default.nix" "README*" "ci" ] ./.;
in
rec {
  hydra-cli = ((pkgs.callPackage ./Cargo.nix {
    cratesIO = pkgs.callPackage ./crates-io.nix {};
  }).hydra_cli {}).overrideDerivation(_: {
    src = sources;
  });

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

  tests.readme = pkgs.runCommand "test-readme" { } ''
    if diff -q ${readme} ${./README.md};
    then
      echo ok > $out
    else
      echo "error: you need to generate the README by running the following command:"
      echo 'hint : cp $(nix-build -A readme --no-out-link) README.md'
    fi
  '';

  tests.rustfmt = pkgs.runCommand "test-rustfmt" { buildInputs = [ pkgs.rustfmt ]; }
  ''
    set +e
    find ${sources} -name "*.rs" | xargs rustfmt --check
    RETCODE=$?
    set -e
    if [ $RETCODE == 0 ]
    then
      echo ok > $out
    else
      echo
      echo "error: rustfmt failed"
      echo 'hint : run "cargo fmt"'
      echo
    fi
  '';

  tests.vm = pkgs.callPackage ./tests/vm.nix { inherit hydra-cli; };
}
