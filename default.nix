{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;

let


  buildReadme = "${mdsh}/bin/mdsh --input ${./README.md} --output $out";
  verifyReadme = "${buildReadme} --frozen && echo 'OK' > $out";
in
rec {

  hydra-cli = pkgs.callPackage ./package.nix {};

  readme = pkgs.runCommand "build-readme" { buildInputs = [ hydra-cli ]; } "${buildReadme}";

  tests = {
    readme = pkgs.runCommand "test-readme" { buildInputs = [ hydra-cli ]; } "${verifyReadme}";
    vm = pkgs.callPackage ./tests/vm.nix { inherit hydra-cli; };
  };
}
