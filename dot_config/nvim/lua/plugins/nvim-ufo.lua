local M = {
  "kevinhwang91/nvim-ufo",
  lazy = false,
  dependencies = {
    "kevinhwang91/promise-async",
  },
}

local virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local folded_lines = endLnum - lnum
  local suffix = (" … %d lines "):format(folded_lines)

  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

function M.config()
  local ufo = require("ufo")

  vim.keymap.set("n", "zR", ufo.openAllFolds)
  vim.keymap.set("n", "zM", ufo.closeAllFolds)
  vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
  vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

  ufo.setup({
    fold_virt_text_handler = virt_text_handler,
    provider_selector = function(bufnr, filetype)
      return { "lsp", "indent" }
    end,
  })
end

return M
