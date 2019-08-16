{ pkgs ? import ./nix/nixpkgs.nix {}
, devBuild ? true
}:

let
  rustChannel = pkgs.latest.rustChannels.stable;
  devRust = [ rustChannel.rust ];
  prodRust = [ pkgs.rustc pkgs.cargo ];
  updateCrateDeps = pkgs.writeScriptBin "update-crate-deps" ''
    #!/bin/sh
    ${pkgs.carnix}/bin/carnix generate-nix --src .
  '';
in
  pkgs.mkShell {
    buildInputs = [ 
      pkgs.pkg-config
      pkgs.openssl
      (if devBuild then devRust else prodRust)
    ] ++ pkgs.stdenv.lib.optionals devBuild [
      pkgs.rustfmt
      pkgs.direnv
      pkgs.carnix
      updateCrateDeps
    ];
  }
