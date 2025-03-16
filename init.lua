vim.g.mapleader                     = " "
vim.o.mouse                         = "a"
vim.opt.autoindent                  = false
vim.opt.background                  = "dark"
vim.opt.breakindent                 = true
vim.opt.breakindentopt              = { shift = 2, min = 40, column = 80 }
vim.opt.clipboard                   = "unnamedplus"
vim.opt.cursorline                  = true
vim.opt.expandtab                   = true
vim.opt.foldlevel                   = 99
vim.opt.guicursor                   = "n-v-c-sm-i-ci-ve-r-cr-o:block"
vim.opt.ignorecase                  = true
vim.opt.incsearch                   = true
vim.opt.linebreak                   = true
vim.opt.shiftwidth                  = 2
vim.opt.showbreak                   = "+ "
vim.opt.showtabline                 = 0
vim.opt.smartindent                 = false
vim.opt.smarttab                    = false
vim.opt.spell                       = false
vim.opt.spelllang                   = "en_us"
vim.opt.tabstop                     = 2
vim.opt.termguicolors               = true
vim.opt.wrap                        = false
vim.wo.number                       = true
vim.wo.relativenumber               = true
vim.g.nvim_directory                = vim.env.HOME .. "/.config/BlackForest"
vim.g.init_directory                = vim.env.HOME .. "/.config/BlackForest/lua"
vim.g.inits_directory               = vim.env.HOME .. "/.config/BlackForest/inits"
vim.g.function_directory            = vim.env.HOME .. "/.config/BlackForest/lua/functions"
vim.g.plugin_directory              = vim.env.HOME .. "/.config/BlackForest/lua/plugin"
vim.g.active_colorscheme            = "marri"
vim.g.vim_markdown_toc_autofit      = 1
vim.g.vim_markdown_math             = 1
vim.g.vim_markdown_frontmatter      = 1
vim.g.vim_markdown_toml_frontmatter = 1

package.path = string.format("%s;%s/?.lua", package.path, vim.g.function_directory)

require("config.lazy")
require("color_groups")
require("bundles.mason")
require("inits.commands")

-- dofile(vim.g.inits_directory .. "/plugin_lazy.lua")
-- dofile(vim.g.init_directory .. "/rock.lua")
-- dofile(vim.g.init_directory .. "/color_groups.lua")

-- dofile(vim.g.init_directory .. "/commands.lua")
-- dofile(vim.g.init_directory .. "/autocmds.lua")
-- dofile(vim.g.init_directory .. "/parsers.lua")
-- dofile(vim.g.init_directory .. "/utility.lua")

-- dofile(vim.fs.joinpath(vim.g.init_directory, "notes_telescope.lua"))

-- vim.cmd("CodeiumDisable")
