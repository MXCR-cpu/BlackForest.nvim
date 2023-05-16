local api = vim.api
local g = vim.g

local number_column_colors = { fg = g.colors_shades[10] }
local sign_column_colors = { fg = g.colors_shades[15] }
local highlight_text = { fg = g.colors_shades[1], bg = g.colors_shades[29] }
local color_groups = {
	-- Editor --
	{ 'Normal',      {} },
	{ 'NormalFloat', {} },
	{ 'NonText',     number_column_colors },
	{ 'LineNr',      number_column_colors },
	{ 'LineNrAbove', number_column_colors },
	{ 'LineNrBelow', number_column_colors },
	{ 'Visual',      highlight_text },
	{ 'Search',      highlight_text },
	{ 'IncSearch',   highlight_text },
	{ 'SpellBad', {
		undercurl = true,
		italic = true,
	} },
	{ 'SpellLocal', {
		underdotted = true,
		italic = true,
	} },
	{ 'SpellRare', {
		underdashed = true,
		italic = true,
	} },
	{ 'SpellCap', {
		underdouble = true,
		italic = true,
	} },
	{ 'FloatShadowThrough',   {} },
	{ 'FloatShadow',          {} },
	{ 'Directory',            {} },
	{ 'Pmenu',                {} },
	{ 'PmenuSel',             {} },
	{ 'WinSeparator',         {} },
	{ 'VertSplit',            {} },
	{ 'FoldColumn',           sign_column_colors },
	{ 'SignColumn',           sign_column_colors },
	{ 'NvimTreeSignColumn',   sign_column_colors },
	{ 'CursorColumn',         sign_column_colors },
	{ 'NvimTreeCursorColumn', sign_column_colors },
	{ 'ColorColumn',          { fg = '#000000', bg = '#ffffff' } },
	{ 'TODO',                 { fg = g.colors_shades[1], bg = g.colors_shades[20] } },
	-- Telescope --
	{ 'TelescopeSelection',   { fg = g.colors_shades[29], bg = g.colors_shades[5] } },
	--- NvimTree --
	{ 'NvimTreeIndentMarker', { fg = g.colors_shades[10] } },
	{ 'NvimTreeWindowPicker', { fg = g.colors_shades[5], bg = g.colors_shades[25] } },
	-- WhichKey --
	{ 'WhichKeyFloat',        {} },
	{ 'WhichKey',             { fg = g.colors_shades[29] } },
	{ 'WhichKeyDesc',         { fg = g.colors_shades[10] } },
	{ 'WhichKeyGroup',        { fg = g.colors_shades[15] } },
	{ 'WhichKeySeparator',    { fg = g.colors_shades[10] } },
	{ 'WhichKeyBorder',       { fg = g.colors_shades[29] } },
}

local highlight_color_groups = {
	{
		'Function',
		'Identifier',
	},
	{
		'CursorLineNr',
		'Statement',
		'StorageClass',
		'Tag',
	},
	{
		'String',
		'Number',
		'PreProc',
		'Define',
		'Label',
	},
	{
		'Keyword',
		'Character',
		'Constant',
	},
	{
		'Type',
		'Special',
		'Delimiter',
		'Conditional',
		'Operator',
	},
	{
		'Comment',
	},
}
for _, value in ipairs(color_groups) do
	api.nvim_set_hl(0, value[1], value[2])
end

for key, value in ipairs(highlight_color_groups) do
	for _, inner_value in ipairs(value) do
		api.nvim_set_hl(0, inner_value, { fg = g.colors_shades[#g.colors_shades - 5 - (2 * key)] })
	end
end

local nvim_tree_icon = {
	'NvimTreeFolderIcon',
	'NvimTreeFileIcon',
}

for _, icon_name in ipairs(nvim_tree_icon) do
	api.nvim_set_hl(0, icon_name, {
		ctermfg = 'NONE',
		ctermbg = 'NONE',
	})
end
