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

local function hsl_to_hex(h, s, l)
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
lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        autostart = true
    })

local signs = { Error = "󰫈 ", Warn = "󰋘", Hint = "󰋘", Info = "󰋘" }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end




require('lspconfig.ui.windows').default_options.border = 'single'
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })


lspconfig.lua_ls.setup {
    capabitilies = capabitilies
}

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = true,
})

---@class MontesquieuColor
local colors = {
    dark  = {
        bg = hsl_to_hex(0, 0, 11),
        bg_float = hsl_to_hex(0, 0, 9),
        bg_focused = hsl_to_hex(0, 0, 20),
        fg = hsl_to_hex(0, 0, 97),
        fg_unfocused = "gray",
        fg_focused = hsl_to_hex(0, 0, 100),
        cursor_line = hsl_to_hex(0, 0, 16),
        separator = hsl_to_hex(0, 0, 24),

        tokens = {
            identifier = hsl_to_hex(0, 0, 90),
            property = hsl_to_hex(201, 53, 82),
            constant = "NONE",
            comment = hsl_to_hex(0, 0, 50),
            keyword = hsl_to_hex(214, 62, 69),
            func = hsl_to_hex(333, 98, 84),
            -- number = hsl_to_hex(0,0,25),
            string = hsl_to_hex(194, 29, 61),
            type = hsl_to_hex(21, 51, 75),

        }
    },
    light = {
        bg = hsl_to_hex(0, 0, 100),
        bg_float = hsl_to_hex(0, 0, 97),
        bg_focused = "NONE",
        fg = hsl_to_hex(0, 0, 5),
        fg_unfocused = hsl_to_hex(0, 0, 50),
        fg_focused = hsl_to_hex(0, 0, 0),
        cursor_line = "NONE",
        separator = hsl_to_hex(0, 0, 24),

        tokens = {
            -- identifier = "NONE",
            -- constant = "NONE",
            comment = hsl_to_hex(0, 0, 43),
            keyword = hsl_to_hex(233, 49, 71),
            func = hsl_to_hex(330, 55, 75),
            number = hsl_to_hex(0, 0, 25),
            string = hsl_to_hex(194, 29, 51),
            -- type = hsl_to_hex(21, 51, 75),
        }
    },
}


