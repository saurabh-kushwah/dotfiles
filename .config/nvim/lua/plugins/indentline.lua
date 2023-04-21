local indentline = require("ibl")

vim.opt.list = true

local highlight = {
    "CursorColumn",
    "Whitespace",
}

indentline.setup({
  indent = { highlight = highlight, char = "" },
  whitespace = {
      highlight = highlight,
      remove_blankline_trail = false,
  },
  scope = { enabled = false },
})
