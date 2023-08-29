local M = {
  "anuvyklack/pretty-fold.nvim",
  lazy = false,
}

function M.config()
  require("pretty-fold").setup({
    keep_indentation = true,
    fill_char = '·',
  })
end

return M
