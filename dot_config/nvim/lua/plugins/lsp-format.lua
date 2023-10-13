local M = {
  "lukas-reineke/lsp-format.nvim",
  lazy = false,
}

function M.config()
  require("lsp-format").setup({
    sync = true, -- Fix for :wq with async
  })
  -- Tries to fix async problem with :wq
  --vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
end

return {}
