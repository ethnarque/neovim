local util = require("core.util")
local icon = require("core.icons")
local capabitilies = require("plugins.lsp.capabitilies")
local on_attach = require("plugins.lsp.on_attach")

local group = util.augroup("plugin-lsp")

require("plugins.lsp.format")

vim.api.nvim_create_autocmd("BufReadPre", {
	group = group,
	callback = function()
		util.lazy_load("nvim-lspconfig")
		util.lazy_load("neodev.nvim")
		util.lazy_load("fidget.nvim")

		local diagnostics = { "Error", "Warn", "Hint", "Info" }

		require("neodev").setup()
		require("fidget").setup()

		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
		})

		for _, v in ipairs(diagnostics) do
			vim.fn.sign_define(string.format("DiagnosticSign%s", v), { text = icon.diagnostic[v] })
		end

		for server_name, server_config in pairs(require("plugins.lsp.servers")) do
			local o = {}

			if type(o.capabilities) == "function" then
				o.capabilities(capabitilies)
			else
				o.capabilities = capabitilies
			end

			if type(o.on_attach) == "function" then
				o.on_attach(on_attach)
			else
				o.on_attach = on_attach
			end

			o = vim.tbl_extend("force", server_config, o, {})
			require("lspconfig")[server_name].setup(o)
		end
	end,
})
