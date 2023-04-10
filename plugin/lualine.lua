-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir

-- Color table for highlights
-- stylua: ignore

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
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
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
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Functions --
-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

local climbing_color = 0

local function color_mode_change()
	climbing_color = (climbing_color + 1) % 48
	return {
		fg = vim.g.colors_shades[29 - math.abs(climbing_color - 24)],
	}
end

ins_left({
	function()
		return "████ " .. string.upper(vim.fn.mode()) .. " ████"
	end,
	color = color_mode_change,
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = vim.g.colors_shades[28] },
})

ins_left({ "location", color = { fg = vim.g.colors_shades[24] } })

ins_left({ "progress", color = { fg = vim.g.colors_shades[20] } })

ins_left({
	-- filesize component
	"filesize",
	cond = conditions.buffer_not_empty,
	color = { fg = vim.g.colors_shades[16] },
})

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
	color = { fg = vim.g.colors_shades[16] },
})

ins_right({
	"fileformat",
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { fg = vim.g.colors_shades[20] },
})

ins_right({
	"branch",
	icon = "",
	color = { fg = vim.g.colors_shades[24] },
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "柳 ", removed = " " },
	diff_color = {
		added = { fg = vim.g.colors_shades[26] },
		modified = { fg = vim.g.colors_shades[27] },
		removed = { fg = vim.g.colors_shades[28] },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "████  ████"
	end,
	color = color_mode_change,
})

require("lualine").setup(config)
-- 29 shades
