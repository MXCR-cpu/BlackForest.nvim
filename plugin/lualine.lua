local g = vim.g
local fn = vim.fn
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir

local colors = {
  bg        = '#111111',
  fg        = '#bbc2cf',
  yellow    = '#edfc1b',
  cyan      = '#008080',
  darkblue  = '#081633',
  green     = '#98be65',
  orange    = '#FF8800',
  violet    = '#a9a1e1',
  magenta   = '#c678dd',
  blue      = '#51afef',
  red       = '#ec5f67',
  white     = '#eeeeee',
  black     = '#000000',
  darkgrey  = '#313131',
  grey      = '#6C6C6C',
  lightgrey = '#B2B2B2',
}

local conditions = {
  buffer_not_empty = function()
    return fn.empty(fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = fn.expand("%:p:h")
    local gitdir = fn.finddir(".git", filepath .. ";")
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
      normal = { c = { fg = colors.fg } },
      inactive = { c = { fg = colors.fg } },
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

-- Functions --
local climbing_color = 0
local interval = 100
-- local half_interval = math.floor(interval / 2)
-- local conversion = (#g.colors_shades - 1) / half_interval
local color_mode_change = { fg = "#FF8700" }

-- local function color_mode_change()
--   return {
--     fg = g.colors_shades[math.floor(conversion * math.abs(climbing_color - half_interval)) + 1]
--   }
-- end

config.sections.lualine_c = {
  {
    function()
      climbing_color = (climbing_color % interval) + 1
      return "██ " .. string.upper(fn.mode()) .. " ██▓▓▒▒░░"
    end,
    color = color_mode_change,
  },
  {
    "filename",
    cond = conditions.buffer_not_empty,
    color = { fg = g.colors_shades[fn.color_index(100)] },
  },
  {
    "progress",
    color = { fg = g.colors_shades[fn.color_index(80)] }
  },
  {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.cyan },
    },
  },
  {
    function()
      return "%="
    end,
  },
  {
    function()
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return ""
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return string.format(" %s", string.upper(client.name))
        end
      end
      return ""
    end,
    icon = "",
    color = color_mode_change,
  }
}

config.sections.lualine_x = {
  {
    "branch",
    icon = "",
    color = { fg = vim.g.colors_shades[fn.color_index(70)] },
  },
  {
    "diff",
    -- Is it me or the symbol for modified us really weird
    symbols = { added = " ", modified = "◎ ", removed = " " },
    diff_color = {
      added = { fg = vim.g.colors_shades[fn.color_index(80)] },
      modified = { fg = vim.g.colors_shades[fn.color_index(85)] },
      removed = { fg = vim.g.colors_shades[fn.color_index(90)] },
    },
    cond = conditions.hide_in_width,
  },
  {
    function()
      return "░░▒▒▓▓██  ██"
    end,
    color = color_mode_change,
  },
}

config.inactive_sections.lualine_c = {
  {
    "filename",
    cond = conditions.buffer_not_empty,
    color = { fg = g.colors_shades[fn.color_index(100)] },
  },
  {
    "progress",
    color = { fg = g.colors_shades[fn.color_index(80)] }
  },
}

require("lualine").setup(config)

