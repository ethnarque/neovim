{ pkgs ? import <nixpkgs> { } }:

let
  core-nvim = pkgs.stdenv.mkDerivation {
    name = "core-nvim";
    src = ./modules;
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
    '';
  };

  core-pkg-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "core-pkg.nvim";
    version = "0.7.0";
    src = ./modules { };
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
