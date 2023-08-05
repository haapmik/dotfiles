local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions

  null_ls.setup({
    sources = {
      -- Sources not available in Mason
      diagnostics.php, -- uses local php instance to check code violations
    },
  })
end

return M
