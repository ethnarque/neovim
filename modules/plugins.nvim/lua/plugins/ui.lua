local util = require("core.util")
local group = util.augroup("plugins-ui")

--- Dev icons
vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		util.lazy_load("nvim-web-devicons")
	end,
})

--- Dashboard
vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		util.lazy_load("dashboard-nvim")
		util.lazy_load("persistence.nvim")

		require("persistence").setup()

		local opts = {
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " Restore Session",
						group = "DiagnosticHint",
						action = 'lua require("persistence").load()',
						key = "s",
					},

					{
						desc = "Quit",
						group = "DiagnosticHint",
						action = "qa",
						key = "q",
					},
				},
			},
		}

		require("dashboard").setup(opts)
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		vim.cmd("packadd lualine.nvim")

		require("lualine").setup({
			options = {
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",
			},
		})
	end,
})
