local number_column_colors = { fg = vim.g.colors_shades[10] }
local highlight_text = { fg = vim.g.colors_shades[1], bg = vim.g.colors_shades[29] }
local color_groups = {
	-- Editor --
	{ "Normal", {} },
	{ "NonText", { fg = vim.g.colors_shades[1] } },
	{ "LineNr", number_column_colors },
	{ "LineNrAbove", number_column_colors },
	{ "LineNrBelow", number_column_colors },
	{ "Visual", highlight_text },
	{ "Search", highlight_text },
	{ "IncSearch", highlight_text },
	{ "SpellBad", {
		undercurl = true,
		italic = true,
	} },
	{ "SpellLocal", {
		underdotted = true,
		italic = true,
	} },
	{ "SpellRare", {
		underdashed = true,
		italic = true,
	} },
	{ "SpellCap", {
		underdouble = true,
		italic = true,
	} },
	{ "Pmenu", { fg = vim.g.colors_shades[28], bg = vim.g.colors_shades[1] } },
	{ "WinSeparator", {} },
	{ "VertSplit", {} },
	{ "TODO", { fg = vim.g.colors_shades[1], bg = vim.g.colors_shades[20] } },
	-- Telescope --
	{ "TelescopeSelection", { fg = vim.g.colors_shades[29], bg = vim.g.colors_shades[5] } },
	--- NvimTree --
	{ "NvimTreeIndentMarker", { fg = vim.g.colors_shades[10] } },
	{ "NvimTreeWindowPicker", { fg = vim.g.colors_shades[5], bg = vim.g.colors_shades[25] } },
	-- WhichKey --
	{ "WhichKey", { fg = vim.g.colors_shades[29] } },
	{ "WhichKeyDesc", { fg = vim.g.colors_shades[10] } },
	{ "WhichKeyGroup", { fg = vim.g.colors_shades[15] } },
	{ "WhichKeySeparator", { fg = vim.g.colors_shades[10] } },
	{ "WhichKeyBorder", { fg = vim.g.colors_shades[29] } },
}

local highlight_color_groups = {
	{
		"Function",
		"Identifier",
	},
	{
		"CursorLineNr",
		"Statement",
		"StorageClass",
		"Tag",
	},
	{
		"String",
		"Number",
		"PreProc",
		"Define",
		"Label",
	},
	{
		"Keyword",
		"Character",
		"Constant",
	},
	{
		"Type",
		"Special",
		"Delimiter",
		"Conditional",
		"Operator",
	},
	{
		"Comment",
	},
}
for _, value in ipairs(color_groups) do
	vim.api.nvim_set_hl(0, value[1], value[2])
end

for key, value in ipairs(highlight_color_groups) do
	for _, inner_value in ipairs(value) do
		vim.api.nvim_set_hl(0, inner_value, { fg = vim.g.colors_shades[#vim.g.colors_shades - 5 - (2 * key)]})
	end
end