{ pkgs ? import <nixpkgs> { } }:
pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "secretaire-nvim";
  version = "0.1.0";
  src = ./.;
  installPhase = ''
    mkdir -p $out
    cd -r ./* $out/
  '';
}
