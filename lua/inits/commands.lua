local api = vim.api
local fn = vim.fn

local user_commands = {
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
		if not require('nvim-surround') then
			print 'nvim-surround not configured'
			return
		end
	end, {} }
}

for key, command_values in pairs(user_commands) do
	api.nvim_create_user_command(key, command_values[1], command_values[2])
end

return {}

