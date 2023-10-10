vim.treesitter.query.set(
  "markdown_inline",
  "highlights",
  [[
    (latex_block) @text.math
    (latex_span_delimiter) @text.delimiter
    (shortcut_link) @text.delimiter
    (emphasis) @text.emphasis
    (link_text) @text.uri
  ]]
)

vim.treesitter.query.set(
  "markdown",
  "highlights",
  [[
    (atx_heading heading_content: (inline)) @text.heading.inline
    (paragraph) @text
    (list_marker_dot) @punctuation
    (list_marker_minus) @punctuation
    (minus_metadata) @documentation
  ]]
)



