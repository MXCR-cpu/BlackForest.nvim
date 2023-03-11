vim.cmd[[
imap <silent><expr> <C-l> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-l>' 

imap <silent><expr> <C-l> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-l>'
smap <silent><expr> <C-l> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-l>'

imap <silent><expr> <C-h> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-h>'
smap <silent><expr> <C-h> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-h>'
]]

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

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

