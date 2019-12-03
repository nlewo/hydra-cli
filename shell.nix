{ pkgs ? import ./nix/nixpkgs.nix {}
, devBuild ? true
}:

let
  rustChannel = pkgs.latest.rustChannels.stable;
  devRust = [ rustChannel.rust ];
  prodRust = [ pkgs.rustc pkgs.cargo ];
  updateCrateDeps = pkgs.writeScriptBin "update-crate-deps" ''
    #!/bin/sh
    # We need recent patches due to the crate renaming feature
    nix run -f https://github.com/kolloch/crate2nix/archive/277fe73f64d1ed71051cddaaece1b19319020229.tar.gz -c crate2nix generate -n "<nixpkgs>" -f ./Cargo.toml -o Cargo.nix
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
