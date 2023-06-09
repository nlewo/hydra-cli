{ pkgs ? import ./nix/nixpkgs.nix {}
, devBuild ? true
}:

let
  updateCrateDeps = pkgs.writeShellScriptBin "update-crate-deps" ''
    ${pkgs.crate2nix}/bin/crate2nix generate
  '';
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.pkg-config
      pkgs.openssl
      pkgs.rustc
      pkgs.cargo
    ] ++ pkgs.lib.optionals devBuild [
      pkgs.rustfmt
      pkgs.direnv
      pkgs.crate2nix
      updateCrateDeps
    ];
  }
