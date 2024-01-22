{
  lib,
  lua-language-server,
  stylua,
  vimUtils,
  ...
}: let
  dependencies = [
    lua-language-server
    stylua
  ];

  module = vimUtils.buildVimPlugin {
    pname = "secretaire-lua";
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
