local util = require("core.util")
local group = util.augroup("plugin-utility")

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		util.lazy_load("persistence.nvim")
		require("persistence").setup()
	end,
})
