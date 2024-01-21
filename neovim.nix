{
  callPackage,
  dependencies ? [],
  lib,
  neovim-unwrapped,
  packages ? [],
  vimPlugins,
  wrapNeovim,
  ...
} @ args
: let
  deps = with args.pkgs; dependencies ++ modules.core.dependencies ++ modules.nix.dependencies;
  modules = callPackage ./modules {};
in
  wrapNeovim neovim-unwrapped {
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withNodeJs = false;
    withRuby = false;

    extraMakeWrapperArgs = ''--prefix PATH : ""${lib.makeBinPath deps}'';

    configure = {
      customRC = ''
        lua vim.opt.runtimepath:append("${modules.core.module}")
        lua vim.opt.runtimepath:append("${modules.nix.module}")

        lua require "secretaire.core"
      '';

      packages.core.start = with vimPlugins;
        [
          rose-pine
          plenary-nvim

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
          lspkind-nvim
          nvim-web-devicons

          nvim-lspconfig

          # Treesitter
          nvim-treesitter.withAllGrammars # better code coloring
          playground
          nvim-treesitter-textobjects
          nvim-treesitter-context
          nvim-treesitter-parsers.comment
          nvim-ts-autotag
        ]
        ++ packages
        ++ modules.core.packages;
    };
  }
