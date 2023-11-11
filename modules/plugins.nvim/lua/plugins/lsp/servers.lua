return {
	astro = {},
	cssls = {
		capabilities = function(c)
			c.textDocument.completion.completionItem.snippetSupport = true
			return c
		end,
	},
	dockerls = {},
	emmet_ls = {},
	html = {
		capabilities = function(c)
			c.textDocument.completion.completionItem.snippetSupport = true
			return c
		end,

		settings = {
			css = {
				lint = {
					--- crash lsp server
					validProperties = {},
				},
			},
			html = {
				format = {
					templating = true,
					wrapLineLength = 120,
					wrapAttributes = "auto",
				},
				hover = {
					documentation = true,
					references = true,
				},
			},
		},
	},

	gopls = {},
	jsonls = {},
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
	ocamllsp = {},
	phpactor = {},
	rust_analyzer = {},
	svelte = {},
	tsserver = {},
	vuels = {},
	yamlls = {
		settings = {
			telemetry = { enable = false },
			yaml = {
				schemas = {
					schemaStore = {
						url = "https://www.schemastore.org/api/json/catalog.json",
						enable = true,
					},
					schemas = {
						["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
					},
				},
			},
		},
	},
}
