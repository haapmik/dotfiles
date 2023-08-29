local M = {
  "anuvyklack/fold-preview.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "anuvyklack/keymap-amend.nvim",
  },
  opts = {},
}

return M
