{ pkgs }:
let
  customRC = import ../customrc.nix { inherit pkgs; };
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
      nvim-cmp # generic autocompleter
      cmp-nvim-lsp # use lsp as source for completions
      cmp-nvim-lua # makes vim config editing better with completions
      cmp-buffer # any text in open buffers
      cmp-path # complete paths
      cmp-cmdline # completing in :commands
      cmp-emoji # complete :emojis:
      cmp-nvim-lsp-signature-help # help complete function call by showing args
      cmp-npm # complete node packages in package.json
      luasnip # snippets driver
      cmp_luasnip # snippets completion

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
