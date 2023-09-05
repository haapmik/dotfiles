local M = {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
}

function M.config()
  require("symbols-outline").setup({})
end

return M
