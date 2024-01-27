{ callPackage
, lib
, neovim-nightly
, neovim-unwrapped
, vimPlugins
, wrapNeovim
, modules ? [ ]
, package ? null
, ...
}:
with lib;
let
  m = map (path: callPackage path { }) modules;

  deps = concatMap (x: x.dependencies) m;

  packages = concatMap (x: x.packages) (lib.filter (x: builtins.hasAttr "packages" x) m);

  runtimepathList = concatStringsSep "\n"
    (map (x: ''lua vim.opt.runtimepath:append "${x.module}"'') m);

  requireList = concatStringsSep "\n"
    (map (x: let in ''lua require "${x.module.pname}"'') m);

  customRC = concatStringsSep "\n" [
    runtimepathList
    ''lua require "secretaire"''
    requireList
    ''lua require "secretaire":start()''
  ];
in
wrapNeovim (if (package != null) then package else neovim-unwrapped) {
  viAlias = true;
  vimAlias = true;
  withPython3 = false;
  withNodeJs = false;
  withRuby = false;

  extraMakeWrapperArgs = ''--prefix PATH : ""${lib.makeBinPath deps}'';

  configure = {
    inherit customRC;
    packages.core.start = packages;
  };
}
