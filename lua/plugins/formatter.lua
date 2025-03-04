return {
	{
		'mhartington/formatter.nvim',
    opts = {
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        -- lua = { require("formatter.filetypes.lua").stylua },
        -- rust = { require("formatter.filetypes.rust").rustfmt },
        -- sh = { require("formatter.filetypes.sh").shfmt },
        -- toml = { require("formatter.filetypes.toml").taplo },
        -- json = { require("formatter.filetypes.json").jq },
        -- md = { require("formatter.filetypes.markdown").prettier },
        ["*"] = {
          function()
            return { exe = "sed", args = { "-i", "''", "'s/[ 	]*$//'" } }
          end
        }
      }
    }
  }
}
