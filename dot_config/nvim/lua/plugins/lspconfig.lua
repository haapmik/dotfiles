local M = {
  "neovim/nvim-lspconfig",
  cmd = { "LspStart", "LspInfo" },
  dependencies = {
    "folke/neodev.nvim",
    "williamboman/mason-lspconfig.nvim",
    "creativenull/efmls-configs-nvim",
    "b0o/SchemaStore.nvim",
  },
}

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    async = true,
  })
end

local function get_lsp_client_configs(lsp_client)
  local opts = {}

  -- Create augroup for LSP clients
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  -- Include autocompletion capabilities
  opts.capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- LSP client specific configuration for selected buffer
  opts.on_attach = function(client, bufnr)
    -- Formatting
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end

    -- Cursor diagnostic hover window
    --vim.api.nvim_create_autocmd("CursorHold", {
    --  buffer = bufnr,
    --  callback = function()
    --    vim.diagnostic.open_float(nil, {
    --      focusable = false,
    --      close_events = {
    --        "BufLeave",
    --        "CursorMoved",
    --        "InsertEnter",
    --        "FocusLost",
    --      },
    --      source = "always",
    --      scope = "cursor",
    --    })
    --  end,
    --})
  end

  if lsp_client == "jsonls" then
    opts.settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    }
  end

  if lsp_client == "yamlls" then
    opts.settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
        },
        schemas = {
          require("schemastore").yaml.schemas(),
          kubernetes = "globPattern",
        },
      },
    }
  end

  if lsp_client == "sumneko_lua" or lsp_client == "lua_ls" then
    opts.settings = {
      Lua = {
        workspace = {
          checkThirdParty = false, -- disable those stupid 'luv' prompts
        },
        telemetry = {
          enable = false,
        },
      },
    }
  end

  if lsp_client == "efm" then
    -- Typescript/Javascript
    local eslintd_linter = require("efmls-configs.linters.eslint_d")
    local eslintd_formatter = require("efmls-configs.formatters.eslint_d")
    local prettierd = require("efmls-configs.formatters.prettier_d")
    -- PHP
    local php = require("efmls-configs.linters.php")
    local phpcs = require("efmls-configs.linters.phpcs")
    local phpcbf = require("efmls-configs.formatters.phpcbf")
    -- Rust
    local rustfmt = require("efmls-configs.formatters.rustfmt")
    -- Python
    local black = require("efmls-configs.formatters.black")
    -- Lua
    local stylua = require("efmls-configs.formatters.stylua")

    local languages = {
      typescript = { eslintd_linter, eslintd_formatter, pretierd },
      javascript = { eslintd_linter, eslintd_formatter, pretierd },
      javascriptreact = { eslintd_linter, eslintd_formatter, pretierd },
      typescriptreact = { eslintd_linter, eslintd_formatter, pretierd },
      rust = { rustfmt },
      php = { php, phpcs, phpcbf },
      python = { black },
    }

    opts.init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true,
    }
    opts.settings = {
      filetypes = vim.tbl_keys(languages),
      rootMarkers = {".git/", ".editorconfig"},
      languages = languages,
    }
  end

  return opts
end

function M.config()
  -- IMPORTANT: this should be the first line!
  require("neodev").setup({})

  local lspconfig = require("lspconfig")
  local lsp_client_list = require("mason-lspconfig").get_installed_servers()
  for _, lsp_client in pairs(lsp_client_list) do
    local opts = get_lsp_client_configs(lsp_client)
    lspconfig[lsp_client].setup(opts)
  end
end

return M
