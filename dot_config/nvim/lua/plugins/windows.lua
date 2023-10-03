local M = {
  "anuvyklack/windows.nvim",
  event = "VeryLazy",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  opts = {
    ignore = {
      buftype = { "quickfix" },
      filetype = { "Trouble", "Outline" },
    },
    autowidth = {
      enable = true,
      winwidth = 0.7,
      filetype = {
        help = 2,
      },
    },
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
  },
}

return M
