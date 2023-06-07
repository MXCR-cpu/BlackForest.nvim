local lspconfig = require'lspconfig'
lspconfig.util.default_config.autostart = false
require'mason'.setup()
require'mason-lspconfig'.setup()
require'mason-lspconfig'.setup_handlers {
	function (server_name) -- default handler (optional)
	    lspconfig[server_name].setup {}
	end
}

