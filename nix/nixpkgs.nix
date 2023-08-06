{}:
let
  sources = import ./sources.nix;
  nixpkgs = sources.nixpkgs;
in
  import nixpkgs {  }
