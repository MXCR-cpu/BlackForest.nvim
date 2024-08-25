local _repeat_direction = function(direction, segment, spacing, delimiter, gap, guard)
  if direction:match 'left' and not guard then
    return segment
  elseif direction:match('left') ~= nil then
    return segment .. spacing .. gap .. delimiter .. gap
  elseif direction:match 'right' and not guard then
    return spacing .. segment
  end
  return spacing .. segment .. gap .. delimiter .. gap
end

Aline = {}

---@param direction "left"|"right" The direction of alignment
---@param gap        boolean|nil   Whether there should be a gap in between each field
---@return nil
Aline.align = function(direction, gap)
  local left_position   = vim.api.nvim_buf_get_mark(0, "<")
  local right_position  = vim.api.nvim_buf_get_mark(0, ">")
  local lines           = vim.api.nvim_buf_get_lines(0, left_position[1] - 1, right_position[1], true)
  local delimiter       = vim.fn.input("Character: ")
  local split_lines     = {}
  local segment_lengths = {}
  local string_start    = lines[1]:match '^%s*'
  local space           = ' '

  for _, line in ipairs(lines) do
    local single_split_line = {}
    local inner_index = 1
    for segment in line:gmatch('([^' .. delimiter .. ']+)') do
      single_split_line[#single_split_line + 1] = segment:match '^%s*(.-)%s*$'
      local segment_length = #single_split_line[#single_split_line]
      if #segment_lengths < inner_index or segment_length >= segment_lengths[inner_index] then
        segment_lengths[inner_index] = segment_length
      end
      inner_index = inner_index + 1
    end
    split_lines[#split_lines + 1] = single_split_line
    if line:sub(#line, #line):match(delimiter) then
      segment_lengths[#segment_lengths + 1] = 0
    end
  end
  ---@type string[]
  local strings = {}
  for _, single_split_line in ipairs(split_lines) do
    local new_line = string_start
    for key, segment in ipairs(single_split_line) do
      if gap then
        new_line = new_line ..
            _repeat_direction(
                    direction,
                    segment,
                    space:rep(segment_lengths[key] - #segment),
                    delimiter,
                    space,
                    segment_lengths[key + 1])
      else
        new_line = new_line ..
            _repeat_direction(
                    direction,
                    segment,
                    space:rep(segment_lengths[key] - #segment),
                    delimiter,
                    '',
                    segment_lengths[key + 1])
      end
    end
    strings[#strings + 1] = new_line
  end
  vim.api.nvim_buf_set_lines(0, left_position[1] - 1, right_position[1], true, strings)
end

return Aline

