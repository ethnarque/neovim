{ nixd, nixpkgs-fmt, vimPlugins, ... }:
let
  dependencies = [
    nixd
    nixpkgs-fmt
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.nix
    ]))
  ];
in
{ inherit dependencies packages; }
