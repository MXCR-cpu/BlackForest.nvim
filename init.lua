local fn = vim.fn
local api = vim.api
local opt = vim.opt
local g = vim.g
local o = vim.o

g.mapleader = " "
opt.incsearch = true
opt.ignorecase = true
opt.number = true
opt.linebreak = true
opt.smartindent = true
opt.spell = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.breakindentopt = { shift = 2, min = 40 }
opt.showbreak = ">>> "
opt.spelllang = "en_us"
opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"
o.mouse = "a"

vim.g.colors_shades = {
	"#000000",
	"#050505",
	"#0f0f0f",
	"#191919",
	"#232323",
	"#2d2d2d",
	"#363636",
	"#404040",
	"#404040",
	"#4a4a4a",
	"#545454",
	"#5e5e5e",
	"#676767",
	"#717171",
	"#7b7b7b",
	"#858585",
	"#8f8f8f",
	"#989898",
	"#a2a2a2",
	"#acacac",
	"#b6b6b6",
	"#c0c0c0",
	"#c9c9c9",
	"#d3d3d3",
	"#dddddd",
	"#e7e7e7",
	"#f1f1f1",
	"#fbfbfb",
	"#ffffff",
}

local mappings = {
	{ "n", "j", "gj" },
	{ "n", "k", "gk" },
	{ "v", "j", "gj" },
	{ "v", "k", "gk" },
	{ "n", "H", "5h" },
	{ "n", "J", "5gj" },
	{ "n", "K", "5gk" },
	{ "n", "L", "5l" },
	{ "t", "<Shift><Backspace>", "" },
}

for _, mapping in ipairs(mappings) do
	api.nvim_set_keymap(mapping[1], mapping[2], mapping[3], { noremap = true })
end

vim.cmd([[set clipboard+=unnamedplus]])

local augroup = api.nvim_create_augroup("Terminal_cmds", { clear = true })
local zsh_file = "zsh"
api.nvim_create_autocmd("TermResponse", {
	pattern = zsh_file,
	group = augroup,
	desc = "Change Nvim-Tree Root To Current Terminal Directory",
	callback = function()
		local lines = 0
		local directory_search = nil
		while not directory_search do
			directory_search = api.nvim_buf_get_lines(api.nvim_get_current_buf(), -2 - lines, -1 - lines, true)[1]
				:gmatch("~[/[\\ _.%-_%w]+]*")()
			lines = lines + 1
		end
		if directory_search then
			directory_search = string.gsub(directory_search, "~", "/Users/iMac")
			directory_search = string.gsub(directory_search, " $", "")
			print(lines)
			require("nvim-tree.api").tree.change_root(directory_search)
		end
	end,
})
api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	desc = "Update Compiled PDF",
	callback = function()
		local file_name = vim.fn.expand("%:p"):gsub(" ", "\\ ")
		local option = fn.input("Compile: ")
		if option:find("y") then
			api.nvim_command("!lualatex " .. file_name)
			api.nvim_command("!rm *.log")
			api.nvim_command("!rm *.aux")
			api.nvim_command("!rm *.out")
		end
	end,
})

g.nvim_directory = "/Users/iMac/.config/BlackForest"
dofile(g.nvim_directory .. [[/plugin_packer.lua]])
dofile(g.nvim_directory .. [[/plugin/luasnip.lua]])

-- plugin_packer.lua
api.nvim_create_user_command("Sc", function()
	vim.cmd([[let @/ = ""]])
end, {})
api.nvim_create_user_command("Go", function()
	if fn.expand("%"):sub(1, 4):match("term") == nil then
		print("<<!>> Nvim Go Function: Current buffer is not a terminal buffer")
		return
	end
	local line = api.nvim_get_current_line()
	local dir_name = line:match("~[^]*")
	dir_name = dir_name:sub(1, #dir_name - 1)
	vim.cmd([[cd ]] .. dir_name)
	vim.cmd([[wincmd l]])
	vim.cmd([[Telescope find_files]])
end, {})
api.nvim_create_user_command("Start", function()
	vim.cmd([[e ~/.config/nvim/init.lua]])
	vim.cmd([[split]])
	vim.cmd([[wincmd k]])
	vim.cmd([[terminal]])
	vim.cmd([[set nonumber]])
end, {})

-- Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd[[colorscheme Mies]]
vim.cmd[[set background=dark]]
dofile(g.nvim_directory .. [[/colors_update.lua]])

local nvim_tree_icon = {
	"NvimTreeFolderIcon",
	"NvimTreeFileIcon",
}

for _, icon_name in ipairs(nvim_tree_icon) do
	api.nvim_set_hl(0, icon_name, {
		ctermfg = "NONE",
		ctermbg = "NONE",
	})
end

g.vim_markdown_toc_autofit = 1
g.vim_markdown_math = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_toml_frontmatter = 1
