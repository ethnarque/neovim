{
  alejandra,
  curl,
  fetchFromGitHub,
  fzy,
  git,
  lib,
  lua-language-server,
  nixd,
  ripgrep,
  stylua,
  vimPlugins,
  vimUtils,
  ...
}: let
  module = vimUtils.buildVimPlugin {
    pname = "secretaire-core";
    version = "0.1";
    src = ./.;
    installPhase = ''
      mkdir -p $out
      cd -r ./* $out
    '';
  };

  dependencies = [
    # nodejs
    curl
    fzy
    ripgrep
    git
    # minimal lsp
    lua-language-server
    nixd
    # minimal formatters
    stylua
    alejandra
  ];

  packages = with vimPlugins; [
    plenary-nvim
    # fuzzy find search
    telescope-nvim
    #mini-files-nvim
    # lsp
    nvim-lspconfig
    neodev-nvim
    # formatters
    conform-nvim
    # auto completion and snippets
    nvim-cmp
    cmp-nvim-lsp
    cmp-nvim-lua
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-emoji
    cmp-nvim-lsp-signature-help
    cmp-npm
    cmp_luasnip
    luasnip
    friendly-snippets

    which-key-nvim
    # ui
    fidget-nvim
    # assets
    nvim-web-devicons
    lspkind-nvim
    rose-pine

    dashboard-nvim
    persistence-nvim

    (vimUtils.buildVimPlugin {
      pname = "mini.files";
      version = "0.10.0";
      src = fetchFromGitHub {
        owner = "echasnovski";
        repo = "mini.files";
        rev = "3f8af5f9e4bbedbacbade760531464c0d679490d";
        hash = "sha256-9Xob5PHO+J4VgE8zDMLiewNO70sXQRXBs2td26yfUZY=";
      };
      meta.homepage = " https://github.com/echasnovski/mini.files ";
    })
    (
      vimUtils.buildVimPlugin {
        pname = "auto-dark-mode.nvim";
        version = "0.10.0";
        src = fetchFromGitHub {
          owner = "f-person";
          repo = "auto-dark-mode.nvim";
          rev = "76e8d40d1e1544bae430f739d827391cbcb42fcc";
          hash = "sha256-uJ4LxczgWl4aQCFuG4cR+2zwhNo7HB6R7ZPTdgjvyfY=";
        };
        meta.homepage = " https://github.com/f-person/auto-dark-mode.nvim";
      }
    )
  ];
in {
  inherit dependencies module packages;
}
