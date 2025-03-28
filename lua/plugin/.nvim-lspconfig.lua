local lspconfig = require("lspconfig")
lspconfig.sourcekit.setup{
  cmd = {'xcrun', 'sourcekit-lsp' }
}

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config({
  float = { border = _border }
})
