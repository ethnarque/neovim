local group = vim.api.nvim_create_augroup("secretaire-formatting", { clear = true })

local get_augroup = function(client)
	if not Secretaire.formatting.__augroups[client.id] then
		local group_name = "lsp-format-" .. client.name
		local id = vim.api.nvim_create_augroup(group_name, { clear = true })
		Secretaire.formatting.__augroups[client.id] = id
	end

	return Secretaire.formatting.__augroups[client.id]
end

vim.api.nvim_create_user_command("FormatToggle", function()
	Secretaire.formatting.autoformat = not Secretaire.formatting.autoformat
	print("Setting autoformatting to:" .. tostring(Secretaire.formatting.autoformat))
end, {})

Secretaire:enqueue_autocmd(function()
	return vim.api.nvim_create_autocmd({ "BufReadPost" }, {
		group = group,
		callback = function()
			require("conform").setup({
				formatters_by_ft = Secretaire.formatting.filetypes,
			})
		end,
	})
end)

Secretaire:enqueue_autocmd(function()
	return vim.api.nvim_create_autocmd({ "LspAttach" }, {
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

			if client.name == "tsserver" and Secretaire.formatting.filetypes[vim.bo.filetype] == nil then
				return
			end

			vim.api.nvim_create_autocmd("BufWritePre", {
				group = get_augroup(client),
				buffer = bufnr,
				callback = function()
					if not Secretaire.formatting.autoformat then
						return
					end

					if Secretaire.formatting.filetypes[vim.bo.filetype] then
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
end)
