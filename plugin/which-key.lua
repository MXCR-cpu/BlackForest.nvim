local g = vim.g
local wk = require('which-key')
wk.setup {
	ignore_missing = true,
}

wk.register({
	Q = { '<cmd>q!<CR>', 'Force Quit' },
	W = { '<cmd>w!<CR>', 'Force Write' },
	c = { '<cmd>ClearHighlight<CR>', 'Clear Highlight' },
	d = { '<cmd>DMsg<CR>', 'Get Diagnostic Error' },
	f = { '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', 'Format' },
	h = { '<cmd>wincmd h<CR>', 'Switch Pane Left' },
	i = { '<cmd>AerialToggle left<CR>', 'Open Aerial' },
	j = { '<cmd>wincmd j<CR>', 'Switch Pane Down' },
	k = { '<cmd>wincmd k<CR>', 'Switch Pane Up' },
	l = { '<cmd>wincmd l<CR>', 'Switch Pane Right' },
	n = { '<cmd>NeoTreeFocusToggle<CR>', 'NeoTree Toggle' },
	q = { '<cmd>q<CR>', 'Quit' },
	s = { '<cmd>Lazy sync<CR>', 'Lazy Sync' },
	u = { '<cmd>UndotreeToggle<CR>', 'Undotree Toggle' },
	v = { '<cmd>StartupTime<CR>', 'VimStartup Time' },
	w = { '<cmd>w<CR>', 'Write' },
	z = { '<cmd>luafile $MYVIMRC<CR>', 'Reload Neovim' },
	A = {
		name = 'Align',
		l = { '<cmd>lua require"utility".align("left" ,false)<CR>', 'Align Left' },
		L = { '<cmd>lua require"utility".align("left" ,true)<CR>', 'Align Gap Left' },
		r = { '<cmd>lua require"utility".align("right",false)<CR>', 'Align Right' },
		R = { '<cmd>lua require"utility".align("right",true)<CR>', 'Align Gap Right' },
	},
	B = {
		name = 'Buffer',
		N = { '<cmd>bnext<CR>', 'Next Buffer' },
		P = { '<cmd>bprevious<CR>', 'Previous Buffer' },
		C = { '<cmd>bw!<CR>', 'Close Buffer' },
		T = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Defintion' },
		S = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help' },
		D = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'Buffer Definition' },
		E = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'Buffer Declaration' },
		H = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover' },
	},
	C = {
		name = 'Nvim-Cmp(Insert)',
		['<C-]>'] = { '', 'Select Next Item' },
		['<C-[>'] = { '', 'Select Previous Item' },
		['<C-}>'] = { '', 'Scroll Docs Down' },
		['<C-{>'] = { '', 'Scroll Docs Up' },
		['<C-.>'] = { '', 'Select Item' },
		['<C-!>'] = { '', 'Abort' },
		['<C-;>'] = { '', 'Confirm Selection' },
	},
	D = {
		name = "Diagnostic",
		A = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Action' },
		F = { '<cmd>vim.diagnostic.open_float()<CR>', 'Float' },
		I = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementation' },
		T = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type' },
	},
	E = {
		name = 'Telescope',
		F = { '<cmd>Telescope find_files<CR>', 'Find Files' },
		G = { '<cmd>Telescope live_grep<CR>', 'Live Grep' },
		B = { '<cmd>Telescope buffers<CR>', 'List Buffers' },
		H = { '<cmd>Telescope help_tags<CR>', 'Help Tags' },
		C = { '<cmd>Telescope highlights<CR>', 'Highlight Groups' },
	},
	H = {
		name = 'Harpoon',
		A = { '<cmd>lua require"harpoon.mark".add_file()<CR>', 'Add File' },
		R = { '<cmd>lua require"harpoon.mark".rm_file()<CR>', 'Remove File' },
		S = { '<cmd>lua require"harpoon.mark".set_current_at(0 + vim.fn.input"Index: ")<CR>', 'Set To Index' },
		G = { string.gsub([[<cmd> lua
			local co = coroutine.create(function()
				require"harpoon.ui".nav_file(0 + vim.fn.input"⇀ ")
			end)
			require"harpoon.ui".toggle_quick_menu()
			vim.schedule(function()
				coroutine.resume(co)
			end)
			<CR>]], '\n', ' '), 'Go To Index' },
		N = { '<cmd>lua require"harpoon.ui".nav_next()<CR>', 'Next Mark' },
		P = { '<cmd>lua require"harpoon.ui".nav_prev()<CR>', 'Previous Mark' },
		M = { '<cmd>lua require"harpoon.ui".toggle_quick_menu()<CR>', 'Menu' },
		T = { '<cmd>Telescope harpoon marks<CR>', 'Telescope Menu' },
		L = { '<cmd>lua require"harpoon.term".gotoTerminal(1)<CR>', 'Terminal 1' },
	},
	L = {
		name = 'LSP',
		R = { '<cmd>LspRestart<CR>', 'Restart Lsp' },
		S = { '<cmd>LspStart<CR>', 'Start Lsp' },
		P = { '<cmd>LspStop<CR>', 'Stop Lsp' },
		L = { '<cmd>LspLog<CR>', 'Lsp Log' },
		I = { '<cmd>LspInfo<CR>', 'Lsp Info' },
		M = { '<cmd>Mason<CR>', 'Mason' },
		O = { '<cmd>MasonLog<CR>', 'Mason Log' },
		U = { '<cmd>MasonUpdate<CR>', 'Mason Update' },
	},
	N = {
		name = 'Luasnip',
		E = { '<cmd>lua require"luasnip.loaders".edit_snippet_files()<CR>', 'Edit Snippets' },
		O = { '<cmd>e ' .. g.nvim_directory .. '/Luasnip/<CR>', 'Open Snippet Directory' },
	},
	O = {
		name = 'Open',
		i = { '<cmd>e ' .. g.nvim_directory .. '/init.lua<CR>', 'Init' },
		P = { '<cmd>e ' .. g.nvim_directory .. '/plugin<CR>', 'Plugin' },
		I = { '<cmd>e ' .. g.nvim_directory .. '/inits<CR>', 'Inits' },
		p = { '<cmd>e ' .. g.nvim_directory .. '/inits/plugin_packer.lua<CR>', 'Packer' },
		W = { '<cmd>e ' .. g.nvim_directory .. '/plugin/which-key.lua<CR>', 'Which-Key' },
		L = { '<cmd>e ' .. g.nvim_directory .. '/plugin/lspconfig.lua<CR>', 'Lspconfig' },
		A = { '<cmd>e ' .. os.getenv 'HOME' .. '/.config/alacritty/alacritty.yml<CR>', 'Alacritty' },
		Z = { '<cmd>e ' .. os.getenv 'HOME' .. '/.zshrc<CR>', 'Open Zsh Config File' },
	},
	P = {
		name = 'Panes',
		H = { '<cmd>vert resize -5<CR>', 'Decrease Pane Width' },
		J = { '<cmd>resize -5<CR>', 'Decrease Pane Height' },
		K = { '<cmd>resize +5<CR>', 'Increase Pane Height' },
		L = { '<cmd>vert resize +5<CR>', 'Increase Pane Width' },
		r = { '<cmd>wincmd =<CR>', 'Reload Window Pages' },
		n = { '<cmd>split<CR>', 'Horizontal Split' },
		m = { '<cmd>vsplit<CR>', 'Vertical Split' },
	},
	T = {
		name = 'Tasks',
		L = { '<cmd>!task long<CR>', 'List' },
		A = { '<cmd>lua vim.cmd("!task add " .. vim.fn.input"New Task: ")<CR>', 'Add' },
		D = {
			'<cmd>lua vim.cmd("task delete" .. vim.fn.input"Delete Task Id: " .. " << echo ".. vim.fn.input"Confirm: ")<CR>',
			'Delete'
		},
		C = { '<cmd>lua vim.cmd("task done" .. vim.fn.input"Complete Task Id: ")<CR>', 'Complete' },
		S = { '<cmd>lua vim.cmd"!task sync"<CR>', 'Sync' },
	},
	Z = {
		name = 'Boop',
		Z = { '<cmd>Boop<CR>', 'Open' },
		T = {
			name = 'To',
			H = { '<cmd>BoopToHex<CR>', 'Hex' },
			O = { '<cmd>BoopToOctal<CR>', 'Octal' },
			E = { '<cmd>BoopToBase64<CR>', 'Base64' },
			B = { '<cmd>BoopToBinary<CR>', 'Binary' },
			S = { '<cmd>BoopToSHA256<CR>', 'SHA256' },
		},
		F = {
			name = 'From',
			H = { '<cmd>BoopToHex<CR>', 'Hex' },
			O = { '<cmd>BoopToOctal<CR>', 'Octal' },
			E = { '<cmd>BoopToBase64<CR>', 'Base64' },
			B = { '<cmd>BoopToBinary<CR>', 'Binary' },
		},
		C = {
 			name = 'Case',
			C = { '<cmd>BoopCamelCase<CR>', 'Camel' },
			K = { '<cmd>BoopKebabCase<CR>', 'Kebab' },
			S = { '<cmd>BoopSnakeCase<CR>', 'Snake' },
		}
	}
}, { prefix = '<leader>' })
