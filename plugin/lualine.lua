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
		-- Disable sections and component separators
		icons_enabled = true,
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
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

local style = "dark_forest"
local style_options = {
	dark_forest = {
		{ fg = colors.grey, gui = "italic" },
		{ fg = colors.white, gui = "bold" },
		{ fg = colors.lightgrey, gui = "italic" },
		{ fg = colors.lightgrey, gui = "italic" },
		{ fg = colors.grey, gui = "bold" },
		{ fg = colors.grey, gui = "bold" },
		{ fg = colors.grey, gui = "bold" },
		{ fg = colors.grey, gui = "bold" },
	},
	default = {
		{ fg = colors.blue, gui = "italic" },
		{ fg = colors.green, gui = "bold" },
		{ fg = colors.yellow, gui = "italic" },
		{ fg = colors.orange, gui = "italic" },
		{ fg = colors.red, gui = "bold" },
		{ fg = colors.orange, gui = "bold" },
		{ fg = colors.yellow, gui = "bold" },
		{ fg = colors.green, gui = "bold" },
	}
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

local function color_mode_change()
	local color_mode_options = {
		dark_forest = {
			fg = {
				n = colors.white,
				i = colors.grey,
				v = colors.lightgrey,
				V = colors.lightgrey,
				c = colors.grey,
				no = colors.white,
				s = colors.grey,
				S = colors.grey,
				[""] = colors.lightgrey,
				ic = colors.white,
				R = colors.grey,
				Rv = colors.grey,
				cv = colors.lightgrey,
				ce = colors.grey,
				r = colors.white,
				rm = colors.grey,
				["r?"] = colors.grey,
				["!"] = colors.lightgrey,
				t = colors.white,
			},
			bg = {}
		},
		default = {
			fg = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			},
			bg = {}
		}
	}
	return {
		fg = color_mode_options[style]['fg'][vim.fn.mode()],
		bg = color_mode_options[style]['bg'][vim.fn.mode()] or colors.bg
	}
end

ins_left({
	function()
		return "██"
	end,
	color = color_mode_change,
	padding = { left = 0, right = 0 },
})

ins_left({
	-- mode component
	function()
		return string.upper(vim.fn.mode())
	end,
	color = color_mode_change,
})

ins_left({
	function()
		return "██"
	end,
	color = color_mode_change,
	padding = { left = 0, right = 1 },
})

ins_left({
	-- filesize component
	"filesize",
	cond = conditions.buffer_not_empty,
	color = style_options[style][1],
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = style_options[style][2],
})

ins_left({ "location", color = style_options[style][3] })

ins_left({ "progress", color = style_options[style][4] })

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

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
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
	color = style_options[style][5],
})

-- Add components to right sections
ins_right({
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = style_options[style][6],
})

ins_right({
	"fileformat",
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = style_options[style][7],
})

ins_right({
	"branch",
	icon = "",
	color = style_options[style][8],
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "柳 ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "██"
	end,
	color = color_mode_change,
	padding = { left = 0, right = 0 },
})

ins_right({
	function()
		return ""
	end,
	color = color_mode_change,
})

ins_right({
	function()
		return "██"
	end,
	color = color_mode_change,
	padding = { left = 0, right = 0 },
})

require("lualine").setup(config)

