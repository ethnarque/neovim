---@class core.util
---@field lsp core.util.lsp
local M = {}

M.lsp = require("core.util.lsp")

---@param pkg_name string
function M.lazy_load(pkg_name)
	vim.cmd(string.format("packadd %s", pkg_name))
end

function M.augroup(name)
	return vim.api.nvim_create_augroup("core-" .. name, { clear = true })
end

return M
