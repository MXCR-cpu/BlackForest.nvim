require("mason").setup({
  ui = {
    border = "single",
  },
})

local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      autostart = false,
      capabilities = capabilities
    })
  end,
})

lspconfig.util.default_config.autostart = false

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        enable = true,
        globals = {
          "vim"
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.clangd.setup({
  name = "xtensa-clangd",
  cmd = { "/Users/iMac/Desktop/Software/llvm-project/esp-clang/bin/clangd" },
})

lspconfig.sourcekit.setup({
  cmd = {'xcrun', 'sourcekit-lsp' }
})
