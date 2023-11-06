{ pkgs ? import <nixpkgs> { } }:

let
  secretaire-nvim = pkgs.stdenv.mkDerivation {
    name = "secretaire-nvim";
    src = ./modules/secretaire.nvim;
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
    '';
  };
in
''
  lua vim.opt.runtimepath:append("${secretaire-nvim}")
  lua require "secretaire"
  luafile ~/.config/nvim/init.lua
''
