---@class CoreAugroups
---@field lsp_attach_format number
---@field startup_group number
---@field lazy_group number

---@class CoreAugroups
local M = {}

M.lsp_attach_format = vim.api.nvim_create_augroup("core-lsp-attach-format", { clear = true })
M.startup_group = vim.api.nvim_create_augroup("core-enter", { clear = true })
M.lazy_group = vim.api.nvim_create_augroup("core-lazy", { clear = true })

return M
