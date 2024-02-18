{ nodePackages, vimPlugins, ... }:
let
  dependencies = [
    nodePackages.vscode-langservers-extracted
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.json
    ]))
  ];
in
{ inherit dependencies packages; }
