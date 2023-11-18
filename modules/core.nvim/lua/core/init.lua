-- local util = require("core.util")
--- Colorscheme
-- util.lazy_load("givre.nvim")
-- require("givre").setup()

require("catppuccin").setup()
vim.cmd("colorscheme catppuccin")
require("core.autocmds")
require("core.opts")
require("core.keybindings")
