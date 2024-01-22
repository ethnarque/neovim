{
  lib,
  pkgs,
  ...
}: let
  callPackage = lib.callPackageWith (pkgs // modules);
  modules = {
    core = callPackage ./core {};
    lua = callPackage ./lua {};
    nix = callPackage ./nix {};
  };
in
  modules
