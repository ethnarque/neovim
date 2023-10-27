{ pkgs }: [
  (import ./mini-files.nix { inherit pkgs; })
  (import ./neovim.nix { inherit pkgs; })
]
