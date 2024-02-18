{ vimPlugins, ... }:
let
  dependencies = [ ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.ocaml
    ]))
  ];
in
{ inherit dependencies packages; }
