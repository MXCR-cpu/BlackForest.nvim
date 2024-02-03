local pickers = require"telescope.pickers"
local finders = require"telescope.finders"
local conf = require"telescope.config".values
local actions = require"telescope.actions"
local action_state = require"telescope.actions.state"
local api = vim.api
local cmd = vim.cmd

-- Generate a function that splits a string on the new line delimiter
local split = function(string, delimiter)
  local result = {}
  for match in (string .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

local _prefix = {
  label = "--prefix=label",
  mtime = "--prefix=mtime",
  ctime = "--prefix=ctime",
}

Notes = function(prefix, opts)
  prefix = prefix or "label"
  local notes_list = api.nvim_exec("!notesium list " .. _prefix[prefix], true)
  local lines = split(notes_list, "\n")
  table.remove(lines, 1)
  opts = opts or {}
  pickers.new(opts,{
    prompt_title = "notes",
    finder = finders.new_table {
      results = lines,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        cmd("e /Users/iMac/notes/" .. split(selection[1], ":")[1])
      end)
      return true
    end
  }):find()
end

NotesInsert = function(opts)
  local notes_list = api.nvim_exec("!notesium list", true)
  local lines = split(notes_list, "\n")
  table.remove(lines, 1)
  opts = opts or {}
  pickers.new(opts,{
    prompt_title = "notes",
    finder = finders.new_table {
      results = lines,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        api.nvim_put({ split(selection[1], ":")[1] }, "", false, true)
      end)
      return true
    end,
  }):find()
end

NotesLinks = function(opts)
  local notes_list = api.nvim_exec("!notesium list", true)
  local lines = split(notes_list, "\n")
  table.remove(lines, 1)
  opts = opts or {}
  pickers.new(opts,{
    prompt_title = "notes",
    finder = finders.new_table {
      results = lines,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        api.nvim_put({ split(selection[1], ":")[1] }, "", false, true)
      end)
      return true
    end,
  }):find()
end
