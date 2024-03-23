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



local colors    = {}

colors.light    = {
    shade0        = hsl(0, 0, 97),
    shade1        = hsl(0, 0, 93),
    shade2        = hsl(0, 0, 88),
    shade3        = hsl(0, 0, 84),
    shade4        = hsl(0, 0, 74),
    shade5        = hsl(0, 0, 49),
    shade6        = hsl(0, 0, 42),
    shade7        = hsl(0, 0, 24),
    shade8        = hsl(0, 0, 5),
    shade9        = hsl(0, 0, 0),

    red           = hsl(4, 61, 61),
    red_light     = hsl(3, 71, 67),
    green         = hsl(136, 44, 42),
    green_light   = hsl(136, 44, 55),
    yellow        = hsl(46, 100, 44),
    yellow_light  = hsl(46, 100, 61),
    cyan          = hsl(190, 100, 28),
    cyan_light    = hsl(190, 90, 43),
    blue          = hsl(218, 51, 38),
    blue_light    = hsl(218, 51, 61),
    magenta       = hsl(251, 38, 52),
    magenta_light = hsl(250, 38, 67),

    pink0         = hsl(0, 0, 65),
    pink1         = hsl(249, 25, 54),
    blue0         = hsl(194, 37, 40),
    blue1         = hsl(0, 0, 35),
    blue2         = hsl(0, 0, 0),

    bracket       = "",
    builtin       = hsl(249, 35, 44),
    comment       = hsl(0, 0, 55),
    char          = "",
    func          = hsl(249, 35, 51),
    keyword       = hsl(221, 43, 39),
    id            = hsl(0, 0, 90),
    number        = "",
    path          = hsl(213, 38, 39),
    property      = hsl(0, 0, 30),
    operator      = hsl(0, 0, 50),
    string        = hsl(193, 67, 33),
    tag           = "",
    type          = "",
}

colors.dark     = {
    shade0        = hsl(0, 0, 12),
    shade1        = hsl(0, 0, 16),
    shade2        = hsl(0, 0, 20),
    shade3        = hsl(0, 0, 24),
    shade4        = hsl(0, 0, 35),
    shade5        = hsl(0, 0, 50),
    shade6        = hsl(0, 0, 65),
    shade7        = hsl(0, 0, 90),
    shade8        = hsl(0, 0, 97),
    shade9        = hsl(0, 0, 90),

    red           = hsl(4, 61, 61),
    red_light     = "",
    green         = hsl(152, 45, 60),
    green_light   = "",
    yellow        = "",
    yellow_light  = "#e0ab00",
    cyan          = "",
    cyan_light    = "",
    blue          = hsl(250, 44, 75),
    blue_light    = "",
    magenta       = hsl(250, 44, 64),
    magenta_light = hsl(250, 44, 75),

    bracket       = hsl(0, 0, 80),
    builtin       = hsl(250, 44, 64),
    comment       = hsl(0, 0, 43),
    char          = "",
    delimiter     = hsl(0, 0, 60),
    func          = hsl(250, 44, 75),
    keyword       = hsl(214, 61, 69),
    id            = hsl(0, 0, 90),
    number        = hsl(0, 0, 83),
    path          = hsl(214, 61, 69),
    property      = hsl(0, 0, 73),
    operator      = "",
    string        = hsl(194, 37, 61),
    tag           = "",
    type          = hsl(0, 0, 96),

}

---@class MontesquieuColor
local hl_groups = function(c)
    return {
        shade0        = c.shade0,
        shade1        = c.shade1,
        shade2        = c.shade2,
        shade3        = c.shade3,
        shade4        = c.shade4,
        shade5        = c.shade5,
        shade6        = c.shade6,
        shade7        = c.shade7,
        shade8        = c.shade8,
        shade9        = c.shade9,

        red           = c.red,
        red_light     = c.red_light,
        green         = c.green,
        green_light   = c.green_light,
        yellow        = c.yellow,
        yellow_light  = c.yellow_light,
        cyan          = c.cyan,
        cyan_light    = c.cyan_light,
        blue          = c.blue,
        blue_light    = c.blue_light,
        magenta       = c.magenta,
        magenta_light = c.magenta_light,

        hint          = c.yellow,
        ok            = c.yellow,
        success       = c.yellow,
        warn          = c.yellow,
        danger        = c.yellow,

        bracket       = c.bracket,
        builtin       = c.builtin,
        comment       = c.comment,
        delimiter     = c.delimiter,
        func          = c.func,
        keyword       = c.keyword,
        id            = c.id,
        number        = c.number,
        path          = c.path,
        property      = c.property,
        operator      = c.operator,
        string        = c.string,
        type          = c.type
    }
