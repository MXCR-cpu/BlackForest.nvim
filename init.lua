local cmd = vim.cmd
local g = vim.g
local o = vim.o
local opt = vim.opt

g.mapleader = " "
o.mouse = "a"
opt.autoindent = true
opt.breakindent = true
opt.breakindentopt = { shift = 2, min = 40 }
opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"
opt.ignorecase = true
opt.incsearch = true
opt.linebreak = true
opt.number = true
opt.showbreak = ">>> "
opt.smartindent = true
opt.smartindent = true
opt.spell = true
opt.spelllang = "en_us"

g.nvim_directory = os.getenv"HOME" .. "/.config/BlackForest"
cmd[[colorscheme Mies]]
cmd[[set background=dark]]
cmd[[set clipboard+=unnamedplus]]
local init_files = {
	"/autocmds.lua",
	"/color_palettes.lua",
	"/color_groups.lua",
	"/commands.lua",
	"/mappings.lua",
	"/plugin_packer.lua"
}
for _, file in ipairs(init_files) do
	local file_path = g.nvim_directory .. "/inits" .. file
	dofile(file_path)
end
cmd[[CheckPacker]]

g.vim_markdown_toc_autofit = 1
g.vim_markdown_math = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_toml_frontmatter = 1
