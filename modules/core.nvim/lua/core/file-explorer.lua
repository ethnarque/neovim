require "mini.files".setup()

vim.keymap.set('n', '<leader>fe', function() vim.cmd("lua MiniFiles.open()") end, { desc = '[F]ile [E]xplorer' })
