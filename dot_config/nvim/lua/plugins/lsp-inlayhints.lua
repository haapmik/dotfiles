local M = {
  "lvimuser/lsp-inlayhints.nvim",
  event = { "LspAttach" },
  opts = {
    --inlay_hints = {
    --  only_current_line = true, -- Avoid code pollution with inlay hints
    --},
  },
}

return M
