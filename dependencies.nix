{ pkgs }: with pkgs;[
  fzy
  ripgrep
  git
  curl

  # Lsp
  gopls
  lua-language-server
  nixd
  # node2nixPackages."dockerfile-language-server-nodejs"
  nodePackages."@astrojs/language-server"
  nodePackages."@tailwindcss/language-server"
  nodePackages."@volar/vue-language-server"
  nodePackages.svelte-language-server
  nodePackages.typescript-language-server
  nodePackages.vscode-langservers-extracted
  ocamlPackages.ocaml-lsp
  yaml-language-server

  # Formatter
  nixpkgs-fmt
  # node2nixPackages."@fsouza/prettierd"
  # node2nixPackages."blade-formatter"
  stylua

]
