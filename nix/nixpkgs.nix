{}:

let
  sources = import ./sources.nix;
  nixpkgs = sources.nixpkgs;
  overlay = sources.nixpkgs-mozilla;
  crate2nix = self: super: { crate2nix =  self.callPackage sources.crate2nix {}; };
in
  import nixpkgs { overlays = [ (import overlay) crate2nix ]; }
