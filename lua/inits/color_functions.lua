local api = vim.api
local g = vim.g
local fn = vim.fn

local degToRad = 0.01745329251994329576923690768489

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

-- Color Conversion Functions
-- RGB to Hex Function

function rgbToHex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

function rgbCorrection(r, g, b)
  r = r > 255 and 255 or r
  g = g > 255 and 255 or g
  b = b > 255 and 255 or b

  r = 0 > r and 0 or r
  g = 0 > g and 0 or g
  b = 0 > b and 0 or b
  
  return r, g, b
end

-- HSL Function

function hslToHex(h, s, l)
  h = h / 360
  s = s / 100
  l = l / 100

  local function hueToRgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1/6 then return p + (q - p) * 6 * t end
    if t < 1/2 then return q end
    if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
    return p
  end

  local r, g, b
  if s == 0 then
    r, g, b = l, l, l
  else
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hueToRgb(p, q, h + 1/3) * 255
    g = hueToRgb(p, q, h) * 255
    b = hueToRgb(p, q, h - 1/3) * 255
  end

  r, g, b = rgbCorrection(r, g, b)
  -- print(rgbToHex(r, g, b))
  return rgbToHex(r, g, b)
end

-- LAB Function

function labToHex(l, a, b)
  local function f_inv(t)
    if t > 6/29 then
      return t * t * t
    else
      return 3 * (6/29) * (6/29) * (t - 4/29)
    end
  end

  local xn, yn, zn = 0.95047, 1.0, 1.08883
  local x = xn * f_inv((l + 16) / 116 + a / 500)
  local y = yn * f_inv((l + 16) / 116)
  local z = zn * f_inv((l + 16) / 116 - b / 200)

  local r =  3.2406 * x - 1.5372 * y - 0.4986 * z
  local g = -0.9689 * x + 1.8758 * y + 0.0415 * z
  local b =  0.0557 * x - 0.2040 * y + 1.0570 * z

  local function gamma(t)
    if t > 0.0031308 then
      return 1.055 * (t ^ (1/2.4)) - 0.055
    else
      return 12.92 * t
    end
  end

  r = math.floor(gamma(r) * 255)
  g = math.floor(gamma(g) * 255)
  b = math.floor(gamma(b) * 255)

  r, g, b = rgbCorrection(r, g, b)
  return rgbToHex(r, g, b)
end

-- LCH Function

function lchToHex(l, c, h)
  return labToHex(l, c * math.cos(h * degToRad), c * math.sin(h * degToRad))
end

--

local color_highlight_groups = {
  {
    color = {
      fg = lchToHex(40, 60, 297),
    },
    groups = {
      '@spell',
      'CursorLineNr',
      'ScopeGuide',
    }
  },
  {
    color = {
      fg = lchToHex(62, 80, 29),
    },
    groups = {
      '@tag',
      '@text.emphasis',
      'Character',
      'Constant',
      'String',
      'Tag',
      'WhichKeyGroup',
    }
  },
  {
    color = {
      bg = lchToHex(20, 20, 25),
    },
    groups = {
      "ErrorBoundary",
    }
  },
  {
    color = {
      fg = lchToHex(30, 50, 297),
    },
    groups = {
      '@constructor',
      '@documentation',
      'Comment',
      '@string',
      'LineNr',
    }
  },
  {
    color = {
      fg = lchToHex(40, 60, 310),
    },
    groups = {
      'Keyword',
      'PreProc',
      'rustFoldBraces',
    }
  },
  {
    color = {
      fg = lchToHex(40, 40, 300),
    },
    groups = {
      '@conditional',
      '@punctuation',
      'Function',
    }
  },
  {
    color = {
      fg = lchToHex(23, 23, 278),
    },
    groups = {
      'Delimiter',
      'NeoTreeRootName',
      'Special',
      'zshBrackets',
      'NonText',
      'VertSplit',
      'WinSeparator',
    }
  },
  {
    color = {
      fg = lchToHex(40, 65, 330),
    },
    groups = {
      '@text.math',
    }
  },
  {
    color = {
      fg = lchToHex(45, 50, 324),
    },
    groups = {
      '@attribute',
      '@constant',
      '@tag.attribute',
      '@text.uri',
      'Conditional',
      'Debug',
      'Label',
      'Operator',
      'Statement',
      'WhichKeyDesc',
    }
  },
  {
    color = {
      fg = lchToHex(40, 55, 324),
    },
    groups = {
      '@string.escape',
      'Define',
      'Directory',
      'Tabline',
      'Type',
    }
  },
  {
    color = {
      fg = lchToHex(50, 60, 60),
      -- fg = lchToHex(62, 80, 29),
    },
    groups = {
      'Number',
    }
  },
  {
    color = {
      fg = lchToHex(75, 82, 74),
    },
    groups = {
      '@field',
      '@text.title',
      '@symbol',
      'CmpItemAbbrDefault',
      'NeoTreeTabBar',
      'NeoTreeTitleBar',
      'StorageClass',
      'netrwPlain',
    }
  },
  {
    color = {
      fg = lchToHex(90, 50, 83),
    },
    groups = {
      '@text',
      '@variable',
      'Identifier',
      'MsgArea',
      'NeoTreeFileName',
      'WhichKey',
      'WhichKeyBorder',
    }
  },
  {
    color = {},
    groups = {
      '@none',
      'CursorLine',
      'Normal',
      'NormalNC',
      'NormalFloat',
      'FloatShadowThrough',
      'FloatShadow',
      'Pmenu',
      'PmenuSel',
      'WhichKeyFloat'
    }
  },
}

