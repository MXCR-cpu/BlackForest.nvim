local fn = vim.fn
local loop = vim.loop
local o = vim.o
local opt = vim.opt
local g = vim.g
package.path = g.nvim_directory .. "/?.lua;" .. package.path
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Personal Plugins
  {
    "MXCR-cpu/boop.nvim",
    dir = "/Users/iMac/Desktop/Dev/Lua_Dev/plugins/boop.nvim",
    dev = true,
  },
  {
    'MXCR-cpu/sensai.nvim',
    dir = '/Users/iMac/Desktop/Dev/Lua_Dev/plugins/sensai.nvim',
    -- dev = true,
    init = function()
      package.path = package.path .. ";/Users/iMac/Desktop/Dev/Lua_Dev/plugins/sensai.nvim/?.lua"
      require("sensai"):setup({})
    end
  },

  -- Regular Plugins
  "williamboman/mason-lspconfig.nvim",
  "nvim-treesitter/playground",
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "Exafunction/codeium.vim",
  "mbbill/undotree",
  "dstein64/vim-startuptime",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  {
    "hrsh7th/nvim-cmp",
    init = function()
      require("plugin.nvim-cmp")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    init = function()
      require("plugin.indent-blankline")
    end,
    opts = {},
  },
  {
    "Pheon-Dev/lsp_lines.nvim",
    config = function()
      require("lsp_lines").register_lsp_virtual_lines()
    end
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("plugin.nvim-lspconfig")
    end,
  },
  {
    "numToStr/Comment.nvim",
    init = function()
      require("Comment").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("plugin.nvim-treesitter")
    end,
  },
  {
    "williamboman/mason.nvim",
    init = function()
      require("plugin.mason")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.4",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_fle = true,
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    init = function()
      require("plugin.lualine")
    end,
  },
  {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                home = "~/notes/home",
              },
              index = "index.norg",
            }
          },
          ["core.integrations.treesitter"] = {
            config = {
              configure_parsers = true,
              install_parsers = true,
            }
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
              name = "[Neorg]",
            }
          },
          ["core.concealer"] = {
            folds = false,
            icon_preset = "diamonds",
            init_open_folds = "auto",
          }
        }
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      o.timeout = true
      o.timeoutlen = 300
      require("plugin.which-key")
    end,
    opts = {},
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   init = function()
  --     require("plugin.nvim-autopairs")
  --   end,
  -- },
})
