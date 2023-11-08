local utils = require("core.util")
local group = utils.augroup("ui")

--- Dev icons
vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = function()
        utils.lazy_load("nvim-web-devicons")
    end
})

--- Dashboard
vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = function()
        utils.lazy_load("dashboard-nvim")


        local opts = {
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        desc = ' Restore Session',
                        group = 'DiagnosticHint',
                        action = 'lua require("persistence").load()',
                        key = 's',
                    },
                },
            },
        }

        require("dashboard").setup(opts)
    end
})
