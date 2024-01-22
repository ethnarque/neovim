---@class Secretaire
_G.Secretaire = {
	keybindings = {
		leader = " ",
	},
	editor = {
		auto_dark_mode = true,
	},
}

require("secretaire.settings.opts")
require("secretaire.settings.keybindings")

require("secretaire.ui.colorscheme")
require("secretaire.ui.dashboard")
require("secretaire.ui.statusline")

require("secretaire.editor.completion")
require("secretaire.editor.formatting")
require("secretaire.editor.navigation")
require("secretaire.editor.treesitter")

require("secretaire.diagnostics.lsp")
