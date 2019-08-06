{}:

let
  sources = import ./sources.nix;
  nixpkgs = sources.nixpkgs;
  overlay = sources.nixpkgs-mozilla;
  naersk = sources.naersk;
  mdsh    = (import ./mdsh.nix);
in
import nixpkgs { overlays =
  [ (import overlay)
    (_: _: { inherit sources; })
    (self: super: { naersk = super.callPackage naersk {}; })
    mdsh
  ];
}
