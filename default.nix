{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;

let
  sources = nix-gitignore.gitignoreSource [ "default.nix" "README*" "ci" "tests" ] ./.;
in
rec {
  hydra-cli = ((pkgs.callPackage ./Cargo.nix {
    cratesIO = pkgs.callPackage ./crates-io.nix {};
  }).hydra_cli {}).overrideDerivation(_: {
    src = sources;
  });

  tests = {
    rustfmt = pkgs.runCommand "test-rustfmt" { buildInputs = [ pkgs.rustfmt ]; }
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
    ''  ;
    vm = pkgs.callPackage ./tests/vm.nix { inherit hydra-cli; };
  };
}
