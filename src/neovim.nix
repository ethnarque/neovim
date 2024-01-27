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

  dependencies = makeBinPath (concatMap (x: x.dependencies) m);

  packages = concatMap (x: x.packages) (lib.filter (x: builtins.hasAttr "packages" x) m);

  secretaireRtp = concatStringsSep "\n"
    (map (x: ''vim.opt.runtimepath:append "${x.module}"'') m);

  secretaireModules = concatStringsSep "\n"
    (map (x: let in ''require "${x.module.pname}"'') m);


  customRC = ''
    lua << EOF
        ${secretaireRtp}
        require("secretaire")
        ${secretaireModules}
        require("secretaire"):start()
    EOF
  '';
in
wrapNeovim (if (package != null) then package else neovim-unwrapped) {
  viAlias = true;
  vimAlias = true;
  withPython3 = false;
  withNodeJs = false;
  withRuby = false;

  extraMakeWrapperArgs = ''--prefix PATH : ""${dependencies}'';

  configure = {
    inherit customRC;
    packages.core.start = packages;
  };
}
