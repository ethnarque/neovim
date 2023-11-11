-- local util = require("core.util")
--- Colorscheme
-- util.lazy_load("givre.nvim")
require("givre").setup()
vim.cmd("colorscheme givre-dark")

require("core.autocmds")
require("core.opts")
require("core.keybindings")
