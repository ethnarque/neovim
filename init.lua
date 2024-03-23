vim.opt.spell = false
vim.opt.spelllang = { 'en_us' }

require "neodev".setup()

local cmp = require 'cmp'

cmp.setup({
    completion = {
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline({ "/", "?" }, {
    completion = {
        autocomplete = { "InsertEnter", 'TextChanged' }
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

cmp.setup.cmdline(':', {
    completion = {
        autocomplete = { "InsertEnter", 'TextChanged' }
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})



local function hsl_to_rgb(h, s, l)
    local r, g, b

    if s == 0 then
        r, g, b = l, l, l -- achromatic
    else
        local function hue_to_rgb(p, q, t)
            if t < 0 then t = t + 1 end
            if t > 1 then t = t - 1 end
            if t < 1 / 6 then return p + (q - p) * 6 * t end
            if t < 1 / 2 then return q end
            if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
            return p
        end

        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = hue_to_rgb(p, q, h + 1 / 3)
        g = hue_to_rgb(p, q, h)
        b = hue_to_rgb(p, q, h - 1 / 3)
    end

    return r * 255, g * 255, b * 255
end

local function rgb_to_hex(r, g, b)
    return string.format("#%02X%02X%02X", r, g, b)
end

local function hsl(h, s, l)
    local r, g, b = hsl_to_rgb(h / 360, s / 100, l / 100)
    return rgb_to_hex(r, g, b)
end

local capabitilies = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require "cmp_nvim_lsp".default_capabilities()
capabitilies = vim.tbl_deep_extend("force", capabitilies, cmp_capabilities)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = args.buf }

        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end
})

local lspconfig = require "lspconfig"

lspconfig.util.default_config =
    vim.tbl_extend("force", lspconfig.util.default_config, {
        autostart = true
    })

local signs = {
    Error = "󰫈 ",
    Warn = "󰋘 ",
    Hint = "󰋘 ",
    Info = "󰋘 "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end



require('lspconfig.ui.windows').default_options.border = 'single'
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })


lspconfig.lua_ls.setup {
    capabitilies = capabitilies
}

lspconfig.vala_ls.setup {
    capabitilies = capabitilies
}

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = true,
})

local colors    = {}

colors.dark     = {
    shade0 = hsl(0, 0, 12),
    shade1 = hsl(0, 0, 16),
    shade2 = hsl(0, 0, 20),
    shade3 = hsl(0, 0, 24),
    shade4 = hsl(0, 0, 35),
    shade5 = hsl(0, 0, 50),
    shade6 = hsl(0, 0, 65),
    shade7 = hsl(0, 0, 90),
    shade8 = hsl(0, 0, 97),
    shade9 = hsl(0, 0, 100),

    red = "",
    pink0 = hsl(330, 45, 65),
    pink1 = hsl(333, 98, 84),
    yellow0 = hsl(21, 51, 75),
    green = hsl(152, 45, 60),
    blue0 = hsl(194, 29, 61),
    blue1 = hsl(201, 53, 82),
    blue2 = hsl(214, 62, 69),
}

colors.light    = {
    shade0 = hsl(0, 0, 100),
    shade1 = hsl(0, 0, 97),
    shade2 = hsl(0, 0, 91),
    shade3 = hsl(0, 0, 87),
    shade4 = hsl(0, 0, 75),
    shade5 = hsl(0, 0, 50),
    shade6 = hsl(0, 0, 43),
    shade7 = hsl(0, 0, 25),
    shade8 = hsl(0, 0, 5),
    shade9 = hsl(0, 0, 0),

    red = "",
    pink0 = hsl(330, 45, 55),
    pink1 = hsl(330, 55, 61),
    yellow0 = "",
    green = "",
    blue0 = "#71909b",
    blue1 = "#2f3f83",
    blue2 = "#493a8a",
}

---@class MontesquieuColor
local hl_groups = function(c)
    return {
        shade0 = c.shade0,
        shade1 = c.shade1,
        shade2 = c.shade2,
        shade3 = c.shade3,
        shade4 = c.shade4,
        shade5 = c.shade5,
        shade6 = c.shade6,
        shade7 = c.shade7,
        shade8 = c.shade8,
        shade9 = c.shade9,

        tokens = {
            builtin = c.pink0,
            comment = c.shade5,
            func = c.pink1,
            keyword = c.blue2,
            id = c.shade3,
            number = c.shade9,
            path = c.blue2,
            property = c.blue1,
            operator = c.shade8,
            string = c.blue0,
            type = c.yellow0
        },
    }
end


local function set_dark_hl()
    local theme = "light"
    local c = hl_groups(colors[theme])


    vim.api.nvim_set_hl(0, "Normal", { fg = c.shade9, bg = c.shade0 })  -- Normal text.
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.shade2 })            -- Normal text in floating windows.
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "NONE", bg = "NONE" }) -- Border of floating windows.
    -- FloatTitle	Title of floating windows.
    -- NormalNC	Normal text in non-current windows.
    vim.api.nvim_set_hl(0, "Pmenu", { bg = c.shade2, fg = c.shade5 })    -- Popup menu: Normal item.
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = c.shade4, fg = c.shade9 }) -- Popup menu: Selected item.
    -- PmenuKind	Popup menu: Normal item "kind".
    -- PmenuKindSel	Popup menu: Selected item "kind".
    -- PmenuExtra	Popup menu: Normal item "extra text".
    -- PmenuExtraSel	Popup menu: Selected item "extra text".
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = c.shade2 }) -- Popup menu: Scrollbar.
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = c.blue1 }) -- Popup menu: Thumb of the scrollbar.
    -- Question	|hit-enter| prompt and yes/no questions.
    -- QuickFixLine	Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    -- Search		Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    -- SpecialKey	Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad	Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap	Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal	Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare	Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    -- StatusLine	Status line of current window.
    -- StatusLineNC	Status lines of not-current windows. Note: If this is equal to "StatusLine", Vim will use "^^^" in the status line of the current window.
    -- TabLine		Tab pages line, not active tab page label.
    -- TabLineFill	Tab pages line, where there are no labels.
    -- TabLineSel	Tab pages line, active tab page label.
    vim.api.nvim_set_hl(0, "Title", { fg = c.shade9 }) -- Titles for output from ":set all", ":autocmd" etc.
    -- Visual		Visual mode selection.
    -- VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg	Warning messages.
    vim.api.nvim_set_hl(0, "Whitespace", { link = "NonText" }) -- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
    -- WildMenu	Current match in 'wildmenu' completion.
    -- WinBar		Window bar of current window.
    -- WinBarNC	Window bar of not-current windows.
    -- 					*hl-User1* *hl-User1..9* *hl-User9*
    -- The 'statusline' syntax allows the use of 9 different highlights in the
    -- statusline and ruler (via 'rulerformat').  The names are User1 to User9.
    --
    -- For the GUI you can use the following groups to set the colors for the menu,
    -- scrollbars and tooltips.  They don't have defaults.  This doesn't work for the
    -- Win32 GUI.  Only three highlight arguments have any effect here: font, guibg,
    -- and guifg.
    --
    -- Menu		Current font, background and foreground colors of the menus.
    -- 		Also used for the toolbar.
    -- 		Applicable highlight arguments: font, guibg, guifg.
    --
    -- Scrollbar	Current background and foreground of the main window's
    -- 		scrollbars.
    -- 		Applicable highlight arguments: guibg, guifg.
    --
    -- Tooltip		Current font, background and foreground of the tooltips.
    -- 		Applicable highlight arguments: font, guibg, guifg.
    -- end

    -- --- Editor
    -- 							*hl-Normal*
    -- Normal		Normal text.
    -- 							*hl-NormalFloat*
    -- NormalFloat	Normal text in floating windows.
    -- 							*hl-FloatBorder*
    -- FloatBorder	Border of floating windows.
    -- 							*hl-FloatTitle*
    -- FloatTitle	Title of floating windows.
    -- 							*hl-NormalNC*
    -- NormalNC	Normal text in non-current windows.
    -- 							*hl-Pmenu*
    -- Pmenu		Popup menu: Normal item.
    -- 							*hl-PmenuSel*
    -- PmenuSel	Popup menu: Selected item.
    -- 							*hl-PmenuKind*
    -- PmenuKind	Popup menu: Normal item "kind".
    -- 							*hl-PmenuKindSel*
    -- PmenuKindSel	Popup menu: Selected item "kind".
    -- 							*hl-PmenuExtra*
    -- PmenuExtra	Popup menu: Normal item "extra text".
    -- 							*hl-PmenuExtraSel*
    -- PmenuExtraSel	Popup menu: Selected item "extra text".
    -- 							*hl-PmenuSbar*
    -- PmenuSbar	Popup menu: Scrollbar.
    -- 							*hl-PmenuThumb*
    -- PmenuThumb	Popup menu: Thumb of the scrollbar.
    -- 							*hl-Question*
    -- Question	|hit-enter| prompt and yes/no questions.
    -- 							*hl-QuickFixLine*
    -- QuickFixLine	Current |quickfix| item in the quickfix window. Combined with
    --                 |hl-CursorLine| when the cursor is there.
    -- 							*hl-Search*
    -- Search		Last search pattern highlighting (see 'hlsearch').
    -- 		Also used for similar items that need to stand out.
    -- 							*hl-SpecialKey*
    -- SpecialKey	Unprintable characters: Text displayed differently from what
    -- 		it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- 							*hl-SpellBad*
    -- SpellBad	Word that is not recognized by the spellchecker. |spell|
    -- 		Combined with the highlighting used otherwise.
    -- 							*hl-SpellCap*
    -- SpellCap	Word that should start with a capital. |spell|
    -- 		Combined with the highlighting used otherwise.
    -- 							*hl-SpellLocal*
    -- SpellLocal	Word that is recognized by the spellchecker as one that is
    -- 		used in another region. |spell|
    -- 		Combined with the highlighting used otherwise.
    -- 							*hl-SpellRare*
    -- SpellRare	Word that is recognized by the spellchecker as one that is
    -- 		hardly ever used. |spell|
    -- 		Combined with the highlighting used otherwise.
    -- 							*hl-StatusLine*
    -- StatusLine	Status line of current window.
    -- 							*hl-StatusLineNC*
    -- StatusLineNC	Status lines of not-current windows.
    -- 		Note: If this is equal to "StatusLine", Vim will use "^^^" in
    -- 		the status line of the current window.
    -- 							*hl-TabLine*
    -- TabLine		Tab pages line, not active tab page label.
    -- 							*hl-TabLineFill*
    -- TabLineFill	Tab pages line, where there are no labels.
    -- 							*hl-TabLineSel*
    -- TabLineSel	Tab pages line, active tab page label.
    -- 							*hl-Title*
    -- Title		Titles for output from ":set all", ":autocmd" etc.
    -- 							*hl-Visual*
    -- Visual		Visual mode selection.
    -- 							*hl-VisualNOS*
    -- VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
    -- 							*hl-WarningMsg*
    -- WarningMsg	Warning messages.
    -- 							*hl-Whitespace*
    -- Whitespace	"nbsp", "space", "tab", "multispace", "lead" and "trail"
    -- 		in 'listchars'.
    -- 							*hl-WildMenu*
    -- WildMenu	Current match in 'wildmenu' completion.
    -- 							*hl-WinBar*
    -- WinBar		Window bar of current window.
    -- 							*hl-WinBarNC*
    -- WinBarNC	Window bar of not-current windows.

    --- Editor
    -- ColorColumn	Used for the columns set with 'colorcolumn'. *hl-ColorColumn*
    -- Conceal		Placeholder characters substituted for concealed text (see 'conceallevel') *hl-Conceal*.
    -- CurSearch	Used for highlighting a search pattern under the cursor (see 'hlsearch') *hl-CurSearch*.
    -- Cursor		Character under the cursor. *hl-Cursor*
    -- lCursor		Character under the cursor when |language-mapping| is used (see 'guicursor'). *hl-lCursor*
    -- CursorIM	Like Cursor, but used when in IME mode. *CursorIM* *hl-CursorIM*
    -- CursorColumn	Screen-column at the cursor, when 'cursorcolumn' is set. *hl-CursorColumn*
    -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set. *hl-CursorLine*
    vim.api.nvim_set_hl(0, "CursorLine", { bg = c.shade1 })
    -- Directory	Directory names (and other special names in listings). *hl-Directory*
    -- DiffAdd		Diff mode: Added line. |diff.txt| *hl-DiffAdd*
    -- DiffChange	Diff mode: Changed line. |diff.txt| *hl-DiffChange*
    -- DiffDelete	Diff mode: Deleted line. |diff.txt| *hl-DiffDelete*
    -- DiffText	Diff mode: Changed text within a changed line. |diff.txt| *hl-DiffText*
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = c.shade0 }) -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor	Cursor in a focused terminal. *hl-TermCursor*
    -- TermCursorNC	Cursor in an unfocused terminal. *hl-TermCursorNC*
    -- ErrorMsg	Error messages on the command line. *hl-ErrorMsg*
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.shade3 }) -- Separators between window splits.
    -- Folded		Line used for closed folds. *hl-Folded*
    -- FoldColumn	'foldcolumn' *hl-FoldColumn*
    vim.api.nvim_set_hl(0, "SignColumn", { link = "Normal" }) -- Column where |signs| are displayed.
    -- IncSearch	'incsearch' highlighting; also used for the text replaced with ":s///c". *hl-IncSearch*
    -- Substitute	|:substitute| replacement text highlighting. *hl-Substitute*
    vim.api.nvim_set_hl(0, "LineNr", { bg = c.shade0, fg = c.shade4 }) -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- LineNrAbove	Line number for when the 'relativenumber' option is set, above the cursor line. *hl-LineNrAbove*
    -- LineNrBelow	Line number for when the 'relativenumber' option is set, below the cursor line. *hl-LineNrBelow*
    -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line. *hl-CursorLineNr*
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.shade9 })
    -- CursorLineFold	Like FoldColumn when 'cursorline' is set for the cursor line. *hl-CursorLineFold*
    vim.api.nvim_set_hl(0, "CursorLineSign", { link = "SignColumn" }) -- Like SignColumn when 'cursorline' is set for the cursor line.
    -- MatchParen	Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt| *hl-MatchParen*
    -- ModeMsg		'showmode' message (e.g., "-- INSERT --"). *hl-ModeMsg*
    -- MsgArea		Area for messages and cmdline. *hl-MsgArea*
    -- MsgSeparator	Separator for scrolled messages |msgsep|. *hl-MsgSeparator*
    -- MoreMsg		|more-prompt| *hl-MoreMsg*
    vim.api.nvim_set_hl(0, "NonText", { fg = c.shade3 }) -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.


    -- *Comment
    vim.api.nvim_set_hl(0, "Comment", { fg = c.tokens.comment })       -- any comment
    -- *Constant
    vim.api.nvim_set_hl(0, "Constant", { fg = hsl(330, 46, 66) })      -- any constants
    -- vim.api.nvim_set_hl(0, "Character", { fg = hsl_to_hex(330, 46, 66) }) --  Character	a character constant: 'c', '\n'
    vim.api.nvim_set_hl(0, "String", { fg = c.tokens.string })         -- a string constant: "this is a string"
    vim.api.nvim_set_hl(0, "Number", { fg = c.tokens.number })         -- a number constant: 234, 0xff
    vim.api.nvim_set_hl(0, "Boolean", { link = "Keyword" })            -- a boolean constant: TRUE, false
    vim.api.nvim_set_hl(0, "Float", { link = "Number" })               -- a floating point constant: 2.3e10
    -- *Identifier
    vim.api.nvim_set_hl(0, "Identifier", { fg = c.tokens.identifier }) -- any variable name
    vim.api.nvim_set_hl(0, "Function", { fg = c.tokens.func })         -- function name (also: methods for classes)
    vim.api.nvim_set_hl(0, "Statement", { link = "Keyword" })          -- any statement
    vim.api.nvim_set_hl(0, "Conditional", { link = "Keyword" })        -- if, then, else, endif, switch, etc.
    vim.api.nvim_set_hl(0, "Repeat", { link = "Keyword" })             -- for, do, while, etc.
    vim.api.nvim_set_hl(0, "Label", { link = "Keyword" })              --  case, default, etc.
    vim.api.nvim_set_hl(0, "Operator", { fg = c.tokens.operator })     -- "sizeof", "+", "*", etc.
    vim.api.nvim_set_hl(0, "Keyword", { fg = c.tokens.keyword })       --  any other keyword
    vim.api.nvim_set_hl(0, "Exception", { link = "Keyword" })          --  Exception	try, catch, throw
    -- *PreProc
    vim.api.nvim_set_hl(0, "PreProc", { link = "Keyword" })            -- generic Preprocessor
    --  Include	preprocessor #include
    --  Define		preprocessor #define
    --  Macro		same as Define
    --  PreCondit	preprocessor #if, #else, #endif, etc.

    -- *Type
    vim.api.nvim_set_hl(0, "Type", { fg = c.tokens.type }) -- int, long, char, etc.
    --  StorageClass	static, register, volatile, etc.
    --  Structure	struct, union, enum, etc.
    --  Typedef	A typedef

    -- *Special	
    vim.api.nvim_set_hl(0, "Special", { fg = c.shade9 }) -- any special symbol
    --  SpecialChar	special character in a constant
    --  Tag		you can use CTRL-] on this
    --  Delimiter	character that needs attention
    --  SpecialComment	special things inside a comment
    --  Debug		debugging statements

    -- *Underlined	text that stands out, HTML links

    -- *Ignore		left blank, hidden  |hl-Ignore|

    -- *Error		any erroneous construct

    -- *Todo		anything that needs extra attention; mostly the keywords TODO FIXME and XXX


    --- Languages spec without Treesitter
    vim.api.nvim_set_hl(0, "htmlTag", { link = "Comment" })
    vim.api.nvim_set_hl(0, "htmlEndTag", { link = "htmlTag" })
    vim.api.nvim_set_hl(0, "luaFunc", { fg = c.tokens.builtin })
    vim.api.nvim_set_hl(0, "nixSimpleBuiltin", { fg = c.tokens.builtin })
    --- Treesitter
    vim.api.nvim_set_hl(0, "@keyword.import", { fg = c.tokens.builtin })
    vim.api.nvim_set_hl(0, "@variable.member", { fg = c.tokens.property })
    vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = c.shade6 })
    vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = c.shade7 })
    vim.api.nvim_set_hl(0, "@function.make", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@function.builtin", { fg = c.tokens.builtin })
    vim.api.nvim_set_hl(0, "@string.special.path", { fg = c.tokens.path })
end

-- local function set_light_hl()
--     local c = hl["light"]
--
--     -- Normal text. *hl-Normal*
--     vim.api.nvim_set_hl(0, "Normal", { bg = c.bg400 })
--     -- Normal text in floating windows. *hl-NormalFloat*
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.float })
--     -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
--     vim.api.nvim_set_hl(0, "LineNr", { bg = "#feffff" })
--     vim.api.nvim_set_hl(0, "Pmenu", { bg = hsl(120, 0, 95), fg = c.fg_unfocused })
--
--     vim.api.nvim_set_hl(0, "Keyword", { fg = "#493a8a" })
--     vim.api.nvim_set_hl(0, "Statement", { fg = "#493a8a" })
--     vim.api.nvim_set_hl(0, "String", { fg = "#2f3f83" })
--     vim.api.nvim_set_hl(0, "Number", { fg = hsl(333, 73, 64) })
--     vim.api.nvim_set_hl(0, "Boolean", { fg = hsl(214, 74, 72) })
--     vim.api.nvim_set_hl(0, "Float", { link = "Number" })
--     vim.api.nvim_set_hl(0, "Special", { fg = "#cf7fa7" })
--     vim.api.nvim_set_hl(0, "Comment", { fg = c.fg200 })
-- end

require "trouble".setup()
set_dark_hl()

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("secretaire-highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf

        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true

        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)

        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