local color_palette = {}

for _ , color_group in ipairs(color_highlight_groups) do
  color_palette[#color_palette+1] = color_group.color.fg or '#------'
  for _, group in ipairs(color_group.groups) do
    api.nvim_set_hl(0, group, color_group.color)
  end
end

local color_groups = {
  other = {
    { 'IncSearch',            highlight_text     },
    { 'Search',               highlight_text     },
    { 'Visual',               highlight_text     },
    { 'CursorColumn',         sign_column_colors },
    { 'FoldColumn',           sign_column_colors },
    { 'NvimTreeCursorColumn', sign_column_colors },
    { 'NvimTreeSignColumn',   sign_column_colors },
    { 'SignColumn',           sign_column_colors },
    { 'Tabline',              sign_column_colors },
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
    {
      'lineNrAbove',
      {
        link = 'LineNr',
      },
    },
    {
      'lineNrBelow',
      {
        link = 'LineNr',
      },
    },
    { "zshFunction",
      {
        link = "Function",
        default = true,
      },
    },
    { "zshOperator",
      {
        link = "Operator",
        default = true,
      },
    },
    { "zshVariable",
      {
        link = "@variable",
        default = true,
      },
    },
    { "zshParentheses",
      {
        link = "@variable",
      },
    },
    { "zshBrackets",
      {
        link = "@variable",
      },
    },
    {
      '@punctuation.bracket',
      {
        link = '@punctuation',
      },
    },
    {
      '@punctuation.special',
      {
        link = '@punctuation',
      },
    },
    {
      '@function.builtin',
      {
        link = 'Function',
      },
    },
    {
      '@function.call',
      {
        link = 'Function',
      },
    },
    {
      '@string',
      {
        link = 'String',
      },
    },
    {
      '@text.title.1',
      {
        link = '@text.title',
      },
    },
    {
      '@text.title.2',
      {
        link = '@text.title',
      },
    },
    {
      '@text.title.3',
      {
        link = '@text.title',
      },
    },
    {
      '@text.title.4',
      {
        link = '@text.title',
      },
    },
    {
      '@text.heading.inline',
      {
        link = '@text.title',
      },
    },
    {
      '@text.delimiter',
      {
        link = '@punctuation',
      },
    },
    {
      '@parameter',
      {
        link = '@variable',
      },
    },
  },
}


for _, value in ipairs(color_groups.other) do
  api.nvim_set_hl(0, value[1], value[2])
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

M = {}

M.get_palette = function()
  print(vim.inspect(color_palette))
end

return M
