local M = {
  "anuvyklack/windows.nvim",
  event = "VeryLazy",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
}

function M.config()
  require("windows").setup({
    animation = {
      enable = true,
      duration = 50,
      fps = 60,
    },
  })
end

return M
