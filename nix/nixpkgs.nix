{}:

let
  nixpkgs = (import ./sources.nix).nixpkgs;
  overlay = (import ./sources.nix).nixpkgs-mozilla;
  mdsh    = (import ./mdsh.nix);
in
import nixpkgs { overlays = [ (import overlay) mdsh ]; }
