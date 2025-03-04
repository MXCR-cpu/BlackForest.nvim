return {
  {
  	'nvim-telescope/telescope.nvim',
  	dependencies = {
  		'nvim-lua/plenary.nvim'
  	},
  	opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          find_command = {
            "fd",
            "--hidden",
            "--type", "f",
            "--exclude", ".git",
            "--exclude", "build",
            "--strip-cwd-prefix" },
          theme = "ivy",
        }
      }
    }
  }
}
