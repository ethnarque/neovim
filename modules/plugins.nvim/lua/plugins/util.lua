local util = require("core.util")
local group = util.augroup("plugins-util")

vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = function()
		util.lazy_load("persistence.nvim")
		require("persistence").setup()
	end,
})
