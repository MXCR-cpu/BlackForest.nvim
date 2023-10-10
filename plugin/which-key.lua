local g = vim.g
local wk = require('which-key')
wk.setup {
	ignore_missing = true,
}

wk.register({
	Q = { '<cmd>q!<CR>', 'Force Quit' },
	W = { '<cmd>w!<CR>', 'Force Write' },
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
	a = {
		name = 'Align',
		l = { '<cmd>lua require"utility".align("left" ,false)<CR>', 'Align Left' },
		L = { '<cmd>lua require"utility".align("left" ,true)<CR>', 'Align Gap Left' },
		r = { '<cmd>lua require"utility".align("right",false)<CR>', 'Align Right' },
		R = {
			'<cmd>lua require"utility".align("right",true)<CR>',
			'Align Gap Right'
		},
	},
	b = {
		name = 'Buffer',
		c = { '<cmd>BufferClose<CR>', 'Close Buffer' },
		d = { '<cmd>BufferDelete!<CR>', 'Delete Buffer' },
		e = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'Buffer Declaration' },
		h = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover' },
		n = { '<cmd>BufferNext<CR>', 'Next Buffer' },
		p = { '<cmd>BufferPrevious<CR>', 'Previous Buffer' },
		s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help' },
		t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Defintion' },
		m = { name = 'Move',
			n = { '<cmd>BufferMoveNext<CR>', 'Move Buffer Next' },
			p = { '<cmd>BufferMovePrevious<CR>', 'Move Buffer Previous' },
		},
	},
	c = {
		name = 'Codium',
		e = { '<cmd>CodeiumEnable<CR>', 'Enable Codeium' },
		d = { '<cmd>CodeiumDisable<CR>', 'Disable Codeium' },
	},
	d = {
		name = "Diagnostic",
		a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Action' },
		d = { '<cmd>DMsg<CR>', 'Get Diagnostic Error' },
		f = { '<cmd>vim.diagnostic.open_float()<CR>', 'Float' },
		i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementation' },
		t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type' },
	},
	e = {
		name = 'Telescope',
		f = { '<cmd>Telescope find_files<CR>', 'Find Files' },
		g = { '<cmd>Telescope live_grep<CR>', 'Live Grep' },
		b = { '<cmd>Telescope buffers<CR>', 'List Buffers' },
		h = { '<cmd>Telescope help_tags<CR>', 'Help Tags' },
		c = { '<cmd>Telescope highlights<CR>', 'Highlight Groups' },
	},
	G = {
		name = 'Games',
		T = { '<cmd>lua require("typebreak").start()<CR>', 'Typebreak' }
	},
	H = {
		name = 'Harpoon',
		A = { '<cmd>lua require"harpoon.mark".add_file()<CR>', 'Add File' },
		R = { '<cmd>lua require"harpoon.mark".rm_file()<CR>', 'Remove File' },
		S = {
			[[<cmd>lua
			require"harpoon.mark".set_current_at(0 + vim.fn.input"Index: ")<CR>]],
			'Set To Index'
		},
		G = {
			string.gsub([[<cmd>lua
				local co = coroutine.create(function()
					require"harpoon.ui".nav_file(0 + vim.fn.input"⇀ ")
				end)
				require"harpoon.ui".toggle_quick_menu()
				vim.schedule(function()
					coroutine.resume(co)
				end)
				<CR>]], '\n', ' '),
			'Go To Index'
		},
		N = { '<cmd>lua require"harpoon.ui".nav_next()<CR>', 'Next Mark' },
		P = { '<cmd>lua require"harpoon.ui".nav_prev()<CR>', 'Previous Mark' },
		M = { '<cmd>lua require"harpoon.ui".toggle_quick_menu()<CR>', 'Menu' },
		T = { '<cmd>Telescope harpoon marks<CR>', 'Telescope Menu' },
		L = { '<cmd>lua require"harpoon.term".gotoTerminal(1)<CR>', 'Terminal 1' },
	},
	I = {
		name = 'Codeium',
		['<C-g>'] = { '', 'Accept Completion' },
		['<C-;>'] = { '', 'Cycle Forward' },
		['<C-,>'] = { '', 'Cycle Backward' },
		['<C-x>'] = { '', 'Clear Completion' },
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
		E = {
			'<cmd>lua require"luasnip.loaders".edit_snippet_files()<CR>',
			'Edit Snippets'
		},
		O = {
			'<cmd>e ' .. g.nvim_directory .. '/Luasnip/<CR>',
			'Open Snippet Directory'
		},
	},
	o = {
		name = 'Open',
		c = {
			[[<cmd>lua require'telescope.builtin'.find_files({ ]] ..
				[[cwd = '/Users/iMac/.config/BlackForest/', ]] ..
				[[prompt_title = 'vimwiki' })<CR>]],
			'Config'
		},
		a = {
			'<cmd>e ' .. os.getenv 'HOME' .. '/.config/alacritty/alacritty.yml<CR>',
			'Alacritty'
		},
		z = {
			'<cmd>e ' .. os.getenv 'HOME' .. '/.zshrc<CR>',
			'Open Zsh Config File'
		},
	},
	t = {
		name = 'Tabs',
		l = { '<cmd>tabs<CR>', 'List Tabs' },
		e = { '<cmd>tabnew<CR>', 'New Tab' },
		n = { '<cmd>tabnext<CR>', 'Next Tab' },
		p = { '<cmd>tabprevious<CR>', 'Previous Tab' },
		s = { '<cmd>tabonly<CR>', 'Focus Tab' },
		c = { '<cmd>tabclose<CR>', 'Close Tab' },
	},
	T = {
		name = 'Tasks',
		L = { '<cmd>!task long<CR>', 'List' },
		A = {
			'<cmd>lua vim.cmd("!task add " .. vim.fn.input"New Task: ")<CR>',
			'Add'
		},
		D = {
			[[<cmd>lua vim.cmd(]] ..
				[["task delete" .. vim.fn.input"Delete Task Id: ]] ..
				[[" .. " << echo ".. vim.fn.input"Confirm: ")<CR>']],
			'Delete'
		},
		C = {
			'<cmd>lua vim.cmd("task done" .. vim.fn.input"Complete Task Id: ")<CR>',
			'Complete'
		},
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

