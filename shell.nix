{ nixpkgs ? (import ./nix/sources.nix).nixpkgs
, overlay ? (import ./nix/sources.nix).nixpkgs-mozilla
}:

let
  nixpkgs-mozilla = import (builtins.fetchTarball (overlay.url));
  pkgs = import nixpkgs { overlays = [ nixpkgs-mozilla ]; };
  rustChannel = pkgs.latest.rustChannels.stable;
  rustChannelNightly = pkgs.latest.rustChannels.nightly;
in
  pkgs.mkShell {
    buildInputs = [ 
      rustChannel.rust
      pkgs.rustfmt
      pkgs.direnv
      pkgs.pkg-config
      pkgs.openssl
    ];

  }
