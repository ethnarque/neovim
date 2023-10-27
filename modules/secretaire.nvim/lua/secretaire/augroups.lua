---@class SecretaireAugroups
---@field lsp_attach_format number
---@field startup_group number
---@field lazy_group number

---@class SecretaireAugroups
local M = {}

M.lsp_attach_format = vim.api.nvim_create_augroup("secretaire-lsp-attach-format", { clear = true })
M.startup_group = vim.api.nvim_create_augroup("secretaire-enter", { clear = true })
M.lazy_group = vim.api.nvim_create_augroup("secretaire-lazy", { clear = true })

return M
