local group = vim.api.nvim_create_augroup("secretaire-ui-statusline", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = group,
	callback = function()
		require("lualine").setup({
			options = {
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",
			},
		})
	end,
})
