local o = vim.o

return {
	'dstein64/vim-startuptime',
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			o.timeout = true
			o.timeoutlen = 300
			require 'plugin.which-key'
		end,
		opts = {}
	},

	-- 'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-cmdline',
	-- 'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	{
		'kylechui/nvim-surround',
		init = function()
			require 'plugin.nvim-surround'
		end
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		init = function()
			require 'plugin.indent-blankline'
		end
	},
	'mbbill/undotree',
	{
		'nagy135/typebreak.nvim',
		dependencies = {
      'nvim-lua/plenary.nvim'
    }
	},
	'numToStr/Comment.nvim',
	'nvim-lua/plenary.nvim',
	'nvim-lua/popup.nvim',
	'nvim-treesitter/nvim-treesitter',
	'nvim-treesitter/playground',
	'sQVe/sort.nvim',
  'voldikss/vim-floaterm',
  {
    'startup-nvim/startup.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim'
    },
    opts = {
        section_1 = {
          type = "text",
          align = "center",
          content = require("plugin.start_images").text2,
          highlight = "",
          default_color = "#FF0000",
        },
        section_2 = {
          type = "text",
          align = "center",
          content = {"MXCR_cpu"},
          highlight = "",
          default_color = "#FF0000",
        },
        section_3 = {
          type = "text",
          align = "center",
          content = function()
              local clock = " " .. os.date "%H:%M"
              local date = " " .. os.date "%d-%m-%y"
              return {clock,date}
          end,
          highlight = "",
          default_color = "#FF0000",
        },
        parts = {"section_1", "section_2", "section_3"},
        colors = { background = "none" }
      }
  },
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v2.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		init = function()
			require'neo-tree'.setup{
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					follow_current_fle = true,
				},
			}
		end
	},
	{
		'nvim-lualine/lualine.nvim',
    opts = require("plugin.lualine")
	},
}
