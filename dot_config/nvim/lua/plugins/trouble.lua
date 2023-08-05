local M = {
  "folke/trouble.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

function M.opts()
  return {
    icons = false,
    group = true, -- group by file
    padding = false,
    auto_preview = true,
    auto_open = false,
    auto_close = false,
    use_diagnostic_signs = true,
  }
end

return M
