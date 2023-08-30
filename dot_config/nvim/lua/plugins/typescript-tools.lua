local M = {
  "pmizio/typescript-tools.nvim",
  ft = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
}

local function create_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- for nvim-ufo
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  return capabilities
end


function M.config()
  require("typescript-tools").setup({
    on_attach = function(client)
      -- Prevent tsserver from formatting files
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })
end

--return M
return {}
