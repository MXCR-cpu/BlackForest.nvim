local query = vim.treesitter.query

query.set(
  "markdown_inline",
  "highlights",
  [[
    (latex_block) @text.math
    (latex_span_delimiter) @text.delimiter
    (shortcut_link) @text.delimiter
    (emphasis) @text.emphasis
    (link_text) @text.uri
    (code_span) @text.code
  ]]
)

query.set(
  "markdown",
  "highlights",
  [[
    (fenced_code_block) @text.code
    (atx_heading heading_content: (inline)) @text.heading.inline
    (paragraph) @text
    (list_marker_dot) @punctuation
    (list_marker_minus) @punctuation
    (minus_metadata) @documentation
  ]]
)

-- query.set(
--   "css",
--   "highlights",
--   [[
--     (plain_value) @plain.value
--   ]]
-- )
--
