Secretaire:enqueue_autocmd(function()
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
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
end)

Secretaire:enqueue_autocmd(function()
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
			require("persistence").setup()
		end,
	})
end)
