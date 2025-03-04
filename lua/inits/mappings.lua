-- Most of key mappings are handled by which-key.lua in the plugin directory
local mappings = {
	{ "n", "j",                  "gj"   },
	{ "n", "k",                  "gk"   },
	{ "v", "j",                  "gj"   },
	{ "v", "k",                  "gk"   },
	{ "n", "H",                  "5h"   },
	{ "n", "J",                  "5gj"  },
	{ "n", "K",                  "5gk"  },
	{ "n", "L",                  "5l"   },
	{ "n", "D",                  "dd"   },
	{ "n", "dr",                 "v$hd" },
	{ "n", ";",                  ":"    },
	{ "t", "<Shift><Backspace>", ""     },
	-- { "i", "<C-g>",              "<cmd>lua vim.fn['codeium#Accept']() <CR>" },
	-- { "i", "<C-]>",              "<cmd>lua vim.fn['codeium#CycleCompletions'](1) <CR>" },
	-- { "i", "<C-[>",              "<cmd>lua vim.fn['codeium#CycleCompletions'](-1) <CR>" },
	{ "i", "<C-x>",              "<cmd>lua vim.fn['codeium#Clear']() <CR>" },
	{ "i", "<C-s>",              "<cmd>lua vim.fn['codeium#Complete']()<CR>" },
}

for _, mapping in ipairs(mappings) do
	vim.api.nvim_set_keymap(mapping[1], mapping[2], mapping[3], { noremap = true })
end

local keyset_mappings = {
	-- { "i", "<c-]>",              [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()]] },
	-- { "i", "<c-]>",              [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<space>" : coc#refresh()]] },
	-- { "i", "<c-[>",              [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]] },
	{ "i", "<c-]>",              [[coc#pum#next(1)]] },
	{ "i", "<c-[>",              [[coc#pum#prev(1)]] },
	{ "i", "<c-space>",          [[coc#refresh()]] },
	{ "i", "<c-p>",              function() print('Coc hotkeys configured') end },
}

for _, keyset_mapping in ipairs(keyset_mappings) do
	vim.keymap.set(keyset_mapping[1], keyset_mapping[2], keyset_mapping[3], { silent = true, noremap = true, expr = true, replace_keycodes = false })
end
