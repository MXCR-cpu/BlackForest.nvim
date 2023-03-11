-- local personal_plugins = "/Users/iMac/Desktop/Dev/Lua_Dev/plugin/"
vim.cmd([[packadd packer.nvim]])
package.path = "/Users/iMac/.config/nvim/?.lua;" .. package.path

-- Packer Update Command -> :w |so % |PackerSync
-- or <space>fz

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		mod = require("plugin.lualine"),
	})
	use({"kyazdani42/nvim-web-devicons", mod = require("plugin.devicons") })
	use({ "mhartington/formatter.nvim", mod = require("plugin.formatter") })
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		tag = "nightly",
		mod = require("plugin.nvim-tree"),
	})
	use({ "folke/which-key.nvim", mod = require("plugin.which-key") })
	use({ "norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({}, { mode = "foreground" })
		end,
	})

	-- Neovim Plugins Development
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("rafcamlet/nvim-luapad")
	use("vim-test/vim-test")

	-- Local Plugins
	-- use({ personal_plugins .. "truth-tables.nvim" })
	use({ "MXCR-cpu/boop.nvim" })

	-- LuaSnip Package
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	-- Neovim Lsp
	use({
		"hrsh7th/nvim-cmp",
		mod = require("plugin.nvim-cmp"),
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use({ "neovim/nvim-lspconfig", mod = require("plugin.lspconfig") })
	use({ "nvim-treesitter/nvim-treesitter", mod = require("plugin.treesitter") })
	use("mbbill/undotree")
	use({ "samodostal/image.nvim", requires = { "nvim-lua/plenary.nvim" }, mod = require("plugin.image") })
	use({ "edluffy/hologram.nvim", mod = require("plugin.hologram") })
	use("tpope/vim-commentary")
	use("dstein64/vim-startuptime")
	use({
		"startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		mod = require("plugin.startup"),
	})
	use({
		"xiyaowong/telescope-emoji.nvim",
		run = function()
			require("telescope").load_extension("emoji")
		end
	})
	use({ "lukas-reineke/indent-blankline.nvim", mod = require("plugin.indent-blankline") })
	use({
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	})
	use("junegunn/fzf.vim")

	-- Markdown
	use("allen-mack/nvim-table-md")
	use("ixru/nvim-markdown")

	if Packer_bootstrap then
		require("packer").sync()
	end
end)
