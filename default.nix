let
  pkgs = import ./nix/nixpkgs.nix {};

in
rec {

  hydra-cli = pkgs.callPackage ./package.nix {};
  test = pkgs.callPackage ./tests/vm.nix { inherit hydra-cli; };
}
