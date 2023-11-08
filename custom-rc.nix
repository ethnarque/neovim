{ pkgs ? import <nixpkgs> { } }:

let
  core-nvim = pkgs.stdenv.mkDerivation {
    name = "core-nvim";
    src = ./modules/core.nvim;
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
    '';
  };
in
''
  lua vim.opt.runtimepath:append("${core-nvim}")
  lua require "core"
  luafile ~/.config/nvim/init.lua
''
