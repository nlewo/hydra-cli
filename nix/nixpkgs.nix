{}:

let
  nixpkgs = (import ./sources.nix).nixpkgs;
  overlay = (import ./sources.nix).nixpkgs-mozilla;
  nixpkgs-mozilla = import (builtins.fetchTarball (overlay.url));
in
  import nixpkgs { overlays = [ nixpkgs-mozilla ]; }
