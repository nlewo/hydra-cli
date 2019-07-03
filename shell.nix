{ pkgs ? import ./nix/nixpkgs.nix {}
, devBuild ? true
}:

let
  rustChannel = pkgs.latest.rustChannels.stable;
  devRust = [ rustChannel.rust ];
  prodRust = [ pkgs.rustc pkgs.cargo ];
in
  pkgs.mkShell {
    buildInputs = [ 
      pkgs.rustfmt
      pkgs.direnv
      pkgs.pkg-config
      pkgs.openssl
    ] ++ (if devBuild then devRust else prodRust);

  }
