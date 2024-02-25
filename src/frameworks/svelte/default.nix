{ nodePackages, vimPlugins, ... }:
let
  dependencies = [
    nodePackages.svelte-language-server
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.svelte
    ]))
  ];
in
{ inherit dependencies packages; }
