local M = {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
}

local function handler_stylua(null_ls)
  null_ls.register(null_ls.builtins.formatting.stylua)
end

local function handler_rome(null_ls)
  local config_file_list = { "rome.json" }
  null_ls.register(null_ls.builtins.formatting.rome.with({
    condition = function(utils)
      return utils.root_has_file(config_file_list)
    end,
  }))
end

local function handle_eslint_d(null_ls)
  local config_file_list = {
    ".eslintrc",
    ".eslintrc.json",
    ".eslintrc.yml",
    ".eslintrc.yaml",
    ".eslintrc.js",
  }
  null_ls.register(null_ls.builtins.formatting.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file(config_file_list)
    end,
  }))
  null_ls.register(null_ls.builtins.code_actions.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file(config_file_list)
    end,
  }))
  null_ls.register(null_ls.builtins.diagnostics.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file(config_file_list)
    end,
  }))
end

local function handle_prettierd(null_ls)
  local config_file_list = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.js",
  }
  null_ls.register(null_ls.builtins.formatting.prettierd.with({
    condition = function(utils)
      return utils.root_has_file(config_file_list)
    end,
  }))
end

function M.config()
  local null_ls = require("null-ls")
  null_ls.setup({})

  require("mason-null-ls").setup({
    ensure_installed = {
      -- Always prioritize Mason's sources if available
      "eslint_d",
      "phpcbf",
      "phpcs",
      "prettierd",
      "rome",
      "rustfmt",
      "shellcheck",
      "shfmt",
      "stylua",
    },
    handlers = {
      -- Prevent source use unless configuration file
      -- is included in the project root.
      --function() end, -- disables automatic setup of all null-ls sources
      rome = handler_rome(null_ls),
      eslint_d = handle_eslint_d(null_ls),
      prettierd = handle_prettierd(null_ls),
      stylua = handler_stylua(null_ls),
    },
    automatic_installation = false,
  })
end

return M
