{ pkgs ? import <nixpkgs> { } }:

let
  secretaire-nvim = pkgs.stdenv.mkDerivation {
    name = "secretaire-nvim";
    src = ./modules;
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
    '';
  };

  secretaire-pkg-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "secretaire-pkg.nvim";
    version = "0.7.0";
    src = ./modules { };
    installPhase = ''
      	  mkdir -p $out
      	  cp -r ./* $out/
      	'';
  };
in
''
  lua vim.opt.runtimepath:append("${secretaire-nvim}")
  lua require "secretaire"
  lua require "core"

  luafile ~/.config/nvim/init.lua
''
