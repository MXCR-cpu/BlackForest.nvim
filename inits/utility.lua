local api = vim.api
local fn = vim.fn
local _if = function(bool, val1, val2)
	if bool then
		return val1
	end
	return val2
end

local _repeat = function(character, times)
	local string = ""
	for _ = 1, times do
		string = string .. character
	end
	return string
end

Utility = {}

Utility.align = function()
	local left_position = api.nvim_buf_get_mark(0, "<")
	local right_position = api.nvim_buf_get_mark(0, ">")
	local lines = api.nvim_buf_get_lines(0, left_position[1], right_position[1], true)
	local delimiter = fn.input("Character: ")
	local split_lines = {}
	local segment_lengths = {}
	print('a')
	for _, line in ipairs(lines) do
		local single_split_line = {}
		local inner_index = 1
		for segment in line:gmatch('([^' .. delimiter .. ']+)') do
			single_split_line[#single_split_line + 1] = segment:match '^%s*(.-)%s*$'
			local segment_length = #single_split_line[#single_split_line]
			segment_lengths[inner_index] = _if(
				segment_lengths[inner_index],
				segment_lengths[inner_index],
				0)
			segment_lengths[inner_index] = _if(
				segment_length > segment_lengths[inner_index],
				segment_length,
				segment_lengths[inner_index])
			inner_index = inner_index + 1
		end
		split_lines[#split_lines + 1] = single_split_line
	end
	local strings = {}
	for _, single_split_line in ipairs(split_lines) do
		local new_line = ""
		for key, segment in ipairs(single_split_line) do
			new_line = new_line ..
			    segment ..
			    _if(
			            single_split_line[key + 1],
			            _repeat(' ', segment_lengths[key] - #segment) .. ' ' .. delimiter .. ' ', '')
		end
		strings[#strings + 1] = new_line
	end
	for _, item in ipairs(strings) do
		print(item)
	end
end

return Utility
