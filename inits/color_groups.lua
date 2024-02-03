local api = vim.api
 local g = vim.g
local fn = vim.fn local colors = require("color_functions")

local function lchToHex(hex)
  local newLch = colors.lch:set(lch.l, lch.c, lch.h)
  return newLch:to("HEX")
end

api.nvim_set_hl(0, "@comment",             { link = "Comment"         })
api.nvim_set_hl(0, "@constant",            { link = "Constant"        })
api.nvim_set_hl(0, "@constructor",         { link = "Special"         })
api.nvim_set_hl(0, "@function.builtin",    { link = "Function"        })
api.nvim_set_hl(0, "@function.call",       { link = "Function"        })
api.nvim_set_hl(0, "@parameter",           { link = "@variable"       })
api.nvim_set_hl(0, "@punctuation.bracket", { link = "@punctuation"    })
api.nvim_set_hl(0, "@punctuation.special", { link = "@punctuation"    })
api.nvim_set_hl(0, "@punctuation",         { link = "Delimiter"       })
api.nvim_set_hl(0, "@string",              { link = "String"          })
api.nvim_set_hl(0, "@string.escape",       { link = "String"          })
api.nvim_set_hl(0, "@tag",                 { link = "Tag"             })
api.nvim_set_hl(0, "@text.delimiter",      { link = "Delimiter"       })
api.nvim_set_hl(0, "@text",                { link = "Text"            })
api.nvim_set_hl(0, "@text.heading.inline", { link = "@text.title"     })
api.nvim_set_hl(0, "@text.title.1",        { link = "@text.title"     })
api.nvim_set_hl(0, "@text.title.2",        { link = "@text.title"     })
api.nvim_set_hl(0, "@text.title.3",        { link = "@text.title"     })
api.nvim_set_hl(0, "@text.title.4",        { link = "@text.title"     })
api.nvim_set_hl(0, "@text.math",           { link = "Math"            })
api.nvim_set_hl(0, "@text.title",          { link = "Title"           })
api.nvim_set_hl(0, "@variable",            { link = "Variable"        })
api.nvim_set_hl(0, "@variable.parameter",  { link = "Argument"        })
api.nvim_set_hl(0, "Character",            { link = "String"          })
api.nvim_set_hl(0, "CursorLineNr",         { link = "LineNr"          })
api.nvim_set_hl(0, "FloatBorder",          { link = "Special"         })
api.nvim_set_hl(0, "NeoTreeCursorLine",    { link = "CursorLine"      })
api.nvim_set_hl(0, "lineNrAbove",          { link = "LineNrHidden"    })
api.nvim_set_hl(0, "lineNrBelow",          { link = "LineNrHidden"    })
api.nvim_set_hl(0, "lineNrHidden",         { link = "Hidden"          })
api.nvim_set_hl(0, "zshBrackets",          { link = "Delimiter"       })
api.nvim_set_hl(0, "zshFunction",          { link = "Function"        })
api.nvim_set_hl(0, "zshOperator",          { link = "Operator"        })
api.nvim_set_hl(0, "zshParentheses",       { link = "NvimParenthesis" })
api.nvim_set_hl(0, "zshVariable",          { link = "@variable"       })

api.nvim_set_hl(0, "NeoTreeDotFiles",      { link = "Hidden"    })
api.nvim_set_hl(0, "NeoTreeDimText",       { link = "Hidden"    })
api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { link = "Directory" })
api.nvim_set_hl(0, "NeoTreeDirectoryName", { link = "Directory" })
api.nvim_set_hl(0, "NeoTreeFileIcon",      { link = "File"      })
api.nvim_set_hl(0, "NeoTreeFileName",      { link = "File"      })

api.nvim_set_hl(0, "lualine_x_diff_added_command",  { link = "DiffAdd" })
api.nvim_set_hl(0, "lualine_x_diff_added_inactive", { link = "DiffAdd" })
api.nvim_set_hl(0, "lualine_x_diff_added_insert",   { link = "DiffAdd" })
api.nvim_set_hl(0, "lualine_x_diff_added_normal",   { link = "DiffAdd" })
api.nvim_set_hl(0, "lualine_x_diff_added_replace",  { link = "DiffAdd" })
api.nvim_set_hl(0, "lualine_x_diff_added_terminal", { link = "DiffAdd" })
api.nvim_set_hl(0, "lualine_x_diff_added_visual",   { link = "DiffAdd" })
api.nvim_set_hl(0, "NeoTreeGitAdded",               { link = "DiffAdd" })
api.nvim_set_hl(0, "NeoTreeGitStaged",              { link = "DiffAdd" })
api.nvim_set_hl(0, "NeoTreeGitRenamed",             { link = "DiffAdd" })

