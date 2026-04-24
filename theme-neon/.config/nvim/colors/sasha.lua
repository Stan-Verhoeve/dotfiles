vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "sasha"

local bg      = "NONE"
local bg_dark = "#2a003d"
local bg_sel  = "#4b004d"
local fg      = "#ffb7ff"
local keyword = "#ff66cc"   -- pink: keywords, bold constructs
local string_ = "#c9a0ff"   -- soft lavender: strings, literals
local muted   = "#7a3d7a"   -- dimmed purple: comments
local border  = "#ff4da6"
local yellow  = "#ffff00"
local cyan    = "#00fff7"
local red     = "#ff5555"

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Base
hi("Normal",       { bg = bg,      fg = fg })
hi("NormalFloat",  { bg = bg_dark, fg = fg })
hi("NormalNC",     { bg = bg,      fg = fg })
hi("SignColumn",   { bg = bg })
hi("FoldColumn",   { bg = bg,  fg = muted })
hi("Folded",       { bg = bg_dark, fg = fg })
hi("ColorColumn",  { bg = bg_sel })
hi("Conceal",      { fg = muted })

-- Cursor / lines
hi("CursorLine",   { bg = bg_sel })
hi("CursorColumn", { bg = bg_sel })
hi("CursorLineNr", { fg = fg, bold = true })
hi("LineNr",       { bg = bg, fg = muted })

-- Status / splits
hi("StatusLine",   { bg = bg_dark, fg = fg })
hi("StatusLineNC", { bg = bg,      fg = muted })
hi("WinSeparator", { fg = border })
hi("VertSplit",    { fg = border })

-- Tabline
hi("TabLine",      { bg = bg,      fg = fg })
hi("TabLineSel",   { bg = bg_dark, fg = fg, bold = true })
hi("TabLineFill",  { bg = bg })

-- Search
hi("Search",    { bg = yellow, fg = bg_dark, bold = true })
hi("IncSearch", { bg = border, fg = bg_dark, bold = true })
hi("CurSearch", { bg = border, fg = bg_dark, bold = true })

-- Selection
hi("Visual",    { bg = bg_sel })
hi("VisualNOS", { bg = bg_sel })

-- Popups / completion
hi("Pmenu",      { bg = bg_dark, fg = fg })
hi("PmenuSel",   { bg = bg_sel,  fg = fg, bold = true })
hi("PmenuSbar",  { bg = bg_sel })
hi("PmenuThumb", { bg = border })
hi("FloatBorder",{ bg = bg_dark, fg = border })

-- Messages
hi("ErrorMsg",   { fg = red })
hi("WarningMsg", { fg = yellow })
hi("ModeMsg",    { fg = fg, bold = true })
hi("MoreMsg",    { fg = fg })
hi("Question",   { fg = fg })

-- Diffs
hi("DiffAdd",    { bg = "#002200" })
hi("DiffChange", { bg = "#00002a" })
hi("DiffDelete", { bg = "#2a0000" })
hi("DiffText",   { bg = "#00003d" })

-- Spelling
hi("SpellBad",  { undercurl = true, sp = red })
hi("SpellWarn", { undercurl = true, sp = yellow })
hi("SpellCap",  { undercurl = true, sp = cyan })

-- Syntax: 3 tiers — keywords (pink+bold), strings (lavender), everything else (fg)
hi("Comment",      { fg = muted,   italic = true })
hi("Constant",     { fg = string_ })
hi("String",       { fg = string_ })
hi("Character",    { fg = string_ })
hi("Number",       { fg = string_ })
hi("Boolean",      { fg = string_ })
hi("Float",        { fg = string_ })
hi("Identifier",   { fg = fg })
hi("Function",     { fg = fg })
hi("Statement",    { fg = keyword, bold = true })
hi("Keyword",      { fg = keyword, bold = true })
hi("Conditional",  { fg = keyword, bold = true })
hi("Repeat",       { fg = keyword, bold = true })
hi("Operator",     { fg = fg })
hi("PreProc",      { fg = keyword })
hi("Include",      { fg = keyword, bold = true })
hi("Define",       { fg = keyword })
hi("Macro",        { fg = keyword })
hi("Type",         { fg = fg })
hi("StorageClass", { fg = keyword, bold = true })
hi("Structure",    { fg = fg })
hi("Special",      { fg = fg })
hi("SpecialChar",  { fg = string_ })
hi("Delimiter",    { fg = fg })
hi("Underlined",   { underline = true })

