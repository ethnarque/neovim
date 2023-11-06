return {
    gopls = {},
    nixd = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
                telemetry = { enable = false },
                workspace = { checkThirdParty = false },
            },
        },
    },
    tsserver = {},
}
