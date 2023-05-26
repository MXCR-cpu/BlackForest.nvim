local fn = vim.fn
local loop = vim.loop
local o = vim.o
local opt = vim.opt
package.path = vim.g.nvim_directory .. '/?.lua;' .. package.path
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
	fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	}
end
opt.rtp:prepend(lazypath)
require "lazy".setup {
	{
		"L3MON4D3/LuaSnip",
		version = "<CurrentMajor>.*",
		build = "make install_jsregexp",
		init = function()
			require 'plugin.luasnip'
		end
	},
	'MXCR-cpu/boop.nvim',
	{
		'ThePrimeagen/harpoon',
		config = function()
			require 'harpoon'.setup()
		end
	},
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
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
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
		'mhartington/formatter.nvim',
		init = function()
			require 'plugin.formatter'
		end
	},
	{
		'neovim/nvim-lspconfig',
		init = function()
			require 'plugin.nvim-lspconfig'
		end
	},
	{
		'numToStr/Comment.nvim',
		init = function()
			require 'Comment'.setup()
		end
	},
	'nvim-lua/plenary.nvim',
	'nvim-lua/popup.nvim',
	{
		'nvim-treesitter/nvim-treesitter',
		init = function()
			require 'plugin.nvim-treesitter'
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
	{
		'stevearc/oil.nvim',
		init = function()
			require "oil".setup()
		end
	},
	'tpope/vim-fugitive',
	'rktjmp/lush.nvim',
	{
		'williamboman/mason.nvim',
		init = function()
			require 'plugin.mason'
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
	},
	{
		'windwp/nvim-autopairs',
		init = function()
			require 'plugin.nvim-autopairs'
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		version = '0.1.1',
		dependencies = {
			'nvim-lua/plenary.nvim'
		}
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v2.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		}
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
