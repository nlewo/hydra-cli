{ pkgs ? import ./nix/nixpkgs.nix {}
, devBuild ? true
}:

let
  rustChannel = pkgs.latest.rustChannels.stable;
  devRust = [ rustChannel.rust ];
  prodRust = [ pkgs.rustc pkgs.cargo ];
  updateCrateDeps = pkgs.writeScriptBin "update-crate-deps" ''
    #!/bin/sh
    nix-shell https://github.com/kolloch/crate2nix/tarball/master --run \
    'crate2nix generate -n "<nixpkgs>" -f ./Cargo.toml -o Cargo.nix'
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
      updateCrateDeps
    ];
  }
