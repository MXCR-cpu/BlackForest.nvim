local api = vim.api

---@class Completion
local Completion = {}

---@class Completion
---@field place_statement fun(self: Completion, statement: string[])
function Completion.place_statement(statement)
  ---@type integer
  local row, _ = api.nvim_win_get_cursor(0)
  api.nvim_buf_set_lines(
    0,
    row,
    row + #statement,
    false,
    statement
  )
end

---@class Completion
---@field if_statement fun(self: Completion)
function Completion.if_statement()
  ---@type string
  local file_type = api.nvim_buf_get_option(0, "ft")
  ---@type { [string]: string[] }
  local if_statements = {
    ["rust"] = {
      "if @ {",
      "  @",
      "}",
    },
    ["lua"] = {
      "if @ then",
      "  @",
      "end",
    },
    ["c"] = {
      "if (@) {",
      "  @",
      "}",
    },
    ["cpp"] = {
      "if (@) {",
      "  @",
      "}",
    },
    ["go"] = {
      "if @ {",
      "  @",
      "}",
    },
    ["bash"] = {
      "if %[%[ @ %]%]; then",
      "  @",
      "fi",
    },
  }

  Completion.place_statement(if_statements[file_type])
end

return Completion
