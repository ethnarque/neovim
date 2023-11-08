require "core.colorscheme"
require "core.opts"
require "core.ui"
require "core.plugins.util"

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        require "core.lazy"
        require "core.terminal"
        require "core.autocmds"
        require "core.lsp"
        require "core.treesitter"
        require "core.telescope"
        require "core.coding"
        require "core.lualine"
        require "core.comment"
        require "core.keybindings"
        require "core.file-explorer"
    end

})
