{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;

let
  sources = nix-gitignore.gitignoreSource [ "default.nix" "ci" "tests" "target" ] ./.;
  buildReadme = "${mdsh}/bin/mdsh --input ${sources}/README.md --output $out";
  verifyReadme = "${buildReadme} --frozen && echo 'OK' > $out";
in
rec {

  # XXX: we use buildPackageSingleStep instead of buildPackage, because the
  # cargo version is too old to benefit from incremental builds.
  hydra-cli = pkgs.naersk.buildPackageSingleStep (sources)
    { doDoc = false;
      doCheck = true;
      cargoTest =
        ''
        cargo test --$CARGO_BUILD_PROFILE
        cargo fmt --all -- --check
        '';
      buildInputs = [ pkgs.rustfmt pkgs.openssl pkgs.pkgconfig ];
    };

  readme = pkgs.runCommand "build-readme" { buildInputs = [ hydra-cli ]; } "${buildReadme}";

  tests = {
    readme = pkgs.runCommand "test-readme" { buildInputs = [ hydra-cli ]; } "${verifyReadme}";
    vm = pkgs.callPackage ./tests/vm.nix { inherit hydra-cli; };
  };
}
