require("secretaire.global")

require("secretaire.opts")
require("secretaire.navigation")
require("secretaire.completion")
require("secretaire.treesitter")
require("secretaire.editor")
require("secretaire.keybindings")
require("secretaire.dashboard")

vim.cmd([[ colorscheme rose-pine-main ]])
require("fidget").setup()
require("neodev").setup()
local lspconfig = require("lspconfig")

lspconfig.nixd.setup({})

-- core.lsp.servers = function(servers)
-- 	servers.nixd.setup = {}
-- end
--
--
-- core.register()

lspconfig.lua_ls.setup({})

require("conform").setup({ formatters_by_ft = {
	lua = { "stylua" },
	nix = { "alejandra" },
} })
-- require("core.autocmds")
-- require("core.keybindings")

local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
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
