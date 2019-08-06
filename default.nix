{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;

let
  sources = nix-gitignore.gitignoreSource [ "default.nix" "ci" "tests" "target" ] ./.;
  buildReadme = "${mdsh}/bin/mdsh --input ${sources}/README.md --output $out";
  verifyReadme = "${buildReadme} --frozen && echo 'OK' > $out";
in
rec {

  hydra-cli = ((pkgs.callPackage ./Cargo.nix {
    cratesIO = pkgs.callPackage ./crates-io.nix {};
  }).hydra_cli {}).overrideDerivation(_: {
    src = sources;
    doCheck = true;
    checkPhase = ''
      echo "Checking formatting with 'rustfmt'"
      find . -name "*.rs" | xargs ${rustfmt}/bin/rustfmt --check
    '';
  });

  readme = pkgs.runCommand "build-readme" { buildInputs = [ hydra-cli ]; } "${buildReadme}";

  tests = {
    readme = pkgs.runCommand "test-readme" { buildInputs = [ hydra-cli ]; } "${verifyReadme}";
    vm = pkgs.callPackage ./tests/vm.nix { inherit hydra-cli; };
  };
}
