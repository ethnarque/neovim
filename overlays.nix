final: prev: {
  neovim = import ./packages/neovim.nix { pkgs = final; };

  rustywind = import ./packages/rustywind.nix { pkgs = final; };

  vimPlugins = prev.vimPlugins // {
    mini-files-nvim = import ./packages/mini-files.nix { pkgs = final; };
    mini-indentscope = import ./packages/mini-indentscope.nix { pkgs = final; };
    mini-pairs-nvim = import ./packages/mini-pairs.nix { pkgs = final; };
  };
}
