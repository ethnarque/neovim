{
  lib,
  alejandra,
  nixd,
  vimUtils,
  python3Packages,
  ...
}: let
  dependencies = with python3Packages; [
    alejandra
    nixd
  ];

  module = vimUtils.buildVimPlugin {
    pname = "secretaire-nix";
    version = "0.1";
    src = ./.;
    installPhase = ''
      mkdir -p $out
      cd -r ./* $out
    '';
  };
in {
  inherit dependencies module;
}
