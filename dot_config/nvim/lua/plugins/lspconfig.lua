local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "folke/neodev.nvim",
    "williamboman/mason-lspconfig.nvim",
    "creativenull/efmls-configs-nvim",
    "b0o/SchemaStore.nvim",
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

local function get_lsp_client_configs(lsp_client)
  local opts = {}

  -- Include capabilities
  opts.capabilities = create_capabilities()

  -- Create augroup for LSP clients
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  -- LSP client specific configuration for selected buffer
  opts.on_attach = function(client, bufnr)
    -- Formatting
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            async = false,
          })
        end,
      })
    end
  end

  -- LSP client specific configuration
  local client_config_status, client_config = pcall(require, "lsp_client_config." .. lsp_client)
  if client_config_status then
    for key, value in pairs(client_config) do
      opts[key] = value
    end
  end

  return opts
end

function M.config()
  -- IMPORTANT: this should be the first line!
  require("neodev").setup({
    library = {
      plugins = { "neotest" },
      types = true,
    },
  })

  local lspconfig = require("lspconfig")
  local lsp_client_list = require("mason-lspconfig").get_installed_servers()
  for _, lsp_client in pairs(lsp_client_list) do
    local opts = get_lsp_client_configs(lsp_client)
    lspconfig[lsp_client].setup(opts)
  end
end

return M
