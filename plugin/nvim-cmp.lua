local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- ["<C-]>"] = cmp.mapping.select_next_item(),
		-- ["<C-[>"] = cmp.mapping.select_prev_item(),
		-- ["<C-}>"] = cmp.mapping.scroll_docs(4),
		-- ["<C-{>"] = cmp.mapping.scroll_docs(-4),
		-- ["<C-.>"] = cmp.mapping.complete(),
		-- ["<C-!>"] = cmp.mapping.abort(),
		-- ["<C-;>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = 'luasnip', option = { show_autosnippets = true } },
		},
		{
			{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

