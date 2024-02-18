{ callPackage
, lib
, neovim-unwrapped
, vimPlugins
, wrapNeovim
, modules ? [ ]
, package ? null
, ...
}:
let
  inherit (lib)
    concatMap
    concatStringsSep
    filter
    makeBinPath;

  m = map (path: callPackage path { }) modules;

  customRC = ''
    lua << EOF
        ${concatStringsSep "\n"
            (map
                (mod: ''vim.opt.runtimepath:append "${mod.luaModule}"'')
                (filter (mod: builtins.hasAttr "luaModule" mod) m))}

        ${concatStringsSep "\n"
            (map
                (mod: ''require "${mod.luaModule.pname}"'')
                (filter (mod: builtins.hasAttr "luaModule" mod) m))}
    EOF

    luafile ~/.config/nvim/init.lua
  '';

  dependencies = makeBinPath (concatMap (x: x.dependencies) m);

  vimPlugins = concatMap (x: x.packages) (filter (x: builtins.hasAttr "packages" x) m);
in
wrapNeovim (if (package != null) then package else neovim-unwrapped) {
  viAlias = true;
  vimAlias = true;
  withPython3 = false;
  withNodeJs = false;
  withRuby = false;

  extraMakeWrapperArgs = ''--prefix PATH : "${dependencies}"'';

  configure = {
    inherit customRC;
    packages.core.start = vimPlugins;
  };
}
