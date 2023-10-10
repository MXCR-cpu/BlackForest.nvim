local opt = vim.opt
opt.list = true
opt.termguicolors = true

require("ibl").setup {
	enabled = true,
	indent = {
		char = "│",
		smart_indent_cap = true,
	},
	whitespace = {
		highlight = {
			"CursorColumn",
			"Whitespace",
		},
		remove_blankline_trail = true,
	},
	scope = {
		enabled = true,
		show_start = true,
		show_end = false,
		injected_languages = false,
		highlight = { "ScopeGuide" },
		priority = 500,
	}
}


