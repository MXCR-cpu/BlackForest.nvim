vim.cmd [[packadd packer.nvim]]
package.path = vim.g.nvim_directory .. "/inits/?.lua;" .. package.path

local plugin_list = {
	{ "wbthomason/packer.nvim" },
	{ "nvim-telescope/telescope.nvim", tag = "0.1.1", requires = { { "nvim-lua/plenary.nvim" } } },
	{
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
		mod = require("plugin.lualine"),
	},
	{ "kyazdani42/nvim-web-devicons", mod = require("plugin.devicons") },
	{ "jaredgorski/Mies.vim" },
	{ "mhartington/formatter.nvim", mod = require("plugin.formatter") },
	{
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		tag = "nightly",
		mod = require("plugin.nvim-tree"),
	},
	{ "folke/which-key.nvim", mod = require("plugin.which-key") },
	{ "ziontee113/color-picker.nvim",
		config = function()
			require("color-picker")
		end },
	{
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup {}
		end
	},
	{ "tpope/vim-commentary" },
	{ "tpope/vim-fugitive" },
	{ "sQVe/sort.nvim",
		config = function()
			require("sort").setup {}
		end },
	-- Neovim Plugins Development
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	-- { "rafcamlet/nvim-luapad" },
	---
	{ "ThePrimeagen/harpoon" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	-- Local Plugins
	{ "MXCR-cpu/boop.nvim" },
	-- LuaSnip Package
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	-- Neovim Lsp
	{ "hrsh7th/nvim-cmp", mod = require("plugin.nvim-cmp") },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "neovim/nvim-lspconfig", mod = require("plugin.lspconfig") },
	{ "nvim-treesitter/nvim-treesitter", mod = require("plugin.treesitter") },
	{ "stevearc/aerial.nvim", config = function() require("aerial").setup() end },
	{ "mbbill/undotree" },
	{ "dstein64/vim-startuptime" },
	{ "lukas-reineke/indent-blankline.nvim", mod = require("plugin.indent-blankline") },
}

return require("packer").startup(function(pack)
	for _, v in ipairs(plugin_list) do
		pack(v)
	end
	if Packer_bootstrap then
		require("packer").sync()
	end
end)
