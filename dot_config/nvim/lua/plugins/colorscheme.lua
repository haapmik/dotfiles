local everblush = {
  "Everblush/nvim",
  name = "everblush",
  lazy = false, -- make sure to load colorscheme during startup
  priority = 1000,
  config = function()
    require("everblush").setup({
      nvim_tree = {
        contrast = true,
      },
    })
    vim.cmd("colorscheme everblush")
  end,
}

local kanagawa = {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  build = ":KanagawaCompile",
  opts = function()
    require("kanagawa").setup({
      compile = true,
      undercurl = true,
      dimInactive = true,
      theme = "wave", -- default when "background" not est
      background = {
        -- available options: "wave", "lotus", "dragon"
        dark = "wave",
        light = "lotus",
      },
    })
    vim.cmd("colorscheme kanagawa")
  end,
}

return kanagawa
