local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local lsp_flags = {
	debounce_text_changes = 150,
}

local function merge(...)
	local result = {}
	for _, t in ipairs({ ... }) do
		for k, v in pairs(t) do
			result[k] = v
		end
	end
	return result
end

local function setup_server(server, extra_options)
	local options = {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	}
	if extra_options then
		options = merge(options, extra_options)
	end
	if not require("lspconfig")[server].setup then
		print([[ERROR: LSPCONFIG: ]] .. server .. [[ does not posess a readable setup function]])
	end
	require("lspconfig")[server].setup(options)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
	pyright = {},
	tsserver = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	rust_analyzer = {
		settings = { ["rust-analyzer"] = {} },
	},
	texlab = { build = { args = {"-interaction nonstopmode"}, executable = "lualatex" } },
	racket_langserver = {},
	bashls = {},
	hls = {},
	jsonls = { capabilities = capabilities }
}

for k, v in pairs(servers) do
	setup_server(k, v)
end
