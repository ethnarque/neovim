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

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ]
      (
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
  in {
    # packages = forAllSystems (pkgs: {
    #   default = pkgs.neovim;
    # });

    formatter = forAllSystems (pkgs: pkgs.alejandra);

    # apps = forAllSystems (pkgs: {
    #   default = {
    #     type = "app";
    #     program = "${pkgs.neovim}/bin/nvim";
    #   };
    # });

    devShells = forAllSystems (pkgs: import ./dev-shells.nix {inherit pkgs;});
  };
}