local function set_dark_hl()
    local c = colors["dark"]

    vim.api.nvim_set_hl(0, "Normal", { fg = c.fg, bg = c.bg })          -- Normal text.
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.bg_float })          -- Normal text in floating windows.
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "NONE", bg = "NONE" }) -- Border of floating windows.
    -- FloatTitle	Title of floating windows. *hl-FloatTitle*
    -- NormalNC	Normal text in non-current windows. *hl-NormalNC*
    vim.api.nvim_set_hl(0, "Pmenu", { bg = c.bg_float, fg = "gray" })            -- Popup menu: Normal item.
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = c.bg_focused, fg = c.fg_focused }) -- Popup menu: Selected item.
    -- PmenuKind	Popup menu: Normal item "kind". *hl-PmenuKind*
    -- PmenuKindSel	Popup menu: Selected item "kind". *hl-PmenuKindSel*
    -- PmenuExtra	Popup menu: Normal item "extra text". *hl-PmenuExtra*
    -- PmenuExtraSel	Popup menu: Selected item "extra text". *hl-PmenuExtraSel*
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = c.bg_float }) -- Popup menu: Scrollbar.
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "gray" })    -- Popup menu: Thumb of the scrollbar. *hl-PmenuThumb*
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
    vim.api.nvim_set_hl(0, "Title", { fg = "white" }) -- Titles for output from ":set all", ":autocmd" etc.
    -- Visual		Visual mode selection.
    -- VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg	Warning messages.
    -- Whitespace	"nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
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
    -- 							*hl-Menu*
    -- Menu		Current font, background and foreground colors of the menus.
    -- 		Also used for the toolbar.
    -- 		Applicable highlight arguments: font, guibg, guifg.
    --
    -- 							*hl-Scrollbar*
    -- Scrollbar	Current background and foreground of the main window's
    -- 		scrollbars.
    -- 		Applicable highlight arguments: guibg, guifg.
    --
    -- 							*hl-Tooltip*
    -- Tooltip		Current font, background and foreground of the tooltips.
    -- 		Applicable highlight arguments: font, guibg, guifg.
    -- end
    --
    --
    --
    --
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


    -- *Comment
    vim.api.nvim_set_hl(0, "Comment", { fg = c.tokens.comment })         -- any comment
    -- *Constant
    vim.api.nvim_set_hl(0, "Constant", { fg = hsl_to_hex(330, 46, 66) }) -- any constants
    -- vim.api.nvim_set_hl(0, "Character", { fg = hsl_to_hex(330, 46, 66) }) --  Character	a character constant: 'c', '\n'
    vim.api.nvim_set_hl(0, "String", { fg = c.tokens.string })           -- a string constant: "this is a string"
    vim.api.nvim_set_hl(0, "Number", { fg = c.tokens.number })           -- a number constant: 234, 0xff
    vim.api.nvim_set_hl(0, "Boolean", { link = "Keyword" })              -- a boolean constant: TRUE, false
    vim.api.nvim_set_hl(0, "Float", { link = "Number" })                 -- a floating point constant: 2.3e10
    -- *Identifier
    vim.api.nvim_set_hl(0, "Identifier", { fg = c.tokens.identifier })   -- any variable name
    vim.api.nvim_set_hl(0, "Function", { fg = c.tokens.func })           -- function name (also: methods for classes)
    vim.api.nvim_set_hl(0, "Statement", { link = "Keyword" })            -- any statement
    vim.api.nvim_set_hl(0, "Conditional", { link = "Keyword" })          -- if, then, else, endif, switch, etc.
    vim.api.nvim_set_hl(0, "Repeat", { link = "Keyword" })               -- for, do, while, etc.
    vim.api.nvim_set_hl(0, "Label", { link = "Keyword" })                --  case, default, etc.
    vim.api.nvim_set_hl(0, "Operator", { fg = "#ffffff" })               -- "sizeof", "+", "*", etc.
    vim.api.nvim_set_hl(0, "Keyword", { fg = c.tokens.keyword })         --  any other keyword
    vim.api.nvim_set_hl(0, "Exception", { link = "Keyword" })            --  Exception	try, catch, throw
    -- *PreProc
    vim.api.nvim_set_hl(0, "PreProc", { link = "Keyword" })              -- generic Preprocessor
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
    vim.api.nvim_set_hl(0, "Special", { fg = hsl_to_hex(0, 0, 100) }) -- any special symbol
    --  SpecialChar	special character in a constant
    --  Tag		you can use CTRL-] on this
    --  Delimiter	character that needs attention
    --  SpecialComment	special things inside a comment
    --  Debug		debugging statements

    -- *Underlined	text that stands out, HTML links

    -- *Ignore		left blank, hidden  |hl-Ignore|

    -- *Error		any erroneous construct

    -- *Todo		anything that needs extra attention; mostly the keywords TODO FIXME and XXX


    --- Languages spec
    vim.api.nvim_set_hl(0, "htmlTag", { link = "Comment" })
    vim.api.nvim_set_hl(0, "htmlEndTag", { link = "htmlTag" })
    vim.api.nvim_set_hl(0, "luaFunc", { fg = hsl_to_hex(330, 46, 66) })

    vim.api.nvim_set_hl(0, "nixSimpleBuiltin", { fg = hsl_to_hex(330, 46, 66) })
    --- Treesitter
    vim.api.nvim_set_hl(0, "@keyword.import", { fg = hsl_to_hex(330, 46, 66) })
    vim.api.nvim_set_hl(0, "@variable.member", { fg = c.tokens.property })
    vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = hsl_to_hex(0, 0, 60) })
    vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = hsl_to_hex(0, 0, 75) })
    vim.api.nvim_set_hl(0, "@function.builtin", { fg = hsl_to_hex(330, 45, 65) })

    --- Editor
    -- ColorColumn	Used for the columns set with 'colorcolumn'. *hl-ColorColumn*
    -- Conceal		Placeholder characters substituted for concealed text (see 'conceallevel') *hl-Conceal*.
    -- CurSearch	Used for highlighting a search pattern under the cursor (see 'hlsearch') *hl-CurSearch*.
    -- Cursor		Character under the cursor. *hl-Cursor*
    -- lCursor		Character under the cursor when |language-mapping| is used (see 'guicursor'). *hl-lCursor*
    -- CursorIM	Like Cursor, but used when in IME mode. *CursorIM* *hl-CursorIM*
    -- CursorColumn	Screen-column at the cursor, when 'cursorcolumn' is set. *hl-CursorColumn*
    -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set. *hl-CursorLine*
    vim.api.nvim_set_hl(0, "CursorLine", { bg = c.cursor_line })

    --
    -- Directory	Directory names (and other special names in listings). *hl-Directory*
    -- DiffAdd		Diff mode: Added line. |diff.txt| *hl-DiffAdd*
    -- DiffChange	Diff mode: Changed line. |diff.txt| *hl-DiffChange*
    -- DiffDelete	Diff mode: Deleted line. |diff.txt| *hl-DiffDelete*
    -- DiffText	Diff mode: Changed text within a changed line. |diff.txt| *hl-DiffText*
    -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|. *hl-EndOfBuffer*
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = c.bg })
    -- TermCursor	Cursor in a focused terminal. *hl-TermCursor*
    -- TermCursorNC	Cursor in an unfocused terminal. *hl-TermCursorNC*
    -- ErrorMsg	Error messages on the command line. *hl-ErrorMsg*
    -- Separators between window splits. *hl-WinSeparator*
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.separator })
    -- Folded		Line used for closed folds. *hl-Folded*
    -- FoldColumn	'foldcolumn' *hl-FoldColumn*
    -- Column where |signs| are displayed. *hl-SignColumn*
    vim.api.nvim_set_hl(0, "SignColumn", { link = "Normal" })
    -- IncSearch	'incsearch' highlighting; also used for the text replaced with ":s///c". *hl-IncSearch*
    -- Substitute	|:substitute| replacement text highlighting. *hl-Substitute*
    -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set. *hl-LineNr*
    vim.api.nvim_set_hl(0, "LineNr", { bg = c.bg, fg = c.fg_unfocused })
    -- LineNrAbove	Line number for when the 'relativenumber' option is set, above the cursor line. *hl-LineNrAbove*
    -- LineNrBelow	Line number for when the 'relativenumber' option is set, below the cursor line. *hl-LineNrBelow*
    -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line. *hl-CursorLineNr*
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "white" })
    -- CursorLineFold	Like FoldColumn when 'cursorline' is set for the cursor line. *hl-CursorLineFold*
    -- Like SignColumn when 'cursorline' is set for the cursor line. *hl-CursorLineSign*
    vim.api.nvim_set_hl(0, "CursorLineSign", { link = "SignColumn" })
    -- MatchParen	Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt| *hl-MatchParen*
    -- ModeMsg		'showmode' message (e.g., "-- INSERT --"). *hl-ModeMsg*
    -- MsgArea		Area for messages and cmdline. *hl-MsgArea*
    -- MsgSeparator	Separator for scrolled messages |msgsep|. *hl-MsgSeparator*
    -- MoreMsg		|more-prompt| *hl-MoreMsg*
    -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|. *hl-NonText*
    vim.api.nvim_set_hl(0, "NonText", { fg = hsl_to_hex(0, 0, 25) })
end

local function set_light_hl()
    local c = colors["light"]

    -- Normal text. *hl-Normal*
    vim.api.nvim_set_hl(0, "Normal", { bg = c.bg400 })
    -- Normal text in floating windows. *hl-NormalFloat*
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.float })
    -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    vim.api.nvim_set_hl(0, "LineNr", { bg = "#feffff" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = hsl_to_hex(120, 0, 95), fg = c.fg_unfocused })

    vim.api.nvim_set_hl(0, "Keyword", { fg = "#493a8a" })
    vim.api.nvim_set_hl(0, "Statement", { fg = "#493a8a" })
    vim.api.nvim_set_hl(0, "String", { fg = "#2f3f83" })
    vim.api.nvim_set_hl(0, "Number", { fg = hsl_to_hex(333, 73, 64) })
    vim.api.nvim_set_hl(0, "Boolean", { fg = hsl_to_hex(214, 74, 72) })
    vim.api.nvim_set_hl(0, "Float", { link = "Number" })
    vim.api.nvim_set_hl(0, "Special", { fg = "#cf7fa7" })
    vim.api.nvim_set_hl(0, "Comment", { fg = c.fg200 })
end

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
