_G.Secretaire.lsp = {
	servers = {},
}

local icons = require("secretaire.ui.icons")
local capabitilies = require("secretaire.utils.lsp").get_capabilities()
local on_attach = require("secretaire.utils.lsp").on_attach

local state = _G.Secretaire.lsp
local group = vim.api.nvim_create_augroup("secretaire-lsp", { clear = true })

Secretaire:register(function()
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufNewFile" }, {
		group = group,
		once = true,
		callback = function()
			local diagnostics = { "Error", "Warn", "Hint", "Info" }

			require("neodev").setup({})
			require("fidget").setup({})

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
				vim.fn.sign_define(string.format("DiagnosticSign%s", v), {
					text = icons.diagnostic[v],
				})
			end

			for server_name, server_config in pairs(state.servers) do
				local opts = {}

				if type(opts.capabilities) == "function" then
					opts.capabilities(capabitilies)
				else
					opts.capabilities = capabitilies
				end

				if type(opts.on_attach) == "function" then
					opts.on_attach(on_attach)
				else
					opts.on_attach = on_attach
				end

				opts = vim.tbl_extend("force", server_config, opts, {})
				require("lspconfig")[server_name].setup(opts)
			end
		end,
	})
end)
