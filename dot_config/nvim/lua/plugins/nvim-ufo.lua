local M = {
  "kevinhwang91/nvim-ufo",
  lazy = false,
  dependencies = {
    "kevinhwang91/promise-async",
  },
}

function M.config()
  local ufo = require("ufo")

  vim.keymap.set("n", "zR", ufo.openAllFolds)
  vim.keymap.set("n", "zM", ufo.closeAllFolds)
  vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
  vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

  ufo.setup({
    provider_selector = function(bufnr, filetype)
      return { "lsp", "indent" }
    end,
  })
end

return M
