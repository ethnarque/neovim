local M = {}

---@param pkg_name string
function M.lazy_load(pkg_name)
    vim.cmd(string.format("packadd %s", pkg_name))
end

function M.augroup(name)
    return vim.api.nvim_create_augroup("secretaire-" .. name, { clear = true })
end

return M
