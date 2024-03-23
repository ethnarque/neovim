require "condensation"

vim.opt.spell = false
vim.opt.spelllang = { 'en_us' }

require "neodev".setup()

local cmp = require 'cmp'

cmp.setup({
    completion = {
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline({ "/", "?" }, {
    completion = {
        autocomplete = { "InsertEnter", 'TextChanged' }
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

cmp.setup.cmdline(':', {
    completion = {
        autocomplete = { "InsertEnter", 'TextChanged' }
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})


local capabitilies = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require "cmp_nvim_lsp".default_capabilities()
capabitilies = vim.tbl_deep_extend("force", capabitilies, cmp_capabilities)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = args.buf }

        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end
})

local lspconfig = require "lspconfig"

lspconfig.util.default_config =
    vim.tbl_extend("force", lspconfig.util.default_config, {
        autostart = true
    })

local signs = {
    Error = "󰫈 ",
    Warn = "󰋘 ",
    Hint = "󰋘 ",
    Info = "󰋘 "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end



require('lspconfig.ui.windows').default_options.border = 'single'
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })


lspconfig.lua_ls.setup {
    capabitilies = capabitilies
}

lspconfig.vala_ls.setup {
    capabitilies = capabitilies
}

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = true,
})

require "trouble".setup()

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("secretaire-highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf

        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true

        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)

        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
