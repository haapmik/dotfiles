local M = {
  "lewis6991/satellite.nvim",
  event = "VeryLazy",
}

function M.config()
  require("satellite").setup({})
end

return M
