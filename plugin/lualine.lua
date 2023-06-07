local g = vim.g
local fn = vim.fn
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir

local colors = {
	bg        = '#000000',
	fg        = '#bbc2cf',
	yellow    = '#edfc1b',
	cyan      = '#008080',
	darkblue  = '#081633',
	green     = '#98be65',
	orange    = '#FF8800',
	violet    = '#a9a1e1',
	magenta   = '#c678dd',
	blue      = '#51afef',
	red       = '#ec5f67',
	white     = '#eeeeee',
	black     = '#000000',
	darkgrey  = '#313131',
	grey      = '#6C6C6C',
	lightgrey = '#B2B2B2',
}

local conditions = {
	buffer_not_empty = function()
		return fn.empty(fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = fn.expand("%:p:h")
		local gitdir = fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		icons_enabled = true,
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.fg } },
			inactive = { c = { fg = colors.fg } },
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Functions --
local climbing_color = 0
local interval = 100
local half_interval = math.floor(interval / 2)
local conversion = (#g.colors_shades - 1) / half_interval

local function color_mode_change()
	return {
		fg = g.colors_shades[math.floor(conversion * math.abs(climbing_color - half_interval)) + 1]
	}
end

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left{
	function()
		climbing_color = (climbing_color % interval) + 1
		return "░▒▓█ " .. string.upper(fn.mode()) .. " █▓▒░"
	end,
	color = color_mode_change,
}

ins_left{
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = g.colors_shades[fn.color_index(100)] },
}

ins_left{ "location", color = { fg = g.colors_shades[fn.color_index(90)] } }

ins_left{ "progress", color = { fg = g.colors_shades[fn.color_index(80)] } }

ins_left{
	"filesize",
	cond = conditions.buffer_not_empty,
	color = { fg = g.colors_shades[fn.color_index(75)] },
}

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
})

ins_left({
	function()
		return "%="
	end,
})

ins_left({
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return string.upper(client.name)
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = color_mode_change,
})

-- Add components to right sections
ins_right({
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = vim.g.colors_shades[fn.color_index(50)] },
})

ins_right({
	"fileformat",
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { fg = vim.g.colors_shades[fn.color_index(60)] },
})

ins_right({
	"branch",
	icon = "",
	color = { fg = vim.g.colors_shades[fn.color_index(70)] },
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "◎ ", removed = " " },
	diff_color = {
		added = { fg = vim.g.colors_shades[fn.color_index(80)] },
		modified = { fg = vim.g.colors_shades[fn.color_index(85)] },
		removed = { fg = vim.g.colors_shades[fn.color_index(90)] },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "░▒▓█  █▓▒░"
	end,
	color = color_mode_change,
})

require("lualine").setup(config)
-- 29 shades
