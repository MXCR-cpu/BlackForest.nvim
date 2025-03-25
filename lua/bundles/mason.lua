local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup_handlers({
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      autostart = false,
      capabilities = capabilities
    })
  end,
})

local border = "rounded"


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = border
  }
)

vim.diagnostic.config({
  float = { border = border }
})

lspconfig.util.default_config.autostart = false

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME }
      },
      diagnostics = {
        enable = true,
        globals = { "vim" }
      }
    }
  },
  capabilities = capabilities
})


lspconfig.clangd.setup({
  name = "xtensa-clangd",
  -- cmd = { "/Users/iMac/Desktop/Software/llvm-project/esp-clang/bin/clangd" },
  cmd = { "/usr/local/opt/llvm/bin/clangd" }
})

lspconfig.sourcekit.setup({
  cmd = {'xcrun', 'sourcekit-lsp' }
})
