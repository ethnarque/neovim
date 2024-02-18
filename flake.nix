{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:inclyc/flake-compat";
      flake = false;
    };
  };

  outputs = inputs @ { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      forAllSystems = function:
        (nixpkgs.lib.genAttrs systems
          (system: function
            (
              let
                pkgs = import nixpkgs {
                  inherit system;
                  config.allowUnfree = true;
                  overlays = [
                    (final: prev: {
                      inherit (inputs.neovim-nightly.overlay final prev) neovim-nightly;
                    })
                  ];
                };
              in
              { inherit pkgs system; }
            )
          ));
    in
    {

      formatter = forAllSystems ({ pkgs, ... }: pkgs.nixpkgs-fmt);

      packages = forAllSystems ({ pkgs, system }: rec {
        secretaire = pkgs.callPackage ./src/neovim.nix {
          modules = [
            ./src/core
            ./src/languages/bash
            ./src/languages/css
            ./src/languages/go
            ./src/languages/html
            ./src/languages/javascript
            ./src/languages/json
            ./src/languages/lua
            ./src/languages/nix
            ./src/languages/ocaml
            ./src/languages/python
            ./src/languages/rust
          ];
        };

        default = secretaire;

        nightly = secretaire.override {
          package = pkgs.neovim-unwrapped;
          modules = self.packages.${system}.default.modules;
        };

        server = pkgs.callPackage ./src/neovim.nix {
          modules = [
            ./src/core
            ./src/languages/bash
            ./src/languages/json
            ./src/languages/lua
            ./src/languages/nix
            ./src/languages/python
          ];
        };
      });

      apps = forAllSystems ({ pkgs, ... }: {
        default = {
          type = "app";
          programs = "${self.packages.default}/bin/nvim";
        };

        nightly = {
          type = "app";
          programs = "${self.packages.nightly}/bin/nvim";
        };

        server = {
          type = "app";
          programs = "${self.packages.server}/bin/nvim";
        };
      });

      devShells = forAllSystems ({ pkgs, system }: {
        default = pkgs.mkShell {
          packages = [ self.packages.${system}.default ];
        };

        nightly = pkgs.mkShell {
          packages = [ self.packages.${system}.nightly ];
        };

        server = pkgs.mkShell {
          packages = [ self.packages.${system}.server ];
        };
      });
    };
}
