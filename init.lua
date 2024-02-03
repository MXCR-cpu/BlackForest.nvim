local cmd = vim.cmd
local g = vim.g
local o = vim.o
local opt = vim.opt
local wo = vim.wo

g.mapleader = " "
o.mouse = "a"
opt.autoindent = true
opt.breakindent = true
opt.breakindentopt = { shift = 2, min = 40 }
opt.cursorline = true
opt.expandtab = true
opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"
opt.ignorecase = true
opt.incsearch = true
opt.linebreak = true
opt.shiftwidth = 2
opt.showbreak = "+ "
opt.smartindent = true
opt.smartindent = true
opt.spell = true
opt.spelllang = "en_us"
opt.tabstop = 2
opt.termguicolors = true
opt.wrap = true

wo.number = true
wo.relativenumber = true

g.nvim_directory = os.getenv "HOME" .. "/.config/BlackForest"
cmd [[set background=dark]]
cmd [[set clipboard+=unnamedplus]]

package.path = g.nvim_directory .. '/inits/?.lua;' .. package.path

local init_files = {
  "/color_palettes.lua",
  "/commands.lua",
  "/neovide.lua",
  "/plugin_lazy.lua",
  "/notes_telescope.lua",
  "/utility.lua",
  "/autocmds.lua",
  "/parsers.lua",
  "/color_functions.lua",
  "/color_groups.lua",
  "/mappings.lua",
}
for _, file in ipairs(init_files) do
  local file_path = g.nvim_directory .. "/inits" .. file
  dofile(file_path)
end

g.vim_markdown_toc_autofit = 1
g.vim_markdown_math = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_toml_frontmatter = 1

opt.shiftwidth = 2

vim.cmd("CodeiumDisable")
