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


lspconfig.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,

  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim" }
      }
    }
  },

  capabilities = capabilities
}


lspconfig.clangd.setup({
  name = "xtensa-clangd",
  -- cmd = { "/Users/iMac/Desktop/Software/llvm-project/esp-clang/bin/clangd" },
  cmd = { "/usr/local/opt/llvm/bin/clangd" }
})

lspconfig.sourcekit.setup({
  cmd = {'xcrun', 'sourcekit-lsp' }
})