end


local function set_dark_hl(theme)
    theme = theme or "dark"
    local c = hl_groups(colors[theme])


    vim.api.nvim_set_hl(0, "Normal", { fg = c.shade9, bg = c.shade0 })  -- Normal text.
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.shade2 })            -- Normal text in floating windows.
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "NONE", bg = "NONE" }) -- Border of floating windows.
    -- FloatTitle	Title of floating windows.
    -- NormalNC	Normal text in non-current windows.
    vim.api.nvim_set_hl(0, "Pmenu", { bg = c.shade2, fg = c.shade6 })    -- Popup menu: Normal item.
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = c.shade4, fg = c.shade9 }) -- Popup menu: Selected item.
    -- PmenuKind	Popup menu: Normal item "kind".
    -- PmenuKindSel	Popup menu: Selected item "kind".
    -- PmenuExtra	Popup menu: Normal item "extra text".
    -- PmenuExtraSel	Popup menu: Selected item "extra text".
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = c.shade2 }) -- Popup menu: Scrollbar.
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = c.blue1 }) -- Popup menu: Thumb of the scrollbar.
    -- Question	|hit-enter| prompt and yes/no questions.
    -- QuickFixLine	Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    vim.api.nvim_set_hl(0, "Search", { bg = c.blue_light, fg = c.shade9 }) -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
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
    -- ColorColumn	Used for the columns set with 'colorcolumn'.
    vim.api.nvim_set_hl(0, "Conceal", { bg = c.blue_light }) -- Placeholder characters substituted for concealed text (see 'conceallevel')
    -- CurSearch	Used for highlighting a search pattern under the cursor (see 'hlsearch')
    -- Cursor		Character under the cursor.
    -- lCursor		Character under the cursor when |language-mapping| is used (see 'guicursor'). *hl-lCursor*
    -- CursorIM	Like Cursor, but used when in IME mode. *CursorIM* *hl-CursorIM*
    -- CursorColumn	Screen-column at the cursor, when 'cursorcolumn' is set. *hl-CursorColumn*
    -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set. *hl-CursorLine*
    vim.api.nvim_set_hl(0, "CursorLine", { bg = c.shade1 })
    -- Directory	Directory names (and other special names in listings).
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = c.success })     -- Diff mode: Added line. |diff.txt|
    -- DiffChange	Diff mode: Changed line. |diff.txt|
    vim.api.nvim_set_hl(0, "DiffDelete", { fg = c.danger })  -- Diff mode: Deleted line. |diff.txt|
    -- DiffText	Diff mode: Changed text within a changed line. |diff.txt|
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = c.shade0 }) -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor	Cursor in a focused terminal.
    -- TermCursorNC	Cursor in an unfocused terminal.
    -- ErrorMsg	Error messages on the command line.
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.shade3 }) -- Separators between window splits.
    -- Folded		Line used for closed folds.
    -- FoldColumn	'foldcolumn'
    vim.api.nvim_set_hl(0, "SignColumn", { link = "Normal" })                   -- Column where |signs| are displayed.
    vim.api.nvim_set_hl(0, "IncSearch", { bg = c.yellow_light, fg = c.shade9 }) -- 'incsearch' highlighting; also used for the text replaced with ":s///c".
    vim.api.nvim_set_hl(0, "Substitute", { bg = c.red_light, fg = c.shade9 })   -- |:substitute| replacement text highlighting.
    vim.api.nvim_set_hl(0, "LineNr", { bg = c.shade0, fg = c.shade4 })          -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- LineNrAbove	Line number for when the 'relativenumber' option is set, above the cursor line.
    -- LineNrBelow	Line number for when the 'relativenumber' option is set, below the cursor line.
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.shade9 })         -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
    -- CursorLineFold	Like FoldColumn when 'cursorline' is set for the cursor line.
    vim.api.nvim_set_hl(0, "CursorLineSign", { link = "SignColumn" }) -- Like SignColumn when 'cursorline' is set for the cursor line.
    -- MatchParen	Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg		'showmode' message (e.g., "-- INSERT --").
    -- MsgArea		Area for messages and cmdline.
    -- MsgSeparator	Separator for scrolled messages |msgsep|.
    -- MoreMsg		|more-prompt|
    vim.api.nvim_set_hl(0, "NonText", { fg = c.shade3 }) -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.

    -- *Comment
    vim.api.nvim_set_hl(0, "Comment", { fg = c.comment, italic = true }) -- any comment
    -- *Constant
    vim.api.nvim_set_hl(0, "Constant", { fg = hsl(330, 46, 66) })        -- any constants
    vim.api.nvim_set_hl(0, "Character", { link = "Type" })               --  Character	a character constant: 'c', '\n'
    vim.api.nvim_set_hl(0, "String", { fg = c.string })                  -- a string constant: "this is a string"
    vim.api.nvim_set_hl(0, "Number", { fg = c.number })                  -- a number constant: 234, 0xff
    vim.api.nvim_set_hl(0, "Boolean", { link = "Keyword" })              -- a boolean constant: TRUE, false
    vim.api.nvim_set_hl(0, "Float", { link = "Number" })                 -- a floating point constant: 2.3e10
    -- *Identifier
    vim.api.nvim_set_hl(0, "Identifier", { fg = c.id })                  -- any variable name
    vim.api.nvim_set_hl(0, "Function", { fg = c.func })                  -- function name (also: methods for classes)
    vim.api.nvim_set_hl(0, "Statement", { link = "Keyword" })            -- any statement
    vim.api.nvim_set_hl(0, "Conditional", { link = "Keyword" })          -- if, then, else, endif, switch, etc.
    vim.api.nvim_set_hl(0, "Repeat", { link = "Keyword" })               -- for, do, while, etc.
    vim.api.nvim_set_hl(0, "Label", { link = "Keyword" })                --  case, default, etc.
    vim.api.nvim_set_hl(0, "Operator", { fg = c.operator })              -- "sizeof", "+", "*", etc.
    vim.api.nvim_set_hl(0, "Keyword", { fg = c.keyword })                --  any other keyword
    vim.api.nvim_set_hl(0, "Exception", { link = "Keyword" })            --  Exception	try, catch, throw
    -- *PreProc
    vim.api.nvim_set_hl(0, "PreProc", { link = "Keyword" })              -- generic Preprocessor
    --  Include	preprocessor #include
    --  Define		preprocessor #define
    --  Macro		same as Define
    --  PreCondit	preprocessor #if, #else, #endif, etc.

    -- *Type
    vim.api.nvim_set_hl(0, "Type", { fg = c.type }) -- int, long, char, etc.
    --  StorageClass	static, register, volatile, etc.
    --  Structure	struct, union, enum, etc.
    --  Typedef	A typedef

    -- *Special	
    vim.api.nvim_set_hl(0, "Special", { fg = c.shade9 }) -- any special symbol
    --  SpecialChar	special character in a constant
    --  Tag		you can use CTRL-] on this
    vim.api.nvim_set_hl(0, "Delimiter", { fg = c.delimiter }) -- character that needs attention
    --  SpecialComment	special things inside a comment
    --  Debug		debugging statements
    -- *Underlined	text that stands out, HTML links
    -- *Ignore		left blank, hidden  |hl-Ignore|
    -- *Error
    vim.api.nvim_set_hl(0, "Error", { fg = c.danger }) -- any erroneous construct
    -- *Todo		anything that needs extra attention; mostly the keywords TODO FIXME and XXX


    --- Languages spec without Treesitter
    vim.api.nvim_set_hl(0, "htmlTag", { link = "Comment" })
    vim.api.nvim_set_hl(0, "htmlEndTag", { link = "htmlTag" })
    vim.api.nvim_set_hl(0, "luaFunc", { fg = c.builtin })
    vim.api.nvim_set_hl(0, "nixSimpleBuiltin", { fg = c.builtin })
    --- Treesitter
    vim.api.nvim_set_hl(0, "@keyword.import", { fg = c.builtin })
    vim.api.nvim_set_hl(0, "@variable.member", { fg = c.property })
    vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Delimiter" })
    vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = c.bracket })
    vim.api.nvim_set_hl(0, "@function.make", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@function.builtin", { fg = c.builtin })
    vim.api.nvim_set_hl(0, "@string.special.path", { fg = c.path })
    -- Diagnostics
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { undercurl = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", {})
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {})
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", {})
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {})
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = c.yellow_light })
end

set_dark_hl()
