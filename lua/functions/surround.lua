
Surround = {}

local command_selection = function(arg)
  if string.gmatch(arg.args[1], "add") ~= nil then
    Surround.add()
  elseif string.gmatch(arg.args[2], "delete") ~= nil then
    Surround.delete()
  end
end

Surround.setup = function()
  vim.api.nvim_create_user_command("Surround", command_selection, { nargs = "?", range = true })
end

Surround.test = function()
end

Surround.add = function()
  local start = vim.fn.getpos("'<")
  local finish = vim.fn.getpos("'>")
  local char = vim.fn.input("Char: "):gsub('\"', '\\\"')
  local lines = vim.api.nvim_buf_get_lines(0, start[2] - 1, finish[2], false)
  local jsonified_lines = vim.json.encode(lines):gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('%%', '\\%%'):gsub('~', '\\~'):gsub('!', '\\!')
  local command_result = vim.api.nvim_exec2(
    string.format(
      [[!/Users/iMac/Desktop/Dev/Rust_Dev/surround/target/debug/surround --json --char "%s" add %s %s "%s"]],
      char,
      start[3] - 1,
      finish[3],
      jsonified_lines
    ),
    { output = true }
  )
  local split_command_result = vim.split(command_result.output, "\n")
  table.remove(split_command_result, 1)
  table.remove(split_command_result, 1)
  local ok, resulting_lines = pcall(vim.json.decode, split_command_result[1])
  if not ok then
    vim.notify("command_result.output: " .. command_result.output, vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_buf_set_lines(0, start[2] - 1, finish[2], false, resulting_lines)
end

Surround.delete = function()
  local start = vim.fn.getpos("'<")
  local finish = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start[2] - 1, finish[2], false)
  local jsonified_lines = vim.json.encode(lines):gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('%%', '\\%%'):gsub('~', '\\~'):gsub('!', '\\!')
  local command_result = vim.api.nvim_exec2(
    string.format(
      [[!/Users/iMac/Desktop/Dev/Rust_Dev/surround/target/debug/surround --json delete %s %s "%s"]],
      start[3] - 2,
      finish[3] + 1,
      jsonified_lines
    ),
    { output = true }
  )
  local split_command_result = vim.split(command_result.output, "\n")
  table.remove(split_command_result, 1)
  table.remove(split_command_result, 1)
  local ok, resulting_lines = pcall(vim.json.decode, split_command_result[1])
  if not ok then
    vim.notify("command_result.output: " .. command_result.output, vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_buf_set_lines(0, start[2] - 1, finish[2], false, resulting_lines)
end

return Surround

