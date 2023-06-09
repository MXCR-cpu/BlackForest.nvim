-- Most of key mappings are handled by which-key.lua in the plugin directory
local mappings = {
	{ "n", "j",                  "gj" },
	{ "n", "k",                  "gk" },
	{ "v", "j",                  "gj" },
	{ "v", "k",                  "gk" },
	{ "n", "H",                  "5h" },
	{ "n", "J",                  "5gj" },
	{ "n", "K",                  "5gk" },
	{ "n", "L",                  "5l" },
	{ "t", "<Shift><Backspace>", "" },
}

for _, mapping in ipairs(mappings) do
	vim.api.nvim_set_keymap(mapping[1], mapping[2], mapping[3], { noremap = true })
end