-- Treesitter: same 3-tier philosophy
hi("@comment",               { fg = muted,   italic = true })
hi("@variable",              { fg = fg })
hi("@variable.builtin",      { fg = keyword, bold = true })
hi("@constant",              { fg = string_ })
hi("@constant.builtin",      { fg = keyword, bold = true })
hi("@string",                { fg = string_ })
hi("@number",                { fg = string_ })
hi("@boolean",               { fg = keyword, bold = true })
hi("@function",              { fg = fg })
hi("@function.builtin",      { fg = keyword })
hi("@function.call",         { fg = fg })
hi("@method",                { fg = fg })
hi("@method.call",           { fg = fg })
hi("@keyword",               { fg = keyword, bold = true })
hi("@keyword.function",      { fg = keyword, bold = true })
hi("@keyword.return",        { fg = keyword, bold = true })
hi("@operator",              { fg = fg })
hi("@punctuation.bracket",   { fg = fg })
hi("@punctuation.delimiter", { fg = fg })
hi("@type",                  { fg = fg })
hi("@type.builtin",          { fg = keyword, bold = true })
hi("@parameter",             { fg = fg })
hi("@field",                 { fg = fg })
hi("@property",              { fg = fg })
hi("@namespace",             { fg = fg })
hi("@tag",                   { fg = fg, bold = true })
hi("@tag.attribute",         { fg = fg })
hi("@tag.delimiter",         { fg = fg })
hi("@text.literal",          { fg = fg })
hi("@text.title",            { fg = fg, bold = true })
hi("@text.uri",              { fg = fg, underline = true })
hi("@text.strong",           { bold = true })
hi("@text.emphasis",         { italic = true })
hi("@text.math",             { fg = fg })
hi("@markup.heading",        { fg = fg, bold = true })
hi("@markup.link",           { fg = fg, underline = true })
hi("@markup.raw",            { fg = fg })
hi("@markup.math",           { fg = fg })
hi("@markup.strong",         { bold = true })
hi("@markup.italic",         { italic = true })

-- Diagnostics
hi("DiagnosticError",          { fg = red })
hi("DiagnosticWarn",           { fg = yellow })
hi("DiagnosticInfo",           { fg = cyan })
hi("DiagnosticHint",           { fg = muted })
hi("DiagnosticUnderlineError", { undercurl = true, sp = red })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = yellow })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = cyan })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = muted })

-- LSP references
hi("LspReferenceText",  { bg = bg_sel })
hi("LspReferenceRead",  { bg = bg_sel })
hi("LspReferenceWrite", { bg = bg_sel, bold = true })

-- Gitsigns
hi("GitSignsAdd",    { fg = "#00ff88", bg = bg })
hi("GitSignsChange", { fg = cyan,      bg = bg })
hi("GitSignsDelete", { fg = red,       bg = bg })

-- Telescope
hi("TelescopeBorder",         { fg = border })
hi("TelescopePromptBorder",   { fg = border })
hi("TelescopeResultsBorder",  { fg = border })
hi("TelescopePreviewBorder",  { fg = border })
hi("TelescopeSelection",      { bg = bg_sel, fg = fg, bold = true })
hi("TelescopeSelectionCaret", { fg = border })
hi("TelescopeMatching",       { fg = fg, bold = true, underline = true })
hi("TelescopePromptPrefix",   { fg = border })
