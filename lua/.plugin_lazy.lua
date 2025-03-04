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
  --- Personal Plugins
  {
    "MXCR-cpu/boop.nvim",
    dir = "/Users/iMac/Desktop/Dev/Lua_Dev/plugins/boop.nvim",
    dev = true,
  },
  -- {
  --   'MXCR-cpu/sensai.nvim',
  --   dir = '/Users/iMac/Desktop/Dev/Lua_Dev/plugins/sensai.nvim',
  --   -- dev = true,
  --   init = function()
  --     package.path = package.path .. ";/Users/iMac/Desktop/Dev/Lua_Dev/plugins/sensai.nvim/?.lua"
  --     require("sensai"):setup({})
  --   end
  -- },

  --- Regular Plugins
  "williamboman/mason-lspconfig.nvim",
  "nvim-treesitter/playground",
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "mbbill/undotree",
  "dstein64/vim-startuptime",

  --- Text Completion
  "L3MON4D3/LuaSnip",
  -- {
  --   "Pheon-Dev/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").register_lsp_virtual_lines()
  --   end
  -- },
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("plugin.nvim-lspconfig")
    end,
  },
  "Exafunction/codeium.vim",
  {
    "hrsh7th/nvim-cmp",
    init = function()
      require("plugin.nvim-cmp")
    end,
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "PhilRunninger/cmp-rpncalc",
      "dmitmel/cmp-digraphs",
      "notomo/cmp-neosnippet",
      "lukas-reineke/cmp-rg",
      "tamago324/cmp-zsh",
      "doxnit/cmp-luasnip-choice",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
  },
  {
    "williamboman/mason.nvim",
    init = function()
      require("plugin.mason")
    end,
  },

  --- UI

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    init = function()
      require("plugin.indent-blankline")
    end,
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("plugin.nvim-treesitter")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    init = function()
      require("plugin.lualine")
    end,
  },

  ---

  {
    "numToStr/Comment.nvim",
    init = function()
      require("Comment").setup()
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
  -- {
  --   "vhyrro/luarocks.nvim",
  --   priority = 1000, 
  --   config = true,
  -- },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false,
    version = "*",
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
          ["core.export"] = {},
          ["core.concealer"] = {
            -- config = {
            --   folds = false,
            --   icon_preset = "diamonds",
            --   icons = {
            --     code_block = {
            --       conceal = true,
            --       content_only = true,
            --       highlight = "@neorg.tags.ranged_verbatim.code_block",
            --       insert_enabled = true,
            --       nodes = { "ranged_verbatim_tag" },
            --       padding = {
            --         left = 5,
            --         right = 5,
            --       },
            --       spell_check = false,
            --       width = "fullwidth",
            --     },
            --   },
            --   init_open_folds = "always",
            -- }
          }
        }
      })
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end
  },
  {
      "kawre/leetcode.nvim",
      build = ":TSUpdate html",
      dependencies = {
          "nvim-telescope/telescope.nvim",
          "nvim-lua/plenary.nvim", -- required by telescope
          "MunifTanjim/nui.nvim",

          -- optional
          "nvim-treesitter/nvim-treesitter",
          "rcarriga/nvim-notify",
          "nvim-tree/nvim-web-devicons",
      },
      opts = {
        lang = "c",
        cn = {
            enabled = false, ---@type boolean
            translator = true, ---@type boolean
            translate_problems = true, ---@type boolean
        },
        storage = {
            home = vim.fn.stdpath("data") .. "/leetcode",
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },
      },
  }
})
