local group = vim.api.nvim_create_augroup("secretaire-comment", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function()
        vim.cmd("packadd comment.nvim")
        require "comment".setup()
    end
})
