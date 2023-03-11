-- Utilities for creating configurations
-- local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands

-- Filetype Formatter Site
-- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		rust = { require("formatter.filetypes.rust").rustfmt },
		sh = { require("formatter.filetypes.sh").shfmt },
		toml = { require("formatter.filetypes.toml").taplo },
		json = { require("formatter.filetypes.json").jq },
		md = { require("formatter.filetypes.markdown").prettier },
		["*"] = {
			function()
				return { exe = "sed", args = { "-i", "''", "'s/[ 	]*$//'" } }
			end,
		},
	},
})
