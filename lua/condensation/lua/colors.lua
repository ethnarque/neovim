local M = {}

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

M.night = {}
M.day = {}

M.night.shade = {
    hsl(0, 1, 10), -- 1 - | bg
    hsl(0, 1, 10), -- 2 - | Cursor line
    hsl(0, 1, 13), -- 3 - | Menu and Visual
    hsl(0, 1, 16), -- 4 - | winSeparator and list chars
    hsl(0, 1, 19), -- 5 - Active / Selected UI element background
    hsl(0, 1, 23), -- 6 - | Selected list background
    hsl(0, 1, 28), -- 7 - | Comments
    hsl(0, 1, 38), -- 8 - | Selected list text
    hsl(0, 1, 43), -- 9 - Solid backgrounds
    hsl(0, 1, 48), -- 10 - | Brackets and delimiters
    hsl(0, 1, 71), -- 11 - | + Operators
    hsl(0, 1, 93), -- 12 - High-constrast text
}

M.day.shade = {
    hsl(30, 10, 96), -- 1 - | bg
    hsl(30, 10, 92), -- 2 - | Cursor line
    hsl(30, 10, 90), -- 3 - | Menu and Visual
    hsl(0, 0, 88),   -- 4 - | winSeparator and list chars
    hsl(0, 0, 88),   -- 5 - Active / Selected UI element background
    hsl(0, 0, 85),   -- 6 - | Selected list background
    hsl(0, 0, 73),   -- 7 - | Comments
    hsl(0, 0, 64),   -- 8 - | Menu item text + statusbar
    hsl(0, 0, 55),   -- 9 - Solid backgrounds
    hsl(0, 0, 51),   -- 10 - | Brackets and delimiters
    hsl(0, 0, 39),   -- 11 - | Low constrast text + Operators
    hsl(0, 0, 13),   -- 12 - | High-constrast text - Titles, constants
}

local base16_night = {
    "",               -- black
    "",               -- red
    "",               -- green
    "",               -- yellow
    hsl(214, 61, 69), -- blue
    hsl(245, 36, 68), -- magenta
    hsl(194, 37, 61), -- cyan
    "",               -- white
    "",               -- black bright
    "",               -- red bright
    "",               -- green bright
    "",               -- yellow bright
    "",               -- blue bright
    hsl(250, 44, 75), -- magenta bright
    "",               -- cyan bright
    "",               -- white bright
}

local function make_scale(shades)
    local temp = {}

    for idx, shade in ipairs(shades) do
        temp[idx] = shade
    end

    return temp
end

local gs = make_scale(M.night.shade)
local cs = base16_night

