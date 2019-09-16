{}:

let
  nixpkgs = (import ./sources.nix).nixpkgs;
  overlay = (import ./sources.nix).nixpkgs-mozilla;
in
  import nixpkgs { overlays = [ (import overlay) ]; }
