# Studying indent-blankline.nvim
	## init.lua
	- init
		- creates a nvim namespace
		- resets highlights
		- sets refresh to true
	- setup
		- sets global variables
		- creates augroup and autocmd
		- calls set up blankline variable
	- refresh
		- handles buffer loading
		- checks if plugin is enabled
			- util function returns bool
			- if true 
				- checks if the plugin is active
				- possibly wraps a buffer
		- checks if buffer is being scrolled
			- Reads the left off-set of the buffer and
			chooses the amount of horizontal lines
			required for the allotted space
				- Binary searches the ranges
	## utils.lua
	- memo
	- error_handler
	- is_indent_blankline_enabled
	- clear_line_indent
	- get_from_list
	- _if
	- find_indent
	- get_current_context
	- reset_highlights
	- first_not_nil
	- get_variable
	- merge_ranges
	- binary_search_ranges
	## commands.lua
	- refresh
	- enable
	- disable
	- toggle