local groups = {
    ["Normal"]                 = { bg = gs[1], fg = gs[11] }, -- Normal text.
    ["NormalFloat"]            = { bg = gs[3] },              -- Normal text in floating windows.
    ["FloatBorder"]            = {},                          -- Border of floating windows.
    ["FloatTitle"]             = { link = "Title" },          -- Title of floating windows.
    ["NormalNC"]               = {},                          -- Normal text in non-current windows.
    ["Pmenu"]                  = { bg = gs[3], fg = gs[8] },  -- Popup menu: Normal item.
    ["PmenuSel"]               = { bg = gs[6], fg = gs[12] }, -- Popup menu: Selected item.
    -- PmenuKind	Popup menu: Normal item "kind".
    -- PmenuKindSel	Popup menu: Selected item "kind".
    -- PmenuExtra	Popup menu: Normal item "extra text".
    -- PmenuExtraSel	Popup menu: Selected item "extra text".
    ["PmenuSbar"]              = { bg = gs[3] },                 -- Popup menu: Scrollbar.
    ["PmenuThumb"]             = { bg = gs[11] },                -- Popup menu: Thumb of the scrollbar.
    ["Question"]               = { link = "String" },            --|hit-enter| prompt and yes/no questions.
    ["QuickFixLine"]           = { link = "Search" },            -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    ["Search"]                 = { fg = "orange", bold = true }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    -- SpecialKey	Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad	Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap	Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal	Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare	Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    ["StatusLine"]             = { fg = gs[12], bg = gs[8] }, -- Status line of current window.
    -- StatusLineNC	Status lines of not-current windows. Note: If this is equal to "StatusLine", Vim will use "^^^" in the status line of the current window.
    -- TabLine		Tab pages line, not active tab page label.
    -- TabLineFill	Tab pages line, where there are no labels.
    -- TabLineSel	Tab pages line, active tab page label.
    ["Title"]                  = { fg = gs[12] }, -- Titles for output from ":set all", ":autocmd" etc.
    ["Visual"]                 = { bg = gs[3] },  -- Visual mode selection.
    -- VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg	Warning messages.
    ["Whitespace"]             = { fg = gs[4] }, -- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
    -- ["WildMenu"] = {}, -- Current match in 'wildmenu' completion.
    -- ["WinBar"] = {}, -- Window bar of current window.
    -- ["WinBarNC"] = {}, -- Window bar of not-current windows.
    ["Menu"]                   = {}, -- Current font, background and foreground colors of the menus. Also used for the toolbar. Applicable highlight arguments: font, guibg, guifg.
    ["Scrollbar"]              = {}, -- Current background and foreground of the main window's scrollbars. Applicable highlight arguments: guibg, guifg.
    ["Tooltip"]                = {}, -- Current font, background and foreground of the tooltips. Applicable highlight arguments: font, guibg, guifg.
    --- Editor
    -- ColorColumn	Used for the columns set with 'colorcolumn'.
    ["Conceal"]                = { bg = "" }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    -- CurSearch	Used for highlighting a search pattern under the cursor (see 'hlsearch')
    -- Cursor		Character under the cursor.
    -- lCursor		Character under the cursor when |language-mapping| is used (see 'guicursor'). *hl-lCursor*
    -- CursorIM	Like Cursor, but used when in IME mode. *CursorIM* *hl-CursorIM*
    -- CursorColumn	Screen-column at the cursor, when 'cursorcolumn' is set. *hl-CursorColumn*
    -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set. *hl-CursorLine*
    ["CursorLine"]             = { bg = gs[2] },
    -- Directory	Directory names (and other special names in listings).
    ["DiffAdd"]                = { fg = "green" },  -- Diff mode: Added line. |diff.txt|
    ["DiffChange"]             = { fg = "orange" }, -- Diff mode: Changed line. |diff.txt|
    ["DiffDelete"]             = { fg = "red" },    -- Diff mode: Deleted line. |diff.txt|
    ["DiffText"]               = { fg = "violet" }, -- Diff mode: Changed text within a changed line. |diff.txt|
    ["EndOfBuffer"]            = { fg = gs[1] },    -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor	Cursor in a focused terminal.
    -- TermCursorNC	Cursor in an unfocused terminal.
    ["ErrorMsg"]               = { fg = "red" }, -- Error messages on the command line.
    ["WinSeparator"]           = { fg = gs[4] }, -- Separators between window splits.
    -- Folded		Line used for closed folds.
    -- FoldColumn	'foldcolumn'
    ["SignColumn"]             = { link = "Normal" },        -- Column where |signs| are displayed.
    ["IncSearch"]              = { fg = "orange" },          -- 'incsearch' highlighting; also used for the text replaced with ":s///c".
    ["Substitute"]             = { fg = "red" },             -- |:substitute| replacement text highlighting.
    ["LineNr"]                 = { bg = gs[1], fg = gs[7] }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- Cmp
    ["CmpItemAbbr"]            = { fg = gs[8] },             -- Popup menu: Normal item.
    ["CmpItemKind"]            = { fg = gs[8] },             -- Popup menu: Normal item.
    ["LineNrAbove"]            = { link = "LineNr" },        -- Line number for when the 'relativenumber' option is set, above the cursor line.
    ["LineNrBelow"]            = { link = "LineNr" },        -- Line number for when the 'relativenumber' option is set, below the cursor line.
    ["CursorLineNr"]           = { fg = gs[11] },            -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
    -- CursorLineFold	Like FoldColumn when 'cursorline' is set for the cursor line.
    ["CursorLineSign"]         = { link = "SignColumn" },    -- Like SignColumn when 'cursorline' is set for the cursor line.
    ["MatchParen"]             = { link = "Search" },        --	Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg		'showmode' message (e.g., "-- INSERT --").
    -- MsgArea		Area for messages and cmdline.
    -- MsgSeparator	Separator for scrolled messages |msgsep|.
    -- MoreMsg		|more-prompt|
    ["NonText"]                = { link = "Whitespace" },       -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    -- Syntax
    ["Comment"]                = { fg = gs[7], italic = true }, --* any comment
    ["Constant"]               = { fg = gs[12] },               -- * any constants
    ["Character"]              = { link = "Type" },             -- a character constant: 'c', '\n'
    ["String"]                 = { fg = cs[7] },                -- a string constant: "this is a string"
    ["Number"]                 = { fg = gs[11] },               -- a number constant: 234, 0xff
    ["Boolean"]                = { link = "Keyword" },          -- a boolean constant: TRUE, false
    ["Float"]                  = { link = "Number" },           -- a floating point constant: 2.3e10
    ["Identifier"]             = { fg = gs[11] },               -- * any variable name
    ["Function"]               = { fg = cs[14] },               -- function name (also: methods for classes)
    ["Statement"]              = { link = "Keyword" },          -- any statement
    ["Conditional"]            = { link = "Keyword" },          -- if, then, else, endif, switch, etc.
    ["Repeat"]                 = { link = "Keyword" },          -- for, do, while, etc.
    ["Label"]                  = { link = "Keyword" },          --  case, default, etc.
    ["Operator"]               = { fg = gs[10] },               -- "sizeof", "+", "*", etc.
    ["Keyword"]                = { fg = cs[5] },                --  any other keyword
    ["Exception"]              = { link = "Keyword" },          --  Exception	try, catch, throw
    ["PreProc"]                = { link = "Keyword" },          -- * generic Preprocessor
    ["Include"]                = { link = "Keyword" },          -- preprocessor #include
    --  Define		preprocessor #define
    --  Macro		same as Define
    ["PreCondit"]              = { link = "Keyword" }, -- preprocessor #if, #else, #endif, etc.
    ["Type"]                   = {},                   -- * int, long, char, etc.
    ["StorageClass"]           = { link = "Keyword" }, -- static, register, volatile, etc.
    --  Structure	struct, union, enum, etc.
    --  Typedef	A typedef
    ["Special"]                = {},                                  -- * any special symbol
    --  SpecialChar	special character in a constant
    ["Tag"]                    = {},                                  -- you can use CTRL-] on this
    ["Delimiter"]              = { fg = gs[10] },                     -- character that needs attention
    --  SpecialComment	special things inside a comment
    ["Debug"]                  = {},                                  -- debugging statements
    ["Underline"]              = { italic = true, underline = true }, -- * text that stands out, HTML links
    ["Ignore"]                 = { fg = gs[7] },                      -- * left blank, hidden  |hl-Ignore|
    ["Error"]                  = { fg = "red" },                      -- * any erroneous construct
    ["Todo"]                   = { fg = gs[12] },                     -- * anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    -- Extra syntax
    ["luaFunc"]                = { link = "Function" },
    ["luaTable"]               = { link = "Delimiter" },
    -- Treesitter
    ["@constructor"]           = { link = "Identifier" },
    ["@punctuation.bracket"]   = { link = "Delimiter" },
    ["@punctuation.delimiter"] = { link = "Delimiter" },
    ["@variable.member"]       = { fg = gs[10] },

}


for group, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, group, spec)
end



return M
