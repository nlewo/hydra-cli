{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;

let
  sources = nix-gitignore.gitignoreSource [ "default.nix" "ci" "tests" "target" ] ./.;
  buildReadme = "${mdsh}/bin/mdsh --input ${sources}/README.md --output $out";
  verifyReadme = "${buildReadme} --frozen && echo 'OK' > $out";
in
rec {

  hydra-cli = pkgs.rustPlatform.buildRustPackage {
    name = "hydra-cli";
    src = sources;
    cargoSha256 = "08amg9j18asj2c4s21nx7ryjrp06jqzjif0xdsywrg8lbqjnbbv3";
    buildInputs = lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ];
    nativeBuildInputs = [
      pkgconfig
      openssl
    ];
    checkInputs = [ pkgs.rustfmt ];
    postCheck = ''
      echo "Checking formatting.."
      cargo fmt -- --check
    '';
  };

  readme = pkgs.runCommand "build-readme" { buildInputs = [ hydra-cli ]; } "${buildReadme}";

  tests = {
    readme = pkgs.runCommand "test-readme" { buildInputs = [ hydra-cli ]; } "${verifyReadme}";
    vm = pkgs.callPackage ./tests/vm.nix { inherit hydra-cli; };
  };
}
