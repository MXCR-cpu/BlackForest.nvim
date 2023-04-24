local g = vim.g
Ls = require("luasnip")
S = Ls.snippet
Sn = Ls.snippet_node
T = Ls.text_node
I = Ls.insert_node
F = Ls.function_node
D = Ls.dynamic_node
Fmt = require("luasnip.extras.fmt").fmt
Fmta = require("luasnip.extras.fmt").fmta
Rep = require("luasnip.extras").rep

require("luasnip.loaders.from_lua").load({paths = g.nvim_directory .. "/LuaSnip"})
