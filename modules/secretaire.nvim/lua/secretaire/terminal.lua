vim.defer_fn(function()
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    vim.cmd("packadd toggleterm.nvim")
    require("toggleterm").setup()


    local Terminal = require "toggleterm.terminal".Terminal
    local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
            border = "double",
        },
        -- function to run on opening the terminal
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(_)
            vim.cmd("startinsert!")
        end,
    })

    function _lazygit_toggle()
        lazygit:toggle()
    end
end, 0)


function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }

    vim.keymap.set('t', '<C-j>', '<Cmd>ToggleTermToggleAll<CR>', { desc = 'Show all openned terminal' })
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<cr>', { desc = 'New [T]erminal' })
vim.keymap.set('n', '<C-j>', '<cmd>ToggleTermToggleAll<cr>', { desc = 'Show all openned terminal' })
vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
