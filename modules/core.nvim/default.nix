{ pkgs ? import <nixpkgs> { } }:
pkgs.vimUtils.buildVimPlugin {
  pname = "core-nvim";
  version = "0.1.0";
  src = ./.;
  installPhase = ''
    mkdir -p $out
    cd -r ./* $out/
  '';
}
