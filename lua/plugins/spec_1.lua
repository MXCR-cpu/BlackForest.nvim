local o = vim.o

return {
  -- Plugins
	-- {
	-- 	'ThePrimeagen/harpoon',
	-- 	config = function()
	-- 		require 'harpoon'.setup()
	-- 	end
	-- },
	-- 

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
		'neoclide/coc.nvim',
		branch = 'release',
	},
	{
		'hrsh7th/nvim-cmp',
		init = function()
			require 'plugin.nvim-cmp'
		end
	},
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
		requires = 'nvim-lua/plenary.nvim'
	},
	{
		'neovim/nvim-lspconfig',
		init = function()
			require 'plugin.nvim-lspconfig'
		end
	},
	{ 'numToStr/Comment.nvim', opts = {} },
	'nvim-lua/plenary.nvim',
	'nvim-lua/popup.nvim',
	{
		'nvim-treesitter/nvim-treesitter',
		init = function()
			require 'plugin.nvim-treesitter'
		end
	},
	'nvim-treesitter/playground',
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		init = function()
			vim.g.barbar_auto_setup = true
		end
	},
	{
		'sQVe/sort.nvim',
		init = function()
			require 'plugin.sort'
				end
	},
	{
		'saadparwaiz1/cmp_luasnip',
		init = function()
		end
	},
	{
		'stevearc/aerial.nvim',
		init = function()
			require 'plugin.aerial'
		end
	},
	'tpope/vim-fugitive',
	{
		'williamboman/mason.nvim',
		init = function()
			require 'plugin.mason'
		end
	},
	'williamboman/mason-lspconfig.nvim',
	{ 'windwp/nvim-autopairs' },

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
		init = function()
			require 'plugin.lualine'
		end
	},
	{
		'xbase-lab/xbase',
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim',
		},
	}
}
