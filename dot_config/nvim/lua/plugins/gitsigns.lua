local M = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    linehl = true,
    max_file_length = 10000, -- Default: 40000
  },
}

return M
