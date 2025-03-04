return {
  {
  "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    lazy = true
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {}
  },
  {
    "folke/trouble.nvim",
    opts = {}
  }
}
