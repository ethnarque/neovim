{ nodePackages, vimPlugins, ... }:
let
  dependencies = [
    nodePackages.vscode-langservers-extracted
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.html
    ]))
  ];
in
{ inherit dependencies packages; }
