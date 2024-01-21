{
  lib,
  python312Packages,
  ruff,
  vimUtils,
  ...
}: let
  dependencies = with python312Packages; [
    ruff-lsp
    ruff
  ];

  modules = vimUtils.buildVimPlugin {
    name = "";
  };
in {
  inherit dependencies modules;
}
