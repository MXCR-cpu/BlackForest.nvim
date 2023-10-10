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

api.nvim_create_autocmd("BufRead, BufWrite", {
  pattern = "*.org",
  desc = "Setting org file highlighting",
  callback = function()
    cmd[[set filetype=markdown]]
  end
})

-- cmd[[autocmd BufRead,BufNewFile *.org set filetype=markdown]]

local vertical_column_coloring_group = api.nvim_create_augroup(
	"verticalColumnColoringGroup",
	{ clear = true }
)

api.nvim_create_autocmd(
  "BufEnter",
  {
    pattern = "*",
    desc = "Setting 80 Column Limit matching",
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
      cmd[[match ErrorBoundary /\%>80c/]]
    end,
    group = vertical_column_coloring_group,
  }
)

api.nvim_create_autocmd(
  "BufEnter",
  {
    pattern = "/bin/*",
    desc = "Undoing Terminal 80 Column Limit matching",
    callback = function()
      cmd[[match none]]
    end,
    group = verticalColumnColoringGroup,
  }
)

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
---
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
-- )
--
