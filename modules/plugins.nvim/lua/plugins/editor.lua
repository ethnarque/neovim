local util = require("core.util")
local group = util.augroup("plugins-editor")

vim.api.nvim_create_autocmd({ "BufReadPost", "VimEnter" }, {
	group = group,
	callback = function()
		util.lazy_load("mini.files")
		require("mini.files").setup({
			windows = {
				preview = true,
				width_focus = 30,
				width_preview = 30,
			},
		})

		local show_dotfiles = true

		local filter_show = function(_)
			return true
		end
		local filter_hide = function(fs_entry)
			return not vim.startswith(fs_entry.name, ".")
		end

		local toggle_dotfiles = function()
			show_dotfiles = not show_dotfiles
			local new_filter = show_dotfiles and filter_show or filter_hide
			require("mini.files").refresh({ content = { filter = new_filter } })
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				-- Tweak left-hand side of mapping to your liking
				vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				require("core.util").lsp.on_rename(event.data.from, event.data.to)
			end,
		})

		vim.keymap.set("n", "<leader>fe", function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		end, { desc = "[F]ile [E]xplorer" })

		vim.keymap.set("n", "<leader>fE", function()
			require("mini.files").open(vim.loop.cwd(), true)
		end, { desc = "[F]ile [E]xplorer (cwd)" })
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		vim.cmd([[ packadd toggleterm.nvim ]])
	end,
})

--- Telescope
vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		vim.cmd([[ packadd telescope.nvim ]])

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")

		vim.keymap.set(
			"n",
			"<leader>?",
			require("telescope.builtin").oldfiles,
			{ desc = "[?] Find recently opened files" }
		)
		vim.keymap.set(
			"n",
			"<leader><space>",
			require("telescope.builtin").buffers,
			{ desc = "[ ] Find existing buffers" }
		)
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
		vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set(
			"n",
			"<leader>sw",
			require("telescope.builtin").grep_string,
			{ desc = "[S]earch current [W]ord" }
		)
		vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
	end,
})
