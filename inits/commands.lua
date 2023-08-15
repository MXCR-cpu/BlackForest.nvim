local api = vim.api
local cmd = vim.cmd
local fn = vim.fn


local user_commands = {
	ClearHighlight = { function()
		cmd [[let @/ = ""]]
	end, {} },
	CheckPacker = { function()
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
	end, {} },
	Go = { function()
		if fn.expand("%"):sub(1, 4):match("term") == nil then
			print("<<!>> Nvim Go Function: Current buffer is not a terminal buffer")
			return
		end
		local line = api.nvim_get_current_line()
		local dir_name = line:match("~[^]*")
		dir_name = dir_name:sub(1, #dir_name - 1)
		cmd([[cd ]] .. dir_name)
		cmd [[wincmd l]]
		cmd [[Telescope find_files]]
	end, {} },
	Start = { function()
		cmd [[e ~/.config/nvim/init.lua]]
		cmd [[split]]
		cmd [[wincmd k]]
		cmd [[terminal]]
		cmd [[set nonumber]]
	end, {} },
	DMsg = { function()
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
	end, {} },
	NvimSurround = { function()
		local character_check = function(char)
			if #char ~= 1 then
				print '!Accepting only single character arguments'
				return true
			end
			return false
		end
		local from_char = fn.input 'From: '
		if character_check(from_char) then
			return
		end
		local to_char = fn.input 'To: '
		if character_check(to_char) then
			return
		end
		if not require 'nvim-surround' then
			print 'nvim-surround not configured'
			return
		end
	end, {} },
	Tm = { function()
		cmd [[term]]
		cmd [[set nonumber]]
	end, {} },
}

for key, command_values in pairs(user_commands) do
	api.nvim_create_user_command(key, command_values[1], command_values[2])
end
