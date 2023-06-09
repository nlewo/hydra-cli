{ pkgs ? import ./nix/nixpkgs.nix {}
, devBuild ? true
}:

let
  rustChannel = pkgs.latest.rustChannels.stable;
  devRust = [ rustChannel.rust ];
  prodRust = [ pkgs.rustc pkgs.cargo ];
  updateCrateDeps = pkgs.writeShellScriptBin "update-crate-deps" ''
    ${pkgs.crate2nix}/bin/crate2nix generate
  '';
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.pkg-config
      pkgs.openssl
      (if devBuild then devRust else prodRust)
    ] ++ pkgs.lib.optionals devBuild [
      pkgs.rustfmt
      pkgs.direnv
      updateCrateDeps
    ];
  }
