-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir

local colors = {
  inactive_bg = '#000000',
  active_bg   = '#000000',
  inactive_fg = '#E4007C',
  active_fg   = '#FF0000',
  yellow      = '#edfc1b',
  cyan        = '#008080',
  darkblue    = '#081633',
  green       = '#98be65',
  orange      = '#FF8800',
  violet      = '#a9a1e1',
  magenta     = '#c678dd',
  blue        = '#51afef',
  red         = '#ec5f67',
  white       = '#eeeeee',
  black       = '#000000',
  darkgrey    = '#313131',
  grey        = '#6C6C6C',
  lightgrey   = '#B2B2B2',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    icons_enabled = true,
    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = colors.active_fg, bg = colors.active_bg } },
      inactive = { c = { fg = colors.inactive_fg, bg = colors.inactive_bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

--  
--  

config.sections.lualine_c = {
  { "mode" },
  {
    "filename",
    cond = conditions.buffer_not_empty,
  },
  { "filesize" },
  { "progress" },
  { "searchcount" },
  { "selectioncount" },
  {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    cond = conditions.hide_in_width,
    diagnostics_color = {
      error = "LuaLineN",
      warn = "LuaLineV",
      info = "LuaLineI",
      hint = "LuaLineI",
    },
  },
  {
    function()
      return "%="
    end,
  },
  {
    function()
      local current_buffer_number = tonumber(vim.api.nvim_get_current_buf())
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then
        return "none"
      end
      for _, client in ipairs(clients) do
        for attached_buffer_number, _ in pairs(client.attached_buffers) do
          if attached_buffer_number == current_buffer_number then
            return string.format("%s", string.upper(client.name))
          end
        end
      end
      return "none"
    end,
    icon = "",
  }
}

config.sections.lualine_x = {
  {
    "branch",
    icon = "",
  },
  {
    "diff",
    symbols = { added = " ", modified = "◎ ", removed = " " },
    cond = conditions.hide_in_width,
    diff_color = {
      added = "LuaLineI",
      modified = "LuaLineV",
      removed = "LuaLineN",
    },
  },
}

config.inactive_sections.lualine_c = {
  {
    "filename",
    cond = conditions.buffer_not_empty,
  },
  { "progress" },
}

return config

