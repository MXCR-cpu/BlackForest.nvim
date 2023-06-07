local api = vim.api
local g = vim.g
local fn = vim.fn
fn.color_index = function(percentage)
	return math.floor((percentage * #g.colors_shades) / 100)
end
fn.color_index_hex = function(percentage, inverse)
	local index = math.floor((percentage * #g.colors_shades) / 100)
	if inverse then
		return g.colors_shades[#g.colors_shades - index]
	else
		return g.colors_shades[index]
	end
end
local sign_column_colors = { fg = g.colors_shades[fn.color_index(50)] }
local highlight_text = {
	fg = g.colors_shades[fn.color_index(20)],
	bg = g.colors_shades[fn.color_index(100)]
}
local color_groups = {
	other = {
		{ 'IncSearch', highlight_text },
		{ 'Search',    highlight_text },
		{ 'Visual',    highlight_text },
		{ 'CursorColumn',         sign_column_colors },
		{ 'FoldColumn',           sign_column_colors },
		{ 'NvimTreeCursorColumn', sign_column_colors },
		{ 'NvimTreeSignColumn',   sign_column_colors },
		{ 'SignColumn',           sign_column_colors },
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
		{ 'ColorColumn', {
			fg = g.colors_shades[fn.color_index(1)],
			bg = g.colors_shades[fn.color_index(100)]
		} },
		{ 'TODO', {
			fg = g.colors_shades[fn.color_index(20)],
			bg = g.colors_shades[fn.color_index(60)]
		} },
		{ 'TelescopeSelection', {
			fg = g.colors_shades[fn.color_index(100)],
			bg = g.colors_shades[fn.color_index(15)]
		} },
		{ 'NvimTreeIndentMarker', {
			fg = g.colors_shades[fn.color_index(50)]
		} },
		{ 'NvimTreeWindowPicker', {
			fg = g.colors_shades[fn.color_index(40)],
			bg = g.colors_shades[fn.color_index(80)]
		} },
		{ "CursorLine", {
			bg = "#172234",
		} },
		{ "zshFunction", {
			link = "Function",
			default = true,
		} },
		{ "zshOperator", {
			link = "Operator",
			default = true,
		} },
		{ "zshVariable", {
			link = "@variable",
			default = true,
		} },
		{ "zshParentheses", {
			link = "@variable",
			default = true,
		} },
		{ "zshBrackets", {
			link = "@variable",
			default = true,
		} },
	},
	null = {
		'Normal',
		'NormalNC',
		'NormalFloat',
		'FloatShadowThrough',
		'FloatShadow',
		'Pmenu',
		'PmenuSel',
		'WhichKeyFloat'
	},
	highlight = {
		{
			'@variable',
			'Identifier',
			'MsgArea',
			'NeoTreeFileName',
			'WhichKey',
			'WhichKeyBorder',
		},
		{
			'CmpItemAbbrDefault',
			'CursorLineNr',
			'NeoTreeTabBar',
			'NeoTreeTitleBar',
			'StorageClass',
			'netrwPlain',
		},
		{
			'@field',
			'@function.builtin',
			'@function.call',
			'Function',
			'PreProc',
			'rustFoldBraces',
		},
		{
			'Character',
			'Constant',
			'Number',
			'String',
			'Tag',
			'WhichKeyGroup',
		},
		{
			'Define',
			'Directory',
			'Type',
		},
		{
			'@attribute',
			'@conditional',
			'@constant',
			'Conditional',
			'Keyword',
			'Label',
			'Operator',
			'Statement',
			'WhichKeyDesc',
		},
		{
			'@constructor',
			'@punctuation',
			'Comment',
			'Delimiter',
			'Special',
			'NeoTreeRootName',
		},
		{
			'LineNr',
			'LineNrAbove',
			'LineNrBelow',
			'NonText',
			'VertSplit',
			'WinSeparator',
		},
		{},
		{},
	}
}
for _, value in ipairs(color_groups.other) do
	api.nvim_set_hl(0, value[1], value[2])
end
for _, value in ipairs(color_groups.null) do
	api.nvim_set_hl(0, value, {})
end
for key, value in ipairs(color_groups.highlight) do
	for _, inner_value in ipairs(value) do
		api.nvim_set_hl(0, inner_value, {
			fg = fn.color_index_hex(key * 10, true)
		})
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
