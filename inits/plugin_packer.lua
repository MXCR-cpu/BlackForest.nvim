vim.cmd [[packadd packer.nvim]]
package.path = vim.g.nvim_directory .. '/?.lua;' .. package.path

local plugin_list = {
	{ 'L3MON4D3/LuaSnip'                                                                                                     },
	{ 'MXCR-cpu/boop.nvim'                                                                                                   },
	{ 'ThePrimeagen/harpoon'                                                                                                 },
	{ 'dstein64/vim-startuptime'                                                                                             },
	{ 'folke/which-key.nvim'                    ,mod = require 'plugin.which-key'                                            },
	{ 'hrsh7th/cmp-buffer'                                                                                                   },
	{ 'hrsh7th/cmp-cmdline'                                                                                                  },
	{ 'hrsh7th/cmp-nvim-lsp'                                                                                                 },
	{ 'hrsh7th/cmp-path'                                                                                                     },
	{ 'hrsh7th/nvim-cmp'                        ,mod = require 'plugin.nvim-cmp'                                             },
	{ 'jaredgorski/Mies.vim'                                                                                                 },
	{ 'kyazdani42/nvim-web-devicons'            ,mod = require 'plugin.devicons'                                             },
	{ 'kylechui/nvim-surround'                  ,mod = require 'plugin.nvim-surround'                                        },
	{ 'lukas-reineke/indent-blankline.nvim'     ,mod = require('plugin.indent-blankline')                                    },
	{ 'mbbill/undotree'                                                                                                      },
	{ 'mhartington/formatter.nvim'              ,mod = require 'plugin.formatter'                                            },
	{ 'neovim/nvim-lspconfig'                   ,mod = require 'plugin.lspconfig'                                            },
	{ 'nvim-lua/plenary.nvim'                                                                                                },
	{ 'nvim-lua/popup.nvim'                                                                                                  },
	{ 'nvim-telescope/telescope.nvim'           ,tag = '0.1.1'                          ,requires = {'nvim-lua/plenary.nvim'}},
	{ 'nvim-treesitter/nvim-treesitter'         ,mod = require 'plugin.treesitter'                                           },
	{ 'sQVe/sort.nvim'                          ,mod = require 'plugin.sort'                                                 },
	{ 'saadparwaiz1/cmp_luasnip'                                                                                             },
	{ 'stevearc/aerial.nvim'                    ,mod = require 'plugin.aerial'                                               },
	{ 'tpope/vim-commentary'                                                                                                 },
	{ 'tpope/vim-fugitive'                                                                                                   },
	{ 'wbthomason/packer.nvim'                                                                                               },
	{ 'williamboman/mason.nvim'                 ,mod = require 'plugin.mason'           ,run = ':MasonUpdate'                },
	{ 'windwp/nvim-autopairs'                   ,mod = require 'plugin.nvim-autopairs'                                       },
	{ 'ziontee113/color-picker.nvim'            ,mod = require 'plugin.color-picker'                                         },
	{
		'nvim-lualine/lualine.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
			opt = true,
		},
		mod = require 'plugin.lualine',
	},
	{
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons',
		},
		tag = 'nightly',
		mod = require 'plugin.nvim-tree',
	},
	{
		'kylechui/nvim-surround',
		tag = '*',
		mod = require 'nvim-surround'
	},
}

return require('packer').startup(function(pack)
	for _, v in ipairs(plugin_list) do
		pack(v)
	end
	if Packer_bootstrap then
		require('plugin.packer').sync()
	end
end)
