{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    crate2nix = {
      url = "github:kolloch/crate2nix";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, crate2nix, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        crateName = "hydra-cli";

        inherit (import "${crate2nix}/tools.nix" { inherit pkgs; })
          generatedCargoNix;

        project = pkgs.callPackage (generatedCargoNix {
          name = crateName;
          src = ./.;
        }) {
          defaultCrateOverrides = pkgs.defaultCrateOverrides // {
            # Crate dependency overrides go here
          };
        };

      in {
        packages.${crateName} = project.rootCrate.build;

        defaultPackage = self.packages.${system}.${crateName};

        devShell = pkgs.mkShell {
          inputsFrom = builtins.attrValues self.packages.${system};
          buildInputs = [ pkgs.cargo pkgs.rust-analyzer pkgs.clippy ];
        };
      });
}

