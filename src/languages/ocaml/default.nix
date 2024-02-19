{ ocamlPackages, vimPlugins, ... }:
let
  dependencies = [
    ocamlPackages.ocaml-lsp
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.ocaml
    ]))
  ];
in
{ inherit dependencies packages; }
