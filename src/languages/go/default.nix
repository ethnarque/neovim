{ gopls, vimPlugins, ... }:
let
  dependencies = [
    gopls
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.go
    ]))
  ];
in
{ inherit dependencies packages; }
