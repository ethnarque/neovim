{ nodePackages, shfmt, vimPlugins, ... }:
let
  dependencies = [
    nodePackages.bash-language-server
    shfmt
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.bash
    ]))
  ];
in
{ inherit dependencies packages; }
