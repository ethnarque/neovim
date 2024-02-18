{ rust-analyzer, vimPlugins, ... }:
let
  dependencies = [
    rust-analyzer
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.rust
    ]))
  ];
in
{ inherit dependencies packages; }