api.nvim_set_hl(0, "lualine_x_diff_modified_command",  { link = "DiffModify" })
api.nvim_set_hl(0, "lualine_x_diff_modified_inactive", { link = "DiffModify" })
api.nvim_set_hl(0, "lualine_x_diff_modified_insert",   { link = "DiffModify" })
api.nvim_set_hl(0, "lualine_x_diff_modified_normal",   { link = "DiffModify" })
api.nvim_set_hl(0, "lualine_x_diff_modified_replace",  { link = "DiffModify" })
api.nvim_set_hl(0, "lualine_x_diff_modified_terminal", { link = "DiffModify" })
api.nvim_set_hl(0, "lualine_x_diff_modified_visual",   { link = "DiffModify" })
api.nvim_set_hl(0, "DiffChange",                       { link = "DiffModify" })
api.nvim_set_hl(0, "NeoTreeGitModified",               { link = "DiffModify" })
api.nvim_set_hl(0, "NeoTreeGitRenamed",                { link = "DiffModify" })

api.nvim_set_hl(0, "lualine_x_diff_removed_command",  { link = "DiffRemove" })
api.nvim_set_hl(0, "lualine_x_diff_removed_inactive", { link = "DiffRemove" })
api.nvim_set_hl(0, "lualine_x_diff_removed_insert",   { link = "DiffRemove" })
api.nvim_set_hl(0, "lualine_x_diff_removed_normal",   { link = "DiffRemove" })
api.nvim_set_hl(0, "lualine_x_diff_removed_replace",  { link = "DiffRemove" })
api.nvim_set_hl(0, "lualine_x_diff_removed_terminal", { link = "DiffRemove" })
api.nvim_set_hl(0, "lualine_x_diff_removed_visual",   { link = "DiffRemove" })
api.nvim_set_hl(0, "DiffDelete",                      { link = "DiffRemove" })

api.nvim_set_hl(0, "lualine_c_2_normal",  { link = "LualineN" })
api.nvim_set_hl(0, "lualine_c_2_insert",  { link = "LualineI" })
api.nvim_set_hl(0, "lualine_c_2_visual",  { link = "LualineV" })
api.nvim_set_hl(0, "lualine_c_7_normal",  { link = "LualineN" })
api.nvim_set_hl(0, "lualine_c_7_insert",  { link = "LualineI" })
api.nvim_set_hl(0, "lualine_c_7_visual",  { link = "LualineV" })
api.nvim_set_hl(0, "lualine_x_10_normal", { link = "LualineN" })
api.nvim_set_hl(0, "lualine_x_10_insert", { link = "LualineI" })
api.nvim_set_hl(0, "lualine_x_10_visual", { link = "LualineV" })

api.nvim_set_hl(0, "@spell",             { link = "@none" })
api.nvim_set_hl(0, "FloatShadow",        { link = "@none" })
api.nvim_set_hl(0, "FloatShadowThrough", { link = "@none" })
api.nvim_set_hl(0, "Normal",             { link = "@none" })
api.nvim_set_hl(0, "NormalFloat",        { link = "@none" })
api.nvim_set_hl(0, "NormalNC",           { link = "@none" })
api.nvim_set_hl(0, "Pmenu",              { link = "@none" })
api.nvim_set_hl(0, "PmenuSel",           { link = "@none" })
api.nvim_set_hl(0, "CursorLine",         { link = "@none" })
api.nvim_set_hl(0, "@none",              {})

api.nvim_set_hl(0, "CursorColumn",         { link = "Column" })
api.nvim_set_hl(0, "FoldColumn",           { link = "Column" })
api.nvim_set_hl(0, "NvimTreeCursorColumn", { link = "Column" })
api.nvim_set_hl(0, "NvimTreeSignColumn",   { link = "Column" })
api.nvim_set_hl(0, "SignColumn",           { link = "Column" })

