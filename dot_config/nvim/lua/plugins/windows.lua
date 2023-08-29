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
      easing = function(r) -- https://easings.net/#easeOutExpo
        if r == 1 then
          return 1
        else
          return 1 - math.pow(2, -10 * r)
        end
      end,
    },
  })
end

return M
