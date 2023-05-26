local api = vim.api
local g = vim.g
local fn = vim.fn
vim.fn.color_index = function(percentage)
	return math.floor((percentage * #g.colors_shades) / 100)
end
local number_column_colors = { fg = g.colors_shades[fn.color_index(30)] }
local sign_column_colors = { fg = g.colors_shades[fn.color_index(50)] }
local highlight_text = {
	fg = g.colors_shades[fn.color_index(20)],
	bg = g.colors_shades[fn.color_index(100)]
}
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
	{ 'ColorColumn',          {
		fg = g.colors_shades[fn.color_index(1)],
		bg = g.colors_shades[fn.color_index(100)]
	}},
	{ 'TODO',                 {
		fg = g.colors_shades[fn.color_index(20)],
		bg = g.colors_shades[fn.color_index(60)]
	}},
	-- Telescope --
	{ 'TelescopeSelection',   {
		fg = g.colors_shades[fn.color_index(100)],
		bg = g.colors_shades[fn.color_index(15)]
	}},
	--- NvimTree --
	{ 'NvimTreeIndentMarker', {
		fg = g.colors_shades[fn.color_index(50)]
	}},
	{ 'NvimTreeWindowPicker', {
		fg = g.colors_shades[fn.color_index(40)],
		bg = g.colors_shades[fn.color_index(80)]
	}},
	{ 'WhichKeyFloat',        {} },
}
local highlight_color_groups = {
	{
		'WhichKey',
		'WhichKeyBorder',
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
	},
	{
		'PreProc',
		'Define',
		'Label',
	},
	{
		'WhichKeyGroup',
		'Keyword',
		'Character',
		'Constant',
	},
	{
		'WhichKeyDesc',
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
		api.nvim_set_hl(0, inner_value, {
			fg = g.colors_shades[
				#g.colors_shades -
				math.floor((#g.colors_shades * key) /
					(#highlight_color_groups + 4))
			]
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
