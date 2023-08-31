local function get_config_typescript()
  local prettierd = require("efmls-configs.formatters.prettier_d")
  prettierd.rootMarkers = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.js",
    ".prettierrc.mjs",
    ".prettierrc.cjs",
  }
  prettierd.requireMarker = true

  local eslintd = require("efmls-configs.linters.eslint_d")
  eslintd.rootMarkers = {
    ".eslintrc",
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.json",
  }
  eslintd.requireMarker = true

  local rome = {
    formatCommand = "npx rome format --colors off --stdin-file-path ${INPUT}",
    formatStdin = true,
    rootMarkers = { "rome.json" },
    requireMarker = true,
  }

  return { rome, eslintd, prettierd }
end

local function get_config_rust()
  local rustfmt = require("efmls-configs.formatters.rustfmt")

  return { rustfmt }
end

local function get_config_lua()
  local stylua = require("efmls-configs.formatters.stylua")

  return { stylua }
end

local function get_config_python()
  local black = require("efmls-configs.formatters.black")
  local flake8 = require("efmls-configs.linters.flake8")

  return { black, flake8 }
end

local function get_config_php()
  local php = require("efmls-configs.linters.php")
  local phpcs = require("efmls-configs.linters.phpcs")
  local phpcbf = require("efmls-configs.formatters.phpcbf")

  return { php, phpcs, phpcbf }
end

local function create_config()
  local opts = {}

  local languages = {
    javascript = get_config_typescript(),
    javascriptreact = get_config_typescript(),
    lua = get_config_lua(),
    php = get_config_php(),
    python = get_config_python(),
    rust = get_config_rust(),
    typescript = get_config_typescript(),
    typescriptreact = get_config_typescript(),
  }

  opts.init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
  }

  opts.filetypes = vim.tbl_keys(languages)

  opts.settings = {
    rootMarkers = { ".git/", ".vscode/", ".editorconfig" },
    languages = languages,
  }

  return opts
end

local M = create_config()

return M