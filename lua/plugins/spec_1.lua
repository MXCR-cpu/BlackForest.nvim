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
	-- {
	-- 	'saadparwaiz1/cmp_luasnip',
	-- 	init = function()
	-- 	end
	-- },
	-- 'tpope/vim-fugitive',
	-- { 'windwp/nvim-autopairs' },

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
	-- {
	-- 	'xbase-lab/xbase',
	-- 	dependencies = {
	-- 		'neovim/nvim-lspconfig',
	-- 		'nvim-telescope/telescope.nvim',
	-- 		'nvim-lua/plenary.nvim',
	-- 	},
	-- }
}
