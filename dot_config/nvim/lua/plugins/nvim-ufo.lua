local M = {
  "kevinhwang91/nvim-ufo",
  lazy = false,
  dependencies = {
    "kevinhwang91/promise-async",
  },
  opts = {},
}

local diagnostics_icon = function(foldstart, foldend)
  local value = ""
  local error_count = 0
  local warn_count = 0
  local info_count = 0
  local hint_count = 0

  for i = foldstart, foldend, 1 do
    error_count = error_count + #vim.diagnostic.get(0, { lnum = i, severity = vim.diagnostic.severity.ERROR })
    warn_count = warn_count + #vim.diagnostic.get(0, { lnum = i, severity = vim.diagnostic.severity.WARN })
    info_count = info_count + #vim.diagnostic.get(0, { lnum = i, severity = vim.diagnostic.severity.INFO })
    hint_count = hint_count + #vim.diagnostic.get(0, { lnum = i, severity = vim.diagnostic.severity.HINT })
  end

  if error_count > 0 then
    value = value .. string.format(" E ", error_count)
  elseif warn_count > 0 then
    value = value .. string.format(" W ", warn_count)
  elseif info_count > 0 then
    value = value .. string.format(" I ", info_count)
  elseif hint_count > 0 then
    value = value .. string.format(" H ", hint_count)
  end

  if value ~= "" then
    value = "!!" .. value
  end

  return ""
end

local virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local folded_lines = endLnum - lnum
  local suffix = (" … %d "):format(folded_lines)

  local diagnostics_icon = diagnostics_icon(lnum, endLnum)
  if diagnostics_icon ~= "" then
    suffix = suffix .. diagnostics_icon
  end

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
  require("ufo").setup({
    fold_virt_text_handler = virt_text_handler,
  })
end

return M
