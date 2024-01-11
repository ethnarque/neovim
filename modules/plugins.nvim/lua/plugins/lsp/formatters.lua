local prettier = { { "prettierd", "prettier" } }

return {
	javascript = prettier,
	html = prettier,
	lua = { "stylua" },
	nix = { "alejandra" },
	python = { "isort", "black" },
	svelte = prettier,
	typescript = prettier,
	yaml = prettier,
}
