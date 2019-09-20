{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;

let
  # TODO: fix gitignore and replace this by gitignre
  # See https://github.com/NixOS/nixpkgs/issues/69138
  sources = builtins.path {
    name = "hydra-cli-filtered-source";
    path = ./.;
    filter = (path: type:
      baseNameOf path != ".git" &&
      baseNameOf path != "default.nix" &&
      baseNameOf path != "ci" &&
      baseNameOf path != "tests" &&
      baseNameOf path != "target" &&
      baseNameOf path != "result" &&
      (! (pkgs.lib.hasSuffix ".rs.bk" path)) &&
      (! (pkgs.lib.hasSuffix "~" path))
    );
  };
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
