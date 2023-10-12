local yaml_companion = require("yaml-companion").setup({
  lspconfig = {
    filetypes = { "yaml", "yml" },
  },
})

return yaml_companion
