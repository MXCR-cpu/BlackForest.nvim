return {
	'neovim/nvim-lspconfig',
	{ 'williamboman/mason.nvim', opts = { ui = { border = "single" }}},
  'williamboman/mason-lspconfig.nvim',
	{
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip"
    },
    config = function()
      dofile(vim.g.nvim_directory .. "/plugin/nvim-cmp.lua")
    end
  },
}
