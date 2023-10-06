local M = {
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    yaml = {
      validate = true,
      format = { enable = true },
      hover = true,
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
      },
      schemas = {
        require("schemastore").yaml.schemas(),
      },
    },
  },
}

local yaml_companion = require("yaml-companion").setup({})

return yaml_companion
