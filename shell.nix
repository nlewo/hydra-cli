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
      pkgs.rustfmt
      pkgs.direnv
      pkgs.pkg-config
      pkgs.openssl
      pkgs.carnix
      pkgs.mdsh
      updateCrateDeps
    ] ++ (if devBuild then devRust else prodRust);

  }
