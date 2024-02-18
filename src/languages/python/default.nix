{ black, python3Packages, ruff, vimPlugins, ... }:
let
  dependencies = [
    python3Packages.python-lsp-server
    ruff
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.python
    ]))
  ];
in
{ inherit dependencies packages; }
