local M = {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
}

function M.config()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "cssls",
      "html",
      "intelephense",
      "jsonls",
      "pyright",
      "rome",
      "rust_analyzer",
      "tsserver",
      "efm",
    },
    -- Automatically install servers that were configured via lspconfig
    automatic_installation = true,
  })
end

return M
