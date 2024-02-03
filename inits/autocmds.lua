local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.tex",
  desc = "Update Compiled PDF",
  callback = function()
    local file_name = vim.fn.expand("%:p"):gsub(" ", "\\ ")
    local option = fn.input("Compile: ")
    if option:find("y") then
      api.nvim_command("!lualatex " .. file_name)
      api.nvim_command("!rm *.log")
      api.nvim_command("!rm *.aux")
      api.nvim_command("!rm *.out")
    end
  end,
})

-- api.nvim_create_autocmd("BufRead, BufWrite", {
--   pattern = "*.org",
--   desc = "Setting org file highlighting",
--   callback = function()
--     cmd[[set filetype=markdown]]
--   end
-- })

-- cmd[[autocmd BufRead,BufNewFile *.org set filetype=markdown]]

-- local vertical_column_coloring_group = api.nvim_create_augroup(
--   "verticalColumnColoringGroup",
--   { clear = true }
-- )
--
-- api.nvim_create_autocmd(
--   "BufEnter",
--   {
--     pattern = "*.*",
--     desc = "Setting 80 Column Limit matching",
--     callback = function()
--       local file = fn.expand("<afile>")
--       local excludedFileMatches = {
--         "Makefile",
--         "/bin/",
--         ".txt",
--         ".org",
--         ".log",
--       }
--       for _, pattern in ipairs(excludedFileMatches) do
--         if file:match(pattern) then
--           return
--         end
--       end
--       cmd[[match ErrorBoundary /\%80v/]]
--     end,
--     group = vertical_column_coloring_group,
--   }
-- )

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

-- api.nvim_create_autocmd(
--   "BufEnter",
--   {
--     pattern = "/bin/*",
--     desc = "Undoing Terminal 80 Column Limit matching",
--     callback = function()
--       cmd[[match none]]
--     end,
--     group = verticalColumnColoringGroup,
--   }
-- )

api.nvim_create_autocmd(
  "BufEnter",
  {
    pattern = "*.md",
    desc = "Setting Codium behavior for markdown files",
    callback = function()
      cmd[[CodeiumDisable]]
    end,
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

--- Possible Markdown Plugin
-- local function add_virtual_text()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local ns_id = vim.api.nvim_create_namespace('markdownBlockify')
--   local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--   local position_tuples = { {} }
--   local pos
--   for line_num, line in ipairs(lines) do
--     pos = string.find(line, '%$%$')
--     while pos ~= nil do
--       if #position_tuples[#position_tuples] == 1 then
--         position_tuples[#position_tuples][2] = { line_num, pos }
--         position_tuples[#position_tuples + 1] = {}
--       else
--         position_tuples[#position_tuples][1] = { line_num, pos }
--       end
--       pos = string.find(line, '%$%$', pos)
--     end
--   end
--   print(vim.inspect(position_tuples))
--   return true
-- end
--
-- local markdown_latex_block_group = api.nvim_create_augroup(
--   "markdownLatexBlockGroup",
--   { clear = true })
--
-- api.nvim_create_autocmd(
--   {
--     "BufRead",
--     "BufNewFile",
--     "BufWrite",
--   },
--   {
--     group = markdown_latex_block_group,
--     pattern = "*.md",
--     desc = "Creating latex coloring blocks",
--     callback = function(_)
--       return add_virtual_text()
--     end
--   })
--


-- api.nvim_create_autocmd(
--   "BufLeave",
--   {
--     pattern = "*",
--     desc = "Setting global mark in previous file",
--     callback = function(arg)
--       if arg.buf ~= nil
--         and api.nvim_buf_is_valid(arg.buf)
--         and api.nvim_buf_get_option(arg.buf, 'modifiable') then
--         vim.schedule(function()
--           local position = api.nvim_win_get_cursor(0)
--           -- api.nvim_buf_set_mark(arg.buf, '1', position[1], position[2], {})
--           vim.cmd('m1')
--         end)
--       end
--     end
--   }
-- )

---
--- Builshit solution that did not need to exist if there was
--- a way to distinguish between the nodes that came from the markdown
--- parser and the markdown_inline parser.
---
--- There was no documentation that outlined this issue nor was AI of
--- much help. The solution was a complete, accidental happenstance
--- that occurred when I realized that `TSPlaygroundToggle` was meshing
--- all the parsed nodes together into a single display.
---
--- This solution came with flickering problems that occurred when the
--- cursor moved too quickly, thus why I ventured to create nvim-treesitter
--- highlight capture group to remedy by latex-markdown highlighting need.
---
--- vvv
--
-- local markdown_group = api.nvim_create_augroup(
--   "MardownGroup",
--   { clear = true }
-- )
--
-- api.nvim_create_autocmd(
--   "BufEnter",
--   {
--     pattern = "*.md",
--     desc = "Highlighting Latex Expressions",
--     callback = function()
--       cmd[[match MarkdownLatexInline /\$\_.\{-}\$/]]
--       cmd[[2match MarkdownLatexBlock /\$\$\_.\{-}\$\$/]]
--     end,
--     group = markdown_group,
--   }
--)
