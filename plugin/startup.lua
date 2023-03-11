M = {}

local section_1 = {
	type = "text",
	oldfiles_directory = false,
	align = "center",
	fold_section = false,
	title = "title",
	margin = 0,
	content = require("plugin.dashboard-nvim").text2,
	highlight = "String",
	default_color = "#FFFFFF",
	oldfiles_amount = 5,
}

local section_2_text = function()
	local clock = " " .. os.date "%H:%M"
	local date = " " .. os.date "%d-%m-%y"
	return { clock, date, "", "MXCR-cpu" }
end

local section_2 = {
	type = "text",
	oldfiles_directory = false,
	align = "left",
	fold_section = false,
	title = "title",
	margin = 15,
	content = section_2_text(),
	highlight = "String",
	default_color = "#FFFFFF",
	oldfiles_amount = 5,
}

-- require"startup".setup({theme = "evil"})
require("startup").setup({
	section_1 = section_1, -- for the structure of a section see below
	section_2 = section_2, -- as much sections as you like
	options = {
		mapping_keys = false, -- display mapping (e.g. <leader>ff)

		-- if < 0 fraction of screen width
		-- if > 0 numbers of column
		cursor_column = 0.5,

		-- after = function() -- function that gets executed at the end
		--   <lua commands>
		-- end
		empty_lines_between_mappings = true, -- add an empty line between mapping/commands
		disable_statuslines = true, -- disable status-, buffer- and tablines
		paddings = { 1, 2 }, -- amount of empty lines before each section (must be equal to amount of sections)
	},
	mappings = {},
	-- mappings = {
	--   execute_command = "<CR>",
	--   open_file = "o",
	--   open_file_split = "<c-o>",
	--   open_section = "<TAB>",
	--   open_help = "?",
	-- },
	colors = {
		background = "#1f2227",
		folded_section = "#56b6c2", -- the color of folded sections
		-- this can also be changed with the `StartupFoldedSection` highlight group
	},
	parts = { "section_1", "section_2" }, -- all sections in order
})
