vim.cmd [[packadd packer.nvim]]
package.path = vim.g.nvim_directory .. '/?.lua;' .. package.path

local plugin_list = {
	{ 'L3MON4D3/LuaSnip' },
	{ 'MXCR-cpu/boop.nvim' },
	{ 'ThePrimeagen/harpoon' },
	{ 'dstein64/vim-startuptime' },
	{ 'folke/which-key.nvim' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'jaredgorski/Mies.vim' },
	{ 'kyazdani42/nvim-web-devicons' },
	{ 'kylechui/nvim-surround' },
	{ 'lukas-reineke/indent-blankline.nvim' },
	{ 'mbbill/undotree' },
	{ 'mhartington/formatter.nvim' },
	{ 'neovim/nvim-lspconfig' },
	{ 'numToStr/Comment.nvim' },
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-lua/popup.nvim' },
	{ 'nvim-treesitter/nvim-treesitter' },
	{ 'sQVe/sort.nvim' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'stevearc/aerial.nvim' },
	{ 'tpope/vim-fugitive' },
	{ 'wbthomason/packer.nvim' },
	{ 'williamboman/mason.nvim',            run = ':MasonUpdate' },
	{ 'williamboman/mason-lspconfig.nvim',  run = ':MasonUpdate' },
	{ 'windwp/nvim-autopairs' },
	{ 'ziontee113/color-picker.nvim' },
	{
		'nvim-lualine/lualine.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
			opt = true,
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.1',
		requires = {
			'nvim-lua/plenary.nvim'
		}
	},
	{
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons',
		},
		tag = 'nightly',
	},
	{
		'xbase-lab/xbase',
		run = 'make install',
		requires = {
			'neovim/nvim-lspconfig',
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim',
		},
	}
}
local startup_list = {
	'Comment',
}

return require('packer').startup(function(pack)
	for _, v in ipairs(plugin_list) do
		local plugin_string = v[1]:match '/[%w-]+':match '[%w-]+'
		local mod_function = function()
			v.mod = require('plugin.' .. plugin_string)
		end
		local config_function = function()
			v.config = function()
				require(plugin_string).setup()
			end
		end
		local _ = pcall(mod_function) or pcall(config_function)
		pack(v)
	end
	for _, v in ipairs(startup_list) do
		require(v).setup()
	end
	if Packer_bootstrap then
		require('plugin.packer').sync()
	end
end)
