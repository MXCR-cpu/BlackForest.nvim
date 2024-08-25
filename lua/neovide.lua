if vim.g.neovide then
  vim.o.guifont = 'Source Code Pro:h13'
  local alpha = function()
    return string.format('%x', math.floor((255 * vim.g.transparency) or 0.8))
  end
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.88
  vim.g.neovide_background_color = "#000000" .. alpha()
  vim.g.neovide_input_macos_alt_is_meta = true
end
