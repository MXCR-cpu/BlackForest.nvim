local rocks_config = {
    rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
}

vim.g.rocks_nvim = rocks_config

package.path = table.concat({
  package.path,
  rocks_config.rocks_path .. "/share/lua/5.1/?.lua",
  rocks_config.rocks_path .. "/share/lua/5.1/?/init.lua",
}, ";")

package.cpath = table.concat({
  package.cpath,
  rocks_config.rocks_path .. "/lib/lua/5.1/?.so",
  rocks_config.rocks_path .. "/lib64/lua/5.1/?.so",
  -- Remove the dylib and dll paths if you do not need macos or windows support
  rocks_config.rocks_path .. "/lib/lua/5.1/?.dylib",
  rocks_config.rocks_path .. "/lib64/lua/5.1/?.dylib",
  rocks_config.rocks_path .. "/lib/lua/5.1/?.dll",
  rocks_config.rocks_path .. "/lib64/lua/5.1/?.dll",
}, ";")

vim.opt.runtimepath:append(rocks_config.rocks_path .. "/lib/luarocks/rocks-5.1/*/*")
