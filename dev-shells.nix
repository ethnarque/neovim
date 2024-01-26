{ pkgs, ... }:
let
  modules = map (path: pkgs.callPackage path { }) [
    ./modules/core
    ./modules/nix
    ./modules/lua
  ];
in
{
  default = pkgs.mkShell {
    buildInputs = [
      (pkgs.callPackage ./neovim.nix { inherit modules; })
    ];
  };
}