api.nvim_set_hl(0, "@ibl.scope.whitespace.1", { link = "FirstWhitespace"     })
api.nvim_set_hl(0, "@ibl.whitespace.char.1" , { link = "FirstWhitespace"     })
api.nvim_set_hl(0, "IblWhitespace",           { link = "FirstWhitespace"     })
api.nvim_set_hl(0, "@ibl.indent.char.1",      { link = "IblIndent"           })
api.nvim_set_hl(0, "NeoTreeIndentMarkder",    { link = "IblIndent"           })
api.nvim_set_hl(0, "@ibl.scope.whitespace.2", { link = "SecondWhitespace"    })
api.nvim_set_hl(0, "@ibl.whitespace.char.2" , { link = "SecondWhitespace"    })
api.nvim_set_hl(0, "@ibl.scope.char.1",       { link = "ScopeGuide"          })
api.nvim_set_hl(0, "@ibl.scope.underline.1",  { underline = true })

api.nvim_set_hl(0, "SpellBad",   { underline = true, italic = true })
api.nvim_set_hl(0, "SpellLocal", { underline = true, italic = true })
api.nvim_set_hl(0, "SpellRare",  { underline = true, italic = true })
api.nvim_set_hl(0, "SpellCap",   { underline = true, italic = true })

local colorschemes = {
  mayukai_dark = {
    { color = { fg = "#3d424d" }, groups = { "Normal", "NormalNC", "MsgArea" } },
    { color = { fg = "#000000" }, groups = { "Visual", "Search", "IncSearch" } },
    { color = { fg = "#ff3333" }, groups = { "Error", "DiagnosticError" } },
    { color = { fg = "#95e6cb" }, groups = { "Info", "DiagnosticInfo", "DiffAdd" } },
    { color = { fg = "#ffb454" }, groups = { "Warning", "DiagnosticWarn" } },
    { color = { fg = "#dadbc0" }, groups = { "LineNr" } },
    { color = { fg = "#ff4057" }, groups = { "Cursor", "iCursor" } },
    { color = { fg = "#b3b1ad" }, groups = { "Comment", "Conceal", "NonText" } },
    { color = { fg = "#bae67e" }, groups = { "String", "Constant" } },
    { color = { fg = "#95e6cb" }, groups = { "Special", "SpecialChar" } },
    { color = { fg = "#9dd2bb" }, groups = { "Number", "Float" } },
    { color = { fg = "#f07178" }, groups = { "Statement", "Conditional", "Repeat" } },
    { color = { fg = "#ffa759" }, groups = { "Identifier", "Function", "Keyword" } },
    { color = { fg = "#ff6188" }, groups = { "Operator", "Delimiter" } },
    { color = { fg = "#dadbc0" }, groups = { "Variable", "PreProc", "Include", "Define", "Macro", "PreCondit" } },
    { color = { fg = "#f29e74" }, groups = { "Type", "StorageClass", "Structure", "Typedef" } },
    { color = { fg = "#d4bfff" }, groups = { "Argument", "Tag", "Label", "Enum" } },
    { color = { fg = "#ffd580" }, groups = { "Title", "SpecialComment", "Debug" } },
  },
  marri = {
    { color = { bg = "#4e4e00" }, groups = { "Visual", "Search", "IncSearch" } },
    { color = { fg = "#e6db74" }, groups = { "Delimiter" } },
    { color = { fg = "#f8f8f2" }, groups = { "Normal", "NormalNC" } },
    { color = { fg = "#fd971f" }, groups = { "Variable" } },
    { color = { fg = "#f92672" }, groups = { "Error", "DiagnosticError", "DiffRemove" } },
    { color = { fg = "#a6e22e" }, groups = { "Info", "DiagnosticInfo", "DiffAdd" } },
    { color = { fg = "#e6db74" }, groups = { "Warning", "DiagnosticWarn", "DiffModify" } },
    { color = { fg = "#75715e" }, groups = { "Comment", "Conceal", "NonText", "IblIndent", "WinSeparator", "Hidden" } },
    { color = { fg = "#ffffff" }, groups = { "String", "Constant", "Text" } },
    { color = { fg = "#66d9ef" }, groups = { "LineNr", "Special", "SpecialChar", "PreProc", "Title", "ScopeGuide", "LualineV" } },
    { color = { fg = "#ae81ff" }, groups = { "Number", "Float" } },
    { color = { fg = "#f92672" }, groups = { "Statement", "Conditional", "Repeat" } },
    { color = { fg = "#f92672" }, groups = { "MsgArea", "LualineN" } },
    { color = { fg = "#91abc9" }, groups = { "Identifier" } },
    { color = { fg = "#f92672" }, groups = { "FirstWhitespace", "Directory" } },
    { color = { fg = "#f73754" }, groups = { "SecondWhitespace", "File" } },
    { color = { fg = "#a6e22e" }, groups = { "Function", "LualineI"  } },
    { color = { fg = "#f8f8f2" }, groups = { "Include", "Define", "Macro", "PreCondit" } },
    { color = { fg = "#fd1f1f" }, groups = { "Type", "Keyword", "StorageClass", "Structure", "Typedef" } },
    { color = { fg = "#f4bf75" }, groups = { "Tag", "Label", "Enum", "Math" } },
    { color = { fg = "#f8f8f2" }, groups = { "SpecialComment", "Debug" } },
  },
  norm = {
    { color = { ctermfg = "NONE", ctermbg = "NONE" }, groups = { "@none" } },
    { color = { fg = "#FF8700", underline = true }, groups = { "@ibl.scope.underline.1", "IblScope", "NeoTreeFileNameOpened", "@text.title" } },
    { color = { bg = "#FF0000", underline = true }, groups = { "Error", "ErrorMsg" } },
    { color = { fg = "#FFFFFF", italic = true }, groups = { "@text.emphasis" } },
    { color = { fg = "#FF0000" }, groups = { "DiffRemove" } },
    { color = { fg = "#5FAF5F" }, groups = { "DiffAdd" } },
    { color = { fg = "#C9B6B3" }, groups = { "DiffModify" } },
    { color = { fg = "#FF8700" }, groups = { "@ibl.scope.char.1" } },
    { color = { fg = "#FFFFFF" }, groups = { "ScopeGuide", "DiffAdd" } },
    { color = { fg = "#FFFFFF" }, groups = { "Constant", "String", "Tag", "WhichKeyGroup" } },
    { color = { fg = "#FFFFFF" }, groups = { "@constructor", "@documentation", "LineNr" } },
    { color = { fg = "#FFFFFF" }, groups = { "Keyword", "PreProc", "rustFoldBraces" } },
    { color = { fg = "#FFFFFF" }, groups = { "@conditional", "@punctuation", "Function" } },
    { color = { fg = "#FFFFFF" }, groups = { "Delimiter", "NeoTreeRootName", "Special", "zshBrackets", "iblIndent", "VertSplit" } },
    { color = { fg = "#FFFFFF" }, groups = { "@attribute", "@tag.attribute", "Conditional", "Debug", "Label", "Operator", "Statement", "WhichKeyDesc" } },
    { color = { fg = "#FFFFFF" }, groups = { "Define", "Directory", "Tabline", "Type" } },
    { color = { fg = "#FFFFFF" }, groups = { "Number" } },
    { color = { fg = "#FFFFFF" }, groups = { "@field", "@symbol", "CmpItemAbbrDefault", "NeoTreeTabBar", "NeoTreeTitleBar", "StorageClass", "netrwPlain" } },
    { color = { fg = "#FFFFFF" }, groups = { "@text", "@variable", "Identifier", "MsgArea", "NeoTreeFileName", "WhichKey", "WhichKeyBorder" } },
    { color = { fg = "#FF9C00" }, groups = { "@text.uri" } },
    { color = { fg = "#FF4700" }, groups = { "@text.math", "@text.code" } },
    { color = { fg = "#555555" }, groups = { "@documentation" } },
    { color = { fg = "#888888" }, groups = { "WhichKeyFloat" } },
    { color = { fg = "#000000" }, groups = { "EndOfBuffer" } },
    { color = { fg = "#666666" }, groups = { "Comment", "NonText", "WhichKeySeparator", "WinSeparator" } },
    { color = { fg = "#5F2531" }, groups = { "Column" } },
    { color = { fg = "#473514", bg = "#FECF49" }, groups = { "IncSearch", "Search", "Visual" } },
  }
}

for indx, color_group in ipairs(colorschemes.marri) do
  for _, group in ipairs(color_group.groups) do
    api.nvim_set_hl(0, group, color_group.color)
  end
end

