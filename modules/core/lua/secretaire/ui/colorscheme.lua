_G.Secretaire.ui = {}

---@type "Linux" | "Darwin"
local system

system = vim.loop.os_uname().sysname

if system == "Linux" and os.getenv("XDG_CURRENT_DESKTOP") == "" then
	require("rose-pine").setup({
		groups = {
			background = "#101010",
		},
		highlight_groups = {
			WinSeparator = { fg = "#1A1A1A" },
			EndOfBuffer = { fg = "#101010" },
		},
	})
	vim.cmd("colorscheme rose-pine-main")
else
	require("auto-dark-mode").setup({
		update_interval = 1000,
		set_dark_mode = function()
			require("rose-pine").setup({
				groups = {
					background = "#101010",
				},
				highlight_groups = {
					WinSeparator = { fg = "#1A1A1A" },
					EndOfBuffer = { fg = "#101010" },
				},
			})
			vim.cmd("colorscheme rose-pine-main")
		end,
		set_light_mode = function()
			require("rose-pine").setup({
				groups = {
					background = "base",
				},
				highlight_groups = {
					WinSeparator = { fg = "base" },
					EndOfBuffer = { fg = "base" },
				},
			})
			vim.cmd("colorscheme rose-pine-dawn")
		end,
	})
end
