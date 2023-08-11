local M = {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      indicator = {
        style = "underline",
      },
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
    },
  })
end

return M
