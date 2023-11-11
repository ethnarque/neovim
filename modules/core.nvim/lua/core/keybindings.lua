local lazy_load = require("core.util").lazy_load

vim.defer_fn(function()
	lazy_load("which-key.nvim")
	require("which-key").register({
		["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
		["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
		["<leader>f"] = { name = "[F]iles", _ = "which_key_ignore" },
		["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
		["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
		["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
		["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
		["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
	})
end, 0)

-- Move Lines
vim.keymap.set("n", "<C-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<C-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<C-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<C-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<C-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<C-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- Terminals
local lazygit = require("core.util.terminal")

vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set("n", "<leader>gg", function()
	lazygit:toggle()
end, { silent = true })
-- vim.keymap.set('n', '<C-/>', '<cmd>ToggleTermToggleAll<cr>', { desc = 'Show all openned terminal' })
