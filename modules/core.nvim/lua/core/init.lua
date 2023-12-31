-- local util = require("core.util")
--- Colorscheme
-- util.lazy_load("givre.nvim")
-- require("givre").setup()

require("core.autocmds")
require("core.opts")
require("core.keybindings")

local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		require("rose-pine").setup({
			groups = {
				background = "#101010",
			},
		})
		vim.cmd("colorscheme rose-pine-main")
	end,
	set_light_mode = function()
		require("rose-pine").setup({
			groups = {
				background = "base",
			},
		})
		vim.cmd("colorscheme rose-pine-dawn")
	end,
})
