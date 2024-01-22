Secretaire = {
	keybindings = {
		leader = " ",
	},
	autocmd_queue = {},
	formatting = {
		__augroups = {},
		autoformat = true,
		filetypes = {
			lua = { "stylua" },
		},
	},
}
Secretaire._index = Secretaire

function Secretaire:init()
	local o = {}
	setmetatable(o, Secretaire)
	self._index = self
	return o
end

function Secretaire:register(autocmd)
	table.insert(self.autocmd_queue, autocmd)
end

function Secretaire:bootstrap()
	for _, autocmd in ipairs(self.autocmd_queue) do
		autocmd()
	end
end

--- dev utils
_G.pprint = function(...)
	print(vim.inspect(...))
end

function Secretaire.start()
	Secretaire:bootstrap()
end

return Secretaire
