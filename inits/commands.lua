local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

api.nvim_create_user_command("Sc", function()
	cmd[[let @/ = ""]]
end, {})

api.nvim_create_user_command("CheckPacker", function()
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
end, {})

api.nvim_create_user_command("Go", function()
	if fn.expand("%"):sub(1, 4):match("term") == nil then
		print("<<!>> Nvim Go Function: Current buffer is not a terminal buffer")
		return
	end
	local line = api.nvim_get_current_line()
	local dir_name = line:match("~[^]*")
	dir_name = dir_name:sub(1, #dir_name - 1)
	cmd([[cd ]] .. dir_name)
	cmd[[wincmd l]]
	cmd[[Telescope find_files]]
end, {})

api.nvim_create_user_command("Start", function()
	cmd[[e ~/.config/nvim/init.lua]]
	cmd[[split]]
	cmd[[wincmd k]]
	cmd[[terminal]]
	cmd[[set nonumber]]
end, {})

api.nvim_create_user_command("DMsg", function()
	local function_branches = {
		function()
			print(vim.lsp.diagnostic.get_line_diagnostics()[1]['data']['rendered'])
		end,
		function()
			print(vim.lsp.diagnostic.get_line_diagnostics()[1]['message'])
		end,
		function()
			print('No Diagnostic Information Available')
		end
	}
	for _, function_branch in ipairs(function_branches) do
		local success, _ = pcall(function_branch)
		if success then
			break
		end
	end
end, {})
