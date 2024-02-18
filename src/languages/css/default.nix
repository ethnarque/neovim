{ nodePackages, vimPlugins, ... }:
let
  dependencies = [
    nodePackages.vscode-css-languageserver-bin
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.css
    ]))
  ];
in
{ inherit dependencies packages; }
