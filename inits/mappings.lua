-- Most of key mappings are handled by which-key.lua in the plugin directory
local mappings = {
  { "n", "j",                  "gj"   },
  { "n", "k",                  "gk"   },
  { "v", "j",                  "gj"   },
  { "v", "k",                  "gk"   },
  { "t", "<Shift><Backspace>", ""     },
  -- { "i", "<C-g>",              "<cmd>lua vim.fn['codeium#Accept']() <CR>" },
  -- { "i", "<C-]>",              "<cmd>lua vim.fn['codeium#CycleCompletions'](1) <CR>" },
  -- { "i", "<C-[>",              "<cmd>lua vim.fn['codeium#CycleCompletions'](-1) <CR>" },
  { "i", "<C-x>",              "<cmd>lua vim.fn['codeium#Clear']() <CR>" },
  { "i", "<C-s>",              "<cmd>lua vim.fn['codeium#Complete']()<CR>" },
  { "i", "{",                  "{}<ESC>ha" },
  { "i", "]",                  "<ESC>la" },
  { "i", "(",                  "()<ESC>ha" },
  { "i", "<",                  "<><ESC>ha" },
  { "i", "[",                  "[]<ESC>ha" },
  { "i", "\"",                 "\"\"<ESC>ha" },
  { "i", "'",                  "''<ESC>ha" },
  { "i", "|",                  "||<ESC>ha" },
}

for _, mapping in ipairs(mappings) do
  vim.api.nvim_set_keymap(mapping[1], mapping[2], mapping[3], { noremap = true })
end

-- local cmp = require('cmp')
-- local keyset_mappings = {
  -- { "i", "<c-]>",              [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()]] },
  -- { "i", "<c-]>",              [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<space>" : coc#refresh()]] },
  -- { "i", "<c-[>",              [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]] },
  -- { "i", "<C-]>",              [[coc#pum#next(1)]] },
  -- { "i", "<C-[>",              [[coc#pum#prev(1)]] },
  -- { "i", "<C-space>",          [[coc#refresh()]] },
  -- { "i", "<C-p>",              function() print('Coc hotkeys configured') end },
--   { "i", "<C-]>",     function() cmp.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 1, select = true }) end },
--   { "i", "<C-[>",     function() cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 1, select = true }) end },
--   { "i", "<C-space>", function() cmp.confirm() end  },
--   { "i", "<C-,>",     function() cmp.complete() end  },
--   { "i", "<C-p>",     function() print('nvim-cmp hotkeys configured') end },
-- }

-- for _, keyset_mapping in ipairs(keyset_mappings) do
--   vim.keymap.set(
--     keyset_mapping[1],
--     keyset_mapping[2],
--     keyset_mapping[3],
--     {
--       silent = true,
--       noremap = true,
--       expr = true,
--       replace_keycodes = false
--     }
--   )
-- end

