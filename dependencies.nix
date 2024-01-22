        {pkgs}:
            with pkgs; [
  fzy
  ripgrep
  git
  curl
  nodejs

  # Lsp
  dockerfile-language-server-nodejs
  emmet-ls
  gopls
  lua-language-server
  nixd
  nodePackages."@astrojs/language-server"
  nodePackages."@tailwindcss/language-server"
  nodePackages."@volar/vue-language-server"
  nodePackages.svelte-language-server
  nodePackages.typescript-language-server
  nodePackages.vscode-langservers-extracted
  ocamlPackages.ocaml-lsp
  phpactor
  rust-analyzer
  yaml-language-server

  # Formatter
  isort
  black
  alejandra
  nixpkgs-fmt
  nodePackages.prettier
  prettierd
  stylua
]
