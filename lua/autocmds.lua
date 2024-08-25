local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

api.nvim_create_autocmd(
  "BufEnter",
  {
    pattern = "*.*",
    desc = "Formatting Buffer on Entrance",
    callback = function()
      local file = fn.expand("<afile>")
      local excludedFileMatches = {
        "Makefile",
        "/bin/",
        ".txt",
        ".org",
        ".log",
      }
      for _, pattern in ipairs(excludedFileMatches) do
        if file:match(pattern) then
          return
        end
      end
      cmd[[set expandtab]]
      cmd[[set shiftwidth=2]]
    end,
    -- group = vertical_column_coloring_group,
  }
)

api.nvim_create_autocmd(
  "BufWrite",
  {
    pattern = "*",
    desc = "Replacing Tabs with Space on buffer write",
    ---@params arg {
    ---  id:    number, -  event: string,
    ---  group: number?,
    ---  match: string,
    ---  buf:   number,
    ---  file:  string,
    ---  data:  any
    ---}
    ---@return boolean
    callback = function(arg)
      if string.gmatch(arg.file, "Makefile")() == nil then
        cmd[[silent! :keeppatterns %s/\t/  /g]]
      end
      return false
    end
  }
)

