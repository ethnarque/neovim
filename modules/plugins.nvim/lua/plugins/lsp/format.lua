local util = require("core.util")
local formatters = require("plugins.lsp.formatters")
local is_enabled = true

util.lazy_load("conform.nvim")
require("conform").setup({ formatters_by_ft = formatters })

vim.api.nvim_create_user_command("FormatToggle", function()
	is_enabled = not is_enabled
	print("Setting autoformatting to:" .. tostring(is_enabled))
end, {})

local _augroups = {}
local get_augroup = function(client)
	if not _augroups[client.id] then
		local group_name = "lsp-format-" .. client.name
		local id = vim.api.nvim_create_augroup(group_name, { clear = true })
		_augroups[client.id] = id
	end

	return _augroups[client.id]
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
	callback = function(args)
		local client_id = args.data.client_id
		local client = vim.lsp.get_client_by_id(client_id)
		local bufnr = args.buf

		if not client then
			return
		end

		if not client.server_capabilities.documentFormattingProvider then
			return
		end

		if client.name == "tsserver" and formatters[vim.bo.filetype] == nil then
			return
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = get_augroup(client),
			buffer = bufnr,
			callback = function()
				if not is_enabled then
					return
				end

				if formatters[vim.bo.filetype] then
					require("conform").format()
				else
					vim.lsp.buf.format({
						async = false,
						filter = function(c)
							return c.id == client.id
						end,
					})
				end
			end,
		})
	end,
})
