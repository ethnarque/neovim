{ lib
, modules ? [ ]
, neovim-unwrapped
, vimPlugins
, wrapNeovim
, ...
}:
with lib;
let
  #deps = with args.pkgs; modules.core.dependencies ++ modules.nix.dependencies ++ modules.lua.dependencies;
  deps = concatMap (x: x.dependencies) modules;

  packages = concatMap (x: x.packages) (lib.filter (x: builtins.hasAttr "packages" x) modules);

  runtimepathList = concatStringsSep "\n"
    (map (x: ''lua vim.opt.runtimepath:append "${x.module}"'') modules);

  requireList = concatStringsSep "\n"
    (map (x: ''lua require "${x.module.pname}"'') modules);

  customRC = concatStringsSep "\n" [
    runtimepathList
    ''lua require "secretaire"''
    requireList
    ''lua require "secretaire":start()''
  ];

in
wrapNeovim neovim-unwrapped {
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
