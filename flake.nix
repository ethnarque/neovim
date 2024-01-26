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
        nixpkgs.lib.genAttrs systems (
          system:
          function (
            let
              n = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
                overlays = [
                  # inputs.neovim-nightly.overlay
                  # (import ./overlays.nix)
                  # (import ./modules/core.nvim)
                  # (import ./modules/plugins.nvim)
                ];
              };
            in
            n
          )
        );
    in
    {
      # packages = forAllSystems (pkgs: {
      #   default = pkgs.neovim;
      # });

      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      # apps = forAllSystems (pkgs: {
      #   default = {
      #     type = "app";
      #     program = "${pkgs.neovim}/bin/nvim";
      #   };
      # });

      devShells = forAllSystems (pkgs: import ./dev-shells.nix { inherit pkgs; });
    };
}
