local M = {
  "anuvyklack/pretty-fold.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("pretty-fold").setup({
    keep_indentation = true,
    fill_char = " ",
    sections = {
      left = {
        "content",
        " … ",
        "number_of_folded_lines",
      },
    },
  })
end

return {}
