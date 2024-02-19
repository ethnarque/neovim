{ eslint_d, prettierd, nodePackages, vimPlugins, ... }:
let
  dependencies = [
    eslint_d
    nodePackages.typescript-language-server
    prettierd
  ];

  packages = with vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.javascript
      p.tsx
      p.typescript
    ]))
  ];
in
{ inherit dependencies packages; }
