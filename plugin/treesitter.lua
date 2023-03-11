local run = ":TSUpdate"
local config = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		highlight = {
			enabled = true,
		},
		additional_vim_regex_highlighting = false,
	})
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.just = {
		install_info = {
			url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
			files = { "src/parser.c", "src/scanner.cc" },
			branch = "main",
		},
		maintainers = { "@IndianBoy42" },
	}
end

