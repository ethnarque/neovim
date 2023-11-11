local util = require("core.util")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

util.lazy_load("cmp-nvim-lsp")
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return capabilities
