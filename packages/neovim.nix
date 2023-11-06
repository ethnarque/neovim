{ pkgs }:
let
  customRC = import ../custom-rc.nix { inherit pkgs; };
  dependencies = import ../dependencies.nix { inherit pkgs; };
in
pkgs.wrapNeovim pkgs.neovim-unwrapped {
  viAlias = true;
  vimAlias = true;
  withPython3 = false;
  withNodeJs = false;
  withRuby = false;
  extraMakeWrapperArgs = ''--prefix PATH : "${pkgs.lib.makeBinPath dependencies}"'';
  configure = {
    inherit customRC;
    packages.core.start = with pkgs.vimPlugins;[
      plenary-nvim
      # Greeter
      alpha-nvim
      persistence-nvim

      # Fuzzy finder
      telescope-nvim

      # LSP
      nvim-lspconfig
      neodev-nvim
      fidget-nvim

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-emoji
      cmp-nvim-lsp-signature-help
      cmp-npm
      luasnip
      cmp_luasnip

      # Misc
      vim-sleuth
      lspkind-nvim
      nvim-web-devicons
      lualine-nvim

      pkgs.secretaire-pkg-nvim
      mini-files-nvim

    ];
    packages.core.opt = with pkgs.vimPlugins; [
      comment-nvim
      nvim-dap
      nvim-dap-ui

      which-key-nvim
      toggleterm-nvim


      nvim-treesitter.withAllGrammars # better code coloring
      playground
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-treesitter-parsers.comment
    ];
  };
}
