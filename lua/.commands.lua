local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

local function parse_command_output(command_result)
  local split_command_result = vim.split(command_result.output, "\n")
  table.remove(split_command_result, 1)
  table.remove(split_command_result, 1)
  return split_command_result
end

local user_commands = {
  Go = {
    function()
      if fn.expand("%"):sub(1, 4):match("term") == nil then
        print("<<!>> Nvim Go Function: Current buffer is not a terminal buffer")
        return
      end
      local line = api.nvim_get_current_line()
      local dir_name = line:match("~[^]*")
      dir_name = dir_name:sub(1, #dir_name - 1)
      cmd([[cd ]] .. dir_name)
      cmd([[wincmd l]])
      cmd([[Telescope find_files]])
    end,
    {},
  },
  Start = {
    function()
      cmd([[e ~/.config/nvim/init.lua]])
      cmd([[split]])
      cmd([[wincmd k]])
      cmd([[terminal]])
      cmd([[set nonumber]])
    end,
    {},
  },
  Scratch = {
    function()
      cmd([[e /tmp/]] .. cmd([[!date]]))
    end,
    {},
  },
}

for key, command_values in pairs(user_commands) do
  api.nvim_create_user_command(key, command_values[1], command_values[2])
end
