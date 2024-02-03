require'nvim-web-devicons'.setup{
  color_icons = true;
}

for icon, config in pairs(require'nvim-web-devicons'.get_icons()) do
  config['color'] = "#eeeeee"
  config['cterm_color'] = "15"
  require'nvim-web-devicons'.set_icon{
    icon = config
  }
end
