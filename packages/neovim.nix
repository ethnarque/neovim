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

      # Fuzzy finder

      # Misc
      vim-sleuth
      lspkind-nvim
      lualine-nvim

      pkgs.core-nvim
      pkgs.core-plugins-nvim
      catppuccin-nvim
      rose-pine
      auto-dark-mode-nvim
      oxocarbon-nvim

      nvim-web-devicons
    ];
    packages.core.opt = with pkgs.vimPlugins; [
      # Autocompletion
      # LSP
      nvim-lspconfig
      neodev-nvim
      fidget-nvim
      # Formatter
      conform-nvim
      comment-nvim
      nvim-dap
      nvim-dap-ui

      mini-files-nvim
      mini-pairs-nvim

      which-key-nvim
      toggleterm-nvim
      # Treesitter
      nvim-treesitter.withAllGrammars # better code coloring
      playground
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-treesitter-parsers.comment
      nvim-ts-autotag


      dashboard-nvim
      persistence-nvim

      telescope-nvim
    ];
  };
}
