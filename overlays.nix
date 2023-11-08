final: prev: {
  neovim = import ./packages/neovim.nix { pkgs = final; };

  vimPlugins = prev.vimPlugins // {
    mini-files-nvim = import ./packages/mini-files.nix { pkgs = final; };
    mini-pairs-nvim = import ./packages/mini-files.nix { pkgs = final; };
  };
}
