{pkgs, ...}: let
  modules = pkgs.callPackage ./modules {};
in {
  default = pkgs.mkShell {
    buildInputs = [
      (pkgs.callPackage ./neovim.nix {
        inherit pkgs;
        dependencies = [];
        packages = [
          # modules.nix.module
        ];
        # modules = with pkgs; [
        #   secretaire.nix
        #   secretaire.lua
        # ];
      })
    ];
  };
}
