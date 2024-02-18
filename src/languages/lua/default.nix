{ lua-language-server, stylua, vimPlugins, ... }:
let
  dependencies = [
    lua-language-server
    stylua
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.lua
    ]))
  ];
in
{ inherit dependencies packages; }
