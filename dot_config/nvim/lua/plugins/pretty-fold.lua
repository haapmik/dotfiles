local M = {
  "anuvyklack/pretty-fold.nvim",
  lazy = false,
}

function M.config()
  require("pretty-fold").setup({
    keep_indentation = true,
    fill_char = " ",
    sections = {
      left = {
        "content",
        "…",
        function()
          return string.format(" %d lines ", vim.v.foldend - vim.v.foldstart + 1)
        end,
      },
    },
  })
end

return M
