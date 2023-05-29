{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    crate2nix = {
      url = "github:kolloch/crate2nix";
      flake = false;
    };
    flakeu.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, crate2nix, flakeu }:
    flakeu.lib.eachSystem [flakeu.lib.system.x86_64-linux] (system:
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
        packages = rec {
          hydra-cli = project.rootCrate.build;
          default = hydra-cli;
        };

        apps = rec {
          hydra-cli = flakeu.lib.mkApp { drv = self.packages.${system}.${crateName}; };
          default = hydra-cli;
        };

        legacyPackages = nixpkgs.legacyPackages.${system};

        devShells = rec {
          hydra-cli = pkgs.mkShell {
            inputsFrom = builtins.attrValues self.packages.${system};
            buildInputs = [ pkgs.cargo pkgs.rust-analyzer pkgs.clippy ];
          };
          default = hydra-cli;
        };
        checks = {
          vm = pkgs.callPackage ./tests/vm.nix { hydra-cli = self.packages.${system}.${crateName}; };
        };
      });
}

