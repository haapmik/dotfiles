local M = {
  "williamboman/mason.nvim",
  lazy = false,
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
}

function M.config()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
end

return M
