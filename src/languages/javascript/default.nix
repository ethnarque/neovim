{ eslint_d, prettierd, vimPlugins, ... }:
let
  dependencies = [
    eslint_d
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
