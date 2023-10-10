require("nvim-treesitter.configs").setup{
  auto_install = true,
  highlight = {
    enable = true,
    custom_captures = {
      ['markdown.latex.block'] = 'MarkdownLatexBlock',
      ['markdown.latex.inline'] = 'MarkdownLatexInline',
      ['latex_block'] = 'LatexBlock',
    }
  },
  additional_vim_regex_highlighting = false,
}

