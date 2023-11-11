{ pkgs }:
''
  lua vim.opt.runtimepath:append("${pkgs.core-nvim}")
  lua vim.opt.runtimepath:append("${pkgs.core-plugins-nvim}")
  lua require "core"
  luafile ~/.config/nvim/init.lua
  lua require "plugins"
''
