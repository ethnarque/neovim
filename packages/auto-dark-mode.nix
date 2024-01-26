{ pkgs }:
pkgs.vimUtils.buildVimPlugin {
  pname = "auto-dark-mode.nvim";
  version = "0.10.0";
  src = pkgs.fetchFromGitHub {
    owner = "f-person";
    repo = "auto-dark-mode.nvim";
    rev = "76e8d40d1e1544bae430f739d827391cbcb42fcc";
    hash = "sha256-uJ4LxczgWl4aQCFuG4cR+2zwhNo7HB6R7ZPTdgjvyfY=";
  };
  meta.homepage = " https://github.com/f-person/auto-dark-mode.nvim";
}
