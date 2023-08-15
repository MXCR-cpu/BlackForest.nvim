local fn = vim.fn
local loop = vim.loop
local o = vim.o
local opt = vim.opt
local cmd = vim.cmd
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
require 'lazy'.setup {
	-- AI Plugins
	{
		'codota/tabnine-nvim',
		build = './dl_binaries.sh',
		init = function()
			require'tabnine'.setup{
				disable_auto_comment = true,
				accept_keymap = "<Tab>",
				dismiss_keymap = "<C-]>",
				debounce_ms = 800,
				suggestion_color = { gui = "#808080", cterm = 244 },
				exclude_filetypes = { "TelescopePrompt" },
				log_file_path = nil,
			}
		end
	},
	'Exafunction/codeium.vim',
	-- Plugins
	{
		'L3MON4D3/LuaSnip',
		version = '<CurrentMajor>.*',
		build = 'make install_jsregexp',
		init = function()
			require 'plugin.luasnip'
		end
	},
	{
		'MXCR-cpu/boop.nvim',
		dir = '/Users/iMac/Desktop/Dev/Lua_Dev/plugins/boop.nvim',
		dev = true,
	},
	{
		'MXCR-cpu/sensai.nvim',
		dir = '/Users/iMac/Desktop/Dev/Lua_Dev/plugins/sensai.nvim',
		dev = true,
		init = function()
			require 'sensai'.setup()
		end
	},
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
	'nvim-treesitter/playground',
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
		},
		init = function()
			require'telescope'.load_extension('harpoon')
		end
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
