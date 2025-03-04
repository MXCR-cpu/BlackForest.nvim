vim.utils = {}

---@param inputstr string
function vim.utils.examine(inputstr)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, string:split(inputstr, '\n'))
end
