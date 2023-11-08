local M = {}

---@param pkg_name string
function M.lazy_load(pkg_name)
    vim.cmd(string.format("packadd %s", pkg_name))
end

return M
