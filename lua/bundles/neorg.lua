require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          ucsc = "~/Documents/UCSC/",
        }
      }
    }
  }
})

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
})

