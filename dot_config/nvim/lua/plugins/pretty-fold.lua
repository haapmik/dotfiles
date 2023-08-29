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
        function()
          local value = ""
          local error_count = 0
          local warn_count = 0

          for i = vim.v.foldstart, vim.v.foldend, 1 do
            error_count = error_count + #vim.diagnostic.get(0, { lnum = i, severity = vim.diagnostic.severity.ERROR })
            warn_count = warn_count + #vim.diagnostic.get(0, { lnum = i, severity = vim.diagnostic.severity.WARN })
          end

          if error_count > 0 then
            value = value .. string.format(" %d E ", error_count)
          end

          if warn_count > 0 then
            value = value .. string.format(" %d W ", warn_count)
          end

          if value ~= "" then
            value = "!!" .. value
          end

          return value
        end,
      },
    },
  })
end

return M
