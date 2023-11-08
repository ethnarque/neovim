{
  description = "dotpml's Neovim flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim.url = "github:neovim/neovim/stable?dir=contrib";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ flake-parts, nixpkgs, neovim, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem = { config, pkgs, system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              neovimOverlay
              secretaireOverlay
              secretairePkgOverlay
              (import ./packages/mini-files.nix)
              (import ./packages/mini-pairs.nix)
            ];
          };

          neovimOverlay = prev: final: {
            neovim = neovim.packages.${system}.neovim;
          };

          secretairePkgOverlay = prev: final: {
            secretaire-pkg-nvim = import ./modules/secretaire.nvim { inherit pkgs; };
          };

          secretaireOverlay = prev: final: {
            secretaire-beta = import ./packages/neovim.nix {
              pkgs = pkgs;
            };
          };

        in
        {
          _module.args.pkgs = pkgs;
          formatter = pkgs.nixpkgs-fmt;

          devShells.default = config.devShells.dev;
          devShells.dev = pkgs.mkShell {
            buildInputs = [ pkgs.secretaire-beta pkgs.secretaire-pkg-nvim ];
          };

          packages.default = pkgs.secretaire-beta;

          apps.default = config.apps.stable;
          apps.stable = {
            type = "app";
            program = "${pkgs.secretaire-beta}/bin/nvim";
          };
        };
    };
}
