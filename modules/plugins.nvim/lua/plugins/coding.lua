local util = require("core.util")
local group = util.augroup("plugins-coding")

--- nvim-treesitter
vim.defer_fn(function()
	vim.cmd("packadd nvim-treesitter")
	vim.cmd("packadd nvim-ts-autotag")
	local opts = {
		highlight = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = "<c-s>",
				node_decremental = "<M-space>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	}
	require("nvim-treesitter.configs").setup(opts)
end, 0)

--- mini.pairs
--- Minimal and fast autopairs
vim.api.nvim_create_autocmd("InsertEnter", {
	group = group,
	callback = function()
		util.lazy_load("mini.pairs")
		require("mini.pairs").setup()
	end,
})

--- nvim cmp
--- Code completions
vim.api.nvim_create_autocmd({ "VimEnter", "InsertEnter" }, {
	group = group,
	callback = function()
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<S-CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				format = function(entry, vim_item)
					if vim.tbl_contains({ "path" }, entry.source.name) then
						local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
						if icon then
							vim_item.kind = icon
							vim_item.kind_hl_group = hl_group
							return vim_item
						end
					end
					return require("lspkind").cmp_format({ with_text = false })(entry, vim_item)
				end,
			},
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
		})
	end,
})

--- comment.nvim
vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = function()
		vim.cmd("packadd comment.nvim")
		require("comment").setup()
	end,
})
