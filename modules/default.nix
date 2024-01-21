{
  lib,
  pkgs,
  ...
}: let
  callPackage = lib.callPackageWith (pkgs // modules);
  modules = {
    core = callPackage ./core {};
    nix = callPackage ./nix {};
  };
in
  modules
